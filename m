Return-Path: <stable+bounces-38128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAAA8A0D24
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE1028540C
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9E14532F;
	Thu, 11 Apr 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LR/Tq0al"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CB013DDDD;
	Thu, 11 Apr 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829646; cv=none; b=YdVKPch4gP6A4RgvhmKuHScq9belztGvh6WPnLWCmcnwOMs0ibH5tFfUD27GQt4dlmezrzbktH8KeTzINx8z6h5Dx0Fqm/zfu/OS0M1mWiFQ2B/5iRrINNB4+U38BOWw3Uq8el6CE+FuqokW7uxBbmDJbvHuRj+yGmtJptOTfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829646; c=relaxed/simple;
	bh=SCyd4kS436GX7Nv16TFnvVGRux2MgbCAdEOTIU+NjxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quUyQmHR1KUKtZkcVhwHmbLYAUiLBCqYwSfAGSC9E9vzYCFNr1FM3hMvLGm6m+xwqc4SjGXgmrfBFyW5zr/dNg+FmJenc7sQMM4wbnudI6S4uKAalCKio4PLaFaQ3lTtW630T7FLdW+Aw/aAmFGsqg8IjMcPd2nYVPDmY994vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LR/Tq0al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97EFC433F1;
	Thu, 11 Apr 2024 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712829646;
	bh=SCyd4kS436GX7Nv16TFnvVGRux2MgbCAdEOTIU+NjxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LR/Tq0alsbvE9aSsseR07leQzmSkTvHISr/qf4N/UUco/p2Dcomq2ZsMQwwloNF+f
	 p9MuDk0Mo9iw+cW3MXVkkGdjrSPfuo1okTGD5pVsP+jTGwB0cKG6MR1uBLagd/YcLd
	 2SXmwTmlls+E9iSZTqvuX30Brt2AmxHHfY9nDXX8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	Sean Anderson <sean.anderson@linux.dev>,
	Camelia Groza <camelia.groza@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 057/175] soc: fsl: qbman: Use raw spinlock for cgr_lock
Date: Thu, 11 Apr 2024 11:54:40 +0200
Message-ID: <20240411095421.284101416@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095419.532012976@linuxfoundation.org>
References: <20240411095419.532012976@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Anderson <sean.anderson@linux.dev>

[ Upstream commit fbec4e7fed89b579f2483041fabf9650fb0dd6bc ]

smp_call_function always runs its callback in hard IRQ context, even on
PREEMPT_RT, where spinlocks can sleep. So we need to use a raw spinlock
for cgr_lock to ensure we aren't waiting on a sleeping task.

Although this bug has existed for a while, it was not apparent until
commit ef2a8d5478b9 ("net: dpaa: Adjust queue depth on rate change")
which invokes smp_call_function_single via qman_update_cgr_safe every
time a link goes up or down.

Fixes: 96f413f47677 ("soc/fsl/qbman: fix issue in qman_delete_cgr_safe()")
CC: stable@vger.kernel.org
Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Closes: https://lore.kernel.org/all/20230323153935.nofnjucqjqnz34ej@skbuf/
Reported-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Closes: https://lore.kernel.org/linux-arm-kernel/87wmsyvclu.fsf@pengutronix.de/
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Camelia Groza <camelia.groza@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qbman/qman.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 4d0853ead7ddf..ce08ce98142da 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -976,7 +976,7 @@ struct qman_portal {
 	/* linked-list of CSCN handlers. */
 	struct list_head cgr_cbs;
 	/* list lock */
-	spinlock_t cgr_lock;
+	raw_spinlock_t cgr_lock;
 	struct work_struct congestion_work;
 	struct work_struct mr_work;
 	char irqname[MAX_IRQNAME];
@@ -1194,7 +1194,7 @@ static int qman_create_portal(struct qman_portal *portal,
 		/* if the given mask is NULL, assume all CGRs can be seen */
 		qman_cgrs_fill(&portal->cgrs[0]);
 	INIT_LIST_HEAD(&portal->cgr_cbs);
-	spin_lock_init(&portal->cgr_lock);
+	raw_spin_lock_init(&portal->cgr_lock);
 	INIT_WORK(&portal->congestion_work, qm_congestion_task);
 	INIT_WORK(&portal->mr_work, qm_mr_process_task);
 	portal->bits = 0;
@@ -1369,11 +1369,14 @@ static void qm_congestion_task(struct work_struct *work)
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
@@ -1389,7 +1392,7 @@ static void qm_congestion_task(struct work_struct *work)
 	list_for_each_entry(cgr, &p->cgr_cbs, node)
 		if (cgr->cb && qman_cgrs_get(&c, cgr->cgrid))
 			cgr->cb(p, cgr, qman_cgrs_get(&rr, cgr->cgrid));
-	spin_unlock_irq(&p->cgr_lock);
+	raw_spin_unlock_irq(&p->cgr_lock);
 	qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 }
 
@@ -2346,7 +2349,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	preempt_enable();
 
 	cgr->chan = p->config->channel;
-	spin_lock_irq(&p->cgr_lock);
+	raw_spin_lock_irq(&p->cgr_lock);
 
 	if (opts) {
 		struct qm_mcc_initcgr local_opts = *opts;
@@ -2383,7 +2386,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	    qman_cgrs_get(&p->cgrs[1], cgr->cgrid))
 		cgr->cb(p, cgr, 1);
 out:
-	spin_unlock_irq(&p->cgr_lock);
+	raw_spin_unlock_irq(&p->cgr_lock);
 	put_affine_portal();
 	return ret;
 }
@@ -2418,7 +2421,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		return -EINVAL;
 
 	memset(&local_opts, 0, sizeof(struct qm_mcc_initcgr));
-	spin_lock_irqsave(&p->cgr_lock, irqflags);
+	raw_spin_lock_irqsave(&p->cgr_lock, irqflags);
 	list_del(&cgr->node);
 	/*
 	 * If there are no other CGR objects for this CGRID in the list,
@@ -2443,7 +2446,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		/* add back to the list */
 		list_add(&cgr->node, &p->cgr_cbs);
 release_lock:
-	spin_unlock_irqrestore(&p->cgr_lock, irqflags);
+	raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
 	put_affine_portal();
 	return ret;
 }
@@ -2483,9 +2486,9 @@ static int qman_update_cgr(struct qman_cgr *cgr, struct qm_mcc_initcgr *opts)
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
2.43.0




