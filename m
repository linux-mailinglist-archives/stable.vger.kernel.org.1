Return-Path: <stable+bounces-130788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BA2A806DA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2729B881576
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F5268FE4;
	Tue,  8 Apr 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bi0sw21u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13E264FB0;
	Tue,  8 Apr 2025 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114651; cv=none; b=Fx2YMcOVlEPmtp0Zp0d6GjT35y9qGiepuLw7x46/NMtztfuPPs5kA7o3mvRhSHiXUZCG9JkrY26OZi7szUwTnQ55lIkASimtxeBm7zkecM3mXKsFL9YhO2BpRn/Pw/M+FzZKhDKqjQSu6SzSiG1HfWnr3b4tj61W1HbaO+1z//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114651; c=relaxed/simple;
	bh=vv1JqrBhT+dEtsJ4mMKcw1aNOgB1yWSLq6YKfEPi+7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZyRvbF79OZdCDSjEGyLNMHe5VHVhojbV+71Wve1RBA4qWHuTDSBnPlpeFQcXSeZP/bPd/ZGPF3amB8fIqrtUf+drIKeMztSpxIJc3Z3jelsnp07Vxp9jqq72+i56DyRbZfn1QzTwbbBUVIDCRpeyfNyxhtEF2cNlPXLhUO+sGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bi0sw21u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A528C4CEE5;
	Tue,  8 Apr 2025 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114651;
	bh=vv1JqrBhT+dEtsJ4mMKcw1aNOgB1yWSLq6YKfEPi+7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bi0sw21ufoGiDEmXMm93zcVSe20MdEF3rfmfyLHNHMfawGDFPh+uON4bIEcAZL6Fy
	 yoaz/X7AfzoQTzsDIY7e68q+LqDok0nxSuIXiQI0PayDoEkMzSXf2gtxd52LceEpCh
	 SKDP854z+zvfsPb1lbd1eindG1xbpgLxddStvAQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maher Sanalla <msanalla@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 168/499] IB/mad: Check available slots before posting receive WRs
Date: Tue,  8 Apr 2025 12:46:20 +0200
Message-ID: <20250408104855.369477481@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maher Sanalla <msanalla@nvidia.com>

[ Upstream commit 37826f0a8c2f6b6add5179003b8597e32a445362 ]

The ib_post_receive_mads() function handles posting receive work
requests (WRs) to MAD QPs and is called in two cases:
1) When a MAD port is opened.
2) When a receive WQE is consumed upon receiving a new MAD.

Whereas, if MADs arrive during the port open phase, a race condition
might cause an extra WR to be posted, exceeding the QP’s capacity.
This leads to failures such as:
infiniband mlx5_0: ib_post_recv failed: -12
infiniband mlx5_0: Couldn't post receive WRs
infiniband mlx5_0: Couldn't start port
infiniband mlx5_0: Couldn't open port 1

Fix this by checking the current receive count before posting a new WR.
If the QP’s receive queue is full, do not post additional WRs.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Link: https://patch.msgid.link/c4984ba3c3a98a5711a558bccefcad789587ecf1.1741875592.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/mad.c | 38 ++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 1fd54d5c4dd8b..73f3a0b9a54b5 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2671,11 +2671,11 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 				    struct ib_mad_private *mad)
 {
 	unsigned long flags;
-	int post, ret;
 	struct ib_mad_private *mad_priv;
 	struct ib_sge sg_list;
 	struct ib_recv_wr recv_wr;
 	struct ib_mad_queue *recv_queue = &qp_info->recv_queue;
+	int ret = 0;
 
 	/* Initialize common scatter list fields */
 	sg_list.lkey = qp_info->port_priv->pd->local_dma_lkey;
@@ -2685,7 +2685,7 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 	recv_wr.sg_list = &sg_list;
 	recv_wr.num_sge = 1;
 
-	do {
+	while (true) {
 		/* Allocate and map receive buffer */
 		if (mad) {
 			mad_priv = mad;
@@ -2693,10 +2693,8 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 		} else {
 			mad_priv = alloc_mad_private(port_mad_size(qp_info->port_priv),
 						     GFP_ATOMIC);
-			if (!mad_priv) {
-				ret = -ENOMEM;
-				break;
-			}
+			if (!mad_priv)
+				return -ENOMEM;
 		}
 		sg_list.length = mad_priv_dma_size(mad_priv);
 		sg_list.addr = ib_dma_map_single(qp_info->port_priv->device,
@@ -2705,37 +2703,41 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 						 DMA_FROM_DEVICE);
 		if (unlikely(ib_dma_mapping_error(qp_info->port_priv->device,
 						  sg_list.addr))) {
-			kfree(mad_priv);
 			ret = -ENOMEM;
-			break;
+			goto free_mad_priv;
 		}
 		mad_priv->header.mapping = sg_list.addr;
 		mad_priv->header.mad_list.mad_queue = recv_queue;
 		mad_priv->header.mad_list.cqe.done = ib_mad_recv_done;
 		recv_wr.wr_cqe = &mad_priv->header.mad_list.cqe;
-
-		/* Post receive WR */
 		spin_lock_irqsave(&recv_queue->lock, flags);
-		post = (++recv_queue->count < recv_queue->max_active);
-		list_add_tail(&mad_priv->header.mad_list.list, &recv_queue->list);
+		if (recv_queue->count >= recv_queue->max_active) {
+			/* Fully populated the receive queue */
+			spin_unlock_irqrestore(&recv_queue->lock, flags);
+			break;
+		}
+		recv_queue->count++;
+		list_add_tail(&mad_priv->header.mad_list.list,
+			      &recv_queue->list);
 		spin_unlock_irqrestore(&recv_queue->lock, flags);
+
 		ret = ib_post_recv(qp_info->qp, &recv_wr, NULL);
 		if (ret) {
 			spin_lock_irqsave(&recv_queue->lock, flags);
 			list_del(&mad_priv->header.mad_list.list);
 			recv_queue->count--;
 			spin_unlock_irqrestore(&recv_queue->lock, flags);
-			ib_dma_unmap_single(qp_info->port_priv->device,
-					    mad_priv->header.mapping,
-					    mad_priv_dma_size(mad_priv),
-					    DMA_FROM_DEVICE);
-			kfree(mad_priv);
 			dev_err(&qp_info->port_priv->device->dev,
 				"ib_post_recv failed: %d\n", ret);
 			break;
 		}
-	} while (post);
+	}
 
+	ib_dma_unmap_single(qp_info->port_priv->device,
+			    mad_priv->header.mapping,
+			    mad_priv_dma_size(mad_priv), DMA_FROM_DEVICE);
+free_mad_priv:
+	kfree(mad_priv);
 	return ret;
 }
 
-- 
2.39.5




