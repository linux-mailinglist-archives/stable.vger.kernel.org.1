Return-Path: <stable+bounces-127775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88202A7AB88
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385C73BC568
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C64F25F999;
	Thu,  3 Apr 2025 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA6xCo+q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F125F7A1;
	Thu,  3 Apr 2025 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707062; cv=none; b=lLlC/s/Gi8ULQPxnm9HsoVms3oeXbgaXToPL5UNUGXCHiNZ0chZd4Y9RD4oJEVb+s6pyJT22Evh9IbGof8WQnaVgTJYifqTbhhEwVLQP4o+O7jy1nVOUBisbkNf9nJUv7rXH3yTsceKcMbwwsG6Ybs9J659AhP07hcdG3C/GYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707062; c=relaxed/simple;
	bh=5ccxeDitBDlgfGMnj1XqY7jNfFxqLRKdLgGsUl2/FFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UE3VZGWkw94zveOGCFRy5Q8mfuILg/eDByGvFVeK40eyWCh/kHzDjbxjSbPUFTY/C98mCC8lrgvzmKslxu74ZmpI4SXF8X6WfLEu4clFhK5tH5RgJZiO9eKgNxitfNUe3ar+aO9+OH4HI1kKN+sDXwirubwh3KksFRvEq71dkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA6xCo+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F9FC4CEE8;
	Thu,  3 Apr 2025 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707062;
	bh=5ccxeDitBDlgfGMnj1XqY7jNfFxqLRKdLgGsUl2/FFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EA6xCo+q0o9rw99yw4txcckGHiSzWADdNKg4ek9JUUfd/WZ8zfWxL09PMVNvRwXDg
	 umOycQ97Cn23C252PeAwC3cs/GmS95pKx/mz1uA+Th7xCuh89lZmC8Qy8WEffcl65f
	 JQPGP8rWDlG4J7bWOg3TkHniCW3mU+3MqAstgh3tCAomm5W1WK2rfRa7ltiygoECpU
	 bB4OI3ish0LRilS7rOc3ZsewQERWLUj/WTswHsUfDaNqa3GKQ+G/xBZoOJPi4jpdNX
	 cuxtPj1OFDN3DPv8dQkaCH+4KBSxmPMXlBWQN/N9+BG7lHPgkRn0r/uFKO+weoNqH2
	 Vha6ORymabsEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	sathya.prakash@broadcom.com,
	kashyap.desai@broadcom.com,
	sreekanth.reddy@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 06/49] scsi: mpi3mr: Avoid reply queue full condition
Date: Thu,  3 Apr 2025 15:03:25 -0400
Message-Id: <20250403190408.2676344-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit f08b24d82749117ce779cc66689e8594341130d3 ]

To avoid reply queue full condition, update the driver to check IOCFacts
capabilities for qfull.

Update the operational reply queue's Consumer Index after processing 100
replies. If pending I/Os on a reply queue exceeds a threshold
(reply_queue_depth - 200), then return I/O back to OS to retry.

Also increase default admin reply queue size to 2K.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20250129100850.25430-2-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr.h     | 12 +++++++++++-
 drivers/scsi/mpi3mr/mpi3mr_app.c | 24 ++++++++++++++++++++++++
 drivers/scsi/mpi3mr/mpi3mr_fw.c  | 32 ++++++++++++++++++++++++++++----
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 0c3e1ac076b5f..3c7fd4582c0d6 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -81,13 +81,14 @@ extern atomic64_t event_counter;
 
 /* Admin queue management definitions */
 #define MPI3MR_ADMIN_REQ_Q_SIZE		(2 * MPI3MR_PAGE_SIZE_4K)
-#define MPI3MR_ADMIN_REPLY_Q_SIZE	(4 * MPI3MR_PAGE_SIZE_4K)
+#define MPI3MR_ADMIN_REPLY_Q_SIZE	(8 * MPI3MR_PAGE_SIZE_4K)
 #define MPI3MR_ADMIN_REQ_FRAME_SZ	128
 #define MPI3MR_ADMIN_REPLY_FRAME_SZ	16
 
 /* Operational queue management definitions */
 #define MPI3MR_OP_REQ_Q_QD		512
 #define MPI3MR_OP_REP_Q_QD		1024
+#define MPI3MR_OP_REP_Q_QD2K		2048
 #define MPI3MR_OP_REP_Q_QD4K		4096
 #define MPI3MR_OP_REQ_Q_SEG_SIZE	4096
 #define MPI3MR_OP_REP_Q_SEG_SIZE	4096
