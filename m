Return-Path: <stable+bounces-39912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F218A5552
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72B21C222FC
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2453E2A8D3;
	Mon, 15 Apr 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sjLeby37"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604B1E4B1;
	Mon, 15 Apr 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192190; cv=none; b=WjC5LY9zyp5kONEoIHNsTL1fUJYOXHjIlsCmPPP1G/itzpZfgx/QkLTyDW+5/EvqxKU55AjjtSRnCgKrYD1Jp4r34XvrlCXIDVCFOKPhMZ89Q0sbRqIVUUuzxIQQq/lu8LHbXxnWPoVR4EZL1dIVUgUnCBh9bpqZ7m9BsdbB0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192190; c=relaxed/simple;
	bh=HXH11MLJ1sb/SbUbbtVDrQa8KCP4PQ5wouFH26Yysd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INLs3uiJBMRnJN4pT+NLGbA6PPf6BHv+4+7v8VIu/oXfEWFjvxOnN10J1OwF0CBAWrS9i6E237c0wDtiop+wVjOUTuAZj/9ExooYB9/kFfzCgdZCvkhLcDMcYkAjZYj0SitXI/0hvjehQSX/vp86FhSvhgIR4W7BOkkJTtTgFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sjLeby37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDF8C113CC;
	Mon, 15 Apr 2024 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713192190;
	bh=HXH11MLJ1sb/SbUbbtVDrQa8KCP4PQ5wouFH26Yysd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjLeby378oAYaCt0Pkgnjd5gMezcBNc4fhAY0Stlvstx0ZTbkB6k8WEpxofSjVbUb
	 t5YZczfM/H1R7hWnf1wF+x+pyLLycdEoYnxfxaGCKG3PCfwxYVdx+/BHm+C8qj7qc3
	 qgU+Orw93hGpDHvKrq+qMJqvT+m8Zivycbg45w3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Agroskin <shayagr@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 26/45] net: ena: Fix incorrect descriptor free behavior
Date: Mon, 15 Apr 2024 16:21:33 +0200
Message-ID: <20240415141943.027041408@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141942.235939111@linuxfoundation.org>
References: <20240415141942.235939111@linuxfoundation.org>
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

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit bf02d9fe00632d22fa91d34749c7aacf397b6cde ]

ENA has two types of TX queues:
- queues which only process TX packets arriving from the network stack
- queues which only process TX packets forwarded to it by XDP_REDIRECT
  or XDP_TX instructions

The ena_free_tx_bufs() cycles through all descriptors in a TX queue
and unmaps + frees every descriptor that hasn't been acknowledged yet
by the device (uncompleted TX transactions).
The function assumes that the processed TX queue is necessarily from
the first category listed above and ends up using napi_consume_skb()
for descriptors belonging to an XDP specific queue.

This patch solves a bug in which, in case of a VF reset, the
descriptors aren't freed correctly, leading to crashes.

Fixes: 548c4940b9f1 ("net: ena: Implement XDP_TX action")
Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 44b8df731c889..3ea449be7bdc3 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1205,8 +1205,11 @@ static void ena_unmap_tx_buff(struct ena_ring *tx_ring,
 static void ena_free_tx_bufs(struct ena_ring *tx_ring)
 {
 	bool print_once = true;
+	bool is_xdp_ring;
 	u32 i;
 
+	is_xdp_ring = ENA_IS_XDP_INDEX(tx_ring->adapter, tx_ring->qid);
+
 	for (i = 0; i < tx_ring->ring_size; i++) {
 		struct ena_tx_buffer *tx_info = &tx_ring->tx_buffer_info[i];
 
@@ -1226,10 +1229,15 @@ static void ena_free_tx_bufs(struct ena_ring *tx_ring)
 
 		ena_unmap_tx_buff(tx_ring, tx_info);
 
-		dev_kfree_skb_any(tx_info->skb);
+		if (is_xdp_ring)
+			xdp_return_frame(tx_info->xdpf);
+		else
+			dev_kfree_skb_any(tx_info->skb);
 	}
-	netdev_tx_reset_queue(netdev_get_tx_queue(tx_ring->netdev,
-						  tx_ring->qid));
+
+	if (!is_xdp_ring)
+		netdev_tx_reset_queue(netdev_get_tx_queue(tx_ring->netdev,
+							  tx_ring->qid));
 }
 
 static void ena_free_all_tx_bufs(struct ena_adapter *adapter)
-- 
2.43.0




