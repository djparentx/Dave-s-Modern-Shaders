#!/bin/bash

# =======================================
# Dave's Modern Shaders v1.1
# by djparent
# =======================================

# Copyright (c) 2026 djparent
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# ============================================================
# Root privileges check
# ============================================================
if [ "$(id -u)" -ne 0 ]; then
    exec sudo -- "$0" "$@"
fi

# ============================================================
# Initialization
# ============================================================
export TERM=linux
GPTOKEYB_PID=""
CURR_TTY="/dev/tty1"
TMP_KEYS="/tmp/keys.gptk.$$"
SHADERPATH="/home/ark/.config/retroarch/shaders"
CONFIGPATH="/home/ark/.config/retroarch/config"
CONFIG32PATH="/home/ark/.config/retroarch32/config"
ES_CFG="/etc/emulationstation/es_systems.cfg"
ES_CONF="/home/ark/.emulationstation/es_settings.cfg"
if [ -f "$ES_CONF" ]; then
    ES_DETECTED=$(grep "name=\"Language\"" "$ES_CONF" | grep -o 'value="[^"]*"' | cut -d '"' -f 2)
    [ -n "$ES_DETECTED" ] && SYSTEM_LANG="$ES_DETECTED"
fi

# -------------------------------------------------------
# Default configuration : EN
# -------------------------------------------------------
T_BACKTITLE="Dave's Modern Shaders by djparent"
T_MAINTITLE="Main Menu"
T_HHTITLE="Handhelds"
T_CONTITLE="Consoles"
T_APPLY="Choose Modern Shaders to be applied."
T_REMOVE="Choose Modern Shaders to be removed."
T_CONTROLS="Use X or Y to toggle choices:"
T_SELECT="Make a selection:"
T_APPLY_MENU="Apply Modern Shaders"
T_REMOVE_MENU="Remove Modern Shaders"
T_APPLY_ALL="Apply All"
T_REMOVE_ALL="Remove All"
T_DEPEND="Dependencies"
T_INSTALL="Installing necessary files."
T_APPLIED="Shaders applied."
T_REMOVED="Shaders removed"
T_STARTING="Starting Dave's Modern Shaders,\nPlease wait ..."
T_EXIT="Exit"
T_BACK="Back"

# --- FRANÇAIS (FR) --- 
if [[ "$SYSTEM_LANG" == *"fr"* ]]; then
T_BACKTITLE="Dave s Modern Shaders par djparent"
T_MAINTITLE="Menu principal"
T_HHTITLE="Portables"
T_CONTITLE="Consoles"
T_APPLY="Choisissez les Modern Shaders a appliquer."
T_REMOVE="Choisissez les Modern Shaders a supprimer."
T_CONTROLS="Utilisez X ou Y pour changer la selection :"
T_SELECT="Faites une selection :"
T_APPLY_MENU="Appliquer Modern Shaders"
T_REMOVE_MENU="Supprimer Modern Shaders"
T_APPLY_ALL="Tout appliquer"
T_REMOVE_ALL="Tout supprimer"
T_DEPEND="Dependances"
T_INSTALL="Installation des fichiers necessaires."
T_APPLIED="Shaders appliques."
T_REMOVED="Shaders supprimes"
T_STARTING="Demarrage de Dave's Modern Shaders,\nVeuillez patienter ..."
T_EXIT="Quitter"
T_BACK="Retour"

# --- ESPAÑOL (ES) ---
elif [[ "$SYSTEM_LANG" == *"es"* ]]; then
T_BACKTITLE="Dave s Modern Shaders por djparent"
T_MAINTITLE="Menu principal"
T_HHTITLE="Portatiles"
T_CONTITLE="Consolas"
T_APPLY="Elija los Modern Shaders a aplicar."
T_REMOVE="Elija los Modern Shaders a eliminar."
T_CONTROLS="Use X o Y para cambiar la seleccion:"
T_SELECT="Haga una seleccion:"
T_APPLY_MENU="Aplicar Modern Shaders"
T_REMOVE_MENU="Eliminar Modern Shaders"
T_APPLY_ALL="Aplicar todo"
T_REMOVE_ALL="Eliminar todo"
T_DEPEND="Dependencias"
T_INSTALL="Instalando archivos necesarios."
T_APPLIED="Shaders aplicados."
T_REMOVED="Shaders eliminados"
T_STARTING="Iniciando Dave's Modern Shaders,\nPor favor espere ..."
T_EXIT="Salir"
T_BACK="Atras"

