Return-Path: <stable+bounces-140260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E03AAAA6B8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219B4189B22C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9D297112;
	Mon,  5 May 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHljladf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F742297109;
	Mon,  5 May 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484520; cv=none; b=Q1P3M/jIy92bkAIlfUrwYM0TNdyQlDr/L+z3ou7jTAoyMzlOflUeRiD2exoxuWdLdkHAvqxKgIpVBhhIdRjIH01RXrGJrq1NV3vKou4eKxfJZYyvuYM+QeFCPmoSoMk6odnQoRTfjpc3H3BNNCrJlHsDlEG5JqKmAm26QvWEZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484520; c=relaxed/simple;
	bh=efAAsusLpliVA+wnEyoY/khXhi125dU5XM0uCV+wq7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2TLkpweIl/LUhBuvjHj3xvNdEbNMik/y32n1NWiZfXjdvHKepUV2a37m9Q4apXs6s13he8ZpzV2d1fBc2EUC6SlxLC5l3y1XBU038KselIJIF6cKnvHIn5DjeHYJDf+E90UH4WxfwoqW7kDPAcCubYNu/3rpKtnnPOFV3mtelU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHljladf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C9FC4CEE4;
	Mon,  5 May 2025 22:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484520;
	bh=efAAsusLpliVA+wnEyoY/khXhi125dU5XM0uCV+wq7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHljladfDZcuZAG1y5W0NXqyJ9Q1NMXbKek4Q18EF9/sp8zk1kb6/DsL+lkLgz+Ne
	 AVF9IOP/hNR6YnphSKixfYdIqA2OkyX1hdWb85D4WqCreVKBxifNIttzQVxCaFfb4m
	 O6WcW6Kmxmy63I3oZCr9jbNwfkWQlE/uIM5RGdx7T9iW9pxLUtaTsbs44SrXzbDSYJ
	 fLWyKqSZm5WR01NhSvIBLJ0YPTVbE0yEAJJwRnxdVyQWtzHwMEE55qX9mL33yIDOJU
	 ZqUOHiBiDasGphijMVAaDWJMLXMbz/LaakwnnSewYybgCztoVAQ4ouyMblC4Xp5UOQ
	 lG2ofpuvPhy6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	hayeswang@realtek.com,
	horms@kernel.org,
	dianders@chromium.org,
	gmazyland@gmail.com,
	ste3ls@gmail.com,
	phahn-oss@avm.de,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 512/642] r8152: add vendor/device ID pair for Dell Alienware AW1022z
Date: Mon,  5 May 2025 18:12:08 -0400
Message-Id: <20250505221419.2672473-512-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

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
index 96fa3857d8e25..2cab046749a92 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10085,6 +10085,7 @@ static const struct usb_device_id rtl8152_table[] = {
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


