Return-Path: <stable+bounces-56347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A84D923D52
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D39C1F22F6F
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF8315CD77;
	Tue,  2 Jul 2024 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fECIgi/E"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009282488
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922258; cv=none; b=r9YcjqSXY3rXriyDJrYCZbRwmKgc1DDNDgHkeEJLQxMBITwr7spTATZDZD8RJWZKQ4+uxcAXjFApfkNOz6qNRFE3ngfReg+ILibJ75An53uz2IjHaV6auRZVhPX8XlfxVjkn6h6pZ025h4DyQv8e87zwIbLZ1M6H+LvU8Q8WWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922258; c=relaxed/simple;
	bh=pJxCINEY3o3uks2ch9JzVnZ5OFAgQ7sR+zHfFi7p/i0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WvJO2bk8pgKmMtibrsMUVgGBTZAElCq1oe0I/9H8xK04uDz452wLcvEHtm42BMSiQuM510sqVzmhRdJKEw24VjYleEuJfGcmV3bdY+l1WXpMUqLJfRiMjkSQsHHP8uBfNAZkbWaTXijYP/VIwjuFyZ9uoZylGJ4Jzkx3kqHCDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fECIgi/E; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719922243; x=1720527043; i=w_armin@gmx.de;
	bh=sKcAOrbS+6PBdVYBcvwExarsFMXrQnjZ4lNVW9/5xOg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fECIgi/EdwFu4kdRvJvjDQ1m3ZJEVCCiqkZOmz/WiRF9JHkuL6DuDL2iorwlBAEe
	 e7twEjzCkZ4iMrHUWAeJeF5qKvBKIOXb0SSYMTMUOpd7gE/ggNlBRLI/wEaGVZtd4
	 sNqUEYohQaQ66l53IvWJTsspfEmMZCVRLz4oH7j+OtYOj3ip8hc/tTFmiqLflYl3v
	 f2ZDLUjS3GVFD/Cl8ukMIPsH/b/4FQ2FoFozTTgW9mWVkOtGnS//pHifMOSMAIxax
	 aJhmY5cOHGpXVNs9Enq+T2q4owi08X75ToTF54HpYaKZNYm+AxMd5FP7W1ZTb3pUy
	 9X8ezuZ3PGrxgzgYJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.183.169]) by
 mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MEFvp-1sYCjX2p9x-007brx; Tue, 02 Jul 2024 14:10:42 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Revert "platform/x86: toshiba_acpi: Add quirk for buttons on Z830"
Date: Tue,  2 Jul 2024 14:10:37 +0200
Message-Id: <20240702121037.11329-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sQhqILIQ28UGl/Af7Q7sOGtq0qHDXEGudJBmPgugGwEXr645XBb
 072ilGY75EoyQE2Db4OOswEWUs0a3LLk+Wn7eAxDgBhwU9Pb+P5yeIn8SxFaxLjsot6DTvz
 guERGbwzNyxgcYzBFOmyk2ZwDoUxpnUv0rDQU8BA7zjYA7R3kVRiWuLc7/sW+BqGJgZDQN3
 BUo6VXz35CxFMQRZItabw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/lecrI99EnA=;mt8pBbhrU7N1jvdDPB3XhqgSMk7
 XY/nmH/a7gUNbN6iEqMTnYpECGjZduouOvZRQKv4lQNUykLLIA6YHxifGxxBYr2nM9/3oHZWk
 py/uLgdp3u+WjdZOLeYSORgIhxOWdzAKK/vbWhmYC337kT7PMqHnosv3OrL4hqqgkioz31fu1
 cQS8EBdDniCwFsxU2gNjxHX/zZPXY3gLq3kat9VIdtqB56doLe2EzfDdxQgv7ZQ9EfbaWGtkB
 OGIzpRktuW8BXobmK1u9z1gZlC+t8Y5tahcztlAnyAm/onoqv8H4R7magLynZo8winGiBoJQN
 sN2lvLFAPLd/4fOZeHNxWKQX8DiEcaoT0S/MExyMMMvEJRTdSUSa12EiwnQSdbMMMf2j6ZJjP
 c5+e1ofUjGoF3OdJC10o63f+kEFshw2+aYGj3zJVDAHM4TF67yjOhegIxR+0AmpnR6+4mRhw3
 SiYKc118U7+iBEGJ41B+vgIzy+m5axhDY1eJHr1YEkTGETy2MqI1w1TdIMDUNYvLMOrBuy4E2
 jx43T8tgRDwNTURqnMZCwPbVb6DRhGAEV0FW36hCCK//DeTPVqtcxqhhg+vSVjSVNRGvonXca
 92WLgehH8LoTiBD3VxDq1vU7LRqAYvKkJ8hAvYpIhKVcZDHdTgo3bvvbqHAIl4IgiZgEOxQR2
 bS8xl7Pj0xpodo0+ol6FU4CTS8bs0JPiq6oyV2LGIRnTNTAOFNL8hQulbr43c4N9vtoIMK1A8
 DHRrGQKu60Acsrr3+DelFo3mhVF9P1yc1VYWuq7JJ2nc9RRfplp6Msxf8mEHXrtmI+QxWfQ6F
 QlKRHlcX9DYK0SZXbKZ+5nwnS94g/WG3F31d9Ve0vM0spkNIIESbes6j5dVcZjKJUAlEynglm
 T1A4LnzSQO7ifFwJcdunOhwq/Lv6xX+T2ceg=

