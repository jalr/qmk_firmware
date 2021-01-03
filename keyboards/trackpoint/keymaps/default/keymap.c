#include "kb.h"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP(),
	KEYMAP()
};

const macro_t *action_get_macro(keyrecord_t *record, uint8_t id, uint8_t opt) {
	return MACRO_NONE;
}

void matrix_init_user(void) {
}

void matrix_scan_user(void) {
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
	return true;
}

void led_set_user(uint8_t usb_led) {
}
