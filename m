Return-Path: <stable+bounces-10104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7A2827271
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C451F23572
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9384B5AB;
	Mon,  8 Jan 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FKy3q//K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C06D6E4;
	Mon,  8 Jan 2024 15:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC6AC43397;
	Mon,  8 Jan 2024 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726773;
	bh=vDLxmO9IwHsmSzQPzM7UdxLgozvH9JcVgIzxoqYCenw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKy3q//Kxdo6MNI+0E8Cq+wULKjirbOj3q7+wnmZEIPEu93N5cyK9AWNASMa4DIeL
	 Zxx3k7kfjCt0NhpgYvuN/gaOsX5VABvS4Idg9EQjlkmgbIpHu0ifCNvz/1lpgVsxpa
	 BtELjeOnzN66Q/nOXorENxq/aRIeZ7qEnE73ESaM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Longfang Liu <liulongfang@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 073/124] crypto: hisilicon/qm - fix EQ/AEQ interrupt issue
Date: Mon,  8 Jan 2024 16:08:19 +0100
Message-ID: <20240108150606.337647372@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

From: Longfang Liu <liulongfang@huawei.com>

[ Upstream commit 5acab6eb592387191c1bb745ba9b815e1e076db5 ]

During hisilicon accelerator live migration operation. In order to
prevent the problem of EQ/AEQ interrupt loss. Migration driver will
trigger an EQ/AEQ doorbell at the end of the migration.

This operation may cause double interruption of EQ/AEQ events.
To ensure that the EQ/AEQ interrupt processing function is normal.
The interrupt handling functionality of EQ/AEQ needs to be updated.
Used to handle repeated interrupts event.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/qm.c | 105 +++++++++++++---------------------
 include/linux/hisi_acc_qm.h   |   1 +
 2 files changed, 41 insertions(+), 65 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 193b0b3a77cda..f1589eb3b46af 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -855,47 +855,15 @@ static void qm_poll_req_cb(struct hisi_qp *qp)
 	qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ, qp->qp_status.cq_head, 1);
 }
 
-static int qm_get_complete_eqe_num(struct hisi_qm_poll_data *poll_data)
-{
-	struct hisi_qm *qm = poll_data->qm;
-	struct qm_eqe *eqe = qm->eqe + qm->status.eq_head;
-	u16 eq_depth = qm->eq_depth;
-	int eqe_num = 0;
-	u16 cqn;
-
-	while (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
-		cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
-		poll_data->qp_finish_id[eqe_num] = cqn;
-		eqe_num++;
-
-		if (qm->status.eq_head == eq_depth - 1) {
-			qm->status.eqc_phase = !qm->status.eqc_phase;
-			eqe = qm->eqe;
-			qm->status.eq_head = 0;
-		} else {
-			eqe++;
-			qm->status.eq_head++;
-		}
-
-		if (eqe_num == (eq_depth >> 1) - 1)
-			break;
-	}
-
-	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
-
-	return eqe_num;
-}
-
 static void qm_work_process(struct work_struct *work)
 {
 	struct hisi_qm_poll_data *poll_data =
 		container_of(work, struct hisi_qm_poll_data, work);
 	struct hisi_qm *qm = poll_data->qm;
+	u16 eqe_num = poll_data->eqe_num;
 	struct hisi_qp *qp;
-	int eqe_num, i;
+	int i;
 
-	/* Get qp id of completed tasks and re-enable the interrupt. */
-	eqe_num = qm_get_complete_eqe_num(poll_data);
 	for (i = eqe_num - 1; i >= 0; i--) {
 		qp = &qm->qp_array[poll_data->qp_finish_id[i]];
 		if (unlikely(atomic_read(&qp->qp_status.flags) == QP_STOP))
@@ -911,39 +879,55 @@ static void qm_work_process(struct work_struct *work)
 	}
 }
 
