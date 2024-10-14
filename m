Return-Path: <stable+bounces-83717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6D99BEFE
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FDF1C22416
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D9C1C0DD6;
	Mon, 14 Oct 2024 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeUzZ1wr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16314C5BD;
	Mon, 14 Oct 2024 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878401; cv=none; b=fPr/5BBpIPPRnwJGxNGPMUtQB1gacjiWpjl1rCDq0e5klJE3ZoyAV7AySUEMk7YA1sdbjWkJyco4mUtToJcQfIrrLwNRsiNCf8RHGPZulsncBJ9tVTV2uYIXKaFXhE+LJ7KzID+1HyjN4KTLr9pFANocRO0fHNFG4MV40evUjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878401; c=relaxed/simple;
	bh=IJPe+KHMs0Jr4wtbXXie9OWisHlE7T9H0zYOSBGDXPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U35oaBcaZ0RCbEqxUIFWzCYnsJBITDygliDlDOBBQJMURAPtArAj7IqB6YnE4HJNV9NXg4VO2UX33jZoUSLUidl6/ySTSsSno43pGp35LTCOyQSj4jZJCZgTKbXVsyfTQ9RiRX311Hw9PLh2Ta6/4OlqYcaE68qeqbVceZl1ODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeUzZ1wr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6A8C4CEC3;
	Mon, 14 Oct 2024 03:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878401;
	bh=IJPe+KHMs0Jr4wtbXXie9OWisHlE7T9H0zYOSBGDXPk=;
	h=From:To:Cc:Subject:Date:From;
	b=aeUzZ1wrD/PNXdA3RsxS3JmlJ+C3S0SBBuSuBij1P9z9HTZMDTBsSmu1JjcecNJeZ
	 LOWobA3dJXZ90Tm9uTFwb3E0a9Im+AFkyBOQZzghGGUYX9oDaIW6FlMLNETb7Y2QJn
	 XuV56IgeQ6aL888f/AIeWtazVlsbnKfareLfCjwrvZ+RBgD89TN1/+l5ZisYPouKTI
	 iNFUgBqPLfDi5RUaSVp0oEcR7vmx1lH15JFTWSiX7fotdZb/+q7RUToNUbcgguFQIz
	 b2yMz4RmW5tAR5lMcwlLVMpJ6nQSeRqeRedMK8sc237abeDtlWQw0xAv1q5ofUAcq4
	 mqozGZcHI5EVw==
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
Subject: [PATCH AUTOSEL 5.4 1/2] net: amd: mvme147: Fix probe banner message
Date: Sun, 13 Oct 2024 23:59:53 -0400
Message-ID: <20241014035958.2266211-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index 72abd3f82249b..eb7b1da2fb06f 100644
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


