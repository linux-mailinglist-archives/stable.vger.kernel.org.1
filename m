Return-Path: <stable+bounces-39854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89328A550A
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0D01C21C16
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B12678C89;
	Mon, 15 Apr 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kqkmJ1Jk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097521D53C;
	Mon, 15 Apr 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192015; cv=none; b=aWuFTc1Fj+cTKxSKOsTWqVVPXZNOmYK8l4cxp/zPlnslExBjYsVbNGa82zn4NrA8wMWv1putqBIcmL9CSoosNEPAIDUFqf7V7majJhoqJaxHwnWq/4knUDVq3wdFEih5q1yxrw63qfwzohZ05tC0rvfP+po+H/ypuMC9SrJBgdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192015; c=relaxed/simple;
	bh=XzxNf9Fa4EkdZuCghu2wLTIZ4oDMDOWAaaFN4OMis2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MstQ35o891pcJ/94Gv1BqjJN1JH5g/5AGU8Cr73r0zjcB4MCQ/Nplr77QnM8SvXcDW3Fq7XPjIUu8bFQtHzyYMBsyIKp5ZbS2uIkm8DtghclCpfsfwdKKULYGv+B7ByrKE4fOyuSyiRi3ohm9Dyz6KRHn6B3+JQZUMTJdKNC3zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kqkmJ1Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85722C113CC;
	Mon, 15 Apr 2024 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713192014;
	bh=XzxNf9Fa4EkdZuCghu2wLTIZ4oDMDOWAaaFN4OMis2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kqkmJ1JkWxIfI8HMx3elLTX5MdloTY1NLUsmZWksi22+e8/BNmDbXd+NYD1m95lfB
	 YrSDniegs30pgnnE9QEckA9Ns7+x7mVIGlEb5LnZsiCyKCafWCzEy8tRlx5bzC4E8K
	 e8kBNjIHBt9HHVVMlRJ6wf8KblrhYTS6fsuyVhio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amit Bernstein <amitbern@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 37/69] net: ena: Wrong missing IO completions check order
Date: Mon, 15 Apr 2024 16:21:08 +0200
Message-ID: <20240415141947.281058717@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>
References: <20240415141946.165870434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit f7e417180665234fdb7af2ebe33d89aaa434d16f ]

Missing IO completions check is called every second (HZ jiffies).
This commit fixes several issues with this check:

1. Duplicate queues check:
   Max of 4 queues are scanned on each check due to monitor budget.
   Once reaching the budget, this check exits under the assumption that
   the next check will continue to scan the remainder of the queues,
   but in practice, next check will first scan the last already scanned
   queue which is not necessary and may cause the full queue scan to
   last a couple of seconds longer.
   The fix is to start every check with the next queue to scan.
   For example, on 8 IO queues:
   Bug: [0,1,2,3], [3,4,5,6], [6,7]
   Fix: [0,1,2,3], [4,5,6,7]

2. Unbalanced queues check:
   In case the number of active IO queues is not a multiple of budget,
   there will be checks which don't utilize the full budget
   because the full scan exits when reaching the last queue id.
   The fix is to run every TX completion check with exact queue budget
   regardless of the queue id.
   For example, on 7 IO queues:
   Bug: [0,1,2,3], [4,5,6], [0,1,2,3]
   Fix: [0,1,2,3], [4,5,6,0], [1,2,3,4]
   The budget may be lowered in case the number of IO queues is less
   than the budget (4) to make sure there are no duplicate queues on
   the same check.
   For example, on 3 IO queues:
   Bug: [0,1,2,0], [1,2,0,1]
   Fix: [0,1,2], [0,1,2]

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 21 +++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 9e82e7b9c3b72..b2eb6e1958f04 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3797,10 +3797,11 @@ static void check_for_missing_completions(struct ena_adapter *adapter)
 {
 	struct ena_ring *tx_ring;
 	struct ena_ring *rx_ring;
-	int i, budget, rc;
+	int qid, budget, rc;
 	int io_queue_count;
 
 	io_queue_count = adapter->xdp_num_queues + adapter->num_io_queues;
+
 	/* Make sure the driver doesn't turn the device in other process */
 	smp_rmb();
 
@@ -3813,27 +3814,29 @@ static void check_for_missing_completions(struct ena_adapter *adapter)
 	if (adapter->missing_tx_completion_to == ENA_HW_HINTS_NO_TIMEOUT)
 		return;
 
-	budget = ENA_MONITORED_TX_QUEUES;
+	budget = min_t(u32, io_queue_count, ENA_MONITORED_TX_QUEUES);
 
-	for (i = adapter->last_monitored_tx_qid; i < io_queue_count; i++) {
-		tx_ring = &adapter->tx_ring[i];
-		rx_ring = &adapter->rx_ring[i];
+	qid = adapter->last_monitored_tx_qid;
+
+	while (budget) {
+		qid = (qid + 1) % io_queue_count;
+
+		tx_ring = &adapter->tx_ring[qid];
+		rx_ring = &adapter->rx_ring[qid];
 
 		rc = check_missing_comp_in_tx_queue(adapter, tx_ring);
 		if (unlikely(rc))
 			return;
 
-		rc =  !ENA_IS_XDP_INDEX(adapter, i) ?
+		rc =  !ENA_IS_XDP_INDEX(adapter, qid) ?
 			check_for_rx_interrupt_queue(adapter, rx_ring) : 0;
 		if (unlikely(rc))
 			return;
 
 		budget--;
-		if (!budget)
-			break;
 	}
 
-	adapter->last_monitored_tx_qid = i % io_queue_count;
+	adapter->last_monitored_tx_qid = qid;
 }
 
 /* trigger napi schedule after 2 consecutive detections */
-- 
2.43.0




