Return-Path: <stable+bounces-116187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B060A34713
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B6E7A427F
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C118991E;
	Thu, 13 Feb 2025 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ktG5mwHf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978201865EE;
	Thu, 13 Feb 2025 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460619; cv=none; b=HIewDfh5Y6D6WdZ848i4YaFknziLGH4ASi1ZE6mVBiCGkjPXyDDY6I/URqrXFsdO1ttdDUK+RgRG95zOlV2uhvPRL19AYTlGYIWldxXpo0ugLe2aCsxj+kVp4TqWvzBrSXrpSP/Sa3mMRR/apyXnTlhz8V5X935dqBS95fwFQQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460619; c=relaxed/simple;
	bh=rwZNsyAXsQoHKeDR5imB8YwIKhs2OVTKUtv84sEWR+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYfvi0F2M5RaOGyzwW5OIM+wSuHydgOlV1jtXa/+o1fVyGQ1+MysmzpkjsqKDkgirjaxGWHLtIrabueV04o37OiUbqC+NuA46/ZAuak0laDfnZQEJ4DUu4EpPlfGqiK/19JLc2v/B/qc8Cumi/YSELE0CPU+j/hXSlZCLp5m57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ktG5mwHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE818C4CEE4;
	Thu, 13 Feb 2025 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739460619;
	bh=rwZNsyAXsQoHKeDR5imB8YwIKhs2OVTKUtv84sEWR+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ktG5mwHfjhe2Nj9+F5UtcAcJo2SXsNciao8Iw2MeQpew2+4Bee68GnmmwoG2Uw4ZR
	 6oSN0eTEnDDguBOPSECRkNJplbl0PcGUsC3UbtDvVo/Y+JmacDEZSZl92knjCz1wr9
	 D5j2WX07CHFwDVppwW1pRIbaKPaFFopDI+aWNurE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 163/273] scsi: qla2xxx: Move FCE Trace buffer allocation to user control
Date: Thu, 13 Feb 2025 15:28:55 +0100
Message-ID: <20250213142413.775979337@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142407.354217048@linuxfoundation.org>
References: <20250213142407.354217048@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit 841df27d619ee1f5ca6473e15227b39d6136562d upstream.

Currently FCE Tracing is enabled to log additional ELS events. Instead,
user will enable or disable this feature through debugfs.

Modify existing DFS knob to allow user to enable or disable this
feature.

echo [1 | 0] > /sys/kernel/debug/qla2xxx/qla2xxx_??/fce
cat  /sys/kernel/debug/qla2xxx/qla2xxx_??/fce

