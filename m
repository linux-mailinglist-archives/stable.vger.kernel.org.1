Return-Path: <stable+bounces-56346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D25E923D4A
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB19282DCA
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7758515CD75;
	Tue,  2 Jul 2024 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EOH8mait"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75382488
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922176; cv=none; b=JPr7hlpN0K3zKAEVlnwE2Yjmd4cpiqqheNGxU8XVpa7cpOFpTWWbN1QpoRbLrG6saINkh+V1QHWSnev2TrTt6giZ9bc7EMvLveoXHiJWvXqq2UiqFStbL2jrhgoQ3x2iaJIdb2dtdEqQq6/Z0aUS1r9kbDg8vBwwxjhCZiHNvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922176; c=relaxed/simple;
	bh=qP5P+C7sZUu4GpX8hY9sVNICF+1KVS2a3mrIXc8AWCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bOosaOjMRjXRqgu3OflW7u7TZwmY4z+EWh1SEv1Knl49W8NzJindvnLvuo8uKr2p9zQ9r3F2YVVXZJkj1KygzSfjFbc6xhw2+NIZpzl/yKO6bg1UqOqYyyMritNTJdOxQzjzoOUlgjApbeA5p94TJZ5h0JGaMjlDToyW8ftC/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EOH8mait; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719922159; x=1720526959; i=w_armin@gmx.de;
	bh=kdl3nV7mggj15c0t4Z+HO/aB8YQVF/5FTDZKXk40dwg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EOH8maitklvz4+00uxA4vgP7i6GmtGDRXl/cpYamzczWzgBWbaEM/z/4wrNybsbd
	 3dKQK5OyuapAcwaIPmuEmdIgUvu9zFwP/ulGL7VjEl/NJOSOe+Lt3WGn4Dmnxx3Vv
	 oAGtaQgdbi0goHYa+YHUpo1qj6K30C+ZYbifYmXbLbmFT+j+qepdPBJceH1ZJHHQP
	 ZGnUzl0uF2QK3nYlLjdwcmNVkyXglH0dZNa2KeAlUCH6JmNIHCTdBtTSqGWdthMq6
	 njgE6xlhJojYwvN7xa3b+glPuK+S5EdJjDyE/rN4zc2sTPn9CB6YlG6Qjm+38EztQ
	 k2/YC0BbLy9Y0vMRnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.183.169]) by
 mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N4QsO-1sG7k82UZ4-00zevt; Tue, 02 Jul 2024 14:09:19 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Revert "platform/x86: toshiba_acpi: Add quirk for buttons on Z830"
Date: Tue,  2 Jul 2024 14:09:13 +0200
Message-Id: <20240702120913.11078-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hh1al5b1GvN6wMKrLfTVWiERtFAh9dhW8Of5Uk7/VEy96j0Z080
 hB10VGtcvfHZ53EGcINDU8MqpLzWURNhRK5jUrvTjUCb3+urqvKdgyY0UuBjgDWuoH2dCcL
 lIZcK4nwAIV+y0qWIdcLnEgjUKHrfNKAlXuphUwz1Y6psdqqxGxX77n9pSRyE431xT9qbD/
 R4ieX2I2MTnFzalo5lmEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O7GSyiB0tV0=;zcNT5Nd6rz6XJk7nRn3iJ+FS5ps
 j7m5kQhaEO5OCFSj3zydmws7YLypJBsH/Ipm5kpvbXrpQJSCegzwGZH2lAq9INc666xyDS/rW
 eqWQIavu5N6RGrH0bLDQJfwb5wsOZe0xuQmzzMJW+/dQZewrFU+ZDoWSLWEXtsJtiBgZ+5za/
 knaZalChiZzAYM3v3c/GfIGX9GFBtdC3F1AJ16X5oPPSewDnJZ5QbEzUI6Q6etKr0lfTQe5As
 7goqUGpWYSlzgOo9EI9dpBFLazZTQzMM9Kwpl+UyD/5CV9rFH/fKAo/rpbxxkNi0WktvwM3Zv
 pceuSjqrZaXgxwvsO5nP0a5R5BBlOPE8sg9/CKfFx+WQLUOO4+L82BYcH8n6BmaF5PjUbYjkV
 fN0Nj5oumz7mY2cdx1K0JSsiTRdEN4D94NRl+nKDU3uvCvhtaiAML2cSmZbjVcGYvhHc1rsgr
 T6DeaCT+tnRe8j5iNqkv+Q2B4f5NmLsWJ6n5o9Zh4WRdiXfblss8fScrQSGQ+jd0TDK10LeSe
 MABtVTedd9p4w+IYTGDvfmbj0lgvbTUOfNEw0VVpTYm1U+559etyIWmp4Ikqrx4gSo/wjtTJk
 hiK/squSNSjWGLyaNvq8E/ekx0ZMuboLDwpnioDk8wfh8aAsLj/fZ9WzPxK7gqTbq9ctL53vC
 G1Mh3vLV3471DyykgP7eOyRNhHkS/J17pQcmctzBJ3xDEN21lOkbCmd4ucLUBnQd9ELfExn9o
 oiLmXluL7lqIqth+hJi4iMA/vmee+lb931xg3b18/CnXGuAYDJFFO8RyIEE3/QMym+Vb5RZjW
 ccNi15Z/6xa5RlxlZA7BTeJa2BzJHx4VqOc2h6CdCgoncDRi4MWXaGHwAH4JSjL+KdOmPpPTI
 a8hbwIqAyQBZbfg==

This reverts commit a63054e677fd098fbe69fc9a35325a300c14c698.

The associated patch depends on the availability of the ACPI
quickstart button driver, which will be available starting with
kernel 6.10. This means that the patch brings no benifit for
older kernels.

Even worse, it was found out that the patch is buggy, causing
regressions for people using older kernels.

Fix this by simply reverting the patch from the 6.6 stable tree.

Cc: <stable@vger.kernel.org> # 6.6.x
Reported-by: kemal <kmal@cock.li>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/toshiba_acpi.c | 36 +++--------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/to=
shiba_acpi.c
index 2a5a651235fe..291f14ef6702 100644
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
@@ -3268,14 +3257,7 @@ static const char *find_hci_method(acpi_handle hand=
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
@@ -3283,7 +3265,6 @@ static const struct dmi_system_id toshiba_dmi_quirks=
[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
 		},
-	 .driver_data =3D (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Port=C3=A9g=C3=A9 R830 */
@@ -3293,7 +3274,6 @@ static const struct dmi_system_id toshiba_dmi_quirks=
[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
 		},
-	 .driver_data =3D (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Port=C3=A9g=C3=A9 Z830 */
@@ -3301,7 +3281,6 @@ static const struct dmi_system_id toshiba_dmi_quirks=
[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
 		},
-	 .driver_data =3D (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOT=
KEY_QUICKSTART),
 	},
 };

@@ -3310,8 +3289,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi=
_dev)
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
 	u32 dummy;
-	const struct dmi_system_id *dmi_id;
-	long quirks =3D 0;
 	int ret =3D 0;

 	if (toshiba_acpi)
@@ -3464,15 +3441,8 @@ static int toshiba_acpi_add(struct acpi_device *acp=
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


