Return-Path: <stable+bounces-51883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8512C907210
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D10A281EB1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC8441D;
	Thu, 13 Jun 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i3l005bG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8B17FD;
	Thu, 13 Jun 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282596; cv=none; b=K/2Di4Rws2w1YiyREcxM27+64e6z0RSOTmCdab0S6UWeg5azrsozOXW4yMvSZwUrzyPktpr73tyhLr2PSC+dqJarNG+NhiuTWsFVZ3D1FoDl4k48mJnhCc6q3z3w7Cb3xw9hB6B7rVqAxEWlwjTgaBmryX7Mw+7SUghx3vMO2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282596; c=relaxed/simple;
	bh=8t0925JMUmBcW2I78EIYfJVXR2QwriXrdyXJbTXH0aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMqBpoxIs0gW5kXP7lHPTuShxfaLSZQd5ekZ71kWXcKTocp/6ejLuGyUP9OGix4m4L8IBqFujauIxQCBWBJvMLNZ0A3OLLPjbqWRsxUFiAktxUitFm+06h9HvtXq1RSvmkzqxoVL+yw3kGlLKvo82yXIwLEnjSQZES978pzBcz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i3l005bG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1E4C2BBFC;
	Thu, 13 Jun 2024 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282595;
	bh=8t0925JMUmBcW2I78EIYfJVXR2QwriXrdyXJbTXH0aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3l005bG/eGWeHy4RBgG+8HKmh5L2NFhZBBOv5R1vZF2XM83WzrVULBFw4S/Yzxuy
	 2XN6MEXsyu7EIt7sOJyZHC+V1HSDy3eK1U64u1jONWz9LuVd69AwfSILnidMMhSviV
	 3a5iBky35h1SHPxlePWsT/WcxVzaUdmMHccJReKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Agroskin <shayagr@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 331/402] net: ena: Fix redundant device NUMA node override
Date: Thu, 13 Jun 2024 13:34:48 +0200
Message-ID: <20240613113315.050006945@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shay Agroskin <shayagr@amazon.com>

[ Upstream commit 2dc8b1e7177d4f49f492ce648440caf2de0c3616 ]

The driver overrides the NUMA node id of the device regardless of
whether it knows its correct value (often setting it to -1 even though
the node id is advertised in 'struct device'). This can lead to
suboptimal configurations.

This patch fixes this behavior and makes the shared memory allocation
functions use the NUMA node id advertised by the underlying device.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Link: https://lore.kernel.org/r/20240528170912.1204417-1-shayagr@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index e733419dd3f49..276f6a8631fb1 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -312,7 +312,6 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 			      struct ena_com_io_sq *io_sq)
 {
 	size_t size;
-	int dev_node = 0;
 
 	memset(&io_sq->desc_addr, 0x0, sizeof(io_sq->desc_addr));
 
@@ -325,12 +324,9 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 	size = io_sq->desc_entry_size * io_sq->q_depth;
 
 	if (io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_HOST) {
-		dev_node = dev_to_node(ena_dev->dmadev);
-		set_dev_node(ena_dev->dmadev, ctx->numa_node);
 		io_sq->desc_addr.virt_addr =
 			dma_alloc_coherent(ena_dev->dmadev, size, &io_sq->desc_addr.phys_addr,
 					   GFP_KERNEL);
-		set_dev_node(ena_dev->dmadev, dev_node);
 		if (!io_sq->desc_addr.virt_addr) {
 			io_sq->desc_addr.virt_addr =
 				dma_alloc_coherent(ena_dev->dmadev, size,
@@ -354,10 +350,7 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 		size = (size_t)io_sq->bounce_buf_ctrl.buffer_size *
 			io_sq->bounce_buf_ctrl.buffers_num;
 
-		dev_node = dev_to_node(ena_dev->dmadev);
-		set_dev_node(ena_dev->dmadev, ctx->numa_node);
 		io_sq->bounce_buf_ctrl.base_buffer = devm_kzalloc(ena_dev->dmadev, size, GFP_KERNEL);
-		set_dev_node(ena_dev->dmadev, dev_node);
 		if (!io_sq->bounce_buf_ctrl.base_buffer)
 			io_sq->bounce_buf_ctrl.base_buffer =
 				devm_kzalloc(ena_dev->dmadev, size, GFP_KERNEL);
@@ -397,7 +390,6 @@ static int ena_com_init_io_cq(struct ena_com_dev *ena_dev,
 			      struct ena_com_io_cq *io_cq)
 {
 	size_t size;
-	int prev_node = 0;
 
 	memset(&io_cq->cdesc_addr, 0x0, sizeof(io_cq->cdesc_addr));
 
@@ -409,11 +401,8 @@ static int ena_com_init_io_cq(struct ena_com_dev *ena_dev,
 
 	size = io_cq->cdesc_entry_size_in_bytes * io_cq->q_depth;
 
-	prev_node = dev_to_node(ena_dev->dmadev);
-	set_dev_node(ena_dev->dmadev, ctx->numa_node);
 	io_cq->cdesc_addr.virt_addr =
 		dma_alloc_coherent(ena_dev->dmadev, size, &io_cq->cdesc_addr.phys_addr, GFP_KERNEL);
-	set_dev_node(ena_dev->dmadev, prev_node);
 	if (!io_cq->cdesc_addr.virt_addr) {
 		io_cq->cdesc_addr.virt_addr =
 			dma_alloc_coherent(ena_dev->dmadev, size, &io_cq->cdesc_addr.phys_addr,
-- 
2.43.0