Cc: stable@vger.kernel.org
Fixes: df613b96077c ("[SCSI] qla2xxx: Add Fibre Channel Event (FCE) tracing support.")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20241115130313.46826-4-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_def.h  |    2 
 drivers/scsi/qla2xxx/qla_dfs.c  |  124 ++++++++++++++++++++++++++++++++--------
 drivers/scsi/qla2xxx/qla_gbl.h  |    3 
 drivers/scsi/qla2xxx/qla_init.c |   28 ++++++---
 4 files changed, 126 insertions(+), 31 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4099,6 +4099,8 @@ struct qla_hw_data {
 		uint32_t	npiv_supported		:1;
 		uint32_t	pci_channel_io_perm_failure	:1;
 		uint32_t	fce_enabled		:1;
+		uint32_t	user_enabled_fce	:1;
+		uint32_t	fce_dump_buf_alloced	:1;
 		uint32_t	fac_supported		:1;
 
 		uint32_t	chip_reset_done		:1;
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -409,27 +409,32 @@ qla2x00_dfs_fce_show(struct seq_file *s,
 
 	mutex_lock(&ha->fce_mutex);
 
-	seq_puts(s, "FCE Trace Buffer\n");
-	seq_printf(s, "In Pointer = %llx\n\n", (unsigned long long)ha->fce_wr);
-	seq_printf(s, "Base = %llx\n\n", (unsigned long long) ha->fce_dma);
-	seq_puts(s, "FCE Enable Registers\n");
-	seq_printf(s, "%08x %08x %08x %08x %08x %08x\n",
-	    ha->fce_mb[0], ha->fce_mb[2], ha->fce_mb[3], ha->fce_mb[4],
-	    ha->fce_mb[5], ha->fce_mb[6]);
-
-	fce = (uint32_t *) ha->fce;
-	fce_start = (unsigned long long) ha->fce_dma;
-	for (cnt = 0; cnt < fce_calc_size(ha->fce_bufs) / 4; cnt++) {
-		if (cnt % 8 == 0)
-			seq_printf(s, "\n%llx: ",
-			    (unsigned long long)((cnt * 4) + fce_start));
-		else
-			seq_putc(s, ' ');
-		seq_printf(s, "%08x", *fce++);
+	if (ha->flags.user_enabled_fce) {
+		seq_puts(s, "FCE Trace Buffer\n");
+		seq_printf(s, "In Pointer = %llx\n\n", (unsigned long long)ha->fce_wr);
+		seq_printf(s, "Base = %llx\n\n", (unsigned long long)ha->fce_dma);
+		seq_puts(s, "FCE Enable Registers\n");
+		seq_printf(s, "%08x %08x %08x %08x %08x %08x\n",
+			   ha->fce_mb[0], ha->fce_mb[2], ha->fce_mb[3], ha->fce_mb[4],
+			   ha->fce_mb[5], ha->fce_mb[6]);
+
+		fce = (uint32_t *)ha->fce;
+		fce_start = (unsigned long long)ha->fce_dma;
+		for (cnt = 0; cnt < fce_calc_size(ha->fce_bufs) / 4; cnt++) {
+			if (cnt % 8 == 0)
+				seq_printf(s, "\n%llx: ",
+					   (unsigned long long)((cnt * 4) + fce_start));
+			else
+				seq_putc(s, ' ');
+			seq_printf(s, "%08x", *fce++);
+		}
+
+		seq_puts(s, "\nEnd\n");
+	} else {
+		seq_puts(s, "FCE Trace is currently not enabled\n");
+		seq_puts(s, "\techo [ 1 | 0 ] > fce\n");
 	}
 
-	seq_puts(s, "\nEnd\n");
-
 	mutex_unlock(&ha->fce_mutex);
 
 	return 0;
@@ -467,7 +472,7 @@ qla2x00_dfs_fce_release(struct inode *in
 	struct qla_hw_data *ha = vha->hw;
 	int rval;
 
-	if (ha->flags.fce_enabled)
+	if (ha->flags.fce_enabled || !ha->fce)
 		goto out;
 
 	mutex_lock(&ha->fce_mutex);
@@ -488,11 +493,88 @@ out:
 	return single_release(inode, file);
 }
 
+static ssize_t
+qla2x00_dfs_fce_write(struct file *file, const char __user *buffer,
+		      size_t count, loff_t *pos)
+{
+	struct seq_file *s = file->private_data;
+	struct scsi_qla_host *vha = s->private;
+	struct qla_hw_data *ha = vha->hw;
+	char *buf;
+	int rc = 0;
+	unsigned long enable;
+
+	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
+	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha)) {
+		ql_dbg(ql_dbg_user, vha, 0xd034,
+		       "this adapter does not support FCE.");
+		return -EINVAL;
+	}
+
+	buf = memdup_user_nul(buffer, count);
+	if (IS_ERR(buf)) {
+		ql_dbg(ql_dbg_user, vha, 0xd037,
+		    "fail to copy user buffer.");
+		return PTR_ERR(buf);
+	}
+
+	enable = kstrtoul(buf, 0, 0);
+	rc = count;
+
+	mutex_lock(&ha->fce_mutex);
+
+	if (enable) {
+		if (ha->flags.user_enabled_fce) {
+			mutex_unlock(&ha->fce_mutex);
+			goto out_free;
+		}
+		ha->flags.user_enabled_fce = 1;
+		if (!ha->fce) {
+			rc = qla2x00_alloc_fce_trace(vha);
+			if (rc) {
+				ha->flags.user_enabled_fce = 0;
+				mutex_unlock(&ha->fce_mutex);
+				goto out_free;
+			}
+
+			/* adjust fw dump buffer to take into account of this feature */
+			if (!ha->flags.fce_dump_buf_alloced)
+				qla2x00_alloc_fw_dump(vha);
+		}
+
+		if (!ha->flags.fce_enabled)
+			qla_enable_fce_trace(vha);
+
+		ql_dbg(ql_dbg_user, vha, 0xd045, "User enabled FCE .\n");
+	} else {
+		if (!ha->flags.user_enabled_fce) {
+			mutex_unlock(&ha->fce_mutex);
+			goto out_free;
+		}
+		ha->flags.user_enabled_fce = 0;
+		if (ha->flags.fce_enabled) {
+			qla2x00_disable_fce_trace(vha, NULL, NULL);
+			ha->flags.fce_enabled = 0;
+		}
+
+		qla2x00_free_fce_trace(ha);
+		/* no need to re-adjust fw dump buffer */
+
+		ql_dbg(ql_dbg_user, vha, 0xd04f, "User disabled FCE .\n");
+	}
+
+	mutex_unlock(&ha->fce_mutex);
+out_free:
+	kfree(buf);
+	return rc;
+}
+
 static const struct file_operations dfs_fce_ops = {
 	.open		= qla2x00_dfs_fce_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= qla2x00_dfs_fce_release,
+	.write		= qla2x00_dfs_fce_write,
 };
 
 static int
@@ -671,8 +753,6 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
 	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha))
 		goto out;
