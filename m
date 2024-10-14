Return-Path: <stable+bounces-83714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4212199BEF5
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069132870BF
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306D214B06E;
	Mon, 14 Oct 2024 03:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmDgkRtY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76E136331;
	Mon, 14 Oct 2024 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878392; cv=none; b=ZiuA6PQ8EzQu1hHjC/MZXn6zICDIli/oYv6Y98X20atWBmgz3zOn7ublW0PDw+wKnRsREWQEJWN6FrNAI7I/wO8OW+/UvOL9hF0D9nF9dqvNiIF1GyF4W5X2wneBHiMTPtpzc9qYzC9KbcUE3OsE1W3AKsduwDGVSLuWbfW4tpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878392; c=relaxed/simple;
	bh=Ny8O9DOIZ6581+wK/ZRWd9/dZUeGNzBgDAi9on7Jt3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saxwWStMfan0lENOz/URqOVPCZV1Bpn52N+hKS1FhCqutlHn0IFPrN7VM2jZKJNHMfItyhh7MPczmreKiVpDPu2/gK241Bp1HRNV4w/PVyVNDt3MYpBSkTbKqKFMW8G98e9Knf0rxYtOZsYA6V6dBeKvU/vQc5T4aPwudiSWJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmDgkRtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1583DC4CEC3;
	Mon, 14 Oct 2024 03:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878391;
	bh=Ny8O9DOIZ6581+wK/ZRWd9/dZUeGNzBgDAi9on7Jt3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=lmDgkRtYpEYTykMtR/z4X8ClVqSrI/xIFhkvzjDZcZhFFU3UIdMcKcdlwItDDmi2x
	 S3Szrl/eZSSNI5YhmXOOIpXAwIAYOR0AUzu9nTlVVU85BMksykkfjylVR3JOf/oXot
	 QzaVi5Rvv13RYn1nAYH2Sm/OW9Mnk2w21ZQsoZiCoqpkP/0NiuzdMYnh/yUoqASxZM
	 efX5+4fJI12Dcjd0dQ1NBoTXi7bkdcklMpQGdSXeFj6cU2ys249AQfY4skwxA4KdDj
	 P13iqoRT5oFJeX4rY30l1InreVv2BLZg3V5mptwyfTeD5LjKWa5XrsZLnc3W59Caod
	 BGrFyKfBvBrIw==
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
Subject: [PATCH AUTOSEL 5.10 1/3] net: amd: mvme147: Fix probe banner message
Date: Sun, 13 Oct 2024 23:59:41 -0400
Message-ID: <20241014035948.2261641-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 3f2e4cdd0b83e..133fe0f1166b0 100644
--- a/drivers/net/ethernet/amd/mvme147.c
+++ b/drivers/net/ethernet/amd/mvme147.c
@@ -106,10 +106,6 @@ struct net_device * __init mvme147lance_probe(int unit)
 	address = address >> 8;
 	dev->dev_addr[3] = address&0xff;
 
-	printk("%s: MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
-	       dev->name, dev->base_addr, MVME147_LANCE_IRQ,
-	       dev->dev_addr);
-
 	lp = netdev_priv(dev);
 	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 32K */
 	if (!lp->ram) {
@@ -139,6 +135,9 @@ struct net_device * __init mvme147lance_probe(int unit)
 		return ERR_PTR(err);
 	}
 
+	netdev_info(dev, "MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
+		    dev->base_addr, MVME147_LANCE_IRQ, dev->dev_addr);
+
 	return dev;
 }
 
-- 
2.43.0


