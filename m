Return-Path: <stable+bounces-127782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA53A7ABA9
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6143F17154F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22296263C65;
	Thu,  3 Apr 2025 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSpHyGYs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A79253B69;
	Thu,  3 Apr 2025 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707075; cv=none; b=HP8Tto12ZrdpwvnKdX/lrF2wBaow/JazIKuD8kdcZ/XdrJoDshYikWP1/mNPjHNwedZQCCF3qJE9OegRFvVSo4bPcjnKOaaiYW2ZLL4c7FY8wImpikTcgJ4u+7N0zpBfWeJaE8NAHjvupKw5KS7ivfE5ziciD3DJLdLUnvYXCnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707075; c=relaxed/simple;
	bh=kJ2jEXmnju3HLRFGJ99O6SI8AOeIJq7v6im4cDEw3pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdWt3ILZzQVNiSToTzQVq0zOA9c7riYXvymg3/hB2iCPhBK2Ewd++ojboVqh8d7swJjYYY5sVwJ0hTcUGO38KB6q3Nn7SOWEkY/e0tbETuI56gF6JKP3u7kNsW1FVqQ8G/pthCS5HUBvxct2ZwHoH8k0UAePDEg70p1BTdDeTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSpHyGYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A66C4CEE8;
	Thu,  3 Apr 2025 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707075;
	bh=kJ2jEXmnju3HLRFGJ99O6SI8AOeIJq7v6im4cDEw3pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSpHyGYslNXBeV3hWHSdYjA3jLUyHagxTePmAu77wN8V/p/Q5LuHVobg//0h4FciG
	 qcPsxft0CbcKxnlhiIn8bDfap8cIk/szbvHsbmgL5eguaU5qkGBtHIsIlK896ejMVg
	 aWZczMzcJWwH3DawvRSWuSTGxMkGzdbkUBTR6tj0PgBcCAd5OkMdTVHZtj2OBCQIq1
	 LG9LZaIzgMg5My199N3qJGLn17U6nW8jIYYdwrxDRKsbpvop9PfDweqAJK0laP3IgO
	 FAiE72ersSbAmIVsVpu7EPwdfzvcxL3Vh/8BkxosMWTBqNKzxD1KBloqCQkQiqAAy6
	 O7OQxvf0zQ4Xg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Schulze <max.schulze@online.de>,
	David Hollis <dhollis@davehollis.com>,
	Sven Kreiensen <s.kreiensen@lyconsys.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shannon.nelson@amd.com,
	sd@queasysnail.net,
	jacob.e.keller@intel.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 13/49] net: usb: asix_devices: add FiberGecko DeviceID
Date: Thu,  3 Apr 2025 15:03:32 -0400
Message-Id: <20250403190408.2676344-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Max Schulze <max.schulze@online.de>

[ Upstream commit 4079918ae720e842ed7dff65fedeb9980b374995 ]

The FiberGecko is a small USB module that connects a 100 Mbit/s SFP

Signed-off-by: Max Schulze <max.schulze@online.de>
Tested-by: Max Schulze <max.schulze@online.de>
Suggested-by: David Hollis <dhollis@davehollis.com>
Reported-by: Sven Kreiensen <s.kreiensen@lyconsys.com>
Link: https://patch.msgid.link/20250212150957.43900-2-max.schulze@online.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/asix_devices.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 57d6e5abc30e8..da24941a6e444 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -1421,6 +1421,19 @@ static const struct driver_info hg20f9_info = {
 	.data = FLAG_EEPROM_MAC,
 };
 
+static const struct driver_info lyconsys_fibergecko100_info = {
+	.description = "LyconSys FiberGecko 100 USB 2.0 to SFP Adapter",
+	.bind = ax88178_bind,
+	.status = asix_status,
+	.link_reset = ax88178_link_reset,
+	.reset = ax88178_link_reset,
+	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
+		 FLAG_MULTI_PACKET,
+	.rx_fixup = asix_rx_fixup_common,
+	.tx_fixup = asix_tx_fixup,
+	.data = 0x20061201,
+};
+
 static const struct usb_device_id	products [] = {
 {
 	// Linksys USB200M
@@ -1578,6 +1591,10 @@ static const struct usb_device_id	products [] = {
 	// Linux Automation GmbH USB 10Base-T1L
 	USB_DEVICE(0x33f7, 0x0004),
 	.driver_info = (unsigned long) &lxausb_t1l_info,
+}, {
+	/* LyconSys FiberGecko 100 */
+	USB_DEVICE(0x1d2a, 0x0801),
+	.driver_info = (unsigned long) &lyconsys_fibergecko100_info,
 },
 	{ },		// END
 };
-- 
2.39.5


