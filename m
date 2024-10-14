Return-Path: <stable+bounces-83703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E099BED5
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9664B2397C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A85814659D;
	Mon, 14 Oct 2024 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cClMPThV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362761AAE37;
	Mon, 14 Oct 2024 03:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878359; cv=none; b=drDJjCEaAAUqW4XQoaVaehOM8g6whmBqMElluIVmulBO/o6+Yz8gPARLj1iDR5WnhcNNbh6EQ1fmDU3CbMxkTx/IS6TCaSHE1p1+KFjWxE89edkQJr3xSA19PxiQDm4hpw/1EuU+Iaa7N16P5eC3YmYkFVUKk3fYt1YL243nkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878359; c=relaxed/simple;
	bh=hlFmRF6vtlxFFlJEPBqT0iLFeODwaNMkdPAj8xUvjK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0rpwADlS++SfKXHKPaeygoEc/mOdRPUC6s36IOOyPJ9CWmnrkQFutcum9VJD/7N0T2aR/L4a7wgrgTB/8e/nuWvFynNkpZ/T1UQbuHTCfLCybvT/kz2QweEs7qGTf0psivLX05vXgvLa7Pt2GuCbGyGjOQ4enV0hrKA2ZXfpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cClMPThV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8994DC4CECE;
	Mon, 14 Oct 2024 03:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878358;
	bh=hlFmRF6vtlxFFlJEPBqT0iLFeODwaNMkdPAj8xUvjK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cClMPThVuwjWfB1MNHCGMvPTY77bC3ywidPmxbw/UVYku4g8+YT2XdCc7/Krvhse1
	 tF1SkMP9sr/LgTuLywzlwQQvVd5xSdyyLvVK7F+Q9lhWjbDhXkcNxFFSXcdui6/bwb
	 JKkWMYFlKcuDjNdEBHm1WJ9oNCQ19Zs3gYOBraJlaDqMnG/mUXVy6o+ujcFfAwgTeJ
	 UlMQd2Pue0F051FKaY/JpRrbm2Lv8BlS/Clsdmg0GRuZfKkSJs3gm0j27cNhRgtOi2
	 jVL6uf+QSss16sVtcIpAqWkxm6AAf123S3fQnhUf7hWjYfueoaoVm6sKfn46nCSyKb
	 YcgWU7I+b69/A==
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
Subject: [PATCH AUTOSEL 6.1 08/10] net: amd: mvme147: Fix probe banner message
Date: Sun, 13 Oct 2024 23:58:43 -0400
Message-ID: <20241014035848.2247549-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035848.2247549-1-sashal@kernel.org>
References: <20241014035848.2247549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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


