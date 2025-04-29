Return-Path: <stable+bounces-138791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 766DCAA1A23
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7449C5206
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBBD253344;
	Tue, 29 Apr 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C4ccEAXC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195471519A6;
	Tue, 29 Apr 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950362; cv=none; b=nS7vxnTgElo1f1fAwIP1zd8LXKU2ensGGkSgsdXGNiEF4lSFnVAoe8ea8JTuxmnUQSICYBGw5ExZMU+2zCCLT4tgJVXHJv/KOEoeJr9Jbyalh10Aur8tRN3xjuLaM4WzsxNsXNg9vecc6PLCViIvAj8b1RZZLJdrDmEJaSpFuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950362; c=relaxed/simple;
	bh=sw3PbL+PTOFYMh9o3wAn6znRlZKnLv/Fns0tkTUzaWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHgu9510vty2sSZqFbMUPAWGV2Tm8PgwTf9SWmw/M2sFHE9FHqea2ISZlkoHo/aXlvS7w43N/3oyu1PVztD9fT3uHw/D/y04crV4v6Lf65rzgAu6Jq4n2DBk7Zq7A+cL06YdDwwNEpvaj56QEyAD6AVimApVlUG0TQCDxAHL+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C4ccEAXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB3EC4CEE3;
	Tue, 29 Apr 2025 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950362;
	bh=sw3PbL+PTOFYMh9o3wAn6znRlZKnLv/Fns0tkTUzaWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4ccEAXCjjxkM6guHrXlqH9+2S0KG09QYtltwWNAqHPGoHF+X1XLv/19TCiuZHSAO
	 6AMP8SK6Jp4WWn1sD0dY9Kz+MpecaPhOoJl748lyyh+58tDKzDMvE8A7LYtd74o91a
	 ETedigntDyHPj/0rO0WsihAuQ1MMy1cPP0p1EHgM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 064/204] pds_core: make wait_context part of q_info
Date: Tue, 29 Apr 2025 18:42:32 +0200
Message-ID: <20250429161102.048879549@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index ea773cfa0af67..733f133d69e75 100644
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
@@ -110,10 +105,10 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
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
@@ -166,8 +161,7 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 static int __pdsc_adminq_post(struct pdsc *pdsc,
 			      struct pdsc_qcq *qcq,
 			      union pds_core_adminq_cmd *cmd,
-			      union pds_core_adminq_comp *comp,
-			      struct pdsc_wait_context *wc)
+			      union pds_core_adminq_comp *comp)
 {
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_q_info *q_info;
@@ -209,9 +203,9 @@ static int __pdsc_adminq_post(struct pdsc *pdsc,
 	/* Post the request */
 	index = q->head_idx;
 	q_info = &q->info[index];
-	q_info->wc = wc;
 	q_info->dest = comp;
 	memcpy(q_info->desc, cmd, sizeof(*cmd));
+	reinit_completion(&q_info->completion);
 
 	dev_dbg(pdsc->dev, "head_idx %d tail_idx %d\n",
 		q->head_idx, q->tail_idx);
@@ -235,16 +229,13 @@ int pdsc_adminq_post(struct pdsc *pdsc,
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
 
@@ -254,20 +245,19 @@ int pdsc_adminq_post(struct pdsc *pdsc,
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
 
@@ -296,9 +286,11 @@ int pdsc_adminq_post(struct pdsc *pdsc,
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
index eb73c921dc1ed..b3fa867c8ccd9 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -169,8 +169,10 @@ static void pdsc_q_map(struct pdsc_queue *q, void *base, dma_addr_t base_pa)
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
index f410f7d132056..858bebf797762 100644
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




