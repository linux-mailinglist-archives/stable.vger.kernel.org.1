Return-Path: <stable+bounces-170283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 676B8B2A3DB
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E628D580566
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1131CA50;
	Mon, 18 Aug 2025 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLUwDvUJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01C12DDA1;
	Mon, 18 Aug 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522133; cv=none; b=UYy+F5Bt41mJ7vaWTXySKM3yp/Bt653OcjzADAFKTXTGeF9Ve23m86vBuKStCiZke/vz89eyUbAllglLZ94YTGehuzz/K41IvbGDfWeBA4upIm7j2COc8Ha/Qluq79A/amLZjvYF/UrsCewVe6kSUc+w16gLf6UQRMHaldKddA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522133; c=relaxed/simple;
	bh=w1W/+wOvbij+5OJ9D01HlDPMEbcXNj49aqZXn2XSEn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYuZPZfv7++kKpyK2pqmwv6BQFwUCC7CcOXQFsGAKqEyft74wxT6PGmtI9dybV3x0OThr9ZLg4OGRKZCdfgd/67RO37jDeMzpp31DXlm4z2JY4DVERK1F2lxQth7Gp7g1HKNzqwH4/mlGrTlJANySw+qNkF+ptud54P8w3sD2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLUwDvUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F6FC4CEEB;
	Mon, 18 Aug 2025 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522133;
	bh=w1W/+wOvbij+5OJ9D01HlDPMEbcXNj49aqZXn2XSEn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLUwDvUJKWRkh56cdP6xuFFUmOOig93uwYODC8Gy2QtUVtLga2iz3/KefP/ZqSB7R
	 s1Lf1+XK7mKGyZ1I61MRBuOWPxSLni9f05Lw2wmXDVK1QgNmuRlB/rwMBFkDAKZ4yc
	 XVGFWSboZez3EnFAb6FRKZNdzhKjQQ4qH84PbZaU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	zhangjianrong <zhangjianrong5@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 218/444] net: thunderbolt: Enable end-to-end flow control also in transmit
Date: Mon, 18 Aug 2025 14:44:04 +0200
Message-ID: <20250818124457.018174995@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

From: zhangjianrong <zhangjianrong5@huawei.com>

[ Upstream commit a8065af3346ebd7c76ebc113451fb3ba94cf7769 ]

According to USB4 specification, if E2E flow control is disabled for
the Transmit Descriptor Ring, the Host Interface Adapter Layer shall
not require any credits to be available before transmitting a Tunneled
Packet from this Transmit Descriptor Ring, so e2e flow control should
be enabled in both directions.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://lore.kernel.org/20250624153805.GC2824380@black.fi.intel.com
Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>
Link: https://patch.msgid.link/20250628093813.647005-1-zhangjianrong5@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/thunderbolt/main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 0a53ec293d04..643cf67840b5 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -924,8 +924,12 @@ static int tbnet_open(struct net_device *dev)
 
 	netif_carrier_off(dev);
 
-	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE,
-				RING_FLAG_FRAME);
+	flags = RING_FLAG_FRAME;
+	/* Only enable full E2E if the other end supports it too */
+	if (tbnet_e2e && net->svc->prtcstns & TBNET_E2E)
+		flags |= RING_FLAG_E2E;
+
+	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE, flags);
 	if (!ring) {
 		netdev_err(dev, "failed to allocate Tx ring\n");
 		return -ENOMEM;
@@ -944,11 +948,6 @@ static int tbnet_open(struct net_device *dev)
 	sof_mask = BIT(TBIP_PDF_FRAME_START);
 	eof_mask = BIT(TBIP_PDF_FRAME_END);
 
-	flags = RING_FLAG_FRAME;
-	/* Only enable full E2E if the other end supports it too */
-	if (tbnet_e2e && net->svc->prtcstns & TBNET_E2E)
-		flags |= RING_FLAG_E2E;
-
 	ring = tb_ring_alloc_rx(xd->tb->nhi, -1, TBNET_RING_SIZE, flags,
 				net->tx_ring.ring->hop, sof_mask,
 				eof_mask, tbnet_start_poll, net);
-- 
2.39.5