# --- PORTUGUÊS (PT) ---
elif [[ "$SYSTEM_LANG" == *"pt"* ]]; then
T_BACKTITLE="Dave s Modern Shaders por djparent"
T_MAINTITLE="Menu principal"
T_HHTITLE="Portateis"
T_CONTITLE="Consolas"
T_APPLY="Escolha os Modern Shaders a aplicar."
T_REMOVE="Escolha os Modern Shaders a remover."
T_CONTROLS="Use X ou Y para alternar a selecao:"
T_SELECT="Faca uma selecao:"
T_APPLY_MENU="Aplicar Modern Shaders"
T_REMOVE_MENU="Remover Modern Shaders"
T_APPLY_ALL="Aplicar tudo"
T_REMOVE_ALL="Remover tudo"
T_DEPEND="Dependencias"
T_INSTALL="Instalando ficheiros necessarios."
T_APPLIED="Shaders aplicados."
T_REMOVED="Shaders removidos"
T_STARTING="Iniciando Dave's Modern Shaders,\nPor favor aguarde ..."
T_EXIT="Sair"
T_BACK="Voltar"

# --- ITALIANO (IT) ---
elif [[ "$SYSTEM_LANG" == *"it"* ]]; then
T_BACKTITLE="Dave s Modern Shaders di djparent"
T_MAINTITLE="Menu principale"
T_HHTITLE="Portatili"
T_CONTITLE="Console"
T_APPLY="Scegli i Modern Shaders da applicare."
T_REMOVE="Scegli i Modern Shaders da rimuovere."
T_CONTROLS="Usa X o Y per cambiare selezione:"
T_SELECT="Fai una selezione:"
T_APPLY_MENU="Applica Modern Shaders"
T_REMOVE_MENU="Rimuovi Modern Shaders"
T_APPLY_ALL="Applica tutto"
T_REMOVE_ALL="Rimuovi tutto"
T_DEPEND="Dipendenze"
T_INSTALL="Installazione dei file necessari."
T_APPLIED="Shaders applicati."
T_REMOVED="Shaders rimossi"
T_STARTING="Avvio di Dave's Modern Shaders,\nAttendere prego ..."
T_EXIT="Esci"
T_BACK="Indietro"

# --- DEUTSCH (DE) ---
elif [[ "$SYSTEM_LANG" == *"de"* ]]; then
T_BACKTITLE="Dave s Modern Shaders von djparent"
T_MAINTITLE="Hauptmenu"
T_HHTITLE="Handhelds"
T_CONTITLE="Konsolen"
T_APPLY="Waehlen Sie Modern Shaders zum Anwenden."
T_REMOVE="Waehlen Sie Modern Shaders zum Entfernen."
T_CONTROLS="Verwenden Sie X oder Y zum Umschalten:"
T_SELECT="Treffen Sie eine Auswahl:"
T_APPLY_MENU="Modern Shaders anwenden"
T_REMOVE_MENU="Modern Shaders entfernen"
T_APPLY_ALL="Alle anwenden"
T_REMOVE_ALL="Alle entfernen"
T_DEPEND="Abhaengigkeiten"
T_INSTALL="Installiere notwendige Dateien."
T_APPLIED="Shaders angewendet."
T_REMOVED="Shaders entfernt"
T_STARTING="Dave's Modern Shaders wird gestartet,\nBitte warten ..."
T_EXIT="Beenden"
T_BACK="Zuruck"

# --- POLSKI (PL) ---
elif [[ "$SYSTEM_LANG" == *"pl"* ]]; then
T_BACKTITLE="Dave s Modern Shaders przez djparent"
T_MAINTITLE="Menu glowne"
T_HHTITLE="Urzadzenia przenosne"
T_CONTITLE="Konsole"
T_APPLY="Wybierz Modern Shaders do zastosowania."
T_REMOVE="Wybierz Modern Shaders do usuniecia."
T_CONTROLS="Uzyj X lub Y aby zmienic wybor:"
T_SELECT="Dokonaj wyboru:"
T_APPLY_MENU="Zastosuj Modern Shaders"
T_REMOVE_MENU="Usun Modern Shaders"
T_APPLY_ALL="Zastosuj wszystko"
T_REMOVE_ALL="Usun wszystko"
T_DEPEND="Zaleznosci"
T_INSTALL="Instalowanie wymaganych plikow."
T_APPLIED="Shaders zastosowane."
T_REMOVED="Shaders usuniete"
T_STARTING="Uruchamianie Dave's Modern Shaders,\nProsze czekac ..."
T_EXIT="Wyjscie"
T_BACK="Wstecz"
fi

# ============================================================
# Start gamepad input
# ============================================================
start_gptkeyb() {
    pkill -9 -f gptokeyb 2>/dev/null || true
    if [ -n "${GPTOKEYB_PID:-}" ]; then
        kill "$GPTOKEYB_PID" 2>/dev/null
    fi
    sleep 0.1
	/opt/inttools/gptokeyb -1 "$0" -c "$TMP_KEYS" > /dev/null 2>&1 &
    GPTOKEYB_PID=$!
}

# ============================================================
# Stop gamepad input
# ============================================================
stop_gptkeyb() {
    if [ -n "${GPTOKEYB_PID:-}" ]; then
        kill "$GPTOKEYB_PID" 2>/dev/null
        GPTOKEYB_PID=""
    fi
}

