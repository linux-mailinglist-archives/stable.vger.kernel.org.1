Return-Path: <stable+bounces-150181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0071ACB6D3
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331C04C4E22
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7042423771C;
	Mon,  2 Jun 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wNafEyzU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8622A4EB;
	Mon,  2 Jun 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876293; cv=none; b=oGdvwJTS7VduE4FGumET/hFSfsAU78a6Q/iXpnKCz5aRSpaCCyt0CigfdPcDYNwjekt5lfnU7B6i70Ztd8ZtsOvnV9X3FXafrHkDcmAtgykNPen4nfyN02TX0pk4QRylXxRAKhHxh6PHJGtHOFj/QD0Az9BWYqgq5rfXCm0q2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876293; c=relaxed/simple;
	bh=lFl4j3/B70tVswHYHq4WTxPIx3ohCtAtISqtg8luqO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJWohDDPfolwSsPTIbYcIlkc+/dsINn3RJVME7s/H4dPD7ZzWUOjdeetRMmpcQziYmjyOy+dKMmtYBXYs0LixH/mF9PmKMaQbR45D223G0jvK2Lqf54PIsO/izxjuvnKZMQSDl+ex/o/u5+6ac+K/05y+j6GH+ZI6JCYBXGiTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wNafEyzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379D8C4CEEB;
	Mon,  2 Jun 2025 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876292;
	bh=lFl4j3/B70tVswHYHq4WTxPIx3ohCtAtISqtg8luqO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wNafEyzUpByCDf/DwOroY6saFZTcwDdqMx85QWLY/y+FIud4hMLa1/d+JlqT1n3+G
	 3oiugdv9tN9byjmE/C9SzRu3SiwqJU6EocLWSyxzYKUnRUzG/0Xc2z+6AQrJJRo6iQ
	 DW7AcwietfhLJndsL/DtE+3Dsb4U5DLFY73sGB1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 132/207] r8152: add vendor/device ID pair for Dell Alienware AW1022z
Date: Mon,  2 Jun 2025 15:48:24 +0200
Message-ID: <20250602134303.885891825@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksander Jan Bajkowski <olek2@wp.pl>

[ Upstream commit 848b09d53d923b4caee5491f57a5c5b22d81febc ]

The Dell AW1022z is an RTL8156B based 2.5G Ethernet controller.

Add the vendor and product ID values to the driver. This makes Ethernet
work with the adapter.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Link: https://patch.msgid.link/20250206224033.980115-1-olek2@wp.pl
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c   | 1 +
 include/linux/usb/r8152.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index abf4a488075ef..6cde3d262d415 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9853,6 +9853,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
 	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
+	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{}
 };
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 33a4c146dc19c..2ca60828f28bb 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -30,6 +30,7 @@
 #define VENDOR_ID_NVIDIA		0x0955
 #define VENDOR_ID_TPLINK		0x2357
 #define VENDOR_ID_DLINK			0x2001
+#define VENDOR_ID_DELL			0x413c
 #define VENDOR_ID_ASUS			0x0b05
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
-- 
2.39.5




