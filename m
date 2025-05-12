Return-Path: <stable+bounces-143698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE6FAB4113
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7278C3164
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C80D255E52;
	Mon, 12 May 2025 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hq1QIbZh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C5F2505C5;
	Mon, 12 May 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072791; cv=none; b=J84iwlTRwkvKgIrScCu+2ySroc0+fzsSz5zwKyhwPeQvki3DXE3iTXmj0Myk8YJJSe0H4OJbDMRq7jMsS6trM5o1RigrvxXJ7vjvb3MXabmRYoc+hrC4a2I5Al2Ph9dkC4R54/XVD5HznnI2e+xN3ZPxiyiBTdQnauk/FOCMqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072791; c=relaxed/simple;
	bh=Pm1RmMdKPXv4TvImGHgid8qyN9Mdswkjmx4m+AssvS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2q4xFO0Vph3yo3/iUBTFFYRlDyxPj8YUcCVk/eMbYefByZ9cyI2+QSdjjAyThC0rsyc6z0yEhmcSjSqpmSzUMBVdTMYa5Ck/OHFY2V4Wz+TL0nYZqakU4iVrgjfL7EguhGEk1XQg7G8wT5M3fdUA+Q/m21MFBTLYil3XexqK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hq1QIbZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BD8C4CEE7;
	Mon, 12 May 2025 17:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072790;
	bh=Pm1RmMdKPXv4TvImGHgid8qyN9Mdswkjmx4m+AssvS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hq1QIbZhHrAbnMbcE4vTW+8L0fuIwAGtPHjeW7/IfleJvysf0C2Kx84N+84L6tfNW
	 wKwPxOE5QSQPrLp3/yP//LQSTdz3NbknM2BrC+ymJCPQCfAmT5WcUMlADFPcycVB+N
	 ZKXzntnt/3iaaA51M7M/BxMSTB+Nq1iqqz7NEMyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vicki Pfau <vi@endrift.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.12 057/184] Input: xpad - fix Share button on Xbox One controllers
Date: Mon, 12 May 2025 19:44:18 +0200
Message-ID: <20250512172044.057944629@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vicki Pfau <vi@endrift.com>

commit 4ef46367073b107ec22f46fe5f12176e87c238e8 upstream.

The Share button, if present, is always one of two offsets from the end of the
file, depending on the presence of a specific interface. As we lack parsing for
the identify packet we can't automatically determine the presence of that
interface, but we can hardcode which of these offsets is correct for a given
controller.

More controllers are probably fixable by adding the MAP_SHARE_BUTTON in the
future, but for now I only added the ones that I have the ability to test
directly.

Signed-off-by: Vicki Pfau <vi@endrift.com>
Link: https://lore.kernel.org/r/20250328234345.989761-2-vi@endrift.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/joystick/xpad.c |   35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -77,12 +77,13 @@
  * xbox d-pads should map to buttons, as is required for DDR pads
  * but we map them to axes when possible to simplify things
  */
-#define MAP_DPAD_TO_BUTTONS		(1 << 0)
-#define MAP_TRIGGERS_TO_BUTTONS		(1 << 1)
-#define MAP_STICKS_TO_NULL		(1 << 2)
-#define MAP_SELECT_BUTTON		(1 << 3)
-#define MAP_PADDLES			(1 << 4)
-#define MAP_PROFILE_BUTTON		(1 << 5)
+#define MAP_DPAD_TO_BUTTONS		BIT(0)
+#define MAP_TRIGGERS_TO_BUTTONS		BIT(1)
+#define MAP_STICKS_TO_NULL		BIT(2)
+#define MAP_SHARE_BUTTON		BIT(3)
+#define MAP_PADDLES			BIT(4)
+#define MAP_PROFILE_BUTTON		BIT(5)
+#define MAP_SHARE_OFFSET		BIT(6)
 
 #define DANCEPAD_MAP_CONFIG	(MAP_DPAD_TO_BUTTONS |			\
 				MAP_TRIGGERS_TO_BUTTONS | MAP_STICKS_TO_NULL)
@@ -135,7 +136,7 @@ static const struct xpad_device {
 	{ 0x03f0, 0x048D, "HyperX Clutch", 0, XTYPE_XBOX360 },			/* wireless */
 	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x03f0, 0x07A0, "HyperX Clutch Gladiate RGB", 0, XTYPE_XBOXONE },