# ============================================================
# Font Selection
# ============================================================
original_font=$(setfont -v 2>&1 | grep -o '/.*\.psf.*')
setfont /usr/share/consolefonts/Lat7-TerminusBold22x11.psf.gz

# ============================================================
# Display Management
# ============================================================
printf "\e[?25l" > "$CURR_TTY"
dialog --clear
stop_gptkeyb
pgrep -f osk.py | xargs kill -9
printf "\033[H\033[2J" > "$CURR_TTY"
printf "$T_STARTING" > "$CURR_TTY"
sleep 0.5

# ==============================================
# Config File Creation
# ==============================================
create_gbglslp() {
# --- Create GameBoy shader config file ---
mkdir -p $CONFIGPATH/Gambatte
	cat > $CONFIGPATH/Gambatte/gb.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Gambatte
rm -f $CONFIGPATH/Gambatte/gb.cfg
}

create_gbcglslp() {
# --- Create GameBoy Color shader config file ---
mkdir -p $CONFIGPATH/Gambatte
	cat > $CONFIGPATH/Gambatte/gbc.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Gambatte
rm -f $CONFIGPATH/Gambatte/gbc.cfg
}

create_gbaglslp() {
# --- Create GameBoy Advance shader config file ---
mkdir -p $CONFIGPATH/mGBA
	cat > $CONFIGPATH/mGBA/gba.glslp << 'EOF'
#reference "../../shaders/modern-gba.glslp"
EOF

chown -R ark:ark $CONFIGPATH/mGBA
}

create_ggglslp() {
# --- Create GameGear shader config file ---
mkdir -p $CONFIGPATH/Genesis\ Plus\ GX
	cat > $CONFIGPATH/Genesis\ Plus\ GX/gamegear.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Genesis\ Plus\ GX
}

create_ngpglslp() {
# --- Create NeoGeo Pocket shader config file ---
mkdir -p $CONFIGPATH/Beetle\ NeoPop
	cat > $CONFIGPATH/Beetle\ NeoPop/ngp.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Beetle\ NeoPop
rm -f $CONFIGPATH/Beetle\ NeoPop/ngp.cfg
}	

create_ngpcglslp() {
# --- Create NeoGeo Pocket Color shader config file ---
mkdir -p $CONFIGPATH/Beetle\ NeoPop
	cat > $CONFIGPATH/Beetle\ NeoPop/ngpc.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Beetle\ NeoPop
rm -f $CONFIGPATH/Beetle\ NeoPop/ngpc.cfg
}

create_wscglslp() {
# --- Create WonderSwan Color shader config file ---
mkdir -p $CONFIGPATH/Beetle\ WonderSwan
	cat > $CONFIGPATH/Beetle\ WonderSwan/wonderswancolor.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Beetle\ WonderSwan
}

create_lynxglslp() {
# --- Create Lynx shader config file ---
mkdir -p $CONFIG32PATH/Handy
	cat > $CONFIG32PATH/Handy/atarilynx.glslp << 'EOF'
#reference "~/.config/retroarch/shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIG32PATH/Handy
}

create_arcadeglslp() {
# --- Create Arcade/MAME shader config files ---
mkdir -p $CONFIGPATH/FinalBurn\ Neo
	cat > $CONFIGPATH/FinalBurn\ Neo/arcade.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/FinalBurn\ Neo
}

create_atariglslp() {
# --- Create Atari shader config files ---
mkdir -p $CONFIGPATH/Stella\ 2014
mkdir -p $CONFIGPATH/a5200
mkdir -p $CONFIGPATH/ProSystem
	cat > $CONFIGPATH/Stella\ 2014/atari2600.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

cat > $CONFIGPATH/a5200/atari5200.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

cat > $CONFIGPATH/ProSystem/atari7800.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Stella\ 2014
chown -R ark:ark $CONFIGPATH/a5200
chown -R ark:ark $CONFIGPATH/ProSystem
}

create_capcomglslp() {
# --- Create CAPCOM shader config files ---
mkdir -p $CONFIGPATH/FinalBurn\ Neo
	cat > $CONFIGPATH/FinalBurn\ Neo/cps1.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

cat > $CONFIGPATH/FinalBurn\ Neo/cps2.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

cat > $CONFIGPATH/FinalBurn\ Neo/cps3.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/FinalBurn\ Neo
}

create_nesglslp() {
# --- Create NES shader config file ---
mkdir -p $CONFIGPATH/Nestopia
	cat > $CONFIGPATH/Nestopia/nes.glslp << 'EOF'
#reference "../../shaders/modern-ntsc.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Nestopia
}

create_snesglslp() {
# --- Create SNES shader config file ---
mkdir -p $CONFIGPATH/Snes9x
	cat > $CONFIGPATH/Snes9x/snes.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Snes9x
}

