Return-Path: <stable+bounces-34923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AF189417D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160401F23AA0
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602B481DA;
	Mon,  1 Apr 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GdnJpIK8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A8481C4;
	Mon,  1 Apr 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989754; cv=none; b=DVW3irDXztWH5ek2KgPzkfRp5dbRzLyJe7BvEYkOsRTox55jV9MwNMSWmptRgQVrvItKSc8wU+74VoWfPuBtf4RPEHh3ebZPAWqkIPd1wfIfBBOnYPwUZ01ZnDUHRTd4Ma3pxtYVP0NDOLHpbvjyNKNTkvgH/toFW2VCMh3GXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989754; c=relaxed/simple;
	bh=OcQrV9erZjWIsJF5s5N9YxvA+ry2lXoca3SRvX+haWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V97+xYp+44g6yOGcrLY7jIOhFvYpNvidcukqg5pxKtWDJ5pZahZy0zo/m2+sFjMeGQ03/eVp57Pf3xExdqJBthnK1oeKaO1iU27XKqg3kSBYUQmtPf1ZaWCKhnjUqQ/MU6ZXGo1Sy5F3FAAb0VkID6dHVtrQMS1MU7g2aL+VH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GdnJpIK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30834C433F1;
	Mon,  1 Apr 2024 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989753;
	bh=OcQrV9erZjWIsJF5s5N9YxvA+ry2lXoca3SRvX+haWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GdnJpIK87Tbzlw8jbz/C827xnMGHB3qYUEvLxdjihseMdAk7vo6Rnf2SLlvKN0laj
	 M7pl+dBZk+NCSndpA+iJkQ3tjL+J81fwrXXXnuJ5f2eWTUFaRJ75lThkSjW2FzYp01
	 FNVHo+raQUeP1xCYrp9gegnLNUVn1BpMm0cGouFk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Anderson <sean.anderson@linux.dev>,
	Camelia Groza <camelia.groza@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 142/396] soc: fsl: qbman: Always disable interrupts when taking cgr_lock
Date: Mon,  1 Apr 2024 17:43:11 +0200
Message-ID: <20240401152552.162816822@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Anderson <sean.anderson@linux.dev>

[ Upstream commit 584c2a9184a33a40fceee838f856de3cffa19be3 ]

smp_call_function_single disables IRQs when executing the callback. To
prevent deadlocks, we must disable IRQs when taking cgr_lock elsewhere.
This is already done by qman_update_cgr and qman_delete_cgr; fix the
other lockers.

Fixes: 96f413f47677 ("soc/fsl/qbman: fix issue in qman_delete_cgr_safe()")
CC: stable@vger.kernel.org
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Camelia Groza <camelia.groza@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qbman/qman.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 739e4eee6b75c..1bf1f1ea67f00 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1456,11 +1456,11 @@ static void qm_congestion_task(struct work_struct *work)
 	union qm_mc_result *mcr;
 	struct qman_cgr *cgr;
 
-	spin_lock(&p->cgr_lock);
+	spin_lock_irq(&p->cgr_lock);
 	qm_mc_start(&p->p);
 	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYCONGESTION);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
-		spin_unlock(&p->cgr_lock);
+		spin_unlock_irq(&p->cgr_lock);
 		dev_crit(p->config->dev, "QUERYCONGESTION timeout\n");
 		qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 		return;
@@ -1476,7 +1476,7 @@ static void qm_congestion_task(struct work_struct *work)
 	list_for_each_entry(cgr, &p->cgr_cbs, node)
 		if (cgr->cb && qman_cgrs_get(&c, cgr->cgrid))
 			cgr->cb(p, cgr, qman_cgrs_get(&rr, cgr->cgrid));
-	spin_unlock(&p->cgr_lock);
+	spin_unlock_irq(&p->cgr_lock);
 	qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 }
 
@@ -2440,7 +2440,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	preempt_enable();
 
 	cgr->chan = p->config->channel;
-	spin_lock(&p->cgr_lock);
+	spin_lock_irq(&p->cgr_lock);
 
 	if (opts) {
 		struct qm_mcc_initcgr local_opts = *opts;
@@ -2477,7 +2477,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	    qman_cgrs_get(&p->cgrs[1], cgr->cgrid))
 		cgr->cb(p, cgr, 1);
 out:
-	spin_unlock(&p->cgr_lock);
+	spin_unlock_irq(&p->cgr_lock);
 	put_affine_portal();
 	return ret;
 }
-- 
2.43.0