@@ -329,6 +330,7 @@ enum mpi3mr_reset_reason {
 #define MPI3MR_RESET_REASON_OSTYPE_SHIFT	28
 #define MPI3MR_RESET_REASON_IOCNUM_SHIFT	20
 
+
 /* Queue type definitions */
 enum queue_type {
 	MPI3MR_DEFAULT_QUEUE = 0,
@@ -388,6 +390,7 @@ struct mpi3mr_ioc_facts {
 	u16 max_msix_vectors;
 	u8 personality;
 	u8 dma_mask;
+	bool max_req_limit;
 	u8 protocol_flags;
 	u8 sge_mod_mask;
 	u8 sge_mod_value;
@@ -457,6 +460,8 @@ struct op_req_qinfo {
  * @enable_irq_poll: Flag to indicate polling is enabled
  * @in_use: Queue is handled by poll/ISR
  * @qtype: Type of queue (types defined in enum queue_type)
+ * @qfull_watermark: Watermark defined in reply queue to avoid
+ *                    reply queue full
  */
 struct op_reply_qinfo {
 	u16 ci;
@@ -472,6 +477,7 @@ struct op_reply_qinfo {
 	bool enable_irq_poll;
 	atomic_t in_use;
 	enum queue_type qtype;
+	u16 qfull_watermark;
 };
 
 /**
@@ -1154,6 +1160,8 @@ struct scmd_priv {
  * @snapdump_trigger_active: Snapdump trigger active flag
  * @pci_err_recovery: PCI error recovery in progress
  * @block_on_pci_err: Block IO during PCI error recovery
+ * @reply_qfull_count: Occurences of reply queue full avoidance kicking-in
+ * @prevent_reply_qfull: Enable reply queue prevention
  */
 struct mpi3mr_ioc {
 	struct list_head list;
@@ -1352,6 +1360,8 @@ struct mpi3mr_ioc {
 	bool fw_release_trigger_active;
 	bool pci_err_recovery;
 	bool block_on_pci_err;
+	atomic_t reply_qfull_count;
+	bool prevent_reply_qfull;
 };
 
 /**
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 7589f48aebc80..1532436f0f3af 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -3060,6 +3060,29 @@ reply_queue_count_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(reply_queue_count);
 
+/**
+ * reply_qfull_count_show - Show reply qfull count
+ * @dev: class device
+ * @attr: Device attributes
+ * @buf: Buffer to copy
+ *
+ * Retrieves the current value of the reply_qfull_count from the mrioc structure and
+ * formats it as a string for display.
+ *
+ * Return: sysfs_emit() return
+ */
+static ssize_t
+reply_qfull_count_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct mpi3mr_ioc *mrioc = shost_priv(shost);
+
+	return sysfs_emit(buf, "%u\n", atomic_read(&mrioc->reply_qfull_count));
+}
+
+static DEVICE_ATTR_RO(reply_qfull_count);
+
 /**
  * logging_level_show - Show controller debug level
  * @dev: class device
@@ -3152,6 +3175,7 @@ static struct attribute *mpi3mr_host_attrs[] = {
 	&dev_attr_fw_queue_depth.attr,
 	&dev_attr_op_req_q_count.attr,
 	&dev_attr_reply_queue_count.attr,
+	&dev_attr_reply_qfull_count.attr,
 	&dev_attr_logging_level.attr,
 	&dev_attr_adp_state.attr,
 	NULL,
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 5ed31fe57474a..656108dd2ee30 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -2104,15 +2104,22 @@ static int mpi3mr_create_op_reply_q(struct mpi3mr_ioc *mrioc, u16 qidx)
 	}
 
 	reply_qid = qidx + 1;
-	op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD;
-	if ((mrioc->pdev->device == MPI3_MFGPAGE_DEVID_SAS4116) &&
-		!mrioc->pdev->revision)
-		op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD4K;
+
+	if (mrioc->pdev->device == MPI3_MFGPAGE_DEVID_SAS4116) {
+		if (mrioc->pdev->revision)
+			op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD;
+		else
+			op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD4K;
+	} else
+		op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD2K;
+
 	op_reply_q->ci = 0;
 	op_reply_q->ephase = 1;
 	atomic_set(&op_reply_q->pend_ios, 0);
 	atomic_set(&op_reply_q->in_use, 0);
 	op_reply_q->enable_irq_poll = false;
+	op_reply_q->qfull_watermark =
+		op_reply_q->num_replies - (MPI3MR_THRESHOLD_REPLY_COUNT * 2);
 
 	if (!op_reply_q->q_segments) {
 		retval = mpi3mr_alloc_op_reply_q_segments(mrioc, qidx);
@@ -2416,8 +2423,10 @@ int mpi3mr_op_request_post(struct mpi3mr_ioc *mrioc,
 	void *segment_base_addr;
 	u16 req_sz = mrioc->facts.op_req_sz;
 	struct segments *segments = op_req_q->q_segments;
+	struct op_reply_qinfo *op_reply_q = NULL;
 
 	reply_qidx = op_req_q->reply_qid - 1;
+	op_reply_q = mrioc->op_reply_qinfo + reply_qidx;
 
 	if (mrioc->unrecoverable)
 		return -EFAULT;
@@ -2448,6 +2457,15 @@ int mpi3mr_op_request_post(struct mpi3mr_ioc *mrioc,
 		goto out;
 	}
 
+	/* Reply queue is nearing to get full, push back IOs to SML */
+	if ((mrioc->prevent_reply_qfull == true) &&
+		(atomic_read(&op_reply_q->pend_ios) >
+	     (op_reply_q->qfull_watermark))) {
+		atomic_inc(&mrioc->reply_qfull_count);
+		retval = -EAGAIN;
+		goto out;
+	}
+
 	segment_base_addr = segments[pi / op_req_q->segment_qd].segment;
 	req_entry = (u8 *)segment_base_addr +
 	    ((pi % op_req_q->segment_qd) * req_sz);
@@ -3091,6 +3109,9 @@ static void mpi3mr_process_factsdata(struct mpi3mr_ioc *mrioc,
 	mrioc->facts.dma_mask = (facts_flags &
 	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_MASK) >>
 	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_SHIFT;
+	mrioc->facts.dma_mask = (facts_flags &
+	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_MASK) >>
+	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_SHIFT;
 	mrioc->facts.protocol_flags = facts_data->protocol_flags;
 	mrioc->facts.mpi_version = le32_to_cpu(facts_data->mpi_version.word);
 	mrioc->facts.max_reqs = le16_to_cpu(facts_data->max_outstanding_requests);
@@ -4214,6 +4235,9 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
 		mrioc->shost->transportt = mpi3mr_transport_template;
 	}
 
+	if (mrioc->facts.max_req_limit)
+		mrioc->prevent_reply_qfull = true;
+
 	mrioc->reply_sz = mrioc->facts.reply_sz;
 
 	retval = mpi3mr_check_reset_dma_mask(mrioc);
-- 
2.39.5