create_sg1000glslp() {
# --- Create SG1000 shader config file ---
mkdir -p $CONFIGPATH/Genesis\ Plus\ GX
	cat > $CONFIGPATH/Genesis\ Plus\ GX/sg-1000.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Genesis\ Plus\ GX
}

create_msglslp() {
# --- Create MasterSystem shader config file ---
mkdir -p $CONFIGPATH/Genesis\ Plus\ GX
	cat > $CONFIGPATH/Genesis\ Plus\ GX/mastersystem.glslp << 'EOF'
#reference "../../shaders/modern-ntsc.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Genesis\ Plus\ GX
}

create_mdglslp() {
# --- Create Mega Drive shader config file ---
mkdir -p $CONFIGPATH/Genesis\ Plus\ GX
	cat > $CONFIGPATH/Genesis\ Plus\ GX/megadrive.glslp << 'EOF'
#reference "../../shaders/modern-ntsc.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Genesis\ Plus\ GX
}

create_segacdglslp() {
# --- Create SEGA CD shader config file ---
mkdir -p $CONFIGPATH/Genesis\ Plus\ GX
	cat > $CONFIGPATH/Genesis\ Plus\ GX/segacd.glslp << 'EOF'
#reference "../../shaders/modern-ntsc.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Genesis\ Plus\ GX
}

create_sega32xglslp() {
# --- Create SEGA 32x shader config file ---
mkdir -p $CONFIGPATH/PicoDrive
	cat > $CONFIGPATH/PicoDrive/sega32x.glslp << 'EOF'
#reference "../../shaders/modern-ntsc.glslp"
EOF

chown -R ark:ark $CONFIGPATH/PicoDrive
}

create_pcengineglslp() {
# --- Create PC Engine shader config file ---
mkdir -p $CONFIGPATH/Beetle\ PCE\ Fast
	cat > $CONFIGPATH/Beetle\ PCE\ Fast/pcengine.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Beetle\ PCE\ Fast
}

create_pcenginecdglslp() {
# --- Create PC Engine CD shader config file ---
mkdir -p $CONFIGPATH/Beetle\ PCE\ Fast
	cat > $CONFIGPATH/Beetle\ PCE\ Fast/pcenginecd.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Beetle\ PCE\ Fast
}

create_neogeoglslp() {
# --- Create NeoGeo shader config file ---
mkdir -p $CONFIGPATH/FinalBurn\ Neo
	cat > $CONFIGPATH/FinalBurn\ Neo/neogeo.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/FinalBurn\ Neo
}

create_neogeocdglslp() {
# --- Create NeoGeo CD shader config file ---
mkdir -p $CONFIGPATH/NeoCD
	cat > $CONFIGPATH/NeoCD/neogeocd.glslp << 'EOF'
#reference "../../shaders/modern-simple.glslp"
EOF

chown -R ark:ark $CONFIGPATH/NeoCD
}

# ==============================================
# Config File Deletion
# ==============================================
delete_gbglslp() {
# --- Delete GameBoy shader config file ---
rm -f $CONFIGPATH/Gambatte/gb.glslp
}

delete_gbcglslp() {
# --- Delete GameBoy Color shader config file ---
rm -f $CONFIGPATH/Gambatte/gbc.glslp
}

delete_gbaglslp() {
# --- Delete GameBoy Advance shader config file ---
rm -f $CONFIGPATH/mGBA/gba.glslp
}

delete_ggglslp() {
# --- Delete GameGear shader config file ---
rm -f $CONFIGPATH/Genesis\ Plus\ GX/gamegear.glslp
}

delete_ngpglslp() {
# --- Delete NeoGeo Pocket shader config file ---
rm -f $CONFIGPATH/Beetle\ NeoPop/ngp.glslp
}	

delete_ngpcglslp() {
# --- Delete NeoGeo Pocket Color shader config file ---
rm -f $CONFIGPATH/Beetle\ NeoPop/ngpc.glslp
}

delete_wscglslp() {
# --- Delete WonderSwan Color shader config file ---
rm -f $CONFIGPATH/Beetle\ WonderSwan/wonderswancolor.glslp
}

delete_lynxglslp() {
# --- Delete Lynx shader config file ---
rm -f $CONFIG32PATH/Handy/atarilynx.glslp
}

delete_arcadeglslp() {
# --- Delete Arcade/Mame shader config files ---
rm -f $CONFIGPATH/FinalBurn\ Neo/arcade.glslp
}

delete_atariglslp() {
# --- Delete Atari shader config files ---
rm -f $CONFIGPATH/Stella\ 2014/atari2600.glslp
rm -f $CONFIGPATH/a5200/atari5200.glslp
rm -f $CONFIGPATH/ProSystem/atari7800.glslp
}

