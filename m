Return-Path: <stable+bounces-180861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14EB8E9FD
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0441C3BD46B
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 00:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCD05464E;
	Mon, 22 Sep 2025 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBgggzD5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D83C33
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758501715; cv=none; b=YVNf5Ne7EkhlpncxQCMeCVeIQl3+YiUZ5sQQ7/PW8jf+wS6qb7odkTZTUgGEvPnFNy5FdAKQyiM60V+3hrgH+0YQlzCKc5aN2QEgbK9EoFpN+2iFe+FKrawWKC4zODyklcdUxe4jofwpJlIRZJOytcPwFrORSu71cRwIGNMUEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758501715; c=relaxed/simple;
	bh=QKrlPK8qVpZJi6wq1ioCxWUZe/bxIdjQs+DNMm7iD1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXNe+w0w20REl8/mydhC8t0PsjrXf8LHeNqJEyWEHClCy0aWc7CPDvvsyeZz7jtRxFKNwqC7gRvfjJt8gYzNKfXSvay07PtE7UozDsOGwhKGJ+aktg+5FUKKSVnzpl2lzwB0WFkcQC0OAWIw1tNgXFJFcRzN2pxtvNQgoHQV1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBgggzD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA88C4CEE7;
	Mon, 22 Sep 2025 00:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758501715;
	bh=QKrlPK8qVpZJi6wq1ioCxWUZe/bxIdjQs+DNMm7iD1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBgggzD5CSq1bFiTGGaldWlXCgjag46qkpbO7t0SJXsVZjirtA1YQ0lTUzEgWE9Ek
	 RnVkgdVudnsk4hIyrEjKdhzx5Dju8gudN1RwM3CKkxbRxvMQ8XDruWn+zDjeYTsR0o
	 w57BC+Jw6SEKKzvdWwlFcG8NvUyAF/m4zpLBczRiPaDbMznXb7JBaMXnZ3NRbV1jue
	 eZ0LIMp9joqBJWZMGzlfUbc6FkFoX8X4+071WN0NHjK8bHmf/ddVJh2FjIUaES7RBM
	 Q0dQwRiu16dMIMFZDdZdWjlJdzP6KLfQ6Qn56H5Nk5fJnv3ycMy//v1poZagKopALC
	 vPHiTLKGqd24Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/2] platform/x86: asus-wmi: Fix ROG button mapping, tablet mode on ASUS ROG Z13
Date: Sun, 21 Sep 2025 20:41:52 -0400
Message-ID: <20250922004153.3106044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092125-thigh-immerse-6abd@gregkh>
References: <2025092125-thigh-immerse-6abd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Antheas Kapenekakis <lkml@antheas.dev>

[ Upstream commit 132bfcd24925d4d4531a19b87acb8474be82a017 ]

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
Stable-dep-of: 225d1ee0f5ba ("platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan quirk")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 23 +++++++++++++++++++----
 drivers/platform/x86/asus-wmi.h    |  3 ++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index e6726be5890e7..6928bb6ae0f3c 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -147,7 +147,12 @@ static struct quirk_entry quirk_asus_ignore_fan = {
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
@@ -539,6 +544,15 @@ static const struct dmi_system_id asus_quirks[] = {
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
 
@@ -636,6 +650,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_IGNORE, 0xCF, },	/* AC mode */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
 	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
+	{ KE_KEY, ASUS_WMI_KEY_ARMOURY, { KEY_PROG3 } },
 	{ KE_END, 0},
 };
 
@@ -655,9 +670,9 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
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
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 018dfde4025e7..5cd4392b964eb 100644
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
-- 
2.51.0