-	{ 0x03f0, 0x08B6, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },		/* v2 */
+	{ 0x03f0, 0x08B6, "HyperX Clutch Gladiate", MAP_SHARE_BUTTON, XTYPE_XBOXONE },		/* v2 */
 	{ 0x03f0, 0x09B4, "HyperX Clutch Tanto", 0, XTYPE_XBOXONE },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
@@ -159,7 +160,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x0b00, "Microsoft X-Box One Elite 2 pad", MAP_PADDLES, XTYPE_XBOXONE },
 	{ 0x045e, 0x0b0a, "Microsoft X-Box Adaptive Controller", MAP_PROFILE_BUTTON, XTYPE_XBOXONE },
-	{ 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller", MAP_SELECT_BUTTON, XTYPE_XBOXONE },
+	{ 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller", MAP_SHARE_BUTTON | MAP_SHARE_OFFSET, XTYPE_XBOXONE },
 	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360 },
@@ -211,7 +212,7 @@ static const struct xpad_device {
 	{ 0x0738, 0xcb29, "Saitek Aviator Stick AV8R02", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xf738, "Super SFIV FightStick TE S", 0, XTYPE_XBOX360 },
 	{ 0x07ff, 0xffff, "Mad Catz GamePad", 0, XTYPE_XBOX360 },
-	{ 0x0b05, 0x1a38, "ASUS ROG RAIKIRI", 0, XTYPE_XBOXONE },
+	{ 0x0b05, 0x1a38, "ASUS ROG RAIKIRI", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x0b05, 0x1abb, "ASUS ROG RAIKIRI PRO", 0, XTYPE_XBOXONE },
 	{ 0x0c12, 0x0005, "Intec wireless", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8801, "Nyko Xbox Controller", 0, XTYPE_XBOX },
@@ -390,7 +391,7 @@ static const struct xpad_device {
 	{ 0x2dc8, 0x6001, "8BitDo SN30 Pro", 0, XTYPE_XBOX360 },
 	{ 0x2e24, 0x0652, "Hyperkin Duke X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x2e24, 0x1688, "Hyperkin X91 X-Box One pad", 0, XTYPE_XBOXONE },
-	{ 0x2e95, 0x0504, "SCUF Gaming Controller", MAP_SELECT_BUTTON, XTYPE_XBOXONE },
+	{ 0x2e95, 0x0504, "SCUF Gaming Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x31e3, 0x1100, "Wooting One", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1200, "Wooting Two", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1210, "Wooting Lekker", 0, XTYPE_XBOX360 },
@@ -1027,7 +1028,7 @@ static void xpad360w_process_packet(stru
  *	The report format was gleaned from
  *	https://github.com/kylelemons/xbox/blob/master/xbox.go
  */
-static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, u32 len)
 {
 	struct input_dev *dev = xpad->dev;
 	bool do_sync = false;
@@ -1068,8 +1069,12 @@ static void xpadone_process_packet(struc
 		/* menu/view buttons */
 		input_report_key(dev, BTN_START,  data[4] & BIT(2));
 		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
-		if (xpad->mapping & MAP_SELECT_BUTTON)
-			input_report_key(dev, KEY_RECORD, data[22] & BIT(0));
+		if (xpad->mapping & MAP_SHARE_BUTTON) {
+			if (xpad->mapping & MAP_SHARE_OFFSET)
+				input_report_key(dev, KEY_RECORD, data[len - 26] & BIT(0));
+			else
+				input_report_key(dev, KEY_RECORD, data[len - 18] & BIT(0));
+		}
 
 		/* buttons A,B,X,Y */
 		input_report_key(dev, BTN_A,	data[4] & BIT(4));
@@ -1217,7 +1222,7 @@ static void xpad_irq_in(struct urb *urb)
 		xpad360w_process_packet(xpad, 0, xpad->idata);
 		break;
 	case XTYPE_XBOXONE:
-		xpadone_process_packet(xpad, 0, xpad->idata);
+		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	default:
 		xpad_process_packet(xpad, 0, xpad->idata);
@@ -1974,7 +1979,7 @@ static int xpad_init_input(struct usb_xp
 	    xpad->xtype == XTYPE_XBOXONE) {
 		for (i = 0; xpad360_btn[i] >= 0; i++)
 			input_set_capability(input_dev, EV_KEY, xpad360_btn[i]);
-		if (xpad->mapping & MAP_SELECT_BUTTON)
+		if (xpad->mapping & MAP_SHARE_BUTTON)
 			input_set_capability(input_dev, EV_KEY, KEY_RECORD);
 	} else {
 		for (i = 0; xpad_btn[i] >= 0; i++)