-	if (!ha->fce)
-		goto out;
 
 	if (qla2x00_dfs_root)
 		goto create_dir;
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -11,6 +11,9 @@
 /*
  * Global Function Prototypes in qla_init.c source file.
  */
+int  qla2x00_alloc_fce_trace(scsi_qla_host_t *);
+void qla2x00_free_fce_trace(struct qla_hw_data *ha);
+void qla_enable_fce_trace(scsi_qla_host_t *);
 extern int qla2x00_initialize_adapter(scsi_qla_host_t *);
 extern int qla24xx_post_prli_work(struct scsi_qla_host *vha, fc_port_t *fcport);
 
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2681,7 +2681,7 @@ exit:
 	return rval;
 }
 
-static void qla_enable_fce_trace(scsi_qla_host_t *vha)
+void qla_enable_fce_trace(scsi_qla_host_t *vha)
 {
 	int rval;
 	struct qla_hw_data *ha = vha->hw;
@@ -3717,25 +3717,24 @@ qla24xx_chip_diag(scsi_qla_host_t *vha)
 	return rval;
 }
 
-static void
-qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
+int qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 {
 	dma_addr_t tc_dma;
 	void *tc;
 	struct qla_hw_data *ha = vha->hw;
 
 	if (!IS_FWI2_CAPABLE(ha))
-		return;
+		return -EINVAL;
 
 	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
 	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha))
-		return;
+		return -EINVAL;
 
 	if (ha->fce) {
 		ql_dbg(ql_dbg_init, vha, 0x00bd,
 		       "%s: FCE Mem is already allocated.\n",
 		       __func__);
-		return;
+		return -EIO;
 	}
 
 	/* Allocate memory for Fibre Channel Event Buffer. */
@@ -3745,7 +3744,7 @@ qla2x00_alloc_fce_trace(scsi_qla_host_t
 		ql_log(ql_log_warn, vha, 0x00be,
 		       "Unable to allocate (%d KB) for FCE.\n",
 		       FCE_SIZE / 1024);
-		return;
+		return -ENOMEM;
 	}
 
 	ql_dbg(ql_dbg_init, vha, 0x00c0,
@@ -3754,6 +3753,16 @@ qla2x00_alloc_fce_trace(scsi_qla_host_t
 	ha->fce_dma = tc_dma;
 	ha->fce = tc;
 	ha->fce_bufs = FCE_NUM_BUFFERS;
+	return 0;
+}
+
+void qla2x00_free_fce_trace(struct qla_hw_data *ha)
+{
+	if (!ha->fce)
+		return;
+	dma_free_coherent(&ha->pdev->dev, FCE_SIZE, ha->fce, ha->fce_dma);
+	ha->fce = NULL;
+	ha->fce_dma = 0;
 }
 
 static void
@@ -3844,9 +3853,10 @@ qla2x00_alloc_fw_dump(scsi_qla_host_t *v
 		if (ha->tgt.atio_ring)
 			mq_size += ha->tgt.atio_q_length * sizeof(request_t);
 
-		qla2x00_alloc_fce_trace(vha);
-		if (ha->fce)
+		if (ha->fce) {
 			fce_size = sizeof(struct qla2xxx_fce_chain) + FCE_SIZE;
+			ha->flags.fce_dump_buf_alloced = 1;
+		}
 		qla2x00_alloc_eft_trace(vha);
 		if (ha->eft)
 			eft_size = EFT_SIZE;