delete_capcomglslp() {
# --- Delete CAPCOM shader config files ---
rm -f $CONFIGPATH/FinalBurn\ Neo/cps1.glslp
rm -f $CONFIGPATH/FinalBurn\ Neo/cps2.glslp
rm -f $CONFIGPATH/FinalBurn\ Neo/cps3.glslp
}

delete_nesglslp() {
# --- Delete NES shader config file ---
rm -f $CONFIGPATH/Nestopia/nes.glslp
}

delete_snesglslp() {
# --- Delete SNES shader config file ---
rm -f $CONFIGPATH/Snes9x/snes.glslp
}

delete_sg1000glslp() {
# --- Delete SG-1000 shader config file ---
rm -f $CONFIGPATH/Genesis\ Plus\ GX/sg-1000.glslp
}

delete_msglslp() {
# --- Delete MasterSystem shader config file ---
rm -f $CONFIGPATH/Genesis\ Plus\ GX/mastersystem.glslp
}

delete_mdglslp() {
# --- Delete Mega Drive shader config file ---
rm -f $CONFIGPATH/Genesis\ Plus\ GX/megadrive.glslp
}

delete_segacdglslp() {
# --- Delete SEGA CD shader config file ---
rm -f $CONFIGPATH/Genesis\ Plus\ GX/segacd.glslp
}

delete_sega32xglslp() {
# --- Delete SEGA 32x shader config file ---
rm -f $CONFIGPATH/PicoDrive/sega32x.glslp
}

delete_pcengineglslp() {
# --- Delete PC Engine shader config file ---
rm -f $CONFIGPATH/Beetle\ PCE\ Fast/pcengine.glslp
}

delete_pcenginecdglslp() {
# --- Delete PC Engine CD shader config file ---
rm -f $CONFIGPATH/Beetle\ PCE\ Fast/pcenginecd.glslp
}

delete_neogeoglslp() {
# --- Delete NeoGeo shader config file ---
rm -f $CONFIGPATH/FinalBurn\ Neo/neogeo.glslp
}

delete_neogeocdglslp() {
# --- Delete NeoGeo CD shader config file ---
rm -f $CONFIGPATH/NeoCD/neogeocd.glslp
}

# ============================================================
# Exit the script
# ============================================================
exit_menu() {
	trap - EXIT
    printf "\033[H\033[2J" > "$CURR_TTY"
    printf "\e[?25h" > "$CURR_TTY"
	stop_gptkeyb
    if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
        [ -n "$original_font" ] && setfont "$original_font"
    fi

    exit 0
}

# ============================================================
# Remove All
# ============================================================
remove_all() {
	delete_gbglslp
	delete_gbcglslp
	delete_gbaglslp
	delete_ggglslp
	delete_ngpglslp
	delete_ngpcglslp
	delete_wscglslp
	delete_lynxglslp
	delete_arcadeglslp
	delete_atariglslp
	delete_capcomglslp
	delete_nesglslp
	delete_snesglslp
	delete_sg1000glslp
	delete_msglslp
	delete_mdglslp
	delete_segacdglslp
	delete_sega32xglslp
	delete_pcengineglslp
	delete_pcenginecdglslp
	delete_neogeoglslp
	delete_neogeocdglslp
	
	dialog --backtitle "$T_BACKTITLE" --title "$T_REMOVE_ALL" --msgbox "\n $T_REMOVED" 7 40 > "$CURR_TTY"
}

# ============================================================
# Apply All
# ============================================================
apply_all() {
	create_gbglslp
	create_gbcglslp
	create_gbaglslp
	create_ggglslp
	create_ngpglslp
	create_ngpcglslp
	create_wscglslp
	create_lynxglslp
	create_arcadeglslp
	create_atariglslp
	create_capcomglslp
	create_nesglslp
	create_snesglslp
	create_sg1000glslp
	create_msglslp
	create_mdglslp
	create_segacdglslp
	create_sega32xglslp
	create_pcengineglslp
	create_pcenginecdglslp
	create_neogeoglslp
	create_neogeocdglslp
	
	dialog --backtitle "$T_BACKTITLE" --title "$T_APPLY_ALL" --msgbox "\n $T_APPLIED" 7 40 > "$CURR_TTY"
}