-static bool do_qm_eq_irq(struct hisi_qm *qm)
+static void qm_get_complete_eqe_num(struct hisi_qm *qm)
 {
 	struct qm_eqe *eqe = qm->eqe + qm->status.eq_head;
-	struct hisi_qm_poll_data *poll_data;
-	u16 cqn;
+	struct hisi_qm_poll_data *poll_data = NULL;
+	u16 eq_depth = qm->eq_depth;
+	u16 cqn, eqe_num = 0;
 
-	if (!readl(qm->io_base + QM_VF_EQ_INT_SOURCE))
-		return false;
+	if (QM_EQE_PHASE(eqe) != qm->status.eqc_phase) {
+		atomic64_inc(&qm->debug.dfx.err_irq_cnt);
+		qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
+		return;
+	}
 
-	if (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
+	cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
+	if (unlikely(cqn >= qm->qp_num))
+		return;
+	poll_data = &qm->poll_data[cqn];
+
+	while (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
 		cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
-		poll_data = &qm->poll_data[cqn];
-		queue_work(qm->wq, &poll_data->work);
+		poll_data->qp_finish_id[eqe_num] = cqn;
+		eqe_num++;
+
+		if (qm->status.eq_head == eq_depth - 1) {
+			qm->status.eqc_phase = !qm->status.eqc_phase;
+			eqe = qm->eqe;
+			qm->status.eq_head = 0;
+		} else {
+			eqe++;
+			qm->status.eq_head++;
+		}
 
-		return true;
+		if (eqe_num == (eq_depth >> 1) - 1)
+			break;
 	}
 
-	return false;
+	poll_data->eqe_num = eqe_num;
+	queue_work(qm->wq, &poll_data->work);
+	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
 }
 
 static irqreturn_t qm_eq_irq(int irq, void *data)
 {
 	struct hisi_qm *qm = data;
-	bool ret;
-
-	ret = do_qm_eq_irq(qm);
-	if (ret)
-		return IRQ_HANDLED;
 
-	atomic64_inc(&qm->debug.dfx.err_irq_cnt);
-	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
+	/* Get qp id of completed tasks and re-enable the interrupt */
+	qm_get_complete_eqe_num(qm);
 
-	return IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t qm_mb_cmd_irq(int irq, void *data)
@@ -1025,6 +1009,8 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 	u16 aeq_depth = qm->aeq_depth;
 	u32 type, qp_id;
 
+	atomic64_inc(&qm->debug.dfx.aeq_irq_cnt);
+
 	while (QM_AEQE_PHASE(aeqe) == qm->status.aeqc_phase) {
 		type = le32_to_cpu(aeqe->dw0) >> QM_AEQE_TYPE_SHIFT;
 		qp_id = le32_to_cpu(aeqe->dw0) & QM_AEQE_CQN_MASK;
@@ -1062,17 +1048,6 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t qm_aeq_irq(int irq, void *data)
-{
-	struct hisi_qm *qm = data;
-
-	atomic64_inc(&qm->debug.dfx.aeq_irq_cnt);
-	if (!readl(qm->io_base + QM_VF_AEQ_INT_SOURCE))
-		return IRQ_NONE;
-
-	return IRQ_WAKE_THREAD;
-}
-
 static void qm_init_qp_status(struct hisi_qp *qp)
 {
 	struct hisi_qp_status *qp_status = &qp->qp_status;
@@ -5012,8 +4987,8 @@ static int qm_register_aeq_irq(struct hisi_qm *qm)
 		return 0;
 
 	irq_vector = val & QM_IRQ_VECTOR_MASK;
-	ret = request_threaded_irq(pci_irq_vector(pdev, irq_vector), qm_aeq_irq,
-						   qm_aeq_thread, 0, qm->dev_name, qm);
+	ret = request_threaded_irq(pci_irq_vector(pdev, irq_vector), NULL,
+						   qm_aeq_thread, IRQF_ONESHOT, qm->dev_name, qm);
 	if (ret)
 		dev_err(&pdev->dev, "failed to request eq irq, ret = %d", ret);
 
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 9da4f3f1e6d61..7262c9993c39c 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -276,6 +276,7 @@ struct hisi_qm_poll_data {
 	struct hisi_qm *qm;
 	struct work_struct work;
 	u16 *qp_finish_id;
+	u16 eqe_num;
 };
 
 /**
-- 
2.43.0




