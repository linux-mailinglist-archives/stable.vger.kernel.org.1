Return-Path: <stable+bounces-23377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D344785FEB5
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 18:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A17B22BE9
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEDD15443A;
	Thu, 22 Feb 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v2hlfZd2"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92D1E488;
	Thu, 22 Feb 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621686; cv=none; b=pI/4tQ6+Q47qj8kZbvifGdZf33HAJ9n5AtkoqI+QyOgmuZkpB3yL1nSYt3dKNKftwF9WU9YpEoZnVU3255PrJjQxVwi+pf+1sBWxlier2LNGnlD4dFzBuojkFBVc+wfaFHScZT1jpog9iYzA4fLATmM26V4DsIRzUaBgXuPjFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621686; c=relaxed/simple;
	bh=bjbBKm61sS3OCiUiTraEzgDb0fORpdkoRq5LcJPn/Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GV920N1iibJFs0Cfki9ssG2+LG7Le9BSjBt1zd34vyRp0E/KV92k9EckDIXYOvmbWbwBADL5gtOpQqiWSGZ7PY+2Val7eQ4DoSLztrQ6ww1yQDrSq47mqpfPj84t1y17Xc4OtbN4560gOgg3sCvlocYhaZth9VvkAYqdanzJDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v2hlfZd2; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708621681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O7tlgS7MkdA1L6vxpIiDfXudireah7BPJ6Dyc7UeOKw=;
	b=v2hlfZd2C3xXw8cSD+mG/AWXt4cPww48KC+Yl2NE0ShrDnG7iKAcyA4P/30m+d3Wy1N4l7
	1OvH3paUYLfUVPW1dT1KiweB4c9jOB3an6HIr+xD2LtIOzS1yXTReMa6UyBxkDxS4UOLMN
	Cnu4tKGVlc5mx/+HeM4pLas0mCEkWwg=
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
Subject: [RESEND2 PATCH net v4 1/2] soc: fsl: qbman: Always disable interrupts when taking cgr_lock
Date: Thu, 22 Feb 2024 12:07:48 -0500
Message-Id: <20240222170749.2607485-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

smp_call_function_single disables IRQs when executing the callback. To
prevent deadlocks, we must disable IRQs when taking cgr_lock elsewhere.
This is already done by qman_update_cgr and qman_delete_cgr; fix the
other lockers.

Fixes: 96f413f47677 ("soc/fsl/qbman: fix issue in qman_delete_cgr_safe()")
CC: stable@vger.kernel.org
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Camelia Groza <camelia.groza@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Resent from a non-mangling email.

(no changes since v3)

Changes in v3:
- Change blamed commit to something more appropriate

Changes in v2:
- Fix one additional call to spin_unlock

 drivers/soc/fsl/qbman/qman.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 739e4eee6b75..1bf1f1ea67f0 100644
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
2.35.1.1320.gc452695387.dirty


