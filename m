Return-Path: <stable+bounces-137975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15998AA1638
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898629859B0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB32512DE;
	Tue, 29 Apr 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A9LGg5QB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AEB78F58;
	Tue, 29 Apr 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947706; cv=none; b=EtBl7SdvwS/bfsSkqc6252jLxJMg9v55lqL8YdjrCdja28kW9d56XuzoNmxl/odSyBvyiyzxjd7+l6BFydX2Xdo6ALAMDu5pT1NBlCQ101elYfexOu7tVxGzS+z+rSa5Tldm927TGsMPD0YxcbfJAqsqKoHe3ZRtOKcnCS/Mwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947706; c=relaxed/simple;
	bh=JuRAbv53xibk0ThsKEtNDUqy1yFEgOnzgpN+NO3CA3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnlpnenz/8szU0STNxut0+nlJIcsXzKjbwIwRxmkn746fLSRXzRWT+5utAEi2yiYgtMIfzICTWnBkA/iAJ5xLgICgkUptQmCPfBiyAprU8Ojgn+pY+6fmmME+txAxLw+SFfVAo9GBLz5q9MatHttMY4WanZWxfn1WXyrjObxr2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A9LGg5QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59CDC4CEE9;
	Tue, 29 Apr 2025 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947706;
	bh=JuRAbv53xibk0ThsKEtNDUqy1yFEgOnzgpN+NO3CA3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9LGg5QBdU8Afhf3tKoaf2FXwt5mpEIhv31SFEQf+nfn9LsBylHqfkZyF1XY7H4PS
	 zGktscZpjcyWolWePjraya3jRBhYMyjJz7napa3PHoX/x0QL30OmQhdeHp/mdnkmDc
	 suGeFclI1qEFJOLUkVxo7kj+6MPomIF2erSjf8dw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 081/280] pds_core: make wait_context part of q_info
Date: Tue, 29 Apr 2025 18:40:22 +0200
Message-ID: <20250429161118.428555069@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit 3f77c3dfffc7063428b100c4945ca2a7a8680380 ]

Make the wait_context a full part of the q_info struct rather
than a stack variable that goes away after pdsc_adminq_post()
is done so that the context is still available after the wait
loop has given up.

There was a case where a slow development firmware caused
the adminq request to time out, but then later the FW finally
finished the request and sent the interrupt.  The handler tried
to complete_all() the completion context that had been created
on the stack in pdsc_adminq_post() but no longer existed.
This caused bad pointer usage, kernel crashes, and much wailing
and gnashing of teeth.

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20250421174606.3892-5-shannon.nelson@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 36 +++++++++-------------
 drivers/net/ethernet/amd/pds_core/core.c   |  4 ++-
 drivers/net/ethernet/amd/pds_core/core.h   |  2 +-
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index c83a0a80d5334..506f682d15c10 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -5,11 +5,6 @@
 
 #include "core.h"
 
-struct pdsc_wait_context {
-	struct pdsc_qcq *qcq;
-	struct completion wait_completion;
-};
-
 static int pdsc_process_notifyq(struct pdsc_qcq *qcq)
 {
 	union pds_core_notifyq_comp *comp;
@@ -109,10 +104,10 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 		q_info = &q->info[q->tail_idx];
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 
-		/* Copy out the completion data */
-		memcpy(q_info->dest, comp, sizeof(*comp));
-
-		complete_all(&q_info->wc->wait_completion);
+		if (!completion_done(&q_info->completion)) {
+			memcpy(q_info->dest, comp, sizeof(*comp));
+			complete(&q_info->completion);
+		}
 
 		if (cq->tail_idx == cq->num_descs - 1)
 			cq->done_color = !cq->done_color;
@@ -162,8 +157,7 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 static int __pdsc_adminq_post(struct pdsc *pdsc,
 			      struct pdsc_qcq *qcq,
 			      union pds_core_adminq_cmd *cmd,
-			      union pds_core_adminq_comp *comp,
-			      struct pdsc_wait_context *wc)
+			      union pds_core_adminq_comp *comp)
 {
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_q_info *q_info;
@@ -205,9 +199,9 @@ static int __pdsc_adminq_post(struct pdsc *pdsc,
 	/* Post the request */
 	index = q->head_idx;
 	q_info = &q->info[index];
-	q_info->wc = wc;
 	q_info->dest = comp;
 	memcpy(q_info->desc, cmd, sizeof(*cmd));
+	reinit_completion(&q_info->completion);
 
 	dev_dbg(pdsc->dev, "head_idx %d tail_idx %d\n",
 		q->head_idx, q->tail_idx);
@@ -231,16 +225,13 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		     union pds_core_adminq_comp *comp,
 		     bool fast_poll)
 {
-	struct pdsc_wait_context wc = {
-		.wait_completion =
-			COMPLETION_INITIALIZER_ONSTACK(wc.wait_completion),
-	};
 	unsigned long poll_interval = 1;
 	unsigned long poll_jiffies;
 	unsigned long time_limit;
 	unsigned long time_start;
 	unsigned long time_done;
 	unsigned long remaining;
+	struct completion *wc;
 	int err = 0;
 	int index;
 
@@ -250,20 +241,19 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		return -ENXIO;
 	}
 
-	wc.qcq = &pdsc->adminqcq;
-	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp, &wc);
+	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp);
 	if (index < 0) {
 		err = index;
 		goto err_out;
 	}
 
+	wc = &pdsc->adminqcq.q.info[index].completion;
 	time_start = jiffies;
 	time_limit = time_start + HZ * pdsc->devcmd_timeout;
 	do {
 		/* Timeslice the actual wait to catch IO errors etc early */
 		poll_jiffies = msecs_to_jiffies(poll_interval);
-		remaining = wait_for_completion_timeout(&wc.wait_completion,
-							poll_jiffies);
+		remaining = wait_for_completion_timeout(wc, poll_jiffies);
 		if (remaining)
 			break;
 
@@ -292,9 +282,11 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 	dev_dbg(pdsc->dev, "%s: elapsed %d msecs\n",
 		__func__, jiffies_to_msecs(time_done - time_start));
 
-	/* Check the results */
-	if (time_after_eq(time_done, time_limit))
+	/* Check the results and clear an un-completed timeout */
+	if (time_after_eq(time_done, time_limit) && !completion_done(wc)) {
 		err = -ETIMEDOUT;
+		complete(wc);
+	}
 
 	dev_dbg(pdsc->dev, "read admin queue completion idx %d:\n", index);
 	dynamic_hex_dump("comp ", DUMP_PREFIX_OFFSET, 16, 1,
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 4830292d5f879..3c60d4cf9d0e1 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -167,8 +167,10 @@ static void pdsc_q_map(struct pdsc_queue *q, void *base, dma_addr_t base_pa)
 	q->base = base;
 	q->base_pa = base_pa;
 
-	for (i = 0, cur = q->info; i < q->num_descs; i++, cur++)
+	for (i = 0, cur = q->info; i < q->num_descs; i++, cur++) {
 		cur->desc = base + (i * q->desc_size);
+		init_completion(&cur->completion);
+	}
 }
 
 static void pdsc_cq_map(struct pdsc_cq *cq, void *base, dma_addr_t base_pa)
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 543097983bf60..ec637dc4327a5 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -96,7 +96,7 @@ struct pdsc_q_info {
 	unsigned int bytes;
 	unsigned int nbufs;
 	struct pdsc_buf_info bufs[PDS_CORE_MAX_FRAGS];
-	struct pdsc_wait_context *wc;
+	struct completion completion;
 	void *dest;
 };
 
-- 
2.39.5




