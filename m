Return-Path: <stable+bounces-46502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8B8D06FF
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784CD289BA1
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9B815EFA8;
	Mon, 27 May 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLt8eRJj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD715E5D1;
	Mon, 27 May 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825241; cv=none; b=aTXCwDSNZ27K8M4bPiXmQE4NGvZCY9abJryzVZ/V4M5A4CpsnXWuQC04UQtfHUgKWMqdW0+Qe1SpSPuQH3sF8AGZE4+ZjlRtMT2Mujg43Qeequnb5Tju1GSbxXF39FcCNVwtyCm/W2vmLXzZlF6Z1y3l012Vxa2qbKXBQ6xNtuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825241; c=relaxed/simple;
	bh=usPfH4pL6CzqFQBNmbw6aRWHYqXftvOZaHjenx3H2iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZPddQBloKyTYywFY37dCMJhFeR3BxoPDXoRkjLAMtdMx2K17Tp6ao0cJz2t6itySwOkneIgoRsT5bgqygl3Yyg3MgokACgzHeDM4lrGFO+9t83Ez+kJ/CabXoeOXn/oynzKonRTu5ZlAI6tfW+/iAA52CZmdumf23hn1sWjq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLt8eRJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED126C2BBFC;
	Mon, 27 May 2024 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825240;
	bh=usPfH4pL6CzqFQBNmbw6aRWHYqXftvOZaHjenx3H2iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLt8eRJjIPhcASjiw5wFoWsQfnalHZSm1KS2MzCYItBIqvqc/JpnfzbdrGpaWx2CN
	 fc/bzd9EQwknxfe4NRSY6+slrijYKX3WMFhbNEze9Yow4CfCQzGuwy6i6bGgqDb0Bj
	 tPVYwyFMyI+8s/759X7GwGL8qr/d6dn8FSocw4zwrvL5910w4f3Wc8/8y0FYM0BfVR
	 lDIiGhKhZiI4FN7aFG9IvG2X/vjW01JNYU85gkPz1BjPzNkNaZihm8FDlz/g3kmoh/
	 TnlBnRSTGsc1Gem81jcbfYUsA+c6mjoHRX02ByiA/yinSEzGgZl8A2bILL6itGlBl7
	 K18etb0k/vuuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arvid Norlander <lkml@vorpal.se>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	coproscefalo@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 04/20] platform/x86: toshiba_acpi: Add quirk for buttons on Z830
Date: Mon, 27 May 2024 11:52:47 -0400
Message-ID: <20240527155349.3864778-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155349.3864778-1-sashal@kernel.org>
References: <20240527155349.3864778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arvid Norlander <lkml@vorpal.se>

[ Upstream commit 23f1d8b47d125dcd8c1ec62a91164e6bc5d691d0 ]

The Z830 has some buttons that will only work properly as "quickstart"
buttons. To enable them in that mode, a value between 1 and 7 must be
used for HCI_HOTKEY_EVENT. Windows uses 0x5 on this laptop so use that for
maximum predictability and compatibility.

As there is not yet a known way of auto detection, this patch uses a DMI
quirk table. A module parameter is exposed to allow setting this on other
models for testing.

Signed-off-by: Arvid Norlander <lkml@vorpal.se>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240131111641.4418-3-W_Armin@gmx.de
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/toshiba_acpi.c | 36 ++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 291f14ef67024..2a5a651235fe6 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -57,6 +57,11 @@ module_param(turn_on_panel_on_resume, int, 0644);
 MODULE_PARM_DESC(turn_on_panel_on_resume,
 	"Call HCI_PANEL_POWER_ON on resume (-1 = auto, 0 = no, 1 = yes");
 
+static int hci_hotkey_quickstart = -1;
+module_param(hci_hotkey_quickstart, int, 0644);
+MODULE_PARM_DESC(hci_hotkey_quickstart,
+		 "Call HCI_HOTKEY_EVENT with value 0x5 for quickstart button support (-1 = auto, 0 = no, 1 = yes");
+
 #define TOSHIBA_WMI_EVENT_GUID "59142400-C6A3-40FA-BADB-8A2652834100"
 
 /* Scan code for Fn key on TOS1900 models */
@@ -136,6 +141,7 @@ MODULE_PARM_DESC(turn_on_panel_on_resume,
 #define HCI_ACCEL_MASK			0x7fff
 #define HCI_ACCEL_DIRECTION_MASK	0x8000
 #define HCI_HOTKEY_DISABLE		0x0b
+#define HCI_HOTKEY_ENABLE_QUICKSTART	0x05
 #define HCI_HOTKEY_ENABLE		0x09
 #define HCI_HOTKEY_SPECIAL_FUNCTIONS	0x10
 #define HCI_LCD_BRIGHTNESS_BITS		3
@@ -2730,10 +2736,15 @@ static int toshiba_acpi_enable_hotkeys(struct toshiba_acpi_dev *dev)
 		return -ENODEV;
 
 	/*
+	 * Enable quickstart buttons if supported.
+	 *
 	 * Enable the "Special Functions" mode only if they are
 	 * supported and if they are activated.
 	 */
-	if (dev->kbd_function_keys_supported && dev->special_functions)
+	if (hci_hotkey_quickstart)
+		result = hci_write(dev, HCI_HOTKEY_EVENT,
+				   HCI_HOTKEY_ENABLE_QUICKSTART);
+	else if (dev->kbd_function_keys_supported && dev->special_functions)
 		result = hci_write(dev, HCI_HOTKEY_EVENT,
 				   HCI_HOTKEY_SPECIAL_FUNCTIONS);
 	else
@@ -3257,7 +3268,14 @@ static const char *find_hci_method(acpi_handle handle)
  * works. toshiba_acpi_resume() uses HCI_PANEL_POWER_ON to avoid changing
  * the configured brightness level.
  */
-static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
+#define QUIRK_TURN_ON_PANEL_ON_RESUME		BIT(0)
+/*
+ * Some Toshibas use "quickstart" keys. On these, HCI_HOTKEY_EVENT must use
+ * the value HCI_HOTKEY_ENABLE_QUICKSTART.
+ */
+#define QUIRK_HCI_HOTKEY_QUICKSTART		BIT(1)
+
+static const struct dmi_system_id toshiba_dmi_quirks[] = {
 	{
 	 /* Toshiba Portégé R700 */
 	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
@@ -3265,6 +3283,7 @@ static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
 		},
+	 .driver_data = (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Portégé R830 */
@@ -3274,6 +3293,7 @@ static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
 		},
+	 .driver_data = (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Portégé Z830 */
@@ -3281,6 +3301,7 @@ static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
 		},
+	 .driver_data = (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOTKEY_QUICKSTART),
 	},
 };
 
@@ -3289,6 +3310,8 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
 	u32 dummy;
+	const struct dmi_system_id *dmi_id;
+	long quirks = 0;
 	int ret = 0;
 
 	if (toshiba_acpi)
@@ -3441,8 +3464,15 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	}
 #endif
 
+	dmi_id = dmi_first_match(toshiba_dmi_quirks);
+	if (dmi_id)
+		quirks = (long)dmi_id->driver_data;
+
 	if (turn_on_panel_on_resume == -1)
-		turn_on_panel_on_resume = dmi_check_system(turn_on_panel_on_resume_dmi_ids);
+		turn_on_panel_on_resume = !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUME);
+
+	if (hci_hotkey_quickstart == -1)
+		hci_hotkey_quickstart = !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);
 
 	toshiba_wwan_available(dev);
 	if (dev->wwan_supported)
-- 
2.43.0