# ============================================================
# Handheld Remove Menu
# ============================================================
handheld_remove_menu() {
	CHOICES=$(dialog --backtitle "$T_BACKTITLE" \
					 --title "$T_HHTITLE" \
					 --cancel-label "$T_BACK" \
					 --no-tags \
					 --checklist "$T_REMOVE\n$T_CONTROLS" 16 40 14 \
					 "1" "Nintendo GameBoy" "off" \
					 "2" "Nintendo GameBoy Color" "off" \
					 "3" "Nintendo GameBoy Advance" "off" \
					 "4" "SEGA GameGear" "off" \
					 "5" "NeoGeo Pocket" "off" \
					 "6" "NeoGeo Pocket Color" "off" \
					 "7" "WonderSwan Color" "off" \
					 "8" "Atari Lynx" "off" \
					 2>&1 > "$CURR_TTY")
					 
		EXIT_CODE=$?
		[[ $EXIT_CODE -ne 0 ]] && return
	
	for i in {1..8}; do
		if echo "$CHOICES" | grep -qw "$i"; then
			case "$i" in
				1) delete_gbglslp ;;
				2) delete_gbcglslp ;;
				3) delete_gbaglslp ;;
				4) delete_ggglslp ;;
				5) delete_ngpglslp ;;
				6) delete_ngpcglslp ;;
				7) delete_wscglslp ;;
				8) delete_lynxglslp ;;
			esac
		fi
	done
	
	dialog --backtitle "$T_BACKTITLE" --title "$T_HHTITLE" --msgbox "\n $T_REMOVED" 7 40 > "$CURR_TTY"
}

# ============================================================
# Handheld Apply Menu
# ============================================================
handheld_apply_menu() {
	CHOICES=$(dialog --backtitle "$T_BACKTITLE" \
					 --title "$T_HHTITLE" \
					 --cancel-label "$T_BACK" \
					 --no-tags \
					 --checklist "$T_APPLY\n$T_CONTROLS" 16 40 14 \
					 "1" "Nintendo GameBoy" "off" \
					 "2" "Nintendo GameBoy Color" "off" \
					 "3" "Nintendo GameBoy Advance" "off" \
					 "4" "SEGA GameGear" "off" \
					 "5" "NeoGeo Pocket" "off" \
					 "6" "NeoGeo Pocket Color" "off" \
					 "7" "WonderSwan Color" "off" \
					 "8" "Atari Lynx" "off" \
					 2>&1 > "$CURR_TTY")
					 
		EXIT_CODE=$?
		[[ $EXIT_CODE -ne 0 ]] && return
	
	for i in {1..8}; do
		if echo "$CHOICES" | grep -qw "$i"; then
			case "$i" in
				1) create_gbglslp ;;
				2) create_gbcglslp ;;
				3) create_gbaglslp ;;
				4) create_ggglslp ;;
				5) create_ngpglslp ;;
				6) create_ngpcglslp ;;
				7) create_wscglslp ;;
				8) create_lynxglslp ;;
			esac
		fi
	done

	dialog --backtitle "$T_BACKTITLE" --title "$T_HHTITLE" --msgbox "\n $T_APPLIED" 7 40 > "$CURR_TTY"
}


# ============================================================
# Console Remove Menu
# ============================================================
console_remove_menu() {
	CHOICES=$(dialog --backtitle "$T_BACKTITLE" \
					 --title "$T_CONTITLE" \
					 --cancel-label "$T_BACK" \
					 --no-tags \
					 --checklist "$T_REMOVE\n$T_CONTROLS" 16 40 14 \
					 "1" "Arcade/MAME" "off" \
					 "2" "Atari (2600/5200/7800)" "off" \
					 "3" "CAPCOM (I/II/III)" "off" \
					 "4" "Nintendo Entertainment System" "off" \
					 "5" "Super Nintendo ES" "off" \
					 "6" "SEGA SG-1000" "off" \
					 "7" "SEGA MasterSystem" "off" \
					 "8" "SEGA Mega Drive" "off" \
					 "9" "SEGA CD" "off" \
					 "10" "SEGA 32X" "off" \
					 "11" "PC Engine" "off" \
					 "12" "PC Engine CD" "off" \
					 "13" "NeoGeo" "off" \
					 "14" "NeoGeo CD" "off" \
					 2>&1 > "$CURR_TTY")
					 
		EXIT_CODE=$?
		[[ $EXIT_CODE -ne 0 ]] && return

	for i in {1..14}; do
		if echo "$CHOICES" | grep -qw "$i"; then
			case "$i" in
				1) delete_arcadeglslp ;;
				2) delete_atariglslp ;;
				3) delete_capcomglslp ;;
				4) delete_nesglslp ;;
				5) delete_snesglslp ;;
				6) delete_sg1000glslp ;;
				7) delete_msglslp ;;
				8) delete_mdglslp ;;
				9) delete_segacdglslp ;;
				10) delete_sega32xglslp ;;
				11) delete_pcengineglslp ;;
				12) delete_pcenginecdglslp ;;
				13) delete_neogeoglslp ;;
				14) delete_neogeocdglslp ;;
			esac
		fi
	done

	dialog --backtitle "$T_BACKTITLE" --title "$T_CONTITLE" --msgbox "\n $T_REMOVED" 7 40 > "$CURR_TTY"
}

