Return-Path: <stable+bounces-163721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 627AAB0DB33
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420EC1C243D5
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A36E1A01B9;
	Tue, 22 Jul 2025 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BHlr5wK2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544812E36E8;
	Tue, 22 Jul 2025 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191991; cv=none; b=fXBbeVX5cLuwYqstmn6JBBowFB1O8coQktD+vuUuTHZmosKx40sdUnP5RgmOvN0Jte+TSsZ5grP9Vp+/RRJyBXLPzXhxduTgV9rAjL5YUn2McV4reoH0+wX9R2a0Q+Ii+CCqRr/MVN/vSEQwWMm2La7Ttod9gq+pZBjs/NFFkQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191991; c=relaxed/simple;
	bh=1vvX19XK010sJl5eih/W3SWz5D5wmmQSbFUiqJYxY9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcKBHVuqPCSSFOweTaouFyzVzx1pXFg/bo0UdkJQmkUpI5ocVcfhji/g1wlSdlsELPfRZ3j6avtTetmxI6piR7hshhbkJKu4CjhHqqTU9oLgKKfd/AAT1QjhdJPFSekgSIVYQZ0jr+Ryol7qj7AlErmZXS+imhtuxRyW5heOMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BHlr5wK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898D6C4CEEB;
	Tue, 22 Jul 2025 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753191990;
	bh=1vvX19XK010sJl5eih/W3SWz5D5wmmQSbFUiqJYxY9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHlr5wK2vBRdz52Y0T7rban6GQY+S/7cC3C8iWhbu0z0kJwJbCWX2p1RtZTFEIXKl
	 Iw7pyoRbwGhU0Fov5JbKPiNv+oUasJk7c3O5NEKHfIkIF6p2YzyTMQCnvFKiQzikah
	 WXSEsV7gCeZUOF6R2o3H5mEt8wFtAH9D/CshCFKU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryan Mann <rmann@ndigital.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.1 04/79] USB: serial: ftdi_sio: add support for NDI EMGUIDE GEMINI
Date: Tue, 22 Jul 2025 15:44:00 +0200
Message-ID: <20250722134328.545872184@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
References: <20250722134328.384139905@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryan Mann (NDI) <rmann@ndigital.com>

commit c980666b6958d9a841597331b38115a29a32250e upstream.

NDI (Northern Digital Inc.) is introducing a new product called the
EMGUIDE GEMINI that will use an FTDI chip for USB serial communications.
Add the NDI EMGUIDE GEMINI product ID that uses the NDI Vendor ID
rather than the FTDI Vendor ID, unlike older products.

Signed-off-by: Ryan Mann <rmann@ndigital.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/ftdi_sio.c     |    2 ++
 drivers/usb/serial/ftdi_sio_ids.h |    3 +++
 2 files changed, 5 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -803,6 +803,8 @@ static const struct usb_device_id id_tab
 		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NDI_AURORA_SCU_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
+	{ USB_DEVICE(FTDI_NDI_VID, FTDI_NDI_EMGUIDE_GEMINI_PID),
+		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
 	{ USB_DEVICE(NOVITUS_VID, NOVITUS_BONO_E_PID) },
 	{ USB_DEVICE(FTDI_VID, RTSYSTEMS_USB_VX8_PID) },
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -204,6 +204,9 @@
 #define FTDI_NDI_FUTURE_3_PID		0xDA73	/* NDI future device #3 */
 #define FTDI_NDI_AURORA_SCU_PID		0xDA74	/* NDI Aurora SCU */
 
+#define FTDI_NDI_VID			0x23F2
+#define FTDI_NDI_EMGUIDE_GEMINI_PID	0x0003	/* NDI Emguide Gemini */
+
 /*
  * ChamSys Limited (www.chamsys.co.uk) USB wing/interface product IDs
  */



