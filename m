Return-Path: <stable+bounces-175438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0244B36829
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9484565BB2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F235690F;
	Tue, 26 Aug 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zpYqa1Jb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62913374C4;
	Tue, 26 Aug 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217042; cv=none; b=j47RVjOUeXJ3kbYC6RwWr+wZjZ+8QsX1dl7d6fNxOCeaIxo+F0OaUUuG2RD5r+9C4AC+OHoimCeZTan9cZrLe4Mspk2HZaROj+EdcW9ZBhqBog0xHk4rZwyS4BWIG9qvLDwcC/nEGFK1fV0dVB2FtKACNcM4uGv9tnwU7r4KuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217042; c=relaxed/simple;
	bh=9NEfD1/OC5isWRMXzY2VqQtVpIhmV83XnCeqx1x/Ebw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtTQy4HQetkhd3xIpphPWu6j6impZT3s/+CH/z053h/UeWcdNQj5B/wIozovySXhmnPMYP0M/Dbtt9nmMf7DXyIJiJIjV3h1PcPcyTmjhNrAoXw2ZsQt3y83+iq+ZNGOrAZXXOAsqlLIrQZrT4+mp3YZmetKQPq1914CnFMorBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zpYqa1Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9973C4CEF1;
	Tue, 26 Aug 2025 14:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217042;
	bh=9NEfD1/OC5isWRMXzY2VqQtVpIhmV83XnCeqx1x/Ebw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zpYqa1JbvH33AWRZJiEWAQu0HI37sQiqPvhRKI8l2B51bHqTKivNSDD2Q92LpmJcV
	 XJjHYbqjP+rVXWB+BbO58Pux1b6HHswaoeQL8TM8DnJiFjwUQ1GoMppnrXq5ahjCnK
	 qDc4rutMNh9d6SI6PY/7kz/5AsX4ZAXrp+ttKj3g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 607/644] scsi: mpi3mr: Serialize admin queue BAR writes on 32-bit systems
Date: Tue, 26 Aug 2025 13:11:38 +0200
Message-ID: <20250826111001.592852705@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
[ Adapt context in struct mpi3mr_ioc ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpi3mr/mpi3mr.h    |    4 ++++
 drivers/scsi/mpi3mr/mpi3mr_fw.c |   15 +++++++++++----
 drivers/scsi/mpi3mr/mpi3mr_os.c |    2 ++
 3 files changed, 17 insertions(+), 4 deletions(-)

--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -701,6 +701,8 @@ struct scmd_priv {
  * @driver_info: Driver, Kernel, OS information to firmware
  * @change_count: Topology change count
  * @op_reply_q_offset: Operational reply queue offset with MSIx
+ * @adm_req_q_bar_writeq_lock: Admin request queue lock
+ * @adm_reply_q_bar_writeq_lock: Admin reply queue lock
  */
 struct mpi3mr_ioc {
 	struct list_head list;
@@ -828,6 +830,8 @@ struct mpi3mr_ioc {
 	struct mpi3_driver_info_layout driver_info;
 	u16 change_count;
 	u16 op_reply_q_offset;
+	spinlock_t adm_req_q_bar_writeq_lock;
+	spinlock_t adm_reply_q_bar_writeq_lock;
 };
 
 /**
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -11,17 +11,22 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 
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
 
@@ -2183,9 +2188,11 @@ static int mpi3mr_setup_admin_qpair(stru
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
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -3796,6 +3796,8 @@ mpi3mr_probe(struct pci_dev *pdev, const
 	spin_lock_init(&mrioc->tgtdev_lock);
 	spin_lock_init(&mrioc->watchdog_lock);
 	spin_lock_init(&mrioc->chain_buf_lock);
+	spin_lock_init(&mrioc->adm_req_q_bar_writeq_lock);
+	spin_lock_init(&mrioc->adm_reply_q_bar_writeq_lock);
 
 	INIT_LIST_HEAD(&mrioc->fwevt_list);
 	INIT_LIST_HEAD(&mrioc->tgtdev_list);



