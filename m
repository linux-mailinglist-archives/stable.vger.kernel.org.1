Return-Path: <stable+bounces-1093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C437F7E01
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86166B2141A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCC13A8E4;
	Fri, 24 Nov 2023 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0d9V2N7K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21839FF3;
	Fri, 24 Nov 2023 18:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A30FC433C8;
	Fri, 24 Nov 2023 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850542;
	bh=IcvLvRwrx1hk95DYxUbTXUX7cc0iTq0Wyf2fcJLWKSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0d9V2N7KDMvgJO+uEm8XTcJueNN45dwFlA12Rw4kAjXBZ8/EeqRlGs7Pmry1+iIjM
	 0CLLUrX1+MRf/uEg8WpCq0KNw2GQqDKROU5m8eDgMid+N0vlvuuL4pw6oxGt4Gly+A
	 tA0YVSZzzvSdoPV/7d8g6VaLd+jANhH6csLTIXPk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikhail Khvainitski <me@khvoinitsky.org>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 091/491] HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround
Date: Fri, 24 Nov 2023 17:45:27 +0000
Message-ID: <20231124172027.330664475@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Khvainitski <me@khvoinitsky.org>

[ Upstream commit 46a0a2c96f0f47628190f122c2e3d879e590bcbe ]

Built-in firmware of cptkbd handles scrolling by itself (when middle
button is pressed) but with issues: it does not support horizontal and
hi-res scrolling and upon middle button release it sends middle button
click even if there was a scrolling event. Commit 3cb5ff0220e3 ("HID:
lenovo: Hide middle-button press until release") workarounds last
issue but it's impossible to workaround scrolling-related issues
without firmware modification.

Likely, Dennis Schneider has reverse engineered the firmware and
provided an instruction on how to patch it [1]. However,
aforementioned workaround prevents userspace (libinput) from knowing
exact moment when middle button has been pressed down and performing
"On-Button scrolling". This commit detects correctly-behaving patched
firmware if cursor movement events has been received during middle
button being pressed and stops applying workaround for this device.

Link: https://hohlerde.org/rauch/en/elektronik/projekte/tpkbd-fix/ [1]

Signed-off-by: Mikhail Khvainitski <me@khvoinitsky.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-lenovo.c | 68 ++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 44763c0da4441..9c1181313e44d 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -51,7 +51,12 @@ struct lenovo_drvdata {
 	int select_right;
 	int sensitivity;
 	int press_speed;
-	u8 middlebutton_state; /* 0:Up, 1:Down (undecided), 2:Scrolling */
+	/* 0: Up
+	 * 1: Down (undecided)
+	 * 2: Scrolling
+	 * 3: Patched firmware, disable workaround
+	 */
+	u8 middlebutton_state;
 	bool fn_lock;
 };
 
@@ -668,31 +673,48 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
 {
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	/* "wheel" scroll events */
-	if (usage->type == EV_REL && (usage->code == REL_WHEEL ||
-			usage->code == REL_HWHEEL)) {
-		/* Scroll events disable middle-click event */
-		cptkbd_data->middlebutton_state = 2;
-		return 0;
-	}
+	if (cptkbd_data->middlebutton_state != 3) {
+		/* REL_X and REL_Y events during middle button pressed
+		 * are only possible on patched, bug-free firmware
+		 * so set middlebutton_state to 3
+		 * to never apply workaround anymore
+		 */
+		if (cptkbd_data->middlebutton_state == 1 &&
+				usage->type == EV_REL &&
+				(usage->code == REL_X || usage->code == REL_Y)) {
+			cptkbd_data->middlebutton_state = 3;
+			/* send middle button press which was hold before */
+			input_event(field->hidinput->input,
+				EV_KEY, BTN_MIDDLE, 1);
+			input_sync(field->hidinput->input);
+		}
 
-	/* Middle click events */
-	if (usage->type == EV_KEY && usage->code == BTN_MIDDLE) {
-		if (value == 1) {
-			cptkbd_data->middlebutton_state = 1;
-		} else if (value == 0) {
-			if (cptkbd_data->middlebutton_state == 1) {
-				/* No scrolling inbetween, send middle-click */
-				input_event(field->hidinput->input,
-					EV_KEY, BTN_MIDDLE, 1);
-				input_sync(field->hidinput->input);
-				input_event(field->hidinput->input,
-					EV_KEY, BTN_MIDDLE, 0);
-				input_sync(field->hidinput->input);
+		/* "wheel" scroll events */
+		if (usage->type == EV_REL && (usage->code == REL_WHEEL ||
+				usage->code == REL_HWHEEL)) {
+			/* Scroll events disable middle-click event */
+			cptkbd_data->middlebutton_state = 2;
+			return 0;
+		}
+
+		/* Middle click events */
+		if (usage->type == EV_KEY && usage->code == BTN_MIDDLE) {
+			if (value == 1) {
+				cptkbd_data->middlebutton_state = 1;
+			} else if (value == 0) {
+				if (cptkbd_data->middlebutton_state == 1) {
+					/* No scrolling inbetween, send middle-click */
+					input_event(field->hidinput->input,
+						EV_KEY, BTN_MIDDLE, 1);
+					input_sync(field->hidinput->input);
+					input_event(field->hidinput->input,
+						EV_KEY, BTN_MIDDLE, 0);
+					input_sync(field->hidinput->input);
+				}
+				cptkbd_data->middlebutton_state = 0;
 			}
-			cptkbd_data->middlebutton_state = 0;
+			return 1;
 		}
-		return 1;
 	}
 
 	if (usage->type == EV_KEY && usage->code == KEY_FN_ESC && value == 1) {
-- 
2.42.0