This reverts commit 6239d65b917c29853592a8b417bdcedcbf1fe154.

The associated patch depends on the availability of the ACPI
quickstart button driver, which will be available starting with
kernel 6.10. This means that the patch brings no benifit for
older kernels.

Even worse, it was found out that the patch is buggy, causing
regressions for people using older kernels.

Fix this by simply reverting the patch from the 6.1 stable tree.

Cc: <stable@vger.kernel.org> # 6.1.x
Reported-by: kemal <kmal@cock.li>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/toshiba_acpi.c | 36 +++--------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/to=
shiba_acpi.c
index f10994b94a33..160abd3b3af8 100644
=2D-- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -57,11 +57,6 @@ module_param(turn_on_panel_on_resume, int, 0644);
 MODULE_PARM_DESC(turn_on_panel_on_resume,
 	"Call HCI_PANEL_POWER_ON on resume (-1 =3D auto, 0 =3D no, 1 =3D yes");

-static int hci_hotkey_quickstart =3D -1;
-module_param(hci_hotkey_quickstart, int, 0644);
-MODULE_PARM_DESC(hci_hotkey_quickstart,
-		 "Call HCI_HOTKEY_EVENT with value 0x5 for quickstart button support (-=
1 =3D auto, 0 =3D no, 1 =3D yes");
-
 #define TOSHIBA_WMI_EVENT_GUID "59142400-C6A3-40FA-BADB-8A2652834100"

 /* Scan code for Fn key on TOS1900 models */
@@ -141,7 +136,6 @@ MODULE_PARM_DESC(hci_hotkey_quickstart,
 #define HCI_ACCEL_MASK			0x7fff
 #define HCI_ACCEL_DIRECTION_MASK	0x8000
 #define HCI_HOTKEY_DISABLE		0x0b
-#define HCI_HOTKEY_ENABLE_QUICKSTART	0x05
 #define HCI_HOTKEY_ENABLE		0x09
 #define HCI_HOTKEY_SPECIAL_FUNCTIONS	0x10
 #define HCI_LCD_BRIGHTNESS_BITS		3
@@ -2736,15 +2730,10 @@ static int toshiba_acpi_enable_hotkeys(struct tosh=
iba_acpi_dev *dev)
 		return -ENODEV;

 	/*
-	 * Enable quickstart buttons if supported.
-	 *
 	 * Enable the "Special Functions" mode only if they are
 	 * supported and if they are activated.
 	 */
-	if (hci_hotkey_quickstart)
-		result =3D hci_write(dev, HCI_HOTKEY_EVENT,
-				   HCI_HOTKEY_ENABLE_QUICKSTART);
-	else if (dev->kbd_function_keys_supported && dev->special_functions)
+	if (dev->kbd_function_keys_supported && dev->special_functions)
 		result =3D hci_write(dev, HCI_HOTKEY_EVENT,
 				   HCI_HOTKEY_SPECIAL_FUNCTIONS);
 	else
@@ -3270,14 +3259,7 @@ static const char *find_hci_method(acpi_handle hand=
le)
  * works. toshiba_acpi_resume() uses HCI_PANEL_POWER_ON to avoid changing
  * the configured brightness level.
  */
-#define QUIRK_TURN_ON_PANEL_ON_RESUME		BIT(0)
-/*
- * Some Toshibas use "quickstart" keys. On these, HCI_HOTKEY_EVENT must u=
se
- * the value HCI_HOTKEY_ENABLE_QUICKSTART.
- */
-#define QUIRK_HCI_HOTKEY_QUICKSTART		BIT(1)
-
-static const struct dmi_system_id toshiba_dmi_quirks[] =3D {
+static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] =3D {
 	{
 	 /* Toshiba Port=C3=A9g=C3=A9 R700 */
 	 /* https://bugzilla.kernel.org/show_bug.cgi?id=3D21012 */
@@ -3285,7 +3267,6 @@ static const struct dmi_system_id toshiba_dmi_quirks=
[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
 		},
-	 .driver_data =3D (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Port=C3=A9g=C3=A9 R830 */
@@ -3295,7 +3276,6 @@ static const struct dmi_system_id toshiba_dmi_quirks=
[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
 		},
-	 .driver_data =3D (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Port=C3=A9g=C3=A9 Z830 */
@@ -3303,7 +3283,6 @@ static const struct dmi_system_id toshiba_dmi_quirks=
[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
 		},
-	 .driver_data =3D (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOT=
KEY_QUICKSTART),
 	},
 };

@@ -3312,8 +3291,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi=
_dev)
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
 	u32 dummy;
-	const struct dmi_system_id *dmi_id;
-	long quirks =3D 0;
 	int ret =3D 0;

 	if (toshiba_acpi)
@@ -3466,15 +3443,8 @@ static int toshiba_acpi_add(struct acpi_device *acp=
i_dev)
 	}
 #endif

-	dmi_id =3D dmi_first_match(toshiba_dmi_quirks);
-	if (dmi_id)
-		quirks =3D (long)dmi_id->driver_data;
-
 	if (turn_on_panel_on_resume =3D=3D -1)
-		turn_on_panel_on_resume =3D !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUME);
-
-	if (hci_hotkey_quickstart =3D=3D -1)
-		hci_hotkey_quickstart =3D !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);
+		turn_on_panel_on_resume =3D dmi_check_system(turn_on_panel_on_resume_dm=
i_ids);

 	toshiba_wwan_available(dev);
 	if (dev->wwan_supported)
=2D-
2.39.2


