Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5BE6FA80A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjEHKhL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjEHKgs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC121BF7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:36:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07713627C7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A39C4339B;
        Mon,  8 May 2023 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542205;
        bh=ynJjKYwqy3erZ80zvU8qzgrhA8o/yYdGFmvnvkqwDpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDrdgdPhhpHH2cXZ5zXVn7zu9IWtbWQRnVtVzR8UNKs+RFl7aNQo3hB6youUZtg/2
         sY0U4WQol/FbWdiTB/bdik76IDamIq/hciniZExDlDE1yAqoyy7aAUrtqEsHED7inP
         mezQ9671UMmNVchWRMvzkLrhbVyv/+W93pG+Qp3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yi Zhang <yi.zhang@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 361/663] nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage"
Date:   Mon,  8 May 2023 11:43:07 +0200
Message-Id: <20230508094439.871025784@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 4f86a6ff6fbd891232dda3ca97fd1b9630b59809 ]

fcloop_fcp_op() could be called from flush request's ->end_io(flush_end_io) in
which the spinlock of fq->mq_flush_lock is grabbed with irq saved/disabled.

So fcloop_fcp_op() can't call spin_unlock_irq(&tfcp_req->reqlock) simply
which enables irq unconditionally.

Fixes the warning by switching to spin_lock_irqsave()/spin_unlock_irqrestore()

Fixes: c38dbbfab1bc ("nvme-fcloop: fix inconsistent lock state warnings")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fcloop.c | 48 ++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5c16372f3b533..c780af36c1d4a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -614,10 +614,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
 	struct fcloop_fcpreq *tfcp_req =
 		container_of(work, struct fcloop_fcpreq, fcp_rcv_work);
 	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
+	unsigned long flags;
 	int ret = 0;
 	bool aborted = false;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 		tfcp_req->inistate = INI_IO_ACTIVE;
@@ -626,11 +627,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
 		aborted = true;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(aborted))
 		ret = -ECANCELED;
@@ -655,8 +656,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		container_of(work, struct fcloop_fcpreq, abort_rcv_work);
 	struct nvmefc_fcp_req *fcpreq;
 	bool completed = false;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	switch (tfcp_req->inistate) {
 	case INI_IO_ABORTED:
@@ -665,11 +667,11 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		completed = true;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(completed)) {
 		/* remove reference taken in original abort downcall */
@@ -681,9 +683,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		nvmet_fc_rcv_fcp_abort(tfcp_req->tport->targetport,
 					&tfcp_req->tgt_fcp_req);
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->fcpreq = NULL;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 	/* call_host_done releases reference for abort downcall */
@@ -699,11 +701,12 @@ fcloop_tgt_fcprqst_done_work(struct work_struct *work)
 	struct fcloop_fcpreq *tfcp_req =
 		container_of(work, struct fcloop_fcpreq, tio_done_work);
 	struct nvmefc_fcp_req *fcpreq;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	tfcp_req->inistate = INI_IO_COMPLETED;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	fcloop_call_host_done(fcpreq, tfcp_req, tfcp_req->status);
 }
@@ -807,13 +810,14 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 	u32 rsplen = 0, xfrlen = 0;
 	int fcp_err = 0, active, aborted;
 	u8 op = tgt_fcpreq->op;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	active = tfcp_req->active;
 	aborted = tfcp_req->aborted;
 	tfcp_req->active = true;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(active))
 		/* illegal - call while i/o active */
@@ -821,9 +825,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 
 	if (unlikely(aborted)) {
 		/* target transport has aborted i/o prior */
-		spin_lock_irq(&tfcp_req->reqlock);
+		spin_lock_irqsave(&tfcp_req->reqlock, flags);
 		tfcp_req->active = false;
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		tgt_fcpreq->transferred_length = 0;
 		tgt_fcpreq->fcp_error = -ECANCELED;
 		tgt_fcpreq->done(tgt_fcpreq);
@@ -880,9 +884,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 		break;
 	}
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->active = false;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	tgt_fcpreq->transferred_length = xfrlen;
 	tgt_fcpreq->fcp_error = fcp_err;
@@ -896,15 +900,16 @@ fcloop_tgt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 			struct nvmefc_tgt_fcp_req *tgt_fcpreq)
 {
 	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
+	unsigned long flags;
 
 	/*
 	 * mark aborted only in case there were 2 threads in transport
 	 * (one doing io, other doing abort) and only kills ops posted
 	 * after the abort request
 	 */
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->aborted = true;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	tfcp_req->status = NVME_SC_INTERNAL;
 
@@ -946,6 +951,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	struct fcloop_ini_fcpreq *inireq = fcpreq->private;
 	struct fcloop_fcpreq *tfcp_req;
 	bool abortio = true;
+	unsigned long flags;
 
 	spin_lock(&inireq->inilock);
 	tfcp_req = inireq->tfcp_req;
@@ -958,7 +964,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		return;
 
 	/* break initiator/target relationship for io */
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 	case INI_IO_ACTIVE:
@@ -968,11 +974,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		abortio = false;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (abortio)
 		/* leave the reference while the work item is scheduled */
-- 
2.39.2



