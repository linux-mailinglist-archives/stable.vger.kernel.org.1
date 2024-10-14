Return-Path: <stable+bounces-83693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB5899BEB8
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3261C24F6A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8705D19D895;
	Mon, 14 Oct 2024 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqRNl6zY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5E142E77;
	Mon, 14 Oct 2024 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878322; cv=none; b=X9zFFPkHC/Vlv/0qNfDYbeeNo/f9lQ+BmJbRC82g3btxsQlob1RWZGb19OiUp0wXYvF5thNVWH2rSleLkgz9WQXHSfebqDKbSrXPuK4e1UJ1u0y1cVbAIlAuFu6K2lcvn22rcmQnwGz4FYcbhm8zVzTi69/4niURZnjv70nFHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878322; c=relaxed/simple;
	bh=hlFmRF6vtlxFFlJEPBqT0iLFeODwaNMkdPAj8xUvjK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/TfFibb096zg6KeoZRLN9+wX3V/UHfMQR6e2+Ynd30qui43RhNMlZ6iZcGQc2bcu6Uf8hGccp8fXhg+LNjgG4gbeCBzkxlabMz0KRzaOPFb6+HU0N8ktcm/qlb7DhhnL4W/Y9nyPF+RWlXDig99am/l7nc+UQeMHoXgB45vuf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqRNl6zY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3AFC4CECE;
	Mon, 14 Oct 2024 03:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878321;
	bh=hlFmRF6vtlxFFlJEPBqT0iLFeODwaNMkdPAj8xUvjK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqRNl6zY+cfLng2ABuIUil1sFRVtPczQu83MJ14pY3njsdnV5QMQga/K4Ao5YPeff
	 fgrGTwD74ro/zWAZKOnbEpZD1WjDGtYUp3dviKHBDNvc+T0fmA8rhJjfmyv3wxwLE4
	 lVwHwvOPeYuaeKSdNzhWxx+WL2Vwcc7F39Bw03Fx97HD2jvWjadqy/EZ/jDcpb3pog
	 7P3cgTTX7Wi5cOBWt1Bi0fB1N/fLk2t/EC92RSBOK2qB+mSArLI3NZIqm+rgRg2YeK
	 PpzX/troCv91pFKbf01NlOlD+wYz5r8HaLRCMXHnpYor+D0Wgli6prUvmwLR7I4WM/
	 LoLxxiqvpUS1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Palmer <daniel@0x0f.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	quic_jjohnson@quicinc.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/17] net: amd: mvme147: Fix probe banner message
Date: Sun, 13 Oct 2024 23:58:05 -0400
Message-ID: <20241014035815.2247153-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: Daniel Palmer <daniel@0x0f.com>

[ Upstream commit 82c5b53140faf89c31ea2b3a0985a2f291694169 ]

Currently this driver prints this line with what looks like
a rogue format specifier when the device is probed:
[    2.840000] eth%d: MVME147 at 0xfffe1800, irq 12, Hardware Address xx:xx:xx:xx:xx:xx

Change the printk() for netdev_info() and move it after the
registration has completed so it prints out the name of the
interface properly.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/mvme147.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/mvme147.c b/drivers/net/ethernet/amd/mvme147.c
index 410c7b67eba4d..e6cc916d205f1 100644
--- a/drivers/net/ethernet/amd/mvme147.c
+++ b/drivers/net/ethernet/amd/mvme147.c
@@ -105,10 +105,6 @@ static struct net_device * __init mvme147lance_probe(void)
 	macaddr[3] = address&0xff;
 	eth_hw_addr_set(dev, macaddr);
 
-	printk("%s: MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
-	       dev->name, dev->base_addr, MVME147_LANCE_IRQ,
-	       dev->dev_addr);
-
 	lp = netdev_priv(dev);
 	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 32K */
 	if (!lp->ram) {
@@ -138,6 +134,9 @@ static struct net_device * __init mvme147lance_probe(void)
 		return ERR_PTR(err);
 	}
 
+	netdev_info(dev, "MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
+		    dev->base_addr, MVME147_LANCE_IRQ, dev->dev_addr);
+
 	return dev;
 }
 
-- 
2.43.0


