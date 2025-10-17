Return-Path: <stable+bounces-187310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB35BEAA37
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF07D946578
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F7D2F12D9;
	Fri, 17 Oct 2025 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GXRTRxBT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C2A330B28;
	Fri, 17 Oct 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715715; cv=none; b=E4PvNi1ouNKFctVVgbVBwtPDxV6iPkdqW5pR8zjGxpgQiEiButLittI2jyozFDh6cPXEvDTSQI79+MukHsAVUi6o9ZaxYc1WBHEdsh/k3111+rude7xX0JKWdxr4LVwwFIIkTqceUhW4sM53x9pgCYDyumoYMss3TVmmN56TzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715715; c=relaxed/simple;
	bh=+PdNMrqq5QMUGEjTMZMmn/6gIgZfOeL5T23D6qAQCoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nU7pgJpQEvLCurXFRQX9TmJnp4/sQhlZi9EXK6DkO5RnTIaNHDERC5OOXGnlV08IXLfcC+I+knYjHcKK05e+qc/e0avYSjpjsDxP4t9juv7sRbtRHdWEP2mqe71/4bWvOK/r4nOE6KYHWQ1tZaAA+sYJCC36xoPR3rOC9/Zo5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GXRTRxBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AEAC4CEE7;
	Fri, 17 Oct 2025 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715715;
	bh=+PdNMrqq5QMUGEjTMZMmn/6gIgZfOeL5T23D6qAQCoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXRTRxBT28RGd9E2MAemnG6GFiatK3zhg7wdNuSNYLbHUUJANkCCsYkOJ29bem1Ed
	 U4bOOxVi/mllRioabmOT8ujGi9DefqNqHYg3bYOcRElLZ1BdZLh1VGoVKnab71g+dp
	 fCGYfBhJkbGoyOfAbp3HKf5AIZSb//ujq6HWFhoE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nick Morrow <morrownr@gmail.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.17 313/371] wifi: mt76: mt7925u: Add VID/PID for Netgear A9000
Date: Fri, 17 Oct 2025 16:54:48 +0200
Message-ID: <20251017145213.400846604@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Morrow <morrownr@gmail.com>

commit f6159b2051e157550d7609e19d04471609c6050b upstream.

Add VID/PID 0846/9072 for recently released Netgear A9000.

Signed-off-by: Nick Morrow <morrownr@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/7afd3c3c-e7cf-4bd9-801d-bdfc76def506@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -12,6 +12,9 @@
 static const struct usb_device_id mt7925u_device_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7925, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
+	/* Netgear, Inc. A9000 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9072, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
 	{ },
 };
 