# ============================================================
# Console Apply Menu
# ============================================================
console_apply_menu() {
	CHOICES=$(dialog --backtitle "$T_BACKTITLE" \
					 --title "$T_CONTITLE" \
					 --cancel-label "$T_BACK" \
					 --no-tags \
					 --checklist "$T_APPLY\n$T_CONTROLS" 16 40 14 \
					 "1" "Arcade/MAME" "off" \
					 "2" "Atari (2600/5200/7800)" "off" \
					 "3" "CAPCOM (I/II/III)" "off" \
					 "4" "Nintendo Entertainment System" "off" \
					 "5" "Super Nintendo ES" "off" \
					 "6" "SEGA SG-1000" "off" \
					 "7" "SEGA MasterSystem" "off" \
					 "8" "SEGA Mega Drive" "off" \
					 "9" "SEGA CD" "off" \
					 "10" "SEGA 32X" "off" \
					 "11" "PC Engine" "off" \
					 "12" "PC Engine CD" "off" \
					 "13" "NeoGeo" "off" \
					 "14" "NeoGeo CD" "off" \
					 2>&1 > "$CURR_TTY")
					 
		EXIT_CODE=$?
		[[ $EXIT_CODE -ne 0 ]] && return

	for i in {1..14}; do
		if echo "$CHOICES" | grep -qw "$i"; then
			case "$i" in
				1) create_arcadeglslp ;;
				2) create_atariglslp ;;
				3) create_capcomglslp ;;
				4) create_nesglslp ;;
				5) create_snesglslp ;;
				6) create_sg1000glslp ;;
				7) create_msglslp ;;
				8) create_mdglslp ;;
				9) create_segacdglslp ;;
				10) create_sega32xglslp ;;
				11) create_pcengineglslp ;;
				12) create_pcenginecdglslp ;;
				13) create_neogeoglslp ;;
				14) create_neogeocdglslp ;;
			esac
		fi
	done		

	dialog --backtitle "$T_BACKTITLE" --title "$T_CONTITLE" --msgbox "\n $T_APPLIED" 7 40 > "$CURR_TTY"
}

# ============================================================
# Remove Shaders Menu
# ============================================================
remove_shaders_menu() {
    while true; do
        local CHOICE
        CHOICE=$(dialog --clear \
						--cancel-label "$T_BACK" \
						--backtitle "$T_BACKTITLE" \
						--title "$T_REMOVE_MENU" \
						--menu "$T_SELECT" \
						10 40 6 \
						"1" "$T_HHTITLE" \
						"2" "$T_CONTITLE" \
						"3" "$T_REMOVE_ALL" \
						2>&1 > "$CURR_TTY")

        [[ $? -ne 0 ]] && return

        case "$CHOICE" in
            1) handheld_remove_menu ;;
            2) console_remove_menu ;;
			3) remove_all ;;
        esac
    done
}

# ============================================================
# Apply Shaders Menu
# ============================================================
apply_shaders_menu() {
    while true; do
        local CHOICE
        CHOICE=$(dialog --clear \
						--cancel-label "$T_BACK" \
						--backtitle "$T_BACKTITLE" \
						--title "$T_APPLY_MENU" \
						--menu "$T_SELECT" \
						10 40 6 \
						"1" "$T_HHTITLE" \
						"2" "$T_CONTITLE" \
						"3" "$T_APPLY_ALL" \
						2>&1 > "$CURR_TTY")

        [[ $? -ne 0 ]] && return

        case "$CHOICE" in
            1) handheld_apply_menu ;;
            2) console_apply_menu ;;
			3) apply_all ;;
        esac
    done
}


# ============================================================
# Main Menu
# ============================================================
main_menu() {
    while true; do
        local CHOICE
        CHOICE=$(dialog --clear \
						--cancel-label "$T_EXIT" \
						--backtitle "$T_BACKTITLE" \
						--title "$T_MAINTITLE" \
						--menu "$T_SELECT" \
						9 40 6 \
						"1" "$T_APPLY_MENU" \
						"2" "$T_REMOVE_MENU" \
						2>&1 > "$CURR_TTY")

        [[ $? -ne 0 ]] && exit_menu

        case "$CHOICE" in
            1) apply_shaders_menu ;;
            2) remove_shaders_menu ;;
        esac
    done
}

