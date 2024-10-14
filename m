Return-Path: <stable+bounces-83676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE23199BE8F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B5C1C22C37
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D415665C;
	Mon, 14 Oct 2024 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB9llIhR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987315624B;
	Mon, 14 Oct 2024 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878283; cv=none; b=O6FtiQslI52sangiy6UKh+Uj9gLIoaRUh3C87ECxNFCealN7YEMeN/3UgsACDkr5jmLacl/IJ9NdSicpYx0jzU+VOddxRaBxlzrvHbcxjBMSvGeSNoAQpMqk1LfmIYrKFoAwfvNg6Lggqp240bvaZBgGcQ3vpQOa9olLVDjk+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878283; c=relaxed/simple;
	bh=qCICDlZnGDoXb58vGlFU3fU9K0Vyajcva5EQv963CPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNAY+qomPRxPjGvADg+qV/dydTN61WRowKNc16Ur8VjMIgniCJ7q5WSWKUYIdYiJMlsP6F1clyL3D6Q5CIpMIxuSfBec1I7CxSLSsjEGSSTrOxjgvLTXBi4Fw362ZojzCqhFVxGnRA1IF1WOn3w19fr29GfnfBcKPh7+RifPYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB9llIhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D36C4CECE;
	Mon, 14 Oct 2024 03:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878283;
	bh=qCICDlZnGDoXb58vGlFU3fU9K0Vyajcva5EQv963CPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oB9llIhRwE/k8udl1Xlcsxo5b6EH7MixnHrfnEaYKVT6FUaUIQNvJZPaH23Ne83Ds
	 avuT8fgFUEjhFtbR9T/TKhoSaGiEt8PKdRLm7dAjyY9X+cWlnoYvgDJIvAIA9bItku
	 3KwBEuB4qUb1mLordxIOMPVHvsKeCWZjHlU+rdOBb41un3czbFwldku71TG0VdPBiU
	 y4sF0EzuyLfoEGNuXd5dE9zBOoZC1hpCzz/i0GoKIRQga70bBisNpaqleu6gUxQf+A
	 xmtPCNMnyuPIEOgY2eq1ucq1HAnt/46ObACs1ySoe9I3xoW12bVSSSNMpayqpIMfPD
	 vB67aTHgFPoew==
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
Subject: [PATCH AUTOSEL 6.11 18/20] net: amd: mvme147: Fix probe banner message
Date: Sun, 13 Oct 2024 23:57:20 -0400
Message-ID: <20241014035731.2246632-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
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
index c156566c09064..f19b04b92fa9f 100644
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


