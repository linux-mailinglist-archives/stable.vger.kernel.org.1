Return-Path: <stable+bounces-158805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8674AEC066
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 21:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F96178799
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE352D97BF;
	Fri, 27 Jun 2025 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BvKjuv5e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D121ADC7
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053861; cv=none; b=bnVsrR7mwyj+xXshgGb0zf+MGjCEb9izSFWeXZpXc0pDvFM3RXBUhBIDCpJwM32/xYdL1A+Mycsm0vtB7ZVLHbmOCcoc5Up8XqsVPGQhPAqNAdkJqYstCgiN2MBtjzFGTWcVYLFo3KLnbyE63V7de08WxX9i2na1hCq42+oIfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053861; c=relaxed/simple;
	bh=oiMTHog+F+uKeDeh51k1LJ/7nnVyG0WgFibrhOLthzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHLfKRc9Wzdc1W8zAmffZymf5YNcaBK0OCTlk5ULtA3OjnC2tu72AJiPS0dV33Ih2bCviod9PQefLeCH5fB5JfxX8RtP4ddbt4GtPgmOBEszeqVs8+H4joyJ1yeMXM/k4hXhBTITVe32JUkSnb+2v35xg9yUUbcNfXKRsWgwToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BvKjuv5e; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73c17c770a7so544355b3a.2
        for <stable@vger.kernel.org>; Fri, 27 Jun 2025 12:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751053860; x=1751658660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APgr3LNBVWwNPVuC7C3rvR7APHRHSRBdXswhxSMJ494=;
        b=BvKjuv5ePdlawsjD8BzxcMnit39rWUYUMDpbjYNQ5v1fkvxP622XUtIRsTL+eCbWR/
         3exzbIuC2f8aeovJ27IbdxbrUnRCbkoIBh4W7CfJOevSXZhfrdYvnErcHuGmGiQEUK4J
         DSi1xuyycKBfM5J97e15hRJ0wviEZrQbct12g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751053860; x=1751658660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APgr3LNBVWwNPVuC7C3rvR7APHRHSRBdXswhxSMJ494=;
        b=pFsiW/DEwNTtUINqcto4wobjX9qrPs4UI1mewdvM/8ulqGRBL75D/J+pxJjrLRZytT
         KEodjNQhUmg9iZU8JiMO/abQx10KTbMVmCzYBeLfWML/H7cFHJKiFfbuI9h07+P0DT2G
         ViFDQWzm+coKgynDbOZIgDqQnko4HVic+7125LJWxYI1RGpSRMkuz/N3TGZbG7Lhdz2Y
         OWJkUYrsKv/RDnNC5ZrmrlPvuUtx0vk112kQkBEVtePX4mqLCVq0i2WqUUNMjGEQwvOi
         L1VtPr6HveL5vxrl3kJqDCiGn4H6IoN+dx2/+LtCYd7DCPNSTt0xBpK9gD351qxBFSsu
         pSyw==
X-Forwarded-Encrypted: i=1; AJvYcCVzKSN5gFqBLsTBlGZmL13yZzkagfeVCCrqTaRK2cdQVnrZJydU+1VeEIaD5IsnxzzmPfAkH4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6RdE9q+RI7swnc1amieS+e8gviEuqv5o/cWM7Fij5579wfge
	UF+dT1PITSGG/yR0OWtFwtp5P/CBV9TAvznJqhRU5jqPQ+zCQHvzYD4yierFGbznOg==
X-Gm-Gg: ASbGnctNtb6VSiFYql0AIVPglhEyeAaSTUUY3kkckfjh7Hx01oDyeH9shm5rbIzwQI+
	/Hp+OvmPAmmnQav5BsVZ6ScnPXvOlgFCXRF+WXAh008MLfKtPXvs4EYLi2Gb0iSrzmPjYW1kXcj
	UZla8bm+9O1pMriwmq4dscVJlIm70Hafz/sjIYCk3AlG6zxdeOsKAPxhJDOgmm60FO9MkDUt59q
	UDrxWhVZkhEEP5IiaFVj/RGcn/nAku6AGMPyTmpPrJkC7yMzB+VLnwo/jY1TPea1myTD4BPgWWe
	vcA9GskMdHnT1g5D8a64WadzE/5akeRy97J7jGVzS0C5Cy6hoHDpoBy1P/FBtb1Gd1GLY/bIzfi
	6zJASSNd639lCPosD4jMmO1aQq2/qJQk=
X-Google-Smtp-Source: AGHT+IG6YnkWKwXhqtxK3gha9FYeKMi9bmuYoN+JoFm0KgWQO9WyuAZ491zOD5U9GEUiNWYqIRHnvA==
X-Received: by 2002:a17:902:db10:b0:235:1706:1fe7 with SMTP id d9443c01a7336-23ac3bffb5fmr67376525ad.4.1751053859637;
        Fri, 27 Jun 2025 12:50:59 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f247csm23485175ad.79.2025.06.27.12.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 12:50:59 -0700 (PDT)
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: rajsekhar.chundru@broadcom.com,
	sathya.prakash@broadcom.com,
	sumit.saxena@broadcom.com,
	chandrakanth.patil@broadcom.com,
	prayas.patel@broadcom.com,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 3/4] mpi3mr: Serialize admin queue BAR writes on 32-bit systems
Date: Sat, 28 Jun 2025 01:15:38 +0530
Message-Id: <20250627194539.48851-4-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250627194539.48851-1-ranjan.kumar@broadcom.com>
References: <20250627194539.48851-1-ranjan.kumar@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 32-bit systems, 64-bit BAR writes to admin queue registers are
performed as two 32-bit writes. Without locking, this can cause
partial writes when accessed concurrently.

Updated per-queue spinlocks is used to serialize these writes and prevent
race conditions.

Fixes: 824a156633df ("scsi: mpi3mr: Base driver code")
Cc: stable@vger.kernel.org
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
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
index 8976582946a2..0152d31d430a 100644
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
index ce444efd859e..0d1c9bbb13b5 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -5365,6 +5365,8 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	spin_lock_init(&mrioc->tgtdev_lock);
 	spin_lock_init(&mrioc->watchdog_lock);
 	spin_lock_init(&mrioc->chain_buf_lock);
+	spin_lock_init(&mrioc->adm_req_q_bar_writeq_lock);
+	spin_lock_init(&mrioc->adm_reply_q_bar_writeq_lock);
 	spin_lock_init(&mrioc->sas_node_lock);
 	spin_lock_init(&mrioc->trigger_lock);
 
-- 
2.31.1