# ==============================================
# Shader File Creation
# ==============================================
create_files() {

dialog --backtitle "$T_BACKTITLE" --title "$T_DEPEND" --infobox "\n $T_INSTALL" 7 40 > "$CURR_TTY"

# --- Create Modern-Simple shader file ---
	cat > $SHADERPATH/modern-simple.glslp << 'EOF'
shaders = "3"
feedback_pass = "0"
shader0 = "shaders_glsl/scalenx/shaders/scale2xSFX.glsl"
alias0 = ""
wrap_mode0 = "clamp_to_border"
mipmap_input0 = "false"
filter_linear0 = "false"
float_framebuffer0 = "false"
srgb_framebuffer0 = "false"
scale_type_x0 = "source"
scale_x0 = "2.000000"
scale_type_y0 = "source"
scale_y0 = "2.000000"
shader1 = "shaders_glsl/stock.glsl"
alias1 = ""
wrap_mode1 = "clamp_to_border"
mipmap_input1 = "false"
filter_linear1 = "true"
float_framebuffer1 = "false"
srgb_framebuffer1 = "false"
shader2 = "shaders_glsl/interpolation/shaders/sharp-bilinear-simple.glsl"
alias2 = ""
wrap_mode2 = "clamp_to_border"
mipmap_input2 = "false"
filter_linear2 = "true"
float_framebuffer2 = "false"
srgb_framebuffer2 = "false"
EOF

# --- Create GameBoy Advance shader file --
	cat > $SHADERPATH/modern-gba.glslp << 'EOF'
shaders = "4"
feedback_pass = "0"
shader0 = "shaders_glsl/handheld/shaders/color/gba-color.glsl"
alias0 = ""
wrap_mode0 = "clamp_to_border"
mipmap_input0 = "false"
filter_linear0 = "false"
float_framebuffer0 = "false"
srgb_framebuffer0 = "false"
scale_type_x0 = "source"
scale_x0 = "1.000000"
scale_type_y0 = "source"
scale_y0 = "1.000000"
shader1 = "shaders_glsl/scalenx/shaders/scale2xSFX.glsl"
alias1 = ""
wrap_mode1 = "clamp_to_border"
mipmap_input1 = "false"
filter_linear1 = "false"
float_framebuffer1 = "false"
srgb_framebuffer1 = "false"
scale_type_x1 = "source"
scale_x1 = "2.000000"
scale_type_y1 = "source"
scale_y1 = "2.000000"
shader2 = "shaders_glsl/stock.glsl"
alias2 = ""
wrap_mode2 = "clamp_to_border"
mipmap_input2 = "false"
filter_linear2 = "true"
float_framebuffer2 = "false"
srgb_framebuffer2 = "false"
shader3 = "shaders_glsl/interpolation/shaders/sharp-bilinear-simple.glsl"
alias3 = ""
wrap_mode3 = "clamp_to_border"
mipmap_input3 = "false"
filter_linear3 = "true"
float_framebuffer3 = "false"
srgb_framebuffer3 = "false"
EOF

# --- Create Modern-NTSC shader file ---
	cat > $SHADERPATH/modern-ntsc.glslp << 'EOF'
shaders = "4"
feedback_pass = "0"
shader0 = "shaders_glsl/misc/shaders/ntsc-colors.glsl"
alias0 = ""
wrap_mode0 = "clamp_to_border"
mipmap_input0 = "false"
filter_linear0 = "false"
float_framebuffer0 = "false"
srgb_framebuffer0 = "false"
shader1 = "shaders_glsl/scalenx/shaders/scale2xSFX.glsl"
alias1 = ""
wrap_mode1 = "clamp_to_border"
mipmap_input1 = "false"
filter_linear1 = "false"
float_framebuffer1 = "false"
srgb_framebuffer1 = "false"
scale_type_x1 = "source"
scale_x1 = "2.000000"
scale_type_y1 = "source"
scale_y1 = "2.000000"
shader2 = "shaders_glsl/stock.glsl"
alias2 = ""
wrap_mode2 = "clamp_to_border"
mipmap_input2 = "false"
filter_linear2 = "true"
float_framebuffer2 = "false"
srgb_framebuffer2 = "false"
shader3 = "shaders_glsl/interpolation/shaders/sharp-bilinear-simple.glsl"
alias3 = ""
wrap_mode3 = "clamp_to_border"
mipmap_input3 = "false"
filter_linear3 = "true"
float_framebuffer3 = "false"
srgb_framebuffer3 = "false"
EOF

chown -R ark:ark $SHADERPATH

sleep 2
}

# =======================================================
# Clean up temporary keymap
# =======================================================
CleanupKeys() {
    rm -f "$TMP_KEYS"
}

# =======================================================
# Gamepad Setup
# =======================================================
export SDL_GAMECONTROLLERCONFIG_FILE="/opt/inttools/gamecontrollerdb.txt"
chmod 666 /dev/uinput
cp /opt/inttools/keys.gptk "$TMP_KEYS"
sed -i 's/^x = .*/x = space/' "$TMP_KEYS"
sed -i 's/^y = .*/y = space/' "$TMP_KEYS"
if grep -q '^b = backspace' "$TMP_KEYS"; then
    sed -i 's/^b = .*/b = esc/' "$TMP_KEYS"
    sed -i 's/^a = .*/a = enter/' "$TMP_KEYS"
fi
start_gptkeyb

# =======================================================
# Main Execution
# =======================================================
printf "\033[H\033[2J" > "$CURR_TTY"
dialog --clear
trap 'stop_gptkeyb; CleanupKeys; exit_menu' EXIT

[[ ! -f "/home/ark/.config/retroarch/overlay/gb-4k.png" ]] && create_files

main_menu

