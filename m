Return-Path: <stable+bounces-83711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3246399BEEE
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25171F2392D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C288614A4C7;
	Mon, 14 Oct 2024 03:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paz2YQW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64214A4DE;
	Mon, 14 Oct 2024 03:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878380; cv=none; b=A35wXaLUoYbB2R+1ca0Iqe8G0stk3O01WXyXWIw/NG+/SZfPHYY/oaFcMIGDuFC/0r9yEnTac6tmaj0A+lqpjf5F6aVdmvRwp1jlz1ijv7o2Weu/NEW1IGQ9Zc05MNpKjHt8pgjRyyCoSZro+XZxrwGpY0xPu1SVyhWSxbsUi/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878380; c=relaxed/simple;
	bh=kVXOYPgjMt1JytaFYG+TVB7xoIxaL+9bKVxH9OhQVSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkbfeCzU/DSkoYLT0uDvvDOcFBZdG+weoX4+ex47q6Fa4W+1zpkJG556rp98PcXm9N7v+2j4FIQSTl82LMSyuaILtUc7cpttXch1v1MHgmlbyvabg00XKRgzplhhxDJ6BuRt8GBQqaKxwQryG+YS+jejTB8K4OcNO2ivKN2bEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paz2YQW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B3EC4CEC3;
	Mon, 14 Oct 2024 03:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878380;
	bh=kVXOYPgjMt1JytaFYG+TVB7xoIxaL+9bKVxH9OhQVSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=paz2YQW2+SM9JLgz/dG886uHtm+GtMkGD/RFoQZ1XSEqeGeOf2ohn9AA/sHrZS4nU
	 8SNdSxy8Yd6K35+aJpTlmUlgytuXSP/5uwSHuofGVju/Z/bYqKlSROHQDn7VVHFvJ9
	 VgeMCOVjDijumH1ckCzpX27tGdbubq7pHmxLUAZoQAgnfU0Fy8il16c9H16GGswE/y
	 2LZhpmQzeQgZrotW6b3p1GVIOfXZY0dl2Rg9dMJndgbrl2eARm4mdm8beazDnmYAZd
	 DvXlN1cOcHnjQHJzNo2IKadq4MlbFa3cZwebF3i70aOPcgwTtfhJMB6UgXfd/oV6Q6
	 lLIFEP4z2BQLg==
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
Subject: [PATCH AUTOSEL 5.15 6/8] net: amd: mvme147: Fix probe banner message
Date: Sun, 13 Oct 2024 23:59:21 -0400
Message-ID: <20241014035929.2251266-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035929.2251266-1-sashal@kernel.org>
References: <20241014035929.2251266-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index da97fccea9ea6..769355824b7e1 100644
--- a/drivers/net/ethernet/amd/mvme147.c
+++ b/drivers/net/ethernet/amd/mvme147.c
@@ -103,10 +103,6 @@ static struct net_device * __init mvme147lance_probe(void)
 	address = address >> 8;
 	dev->dev_addr[3] = address&0xff;
 
-	printk("%s: MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
-	       dev->name, dev->base_addr, MVME147_LANCE_IRQ,
-	       dev->dev_addr);
-
 	lp = netdev_priv(dev);
 	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 32K */
 	if (!lp->ram) {
@@ -136,6 +132,9 @@ static struct net_device * __init mvme147lance_probe(void)
 		return ERR_PTR(err);
 	}
 
+	netdev_info(dev, "MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
+		    dev->base_addr, MVME147_LANCE_IRQ, dev->dev_addr);
+
 	return dev;
 }
 
-- 
2.43.0


