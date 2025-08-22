Return-Path: <stable+bounces-172432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19F7B31C73
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B746B42672
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5A0306D2B;
	Fri, 22 Aug 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QILRxtcn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D566305E2B
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873576; cv=none; b=C/SH+ZU6BkDXYjloQ4DF0SsNyoK3yjRAC+FLM9KF56JRA7C4SyIr7WrCkKTaflEHoLypKzUp0A5mUsE6BIMM9tEPd6po1n52cVGQIZsksPEqS7w4fdbnMvsR4fvFBQ1rkaXYN9rhwfT+iA8+n9REqEQrqcuAcNV2R1am8taVPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873576; c=relaxed/simple;
	bh=tCfKrFWgnQAfelL84RXXkTGmRKHb69iGP4VRCS12X3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVkzzeFI0TnB52Y62Ze51R4Dyk5+JIztDGU0gaG38zhMVdC/nOegApNGl4nGR39eIHAGXjkwDna1UyHkSMkRsludG9NN+NzNn+498yebLxJRApoGRVk6VXjxTgqy82UIoUU7AVd+yxDhQtAfQexMWjOtY1omyBFLJnC3LEU3XK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QILRxtcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5064CC116B1;
	Fri, 22 Aug 2025 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755873575;
	bh=tCfKrFWgnQAfelL84RXXkTGmRKHb69iGP4VRCS12X3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QILRxtcnd9AMJwGBepTcnGC+2M2kKWVIPZzTQ5CQS5wMmqrXjSTchzeGdrVFTW/Is
	 ZvvSCHRU46OXhFnmTi/uUlvUZGUHGY2mkZxuorVQre1QyMroFWGBTcgJQX0Kn1Zo76
	 ZnlZgyVYZt1VEIQaoaTWFdtnVhMPwTZoApEVhCumHGY8T0zTayMtbFtkPgEBCVPC3Y
	 5mfw5MZuCwojY+gUiTM7oNGBG2Tc0r/ces/cLVafd2a3XSqZEqvvO803Khmebjvybh
	 vaoM8JQD8/RPYG9DNNOgwi1QQ/5zIwwvlYO8GX0dVuShmfu6jLX7uD4otEcANr/7fK
	 sGn2Y/kAESlIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/2] scsi: mpi3mr: Serialize admin queue BAR writes on 32-bit systems
Date: Fri, 22 Aug 2025 10:39:32 -0400
Message-ID: <20250822143932.1267223-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822143932.1267223-1-sashal@kernel.org>
References: <2025082104-chunk-scoring-a931@gregkh>
 <20250822143932.1267223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit c91e140c82eb58724c435f623702e51cc7896646 ]

On 32-bit systems, 64-bit BAR writes to admin queue registers are
performed as two 32-bit writes. Without locking, this can cause partial
writes when accessed concurrently.

Updated per-queue spinlocks is used to serialize these writes and prevent
race conditions.

Fixes: 824a156633df ("scsi: mpi3mr: Base driver code")
Cc: stable@vger.kernel.org
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20250627194539.48851-4-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr.h    |  4 ++++
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 15 +++++++++++----
 drivers/scsi/mpi3mr/mpi3mr_os.c |  2 ++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index bf272dd69d23..f2201108ea91 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -1137,6 +1137,8 @@ struct scmd_priv {
  * @logdata_buf: Circular buffer to store log data entries
  * @logdata_buf_idx: Index of entry in buffer to store
  * @logdata_entry_sz: log data entry size
+ * @adm_req_q_bar_writeq_lock: Admin request queue lock
+ * @adm_reply_q_bar_writeq_lock: Admin reply queue lock
  * @pend_large_data_sz: Counter to track pending large data
  * @io_throttle_data_length: I/O size to track in 512b blocks
  * @io_throttle_high: I/O size to start throttle in 512b blocks
@@ -1339,6 +1341,8 @@ struct mpi3mr_ioc {
 	u8 *logdata_buf;
 	u16 logdata_buf_idx;
 	u16 logdata_entry_sz;
+	spinlock_t adm_req_q_bar_writeq_lock;
+	spinlock_t adm_reply_q_bar_writeq_lock;
 
 	atomic_t pend_large_data_sz;
 	u32 io_throttle_data_length;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index fad94f2cc905..f19b730c7837 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -23,17 +23,22 @@ module_param(poll_queues, int, 0444);
 MODULE_PARM_DESC(poll_queues, "Number of queues for io_uring poll mode. (Range 1 - 126)");
 
 #if defined(writeq) && defined(CONFIG_64BIT)
-static inline void mpi3mr_writeq(__u64 b, void __iomem *addr)
+static inline void mpi3mr_writeq(__u64 b, void __iomem *addr,
+	spinlock_t *write_queue_lock)
 {
 	writeq(b, addr);
 }
 #else
-static inline void mpi3mr_writeq(__u64 b, void __iomem *addr)
+static inline void mpi3mr_writeq(__u64 b, void __iomem *addr,
+	spinlock_t *write_queue_lock)
 {
 	__u64 data_out = b;
+	unsigned long flags;
 
+	spin_lock_irqsave(write_queue_lock, flags);
 	writel((u32)(data_out), addr);
 	writel((u32)(data_out >> 32), (addr + 4));
+	spin_unlock_irqrestore(write_queue_lock, flags);
 }
 #endif
 
@@ -2954,9 +2959,11 @@ static int mpi3mr_setup_admin_qpair(struct mpi3mr_ioc *mrioc)
 	    (mrioc->num_admin_req);
 	writel(num_admin_entries, &mrioc->sysif_regs->admin_queue_num_entries);
 	mpi3mr_writeq(mrioc->admin_req_dma,
-	    &mrioc->sysif_regs->admin_request_queue_address);
+		&mrioc->sysif_regs->admin_request_queue_address,
+		&mrioc->adm_req_q_bar_writeq_lock);
 	mpi3mr_writeq(mrioc->admin_reply_dma,
-	    &mrioc->sysif_regs->admin_reply_queue_address);
+		&mrioc->sysif_regs->admin_reply_queue_address,
+		&mrioc->adm_reply_q_bar_writeq_lock);
 	writel(mrioc->admin_req_pi, &mrioc->sysif_regs->admin_request_queue_pi);
 	writel(mrioc->admin_reply_ci, &mrioc->sysif_regs->admin_reply_queue_ci);
 	return retval;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 87983ea4e06e..e467b56949e9 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -5383,6 +5383,8 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	spin_lock_init(&mrioc->tgtdev_lock);
 	spin_lock_init(&mrioc->watchdog_lock);
 	spin_lock_init(&mrioc->chain_buf_lock);
+	spin_lock_init(&mrioc->adm_req_q_bar_writeq_lock);
+	spin_lock_init(&mrioc->adm_reply_q_bar_writeq_lock);
 	spin_lock_init(&mrioc->sas_node_lock);
 	spin_lock_init(&mrioc->trigger_lock);
 
-- 
2.50.1


