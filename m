Return-Path: <stable+bounces-56345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7BD923D3A
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524FE2879A8
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE115B57B;
	Tue,  2 Jul 2024 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fcmQQVOk"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4314D703
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922033; cv=none; b=ZlpSvMosqsUaOzp+96Bq+YMsJY4eaeTeauZF0HxVBIVw1QWzoVua8KJFlNTC3SMIrC1EBE+6sKNXWcUmymu3SkkURx2Wxg/ROhVRe6J/uupRCVs7uL+YjtOQxEvz2+BI+rN9i/tvmcIkCKwLdd2Csiv7so+WZhN9CXfaxHi0L/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922033; c=relaxed/simple;
	bh=d8i++GiRfnui0M6A3dHa5xxHn7NDiIxhIjRCDecJ5Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hV9804y6w+doHXZHZaMMtyUtCDaf0/mzXtvfnC/97GRg/GZHhoZNPVlh11f6WINUQ2z7SLUHuMKuJXAJLUKOYtdwzwyW7ixzSQWA2Ixh4JUwZWVKEDHubbNfrC7Tj5kzCqSSTYH+iFvvBjxvuHP6GGxBCOBqt1hXs2OWpkNtMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fcmQQVOk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719922016; x=1720526816; i=w_armin@gmx.de;
	bh=Ilw9DAdpFRu4mJaCitepxFoSQPasmg8ruvPtwYjihVk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fcmQQVOkJIuUNDNXutzoOOK/Br+LdyyMpTgZc/yXs/plin/zkIh8SCA/00++Sf6+
	 R0JzhRv+qYvi/9z75bk2FqiWzxA7qGhrqN3t8xOFxUMi3hK/Jw6CjgfV6F5vHFnYH
	 yYsVDw2EHxDQLR7k8quQhSe6VOOkQu76/70f+NL04EAGjBNVHdMQv/6MFAw6owmkG
	 l0FX8g+QZahDJxeSe7iVP4AJZMI1uOVuU9Q44PYT13W3C/a9wUqXgSJTE6Dpd5BLr
	 yXNHtlHQExNGKqQV0ziEhqYrwO/dPCZ1EWCEn0+tERuLWTdEGJyR1Y4YYzQvj7cJK
	 JaX/3PfK0fzPUWZCvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.183.169]) by
 mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mel3n-1rq6LS3zRV-00qh5Q; Tue, 02 Jul 2024 14:06:56 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Revert "platform/x86: toshiba_acpi: Add quirk for buttons on Z830"
Date: Tue,  2 Jul 2024 14:06:46 +0200
Message-Id: <20240702120646.10756-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+LRLZnc4ikeB5cQTRpPA2Xo8kHuoyzK50HoUZeYfj7jgdmapshO
 UVx6rnAZxSX3xAFkchi8+269WrxkqG/Ij9Kh7PmocZQa+Z1SCvs0UPQsIPO1rp/W+ne0swS
 hRKEjR0jjRChXx3SX0J9Wu96Q1jCs2aLsqAuX39pYRH8IVd6kHUWiF1C20pQvp8HIHcGMjP
 nIt6TidI0T24XyarnrZ2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/WuTf59MYBM=;iea/jz+kBwFlvfqStTgd8ytey9F
 uJMrAweodunm1WtlkC7/DJIQ2ALehx0VmMqwQ6nTiiD0qpHIQq31NeXszvdBeil7MlovNOTIl
 hU4BZtrVFYa7/9JHt5QfouFGrASOV9O3JbKN3T89HczTz4HGOaGijzyKedZlVyJAOoz9dn1/C
 BMa8VXUi7vdBbrdJt2pgv85GZ0pKC2vZJmRwFG90je+wAepXp2cDRA7mrc/DXemN2bOuracl/
 tNZ22FRVMAJfxwyIfk+olOPhrJTLqvCWIyX8eyfAPZEFt+hRrkWGP451nx+qxHc1Xee8r/Oh4
 dq1+c1cSt7XEu1ihWgFJZuAVIWimda4mrIeus3U9U0915lnOz4b0aI8MtQy6q6WAv+I6o6HrM
 6gvC1j8pGEcfYw/5V2xt7f7wLERWEECLE6oyaU15tHg0sdUrdtvrflsV3h24DDO4lSq22Fw4y
 0FZHwzQvvz9WXYD/nE/0m+fga0Q+/4ymbGiNJN50MMcP2Y4plKs0S+VNhJTTAHdO7Ec/uqqoW
 7B0QenRZg+HcoYApAeZqE1YO0ShmqIaF5hFBwwO2A+Sy9of2Yaa3EEK/5Pr0Lqlz67cZObvbw
 1EF7lH5SL7ekVacMjR+B+fDWt9QQOuuy9U8VkcE/B/7Swu3rk4h06DplIROwo6kNaTUzL4Lyc
 AyTCK4xXJhNkIS88ByRNd8+xH6Ivznl7M60AwdRwjRFAhlWvT6N+JJE7wSdI7dseU9gVYlXHd
 gu5I+rseRoPNB8Z/E5dqCYgQwcTh8Z41M7Qw47VKfUGWP1ZiAbAyz4JLY2s+nt9X0w2dk21/+
 a+eWSrgaVoZAwiOzKjOFDGPm4M/0j/kgFtjuRC7wDWgtnPu2ncLAZDc+HthEz0fXJwe82t3KA
 oC7RSw7uJ3FqhIaulnifQdAvSyqyXA/W56X8=

This reverts commit 10c66da9f87a96572ad92642ae060e827313b11c.

The associated patch depends on the availability of the ACPI
quickstart button driver, which will be available starting with
kernel 6.10. This means that the patch brings no benifit for
older kernels.

Even worse, it was found out that the patch is buggy, causing
regressions for people using older kernels.

Fix this by simply reverting the patch from the 6.9 stable tree.

Cc: <stable@vger.kernel.org> # 6.9.x
Reported-by: kemal <kmal@cock.li>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/toshiba_acpi.c | 36 +++--------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/to=
shiba_acpi.c
index 16e941449b14..77244c9aa60d 100644
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
@@ -2737,15 +2731,10 @@ static int toshiba_acpi_enable_hotkeys(struct tosh=
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
@@ -3269,14 +3258,7 @@ static const char *find_hci_method(acpi_handle hand=
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
@@ -3284,7 +3266,6 @@ static const struct dmi_system_id toshiba_dmi_quirks=
[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
 		},
-	 .driver_data =3D (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Port=C3=A9g=C3=A9 R830 */
@@ -3294,7 +3275,6 @@ static const struct dmi_system_id toshiba_dmi_quirks=
[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
 		},
-	 .driver_data =3D (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Port=C3=A9g=C3=A9 Z830 */
@@ -3302,7 +3282,6 @@ static const struct dmi_system_id toshiba_dmi_quirks=
[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
 		},
-	 .driver_data =3D (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOT=
KEY_QUICKSTART),
 	},
 };

@@ -3311,8 +3290,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi=
_dev)
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
 	u32 dummy;
-	const struct dmi_system_id *dmi_id;
-	long quirks =3D 0;
 	int ret =3D 0;

 	if (toshiba_acpi)
@@ -3465,15 +3442,8 @@ static int toshiba_acpi_add(struct acpi_device *acp=
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


