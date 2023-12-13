Return-Path: <stable+bounces-6219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635D80D976
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F676B21694
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F7851C50;
	Mon, 11 Dec 2023 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D7+zwyX8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176451C44;
	Mon, 11 Dec 2023 18:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB68BC433C7;
	Mon, 11 Dec 2023 18:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320833;
	bh=4zF96Xs4/1qmg9ut5Pa57CMgnxH576XMFHAJSURggcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7+zwyX8hxaKD+cZQFXqcmbI1Gxf7e+bAX1IIwIxW9pitZicoaDwIgoM2Zq3Qsx5Y
	 1gViQZpQVmcvzR53sy6rPFhN+WYjnKVHq//ZIbWgtznRUSs8BGZbqMtKy1Snd3/1Kq
	 BZX9PcBlSMmafKFUA8JTur8ajNeZG4ZCVvJtKrvA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <linux@rempel-privat.de>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 013/141] platform/x86: asus-wmi: Move i8042 filter install to shared asus-wmi code
Date: Mon, 11 Dec 2023 19:21:12 +0100
Message-ID: <20231211182027.075058962@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
User-Agent: quilt/0.67
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit b52cbca22cbf6c9d2700c1e576d0ddcc670e49d5 ]

asus-nb-wmi calls i8042_install_filter() in some cases, but it never
calls i8042_remove_filter(). This means that a dangling pointer to
the filter function is left after rmmod leading to crashes.

Fix this by moving the i8042-filter installation to the shared
asus-wmi code and also remove it from the shared code on driver unbind.

Fixes: b5643539b825 ("platform/x86: asus-wmi: Filter buggy scan codes on ASUS Q500A")
Cc: Oleksij Rempel <linux@rempel-privat.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231120154235.610808-2-hdegoede@redhat.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/Kconfig       |  2 +-
 drivers/platform/x86/asus-nb-wmi.c | 11 -----------
 drivers/platform/x86/asus-wmi.c    |  8 ++++++++
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 50abcf0c483c3..c03367b13db62 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -257,6 +257,7 @@ config ASUS_WMI
 	depends on RFKILL || RFKILL = n
 	depends on HOTPLUG_PCI
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on SERIO_I8042 || SERIO_I8042 = n
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
@@ -271,7 +272,6 @@ config ASUS_WMI
 config ASUS_NB_WMI
 	tristate "Asus Notebook WMI Driver"
 	depends on ASUS_WMI
-	depends on SERIO_I8042 || SERIO_I8042 = n
 	help
 	  This is a driver for newer Asus notebooks. It adds extra features
 	  like wireless radio and bluetooth control, leds, hotkeys, backlight...
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 7b8942fee76dd..49505939352ae 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -490,8 +490,6 @@ static const struct dmi_system_id asus_quirks[] = {
 
 static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 {
-	int ret;
-
 	quirks = &quirk_asus_unknown;
 	dmi_check_system(asus_quirks);
 
@@ -506,15 +504,6 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 
 	if (tablet_mode_sw != -1)
 		quirks->tablet_switch_mode = tablet_mode_sw;
-
-	if (quirks->i8042_filter) {
-		ret = i8042_install_filter(quirks->i8042_filter);
-		if (ret) {
-			pr_warn("Unable to install key filter\n");
-			return;
-		}
-		pr_info("Using i8042 filter function for receiving events\n");
-	}
 }
 
 static const struct key_entry asus_nb_wmi_keymap[] = {
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e7a01accf4ff1..2a06831449d5d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3092,6 +3092,12 @@ static int asus_wmi_add(struct platform_device *pdev)
 		goto fail_wmi_handler;
 	}
 
+	if (asus->driver->quirks->i8042_filter) {
+		err = i8042_install_filter(asus->driver->quirks->i8042_filter);
+		if (err)
+			pr_warn("Unable to install key filter - %d\n", err);
+	}
+
 	asus_wmi_battery_init(asus);
 
 	asus_wmi_debugfs_init(asus);
@@ -3128,6 +3134,8 @@ static int asus_wmi_remove(struct platform_device *device)
 	struct asus_wmi *asus;
 
 	asus = platform_get_drvdata(device);
+	if (asus->driver->quirks->i8042_filter)
+		i8042_remove_filter(asus->driver->quirks->i8042_filter);
 	wmi_remove_notify_handler(asus->driver->event_guid);
 	asus_wmi_backlight_exit(asus);
 	asus_wmi_input_exit(asus);
-- 
2.42.0




