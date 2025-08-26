Return-Path: <stable+bounces-175978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA0BB36B92
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9037D1C47B29
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D3350820;
	Tue, 26 Aug 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pYSITsY+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A429A322;
	Tue, 26 Aug 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218465; cv=none; b=PNT0vJ3JHb3AYQFpZaW4kSKCND7oSoihRU1U3g8GTIT4LTUnStJnfkHbne2tZ4tk6V4DB533mmqjkHYSGEsCsX1NWUCrkyu2du7h9PK4Ej1zXVPGeqXBBJldI8UBZUQoc50/eikuPWfh0j+ZcrZUm53QR7BjoJpJnFTmfJJhLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218465; c=relaxed/simple;
	bh=/bmG6iVcsFOb8fl27u4b65dl/s6JxFVcn6BwBkXqUfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufTcq52O5L5mfQNYrUivZ+AQ5X1w8ljEJKTJLx7CSRnseWh0N00m9fplflPJPQpHdZuFpxm4jh6MmzhhL8Mv7yB4k42YixmSfcPkFTU05FvvPi6oG0h+UwlKsDv25gFOnFpd7l4wevyzIhFi23n0xWVH5C3K+B91qlz8RIqvM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pYSITsY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14312C4CEF1;
	Tue, 26 Aug 2025 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218465;
	bh=/bmG6iVcsFOb8fl27u4b65dl/s6JxFVcn6BwBkXqUfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYSITsY+t5QX4WycqgkoS0GsLdJopx8WySvzy1yBVPeoLGT9M055q2AMjMcSU4bev
	 Ko4SREk1wzfgzZeMavKI9YhHmUmhtOR3mFUsT5nvQNf40U6IhIviiUjRWEBTRnJ6jL
	 nlVbkr3LuKB1vk855bwJ1etZMWe4o7lzdKvO5nrY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryan Mann <rmann@ndigital.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 003/403] USB: serial: ftdi_sio: add support for NDI EMGUIDE GEMINI
Date: Tue, 26 Aug 2025 13:05:29 +0200
Message-ID: <20250826110905.713018690@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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



