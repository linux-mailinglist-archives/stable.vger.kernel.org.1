Return-Path: <stable+bounces-127730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4237A7AA05
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5F17A770C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CC7256C76;
	Thu,  3 Apr 2025 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snxcRyKt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCF253B7D;
	Thu,  3 Apr 2025 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706965; cv=none; b=UKDYjDD1VrcFemkwQkc+GPlWkDpyX2Tcb9c0njzk+xqy6Locqe68nGhGtyouGju4AoqSQ4VHSFlqJ29hnSsk9GTOymLeryG8A47/ZtAWJPHBg4lgJeWeHQrJI/ej/gSNehzniM7Ztr67pHrm/OLj9A5LnL75VOB4lqYfYdEk4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706965; c=relaxed/simple;
	bh=kJ2jEXmnju3HLRFGJ99O6SI8AOeIJq7v6im4cDEw3pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLxoNXHNSSKB4/TKWVXRrPAgjHCJKJ5i6VpjF6CEGrdQcJB4R1VxhLF2L176UhuiRsQE0nnfmY6+lrsGuLmnSVevjpqGfp1bjPr5jLgFBb3OfNYjjeDtE+YGmsUOe9UZs80ER86yKBqVv/HzpzIpHl+oZyquG6VpeZbjFYcus9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snxcRyKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D540BC4CEE8;
	Thu,  3 Apr 2025 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706964;
	bh=kJ2jEXmnju3HLRFGJ99O6SI8AOeIJq7v6im4cDEw3pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=snxcRyKtW1yM7FWRxPH2ziwL968QqrFi07l+WWkGCchYHtCFzBULGYsyv9I31UUJh
	 Ap1hPUTDIBajfj8I/K01C7wEjDwilVt0sadj/w56Mhjgum4+Yd9pMjx7juv0H71mws
	 VApX5Ucd4dPwuHY9+EhMYSBtqL+7FlN54BWmoi0zw6dlIyyuNGU/VdaXapTksuq7Ov
	 sW4h6XPPCZUGmbHMgYfYghe369l4mGK+ECG0g+4jA8t/TWwva26jReKueuVyRF8NKF
	 wsBT2+tHsuLgDtNqG+znfWjzb7WFV4Muk415zuAXAD+hC2o9qaj6RFneuoO5C6VPs4
	 NkU7lmmfbl2Qw==
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
	sd@queasysnail.net,
	jacob.e.keller@intel.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 15/54] net: usb: asix_devices: add FiberGecko DeviceID
Date: Thu,  3 Apr 2025 15:01:30 -0400
Message-Id: <20250403190209.2675485-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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


