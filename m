Return-Path: <stable+bounces-175465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107BB3683B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B5146812C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C402C0F9C;
	Tue, 26 Aug 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SKIdxrMv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CFF34AB0D;
	Tue, 26 Aug 2025 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217115; cv=none; b=qoTDZiCS5AU9Iwv3rlj97cGZP94RDN+Ticv+wrc8IhdPuxtjhx6dGUJNG0xkw/dH5ZK3VE5jB65o3Rb3zvhxJ1S4yKhV8hToQEvommt9ku1KnWScaizldXGNyPHc3ElunJXsjsOAZh/Zw22vNoBQxWaXP+3aQFBe4kQ2WfjV+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217115; c=relaxed/simple;
	bh=9w9g99EBy1F99R6SfeOnSmUrnkVAGgoETDm2XJvpkJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdeVE92cQ5u9GFrbR6RXi0Z8v7MFkDCEvokLH4faMjGSLjmsOyAAf4pIxeIarN52jLHGUO4XvEqF1n/bmCxMgCgwbyj5unufiRL4coLUdtiV1dTqUfs0JynDUtyFmi3fcw82Q2HxZ61bQ8A8TC02x3YwlfvOgEVc0cTXIn3WVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SKIdxrMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB23C4CEF1;
	Tue, 26 Aug 2025 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217114;
	bh=9w9g99EBy1F99R6SfeOnSmUrnkVAGgoETDm2XJvpkJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKIdxrMvs/isghHf6gohvYJaOIMGNZIqx4MZrgB158PkXonlR2li2E1xSwfCc2FHz
	 q4tKUi+TxKglFBsDXmwcQ2CZ2opNBD9LURQQT53KKPx6SRCQMQaq7hm+o+uh04HTXc
	 HkIOZICkgC7km2zGylRR1jEKrYZrSZMIV57VxCu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryan Mann <rmann@ndigital.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.10 004/523] USB: serial: ftdi_sio: add support for NDI EMGUIDE GEMINI
Date: Tue, 26 Aug 2025 13:03:34 +0200
Message-ID: <20250826110924.682622135@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -781,6 +781,8 @@ static const struct usb_device_id id_tab
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
@@ -197,6 +197,9 @@
 #define FTDI_NDI_FUTURE_3_PID		0xDA73	/* NDI future device #3 */
 #define FTDI_NDI_AURORA_SCU_PID		0xDA74	/* NDI Aurora SCU */
 
+#define FTDI_NDI_VID			0x23F2
+#define FTDI_NDI_EMGUIDE_GEMINI_PID	0x0003	/* NDI Emguide Gemini */
+
 /*
  * ChamSys Limited (www.chamsys.co.uk) USB wing/interface product IDs
  */



