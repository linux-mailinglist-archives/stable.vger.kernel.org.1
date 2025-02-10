Return-Path: <stable+bounces-114592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 727D3A2EF08
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D50F164734
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27BF23099D;
	Mon, 10 Feb 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HJQGwk92"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548801DF744
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195849; cv=none; b=Me4BPp/H0w4VS/ae0x3Xw6/wioYU1l+slcS+R0SuzsVi/Xo+WCJtUqbavaYG5boTLXqQ+Xd9L6ucHKTW5d9pvBzZbmaLi0se6ZBCokTTwUKdk1KL0cNH0dBDYRyPsjceRT9KjvGTiR/TUwIvRT6VBWKb4GQnbMh0ovn0U+6fw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195849; c=relaxed/simple;
	bh=Tgm71iiPUpu8AdWy+ETn5mQ+ls0PrNRvkiuh7W58YvI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IgQVIha6FWY34P1cL5EfyRIsSaiHkky6jUPzKRezP4985NEBpj9S59WY/FlbLGLygpWohaTkvhqtTpnIB2KuGSt1gvhku9BlGHId/VEFB0S2/0fCz57A4PlFJiM5Vt5meD6udazJigJinI/h861FuF1c8AZDCczJOBGTzYUToRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HJQGwk92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F12C4CED1;
	Mon, 10 Feb 2025 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195848;
	bh=Tgm71iiPUpu8AdWy+ETn5mQ+ls0PrNRvkiuh7W58YvI=;
	h=Subject:To:Cc:From:Date:From;
	b=HJQGwk92wgicCeD3wcvZoAA9Ti9UCbtsgY3MC0NCd8hb0MVMEqAA9TZtidx5PWNlb
	 0b9tp80bgMNmnTBGNZYNkrIORemMxYicJMG+e7yE9hKGK8c94tHuQbRSiLiFXZr8jY
	 FAPD7lqmH8r4IC/zjhMN4kYx6XnERoOO72eoxokk=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Move FCE Trace buffer allocation to user" failed to apply to 5.4-stable tree
To: qutran@marvell.com,himanshu.madhani@oracle.com,martin.petersen@oracle.com,njavali@marvell.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:57:20 +0100
Message-ID: <2025021020-sappiness-encode-393a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 841df27d619ee1f5ca6473e15227b39d6136562d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021020-sappiness-encode-393a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 841df27d619ee1f5ca6473e15227b39d6136562d Mon Sep 17 00:00:00 2001
From: Quinn Tran <qutran@marvell.com>
Date: Fri, 15 Nov 2024 18:33:09 +0530
Subject: [PATCH] scsi: qla2xxx: Move FCE Trace buffer allocation to user
 control

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

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 15066c112817..cb95b7b12051 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4098,6 +4098,8 @@ struct qla_hw_data {
 		uint32_t	npiv_supported		:1;
 		uint32_t	pci_channel_io_perm_failure	:1;
 		uint32_t	fce_enabled		:1;
+		uint32_t	user_enabled_fce	:1;
+		uint32_t	fce_dump_buf_alloced	:1;
 		uint32_t	fac_supported		:1;
 
 		uint32_t	chip_reset_done		:1;
diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index a1545dad0c0c..08273520c777 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -409,27 +409,32 @@ qla2x00_dfs_fce_show(struct seq_file *s, void *unused)
 
 	mutex_lock(&ha->fce_mutex);
 
-	seq_puts(s, "FCE Trace Buffer\n");
-	seq_printf(s, "In Pointer = %llx\n\n", (unsigned long long)ha->fce_wr);
-	seq_printf(s, "Base = %llx\n\n", (unsigned long long) ha->fce_dma);
-	seq_puts(s, "FCE Enable Registers\n");
-	seq_printf(s, "%08x %08x %08x %08x %08x %08x\n",
-	    ha->fce_mb[0], ha->fce_mb[2], ha->fce_mb[3], ha->fce_mb[4],
-	    ha->fce_mb[5], ha->fce_mb[6]);
+	if (ha->flags.user_enabled_fce) {
+		seq_puts(s, "FCE Trace Buffer\n");
+		seq_printf(s, "In Pointer = %llx\n\n", (unsigned long long)ha->fce_wr);
+		seq_printf(s, "Base = %llx\n\n", (unsigned long long)ha->fce_dma);
+		seq_puts(s, "FCE Enable Registers\n");
+		seq_printf(s, "%08x %08x %08x %08x %08x %08x\n",
+			   ha->fce_mb[0], ha->fce_mb[2], ha->fce_mb[3], ha->fce_mb[4],
+			   ha->fce_mb[5], ha->fce_mb[6]);
 
-	fce = (uint32_t *) ha->fce;
-	fce_start = (unsigned long long) ha->fce_dma;
-	for (cnt = 0; cnt < fce_calc_size(ha->fce_bufs) / 4; cnt++) {
-		if (cnt % 8 == 0)
-			seq_printf(s, "\n%llx: ",
-			    (unsigned long long)((cnt * 4) + fce_start));
-		else
-			seq_putc(s, ' ');
-		seq_printf(s, "%08x", *fce++);
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
@@ -467,7 +472,7 @@ qla2x00_dfs_fce_release(struct inode *inode, struct file *file)
 	struct qla_hw_data *ha = vha->hw;
 	int rval;
 
-	if (ha->flags.fce_enabled)
+	if (ha->flags.fce_enabled || !ha->fce)
 		goto out;
 
 	mutex_lock(&ha->fce_mutex);
@@ -488,11 +493,88 @@ qla2x00_dfs_fce_release(struct inode *inode, struct file *file)
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
@@ -626,8 +708,6 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
 	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha))
 		goto out;
-	if (!ha->fce)
-		goto out;
 
 	if (qla2x00_dfs_root)
 		goto create_dir;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index cededfda9d0e..e556f57c91af 100644
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
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 31fc6a0eca3e..79cdfec2bca3 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2681,7 +2681,7 @@ qla83xx_nic_core_fw_load(scsi_qla_host_t *vha)
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
@@ -3745,7 +3744,7 @@ qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 		ql_log(ql_log_warn, vha, 0x00be,
 		       "Unable to allocate (%d KB) for FCE.\n",
 		       FCE_SIZE / 1024);
-		return;
+		return -ENOMEM;
 	}
 
 	ql_dbg(ql_dbg_init, vha, 0x00c0,
@@ -3754,6 +3753,16 @@ qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
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
@@ -3844,9 +3853,10 @@ qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
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


