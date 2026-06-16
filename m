Return-Path: <stable+bounces-263755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +iwEN8BXMWomhQUAu9opvQ
	(envelope-from <stable+bounces-263755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7B69032B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:03:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=P0PHglwU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263755-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263755-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3431A3086FC3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF12334C08;
	Tue, 16 Jun 2026 14:00:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A11DB551;
	Tue, 16 Jun 2026 14:00:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618431; cv=none; b=sIHzZ48FHksvbKj8MgdYEoWHEm8/ne6/53XSyeYOJe+wZ4N1c2mrFEW8KU8NXMCkk16HIvIuD7v4WK5x48dKv0T8nGPLaLY+0miaRQHGc1318Ni+9S6RpBZUJpBTYxvRD199ufN2q3kxEHxw1hBxXZtrZh5Zo7GlGCkK+afxYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618431; c=relaxed/simple;
	bh=nU9M73fnlkh2+IH/zueqB+yQ6xnQrHefJplTzS2NNFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SHWKl+gfXPVfhU77qh78rfkaWnaXbOAc/Ze2wfTxO1GOneVfq0E0tc+ZfeNTfnOLzqW/eymUWDCYfCannCYYbP28/ywL146wgrbwNFP8YFk8lKrLg4bvrJgeJ2tulxEXRsFdTN0AThRGw833U19jll6dF/iDlSVsrj3QYb9YRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=P0PHglwU; arc=none smtp.client-ip=45.254.49.198
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 429ab339c;
	Tue, 16 Jun 2026 21:55:15 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: skashyap@marvell.com
Cc: jhasan@marvell.com,
	GR-QLogic-Storage-Upstream@marvell.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: qedf: Fix memory leak in __qedf_probe()
Date: Tue, 16 Jun 2026 21:55:13 +0800
Message-Id: <20260616135513.3982797-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed0b702a303a2kunm1a66c1da4541c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGR0eVhgdGEhKGkJOSE9CHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=P0PHglwU/1VtB+giZMX0FfoNdYl9KHOQ9nlTSq0UtcJUnUbE5Da4GlqIpAIBSMHGoffYbPXXE0Z96xQIwg1y2+PwWwVy/QLgvIUVJm7O23Q+G2betwiBNd3z+btASfJo2Cr+R5YfFKoCmAEOCKDTtY54xNok1L1rbB96h3Js26A=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=9GUWO6PErWNuWiRX8JvxhH2YvUQvw5ImBQBFeCCs5XQ=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263755-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:skashyap@marvell.com,m:jhasan@marvell.com,m:GR-QLogic-Storage-Upstream@marvell.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dawei.feng@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28C7B69032B

qedf_set_fcoe_pf_param() allocates PF queue state for the firmware FCoE
parameters. If qedf_alloc_global_queues() fails after partial allocation,
the existing unwind leaves p_cpuq and global_queues allocated. If later
__qedf_probe() steps fail after PF parameter setup succeeds, the same PF
queue state is also left behind.

Route those paths through qedf_free_fcoe_pf_param() and clear the freed
PF queue pointers so the helper-internal and probe-level unwinds can share
the same cleanup safely.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still present in
v7.1-rc7.

An x86_64 allyesconfig build showed no new warnings. As we do not have a
QLogic FastLinQ FCoE adapter to test with, no runtime testing was able to
be performed.

Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/scsi/qedf/qedf_main.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index da429b3a4283..3a41c0210336 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -32,6 +32,7 @@ static void qedf_shutdown(struct pci_dev *pdev);
 static void qedf_schedule_recovery_handler(void *dev);
 static void qedf_recovery_handler(struct work_struct *work);
 static int qedf_suspend(struct pci_dev *pdev, pm_message_t state);
+static void qedf_free_fcoe_pf_param(struct qedf_ctx *qedf);
 
 /*
  * Driver module parameters.
@@ -2927,15 +2928,18 @@ static void qedf_free_bdq(struct qedf_ctx *qedf)
 	if (qedf->bdq_pbl_list)
 		dma_free_coherent(&qedf->pdev->dev, QEDF_PAGE_SIZE,
 		    qedf->bdq_pbl_list, qedf->bdq_pbl_list_dma);
+	qedf->bdq_pbl_list = NULL;
 
 	if (qedf->bdq_pbl)
 		dma_free_coherent(&qedf->pdev->dev, qedf->bdq_pbl_mem_size,
 		    qedf->bdq_pbl, qedf->bdq_pbl_dma);
+	qedf->bdq_pbl = NULL;
 
 	for (i = 0; i < QEDF_BDQ_SIZE; i++) {
 		if (qedf->bdq[i].buf_addr) {
 			dma_free_coherent(&qedf->pdev->dev, QEDF_BDQ_BUF_SIZE,
 			    qedf->bdq[i].buf_addr, qedf->bdq[i].buf_dma);
+			qedf->bdq[i].buf_addr = NULL;
 		}
 	}
 }
@@ -2945,6 +2949,9 @@ static void qedf_free_global_queues(struct qedf_ctx *qedf)
 	int i;
 	struct global_queue **gl = qedf->global_queues;
 
+	if (!gl)
+		return;
+
 	for (i = 0; i < qedf->num_queues; i++) {
 		if (!gl[i])
 			continue;
@@ -2957,6 +2964,7 @@ static void qedf_free_global_queues(struct qedf_ctx *qedf)
 			    gl[i]->cq_pbl, gl[i]->cq_pbl_dma);
 
 		kfree(gl[i]);
+		gl[i] = NULL;
 	}
 
 	qedf_free_bdq(qedf);
@@ -3201,6 +3209,7 @@ static int qedf_set_fcoe_pf_param(struct qedf_ctx *qedf)
 	if (rval) {
 		QEDF_ERR(&(qedf->dbg_ctx), "Global queue allocation "
 			  "failed.\n");
+		qedf_free_fcoe_pf_param(qedf);
 		return 1;
 	}
 
@@ -3264,11 +3273,14 @@ static void qedf_free_fcoe_pf_param(struct qedf_ctx *qedf)
 		size = qedf->num_queues * sizeof(struct qedf_glbl_q_params);
 		dma_free_coherent(&qedf->pdev->dev, size, qedf->p_cpuq,
 		    qedf->hw_p_cpuq);
+		qedf->p_cpuq = NULL;
+		qedf->hw_p_cpuq = 0;
 	}
 
 	qedf_free_global_queues(qedf);
 
 	kfree(qedf->global_queues);
+	qedf->global_queues = NULL;
 }
 
 /*
@@ -3443,7 +3455,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	rc = qed_ops->fill_dev_info(qedf->cdev, &qedf->dev_info);
 	if (rc) {
 		QEDF_ERR(&qedf->dbg_ctx, "Failed to fill dev info.\n");
-		goto err2;
+		goto err2_free_pf;
 	}
 
 	if (mode != QEDF_MODE_RECOVERY) {
@@ -3452,7 +3464,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 			QEDF_ERR(&qedf->dbg_ctx, "Cannot register devlink\n");
 			rc = PTR_ERR(qedf->devlink);
 			qedf->devlink = NULL;
-			goto err2;
+			goto err2_free_pf;
 		}
 	}
 
@@ -3469,7 +3481,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	if (rc) {
 
 		QEDF_ERR(&(qedf->dbg_ctx), "Cannot start slowpath.\n");
-		goto err2;
+		goto err2_free_pf;
 	}
 
 	/* Start the Slowpath-process */
@@ -3483,7 +3495,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	rc = qed_ops->common->slowpath_start(qedf->cdev, &slowpath_params);
 	if (rc) {
 		QEDF_ERR(&(qedf->dbg_ctx), "Cannot start slowpath.\n");
-		goto err2;
+		goto err2_free_pf;
 	}
 
 	/*
@@ -3713,10 +3725,11 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 err5:
 	qed_ops->stop(qedf->cdev);
 err4:
-	qedf_free_fcoe_pf_param(qedf);
 	qedf_sync_free_irqs(qedf);
 err3:
 	qed_ops->common->slowpath_stop(qedf->cdev);
+err2_free_pf:
+	qedf_free_fcoe_pf_param(qedf);
 err2:
 	qed_ops->common->remove(qedf->cdev);
 err1:
-- 
2.34.1


