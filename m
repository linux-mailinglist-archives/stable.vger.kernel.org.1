Return-Path: <stable+bounces-23378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A4F85FEB8
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 18:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D401C22562
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5643F15099F;
	Thu, 22 Feb 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rzeeEd49"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F350D154BF1
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621689; cv=none; b=TsnVTYkfbcsi0eEqKKGd2raMHWfZf/PiJvLPO/of9mdSjSQywOyURuZjgGFiBAleMUgDCYm9UeKKlmjcBOB73Y9gNWaRZ3gJTAsmXktZHgBeroHzi6PzSMai9wP9segFSCRUUzXfIbSsR8YoYqc1p5XfV0g/iBlQtsD3uLPi0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621689; c=relaxed/simple;
	bh=LGLwT+i1W1ha4eOjAP8fBHDzSr0BgjvWb8WNdS7atjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXT5y28x2FVgzjF4D8ZsgKsg+q+7l2Q/urrzfgukoZXlPv96cZupaSmldgp/cqjtFMmFZmfqpdgBfYDkWJ7sI2HlLHC9reEW6urUKuBgf4OvzgkQHWXDmfOSvB2/I7ToEI+QgaTeIrviAq2cSeFhzwKxbF6+gv4zwYoI/n919nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rzeeEd49; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708621684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9cw43y7Ag2nW/FmjThiF7L/nsZOb2YeI0T4JXqjgN0=;
	b=rzeeEd49VE0/ALeGOGSSbg143s8OTwaFAvrxCY6yGJTNFwwjFnEicT6dia7ttVnRyvmbnK
	HyDFt3Yl46a0RnAXHRXJg/oBUW/egxgGR1825W80HSdBCnN6zALR51w2yk6tin+AfQdKwQ
	QIFIm5ehJbZHhRkiGNuQTCV3GBhhgdo=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Camelia Groza <camelia.groza@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Scott Wood <oss@buserror.net>,
	Li Yang <leoyang.li@nxp.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	stable@vger.kernel.org
Subject: [RESEND2 PATCH net v4 2/2] soc: fsl: qbman: Use raw spinlock for cgr_lock
Date: Thu, 22 Feb 2024 12:07:49 -0500
Message-Id: <20240222170749.2607485-2-sean.anderson@linux.dev>
In-Reply-To: <20240222170749.2607485-1-sean.anderson@linux.dev>
References: <20240222170749.2607485-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

cgr_lock may be locked with interrupts already disabled by
smp_call_function_single. As such, we must use a raw spinlock to avoid
problems on PREEMPT_RT kernels. Although this bug has existed for a
while, it was not apparent until commit ef2a8d5478b9 ("net: dpaa: Adjust
queue depth on rate change") which invokes smp_call_function_single via
qman_update_cgr_safe every time a link goes up or down.

Fixes: 96f413f47677 ("soc/fsl/qbman: fix issue in qman_delete_cgr_safe()")
CC: stable@vger.kernel.org
Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Closes: https://lore.kernel.org/all/20230323153935.nofnjucqjqnz34ej@skbuf/
Reported-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Closes: https://lore.kernel.org/linux-arm-kernel/87wmsyvclu.fsf@pengutronix.de/
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Camelia Groza <camelia.groza@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

Changes in v4:
- Add a note about how raw spinlocks aren't quite right

Changes in v3:
- Change blamed commit to something more appropriate

 drivers/soc/fsl/qbman/qman.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 1bf1f1ea67f0..7e9074519ad2 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -991,7 +991,7 @@ struct qman_portal {
 	/* linked-list of CSCN handlers. */
 	struct list_head cgr_cbs;
 	/* list lock */
-	spinlock_t cgr_lock;
+	raw_spinlock_t cgr_lock;
 	struct work_struct congestion_work;
 	struct work_struct mr_work;
 	char irqname[MAX_IRQNAME];
@@ -1281,7 +1281,7 @@ static int qman_create_portal(struct qman_portal *portal,
 		/* if the given mask is NULL, assume all CGRs can be seen */
 		qman_cgrs_fill(&portal->cgrs[0]);
 	INIT_LIST_HEAD(&portal->cgr_cbs);
-	spin_lock_init(&portal->cgr_lock);
+	raw_spin_lock_init(&portal->cgr_lock);
 	INIT_WORK(&portal->congestion_work, qm_congestion_task);
 	INIT_WORK(&portal->mr_work, qm_mr_process_task);
 	portal->bits = 0;
@@ -1456,11 +1456,14 @@ static void qm_congestion_task(struct work_struct *work)
 	union qm_mc_result *mcr;
 	struct qman_cgr *cgr;
 
-	spin_lock_irq(&p->cgr_lock);
+	/*
+	 * FIXME: QM_MCR_TIMEOUT is 10ms, which is too long for a raw spinlock!
+	 */
+	raw_spin_lock_irq(&p->cgr_lock);
 	qm_mc_start(&p->p);
 	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYCONGESTION);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
-		spin_unlock_irq(&p->cgr_lock);
+		raw_spin_unlock_irq(&p->cgr_lock);
 		dev_crit(p->config->dev, "QUERYCONGESTION timeout\n");
 		qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 		return;
@@ -1476,7 +1479,7 @@ static void qm_congestion_task(struct work_struct *work)
 	list_for_each_entry(cgr, &p->cgr_cbs, node)
 		if (cgr->cb && qman_cgrs_get(&c, cgr->cgrid))
 			cgr->cb(p, cgr, qman_cgrs_get(&rr, cgr->cgrid));
-	spin_unlock_irq(&p->cgr_lock);
+	raw_spin_unlock_irq(&p->cgr_lock);
 	qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 }
 
@@ -2440,7 +2443,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	preempt_enable();
 
 	cgr->chan = p->config->channel;
-	spin_lock_irq(&p->cgr_lock);
+	raw_spin_lock_irq(&p->cgr_lock);
 
 	if (opts) {
 		struct qm_mcc_initcgr local_opts = *opts;
@@ -2477,7 +2480,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	    qman_cgrs_get(&p->cgrs[1], cgr->cgrid))
 		cgr->cb(p, cgr, 1);
 out:
-	spin_unlock_irq(&p->cgr_lock);
+	raw_spin_unlock_irq(&p->cgr_lock);
 	put_affine_portal();
 	return ret;
 }
@@ -2512,7 +2515,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		return -EINVAL;
 
 	memset(&local_opts, 0, sizeof(struct qm_mcc_initcgr));
-	spin_lock_irqsave(&p->cgr_lock, irqflags);
+	raw_spin_lock_irqsave(&p->cgr_lock, irqflags);
 	list_del(&cgr->node);
 	/*
 	 * If there are no other CGR objects for this CGRID in the list,
@@ -2537,7 +2540,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		/* add back to the list */
 		list_add(&cgr->node, &p->cgr_cbs);
 release_lock:
-	spin_unlock_irqrestore(&p->cgr_lock, irqflags);
+	raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
 	put_affine_portal();
 	return ret;
 }
@@ -2577,9 +2580,9 @@ static int qman_update_cgr(struct qman_cgr *cgr, struct qm_mcc_initcgr *opts)
 	if (!p)
 		return -EINVAL;
 
-	spin_lock_irqsave(&p->cgr_lock, irqflags);
+	raw_spin_lock_irqsave(&p->cgr_lock, irqflags);
 	ret = qm_modify_cgr(cgr, 0, opts);
-	spin_unlock_irqrestore(&p->cgr_lock, irqflags);
+	raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
 	put_affine_portal();
 	return ret;
 }
-- 
2.35.1.1320.gc452695387.dirty


