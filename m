Return-Path: <stable+bounces-122644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC1BA5A095
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0DA1729CA
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220C232369;
	Mon, 10 Mar 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rzFiJxYG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE517CA12;
	Mon, 10 Mar 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629086; cv=none; b=nUC2E/tS7lHp78/lPZqO/13T2gH6gVbTqfmbJlMB/lpCG2W31aelzk+Q0x6QeR0o+mSwyM5mgfHE5+5kLUnlPtdaexHZ6wrpukzR51J0YIx4b7iJzz6bgCd8nDUx63ThKtYwzR9JtdWHox8icEKo9pjJzuYkF33Zv8EqKL0SMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629086; c=relaxed/simple;
	bh=XxmxYBBf4d8qg5OcmKrI1Y+DRuCv2FSxNMKGAl1j2Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2tdbYLn1c80MzzO7Jxg2vaej82oUb1opFPJ4wTKmeLyOK0eGYqVsiX4BvhZNg1Jz0uOHH7b33U6mLinBtcbBuxkjBejLRVZJvBCmpT9HA9f44IEJ50s3/RSmQi5oO+Rx3/VIF8+ZThZ2FT0/FSqqYqrMh1LRjWpMW3eTpXA2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rzFiJxYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBADAC4CEE5;
	Mon, 10 Mar 2025 17:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629086;
	bh=XxmxYBBf4d8qg5OcmKrI1Y+DRuCv2FSxNMKGAl1j2Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rzFiJxYG3b+Zk7hPOvoK0ZfL5F2MEUFpKM/2wDiqQcin4aJF+Wd2f3O1wDtNkYhPF
	 l/dtUk0Mvp1DlDkMxTBfA3og+o9M1qHDijhgUayIDYXkDqqDB/Pap24AKD7M+yHLip
	 9mdsW+xrqJ0+Gtas48RfD0qmLZhvFIk3APGAPDYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 172/620] bgmac: reduce max frame size to support just MTU 1500
Date: Mon, 10 Mar 2025 18:00:18 +0100
Message-ID: <20250310170552.412654476@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 752e5fcc2e77358936d36ef8e522d6439372e201 ]

bgmac allocates new replacement buffer before handling each received
frame. Allocating & DMA-preparing 9724 B each time consumes a lot of CPU
time. Ideally bgmac should just respect currently set MTU but it isn't
the case right now. For now just revert back to the old limited frame
size.

This change bumps NAT masquerade speed by ~95%.

Since commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
page_frag_alloc_align()"), the bgmac driver fails to open its network
interface successfully and runs out of memory in the following call
stack:

bgmac_open
  -> bgmac_dma_init
    -> bgmac_dma_rx_skb_for_slot
      -> netdev_alloc_frag

BGMAC_RX_ALLOC_SIZE = 10048 and PAGE_FRAG_CACHE_MAX_SIZE = 32768.

Eventually we land into __page_frag_alloc_align() with the following
parameters across multiple successive calls:

__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=0
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=10048
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=20096
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=30144

So in that case we do indeed have offset + fragsz (40192) > size (32768)
and so we would eventually return NULL. Reverting to the older 1500
bytes MTU allows the network driver to be usable again.

Fixes: 8c7da63978f1 ("bgmac: configure MTU and add support for frames beyond 8192 byte size")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
[florian: expand commit message about recent commits]
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20250127175159.1788246-1-florian.fainelli@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bgmac.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.h b/drivers/net/ethernet/broadcom/bgmac.h
index 99a344175a751..378c72bfbd9e5 100644
--- a/drivers/net/ethernet/broadcom/bgmac.h
+++ b/drivers/net/ethernet/broadcom/bgmac.h
@@ -328,8 +328,7 @@
 #define BGMAC_RX_FRAME_OFFSET			30		/* There are 2 unused bytes between header and real data */
 #define BGMAC_RX_BUF_OFFSET			(NET_SKB_PAD + NET_IP_ALIGN - \
 						 BGMAC_RX_FRAME_OFFSET)
-/* Jumbo frame size with FCS */
-#define BGMAC_RX_MAX_FRAME_SIZE			9724
+#define BGMAC_RX_MAX_FRAME_SIZE			1536
 #define BGMAC_RX_BUF_SIZE			(BGMAC_RX_FRAME_OFFSET + BGMAC_RX_MAX_FRAME_SIZE)
 #define BGMAC_RX_ALLOC_SIZE			(SKB_DATA_ALIGN(BGMAC_RX_BUF_SIZE + BGMAC_RX_BUF_OFFSET) + \
 						 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
-- 
2.39.5




