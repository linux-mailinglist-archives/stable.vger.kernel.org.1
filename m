Return-Path: <stable+bounces-184877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7766CBD44AA
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EACE1882C50
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C7430B534;
	Mon, 13 Oct 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VcLhSmET"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F0730B52A;
	Mon, 13 Oct 2025 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368693; cv=none; b=obP9BQHw31shzVbzlnYlwJVRFgzk4mcnOOpvEvR0mR9vZ94czFVQBOTzEZKERLEtMjTrNIdoKpve4ePX1+9s6oMatXAAHeefl+l5a7OU1koDBDcCccFU/+SqUGNTrkfnD9nOLni28ek9nzOZg2FRlLXlxCm2OmIx2xYqRC/A7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368693; c=relaxed/simple;
	bh=efIPciUUja163d1fAgnDKDo1P5MJXN40eA6A9gC9jYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVBPLW5YejbqqtwwbX/mMOcUN3L4f43WrH/PAQCM1QppQOxVS64NzJXSaMzr7CmhcH8HPFQSwvc15nFBsSHEfFr+lYLeBeRmGj4uhNXrPPe/dxZpcuo9xOnmvX5QLzJUkKFmPP08Sd+pVgdGz1tfj0o/rm/ifWVuvPg7zkVuCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VcLhSmET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28510C4CEE7;
	Mon, 13 Oct 2025 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368692;
	bh=efIPciUUja163d1fAgnDKDo1P5MJXN40eA6A9gC9jYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VcLhSmETWyGMKZ3mBzM/8sm5G6azpNyKamo+T5nHlxoonVMHEcQOi/HWgPBIIre+O
	 405zsRaBsC+lkCLPw2fthJIozW+v79F0jSuBuzuhJdhgrI6UGKttPQo4Cv1087G4dX
	 NmXabnZR/vYXNDeT2YKZAze5wYOU8eu6kCuewBEw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 216/262] net: dlink: handle copy_thresh allocation failure
Date: Mon, 13 Oct 2025 16:45:58 +0200
Message-ID: <20251013144334.023757643@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Yeounsu Moon <yyyynoom@gmail.com>

[ Upstream commit 8169a6011c5fecc6cb1c3654c541c567d3318de8 ]

The driver did not handle failure of `netdev_alloc_skb_ip_align()`.
If the allocation failed, dereferencing `skb->protocol` could lead to
a NULL pointer dereference.

This patch tries to allocate `skb`. If the allocation fails, it falls
back to the normal path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250928190124.1156-1-yyyynoom@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/dlink/dl2k.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 2c1b551e14423..92856cf387c76 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -953,15 +953,18 @@ receive_packet (struct net_device *dev)
 		} else {
 			struct sk_buff *skb;
 
+			skb = NULL;
 			/* Small skbuffs for short packets */
-			if (pkt_len > copy_thresh) {
+			if (pkt_len <= copy_thresh)
+				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
+			if (!skb) {
 				dma_unmap_single(&np->pdev->dev,
 						 desc_to_dma(desc),
 						 np->rx_buf_sz,
 						 DMA_FROM_DEVICE);
 				skb_put (skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
-			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
+			} else {
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
-- 
2.51.0




