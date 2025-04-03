Return-Path: <stable+bounces-127869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F2AA7AC94
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ECFF7A7C34
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C02D27E1AD;
	Thu,  3 Apr 2025 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoEY1q3Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7527D77F;
	Thu,  3 Apr 2025 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707277; cv=none; b=OyFPMWpqLrlgvBanuhNIc5wlRClSpszhTp1vZWbm+KXuIpJqnZXxit+ESYp1OloeGr+0ks1M/9hjdY3sV4HXmhFN+QjFb9cw6+VEJvCU9Yn2w5M6b7P5D/jGWgxObYeFdPjOQhM5ItrU5TchTkQ7inSsU9n5bFj1/p3fuO2V0U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707277; c=relaxed/simple;
	bh=6rfcg2gxnCpP4fPZ2NdhJLHvBZubv5dztVBaEWskFFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UnwGYHhZzFMYmlS4k2NmX5impmCc7RlrAJTeF4J244vz69xAbK1kN3I5a8ZLCDouTi3l+Jz0YDbNGd0wi2MUcciRwhmuFG8g3/yzNtMywj/r1UOz7fxnrIWSKx+W5l02XfT5qiHw89A7x+YqpPBWvw2+uIuTqS8o2a3kVu9qQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoEY1q3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15731C4CEE3;
	Thu,  3 Apr 2025 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707276;
	bh=6rfcg2gxnCpP4fPZ2NdhJLHvBZubv5dztVBaEWskFFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoEY1q3QK8DYv0Swqm3wnafDhXI2Ap5s2PAMT93U9FNh3ZTCxPjWWZkrZAhh3XshU
	 KlOM6jhx8VICjst3t+z0pFgWvANxBNy52GBuYnQil0z8PoWAwm62OMgFX6IOrTmbf7
	 dW0TqaqLF3vGdth/fjnypMjvgbjHdXyLVraBIV76KPwHaxdJ4MnexM+vQCPX7kQlNN
	 VWR+cce7sHpF0D2YiMQ+ZDEQJgA9Py6VkxxI9ioIIVcCHf2jymYAAHztT/jL1kwk2e
	 DOSnWWRcQ1ycF+d1aIj7LZ1RHTYIuDoNLDjPy3OVq7783DsvusD8ERzmQzGO7v/tyi
	 JhQ94bssHDCTg==
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
	jacob.e.keller@intel.com,
	horms@kernel.org,
	shannon.nelson@amd.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/26] net: usb: asix_devices: add FiberGecko DeviceID
Date: Thu,  3 Apr 2025 15:07:23 -0400
Message-Id: <20250403190745.2677620-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190745.2677620-1-sashal@kernel.org>
References: <20250403190745.2677620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index f7cff58fe0449..ec4dcf89cbedd 100644
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


