Return-Path: <stable+bounces-181394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58235B9318E
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0792A7A7A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765325A34F;
	Mon, 22 Sep 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FT9q9Rqb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305818C2C;
	Mon, 22 Sep 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570432; cv=none; b=RekfJABrjMyxHxIIlESPNEl9kyaop8kuYrSHLTk9JlmSSlncx2VVi0aqlXFPnYBhHVbTTyImROEqn/W0Plw0jTbOzgZqHIP7JukzafkdVLvz9oC1xy5KiovE5bPM5p3JSXIR4M8NluLTryrwGHsaDkuMaqS0N7PwUobDnVj0I90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570432; c=relaxed/simple;
	bh=ehShPMRpDaaZ6eEfJjZr+6bXgT1acQItcXporc1kRd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBki2syW3IH9noyIs9XdhI7X+tMDqAsawoYn8VgSlS0tYED46PALdASYETBh1YRmuMkAsilMoBbeXewMsHT8eHxA9Onxfsf6m2+KXtqaYxRPDjQbeb2A8tWLYAws/E8X7EYZ3XaO+z0WfAYmnUY7hmBr8buUAySExj/6HTUVjIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FT9q9Rqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E28AC4CEF0;
	Mon, 22 Sep 2025 19:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570432;
	bh=ehShPMRpDaaZ6eEfJjZr+6bXgT1acQItcXporc1kRd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FT9q9Rqb4tj9vRhqRMU/zEFj26aqD4yYN65n39QrSrW9ikuVzCkEf/OVPZhSz0nOz
	 G/TmVvNPGYjEMUG76pL6TpxAgh4jRf70Db2OPye9HtH6o9JzyBgXqPFpNaiRqVA9cC
	 Up78HBGF572dQnmQWxzP7U7UUdu6Hok50FHeT2Fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antheas Kapenekakis <lkml@antheas.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.16 139/149] platform/x86: asus-wmi: Fix ROG button mapping, tablet mode on ASUS ROG Z13
Date: Mon, 22 Sep 2025 21:30:39 +0200
Message-ID: <20250922192416.372469455@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antheas Kapenekakis <lkml@antheas.dev>

commit 132bfcd24925d4d4531a19b87acb8474be82a017 upstream.

On commit 9286dfd5735b ("platform/x86: asus-wmi: Fix spurious rfkill on
UX8406MA"), Mathieu adds a quirk for the Zenbook Duo to ignore the code
0x5f (WLAN button disable). On that laptop, this code is triggered when
the device keyboard is attached.

On the ASUS ROG Z13 2025, this code is triggered when pressing the side
button of the device, which is used to open Armoury Crate in Windows.

As this is becoming a pattern, where newer Asus laptops use this keycode
for emitting events, let's convert the wlan ignore quirk to instead
allow emitting codes, so that userspace programs can listen to it and
so that it does not interfere with the rfkill state.

With this patch, the Z13 wil emit KEY_PROG3 and the Duo will remain
unchanged and emit no event. While at it, add a quirk for the Z13 to
switch into tablet mode when removing the keyboard.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Link: https://lore.kernel.org/r/20250808154710.8981-2-lkml@antheas.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/asus-nb-wmi.c |   23 +++++++++++++++++++----
 drivers/platform/x86/asus-wmi.h    |    3 ++-
 2 files changed, 21 insertions(+), 5 deletions(-)

--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -147,7 +147,12 @@ static struct quirk_entry quirk_asus_ign
 };
 
 static struct quirk_entry quirk_asus_zenbook_duo_kbd = {
-	.ignore_key_wlan = true,
+	.key_wlan_event = ASUS_WMI_KEY_IGNORE,
+};
+
+static struct quirk_entry quirk_asus_z13 = {
+	.key_wlan_event = ASUS_WMI_KEY_ARMOURY,
+	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
 };
 
 static int dmi_matched(const struct dmi_system_id *dmi)
@@ -539,6 +544,15 @@ static const struct dmi_system_id asus_q
 		},
 		.driver_data = &quirk_asus_zenbook_duo_kbd,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG Z13",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Flow Z13"),
+		},
+		.driver_data = &quirk_asus_z13,
+	},
 	{},
 };
 
@@ -636,6 +650,7 @@ static const struct key_entry asus_nb_wm
 	{ KE_IGNORE, 0xCF, },	/* AC mode */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
 	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
+	{ KE_KEY, ASUS_WMI_KEY_ARMOURY, { KEY_PROG3 } },
 	{ KE_END, 0},
 };
 
@@ -655,9 +670,9 @@ static void asus_nb_wmi_key_filter(struc
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
 		break;
-	case 0x5F: /* Wireless console Disable */
-		if (quirks->ignore_key_wlan)
-			*code = ASUS_WMI_KEY_IGNORE;
+	case 0x5F: /* Wireless console Disable / Special Key */
+		if (quirks->key_wlan_event)
+			*code = quirks->key_wlan_event;
 		break;
 	}
 }
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -18,6 +18,7 @@
 #include <linux/i8042.h>
 
 #define ASUS_WMI_KEY_IGNORE (-1)
+#define ASUS_WMI_KEY_ARMOURY	0xffff01
 #define ASUS_WMI_BRN_DOWN	0x2e
 #define ASUS_WMI_BRN_UP		0x2f
 
@@ -40,7 +41,7 @@ struct quirk_entry {
 	bool wmi_force_als_set;
 	bool wmi_ignore_fan;
 	bool filter_i8042_e1_extended_codes;
-	bool ignore_key_wlan;
+	int key_wlan_event;
 	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
 	int wapf;
 	/*



