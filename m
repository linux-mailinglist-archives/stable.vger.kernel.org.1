Return-Path: <stable+bounces-34327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A0893EDF
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4C41F2182E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD84778E;
	Mon,  1 Apr 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oMCYfg7I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D99446AC;
	Mon,  1 Apr 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987746; cv=none; b=YgSMgp50FkOdINvfXej0PBSeXRs1AMGpSSFLJHMYnqT/k0p6uYGlTR9AWXkfgTwm6aMiuIKTQ94QhQMXisHHRSPo17UTqcIcdbjJbKwppt2MqMORkKT82fqN9cWY+cExnNiYUBMmARm/lPhw8f6kXMCtJ7OmHxI3cAC2RYl1aII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987746; c=relaxed/simple;
	bh=mbuF90xEdRfr3MYcWn2hPMp2idg5qKC3huwDqnJ29AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQqe+MhIj8KeuMOHuam1iGXzQVJEbKC87HLR0+VCUwofPahJPgIUupg/O83Yhcc5MM6PSKr9y6zhI0m5h9HE15GzaWDhoFwdEPGhH+q0Os3mPzLdJJ5/nkf9DopYNuvydCUI+k/yWP4A4cdRF9Q8ZDldj7PK2Jw+CeDsneTYbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oMCYfg7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9F1C433C7;
	Mon,  1 Apr 2024 16:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987746;
	bh=mbuF90xEdRfr3MYcWn2hPMp2idg5qKC3huwDqnJ29AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMCYfg7Iff3TS/L+mBpPYd0xDXXDFurWpD4BUcveR5K2NcpwLFnr35rAbTFu/WCRW
	 ZCPrvM4CFCD6bTrqCLNYtdxT6OInES4pxNRwOfNmNIfc3/twIQbB4fl6fACTl3Zi2A
	 Xpgk5pAQSjcsDpmmKA1pGeARwdOEWkDEb8Q1CpU8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.8 379/399] scsi: qla2xxx: Split FCE|EFT trace control
Date: Mon,  1 Apr 2024 17:45:45 +0200
Message-ID: <20240401152600.492040214@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit 76a192e1a566e15365704b9f8fb3b70825f85064 upstream.

Current code combines the allocation of FCE|EFT trace buffers and enables
the features all in 1 step.

Split this step into separate steps in preparation for follow-on patch to
allow user to have a choice to enable / disable FCE trace feature.

Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240227164127.36465-4-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |  102 ++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 61 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2669,6 +2669,40 @@ exit:
 	return rval;
 }
 
+static void qla_enable_fce_trace(scsi_qla_host_t *vha)
+{
+	int rval;
+	struct qla_hw_data *ha = vha->hw;
+
+	if (ha->fce) {
+		ha->flags.fce_enabled = 1;
+		memset(ha->fce, 0, fce_calc_size(ha->fce_bufs));
+		rval = qla2x00_enable_fce_trace(vha,
+		    ha->fce_dma, ha->fce_bufs, ha->fce_mb, &ha->fce_bufs);
+
+		if (rval) {
+			ql_log(ql_log_warn, vha, 0x8033,
+			    "Unable to reinitialize FCE (%d).\n", rval);
+			ha->flags.fce_enabled = 0;
+		}
+	}
+}
+
+static void qla_enable_eft_trace(scsi_qla_host_t *vha)
+{
+	int rval;
+	struct qla_hw_data *ha = vha->hw;
+
+	if (ha->eft) {
+		memset(ha->eft, 0, EFT_SIZE);
+		rval = qla2x00_enable_eft_trace(vha, ha->eft_dma, EFT_NUM_BUFFERS);
+
+		if (rval) {
+			ql_log(ql_log_warn, vha, 0x8034,
+			    "Unable to reinitialize EFT (%d).\n", rval);
+		}
+	}
+}
 /*
 * qla2x00_initialize_adapter
 *      Initialize board.
@@ -3672,9 +3706,8 @@ qla24xx_chip_diag(scsi_qla_host_t *vha)
 }
 
 static void
-qla2x00_init_fce_trace(scsi_qla_host_t *vha)
+qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
 {
-	int rval;
 	dma_addr_t tc_dma;
 	void *tc;
 	struct qla_hw_data *ha = vha->hw;
@@ -3703,27 +3736,17 @@ qla2x00_init_fce_trace(scsi_qla_host_t *
 		return;
 	}
 
-	rval = qla2x00_enable_fce_trace(vha, tc_dma, FCE_NUM_BUFFERS,
-					ha->fce_mb, &ha->fce_bufs);
-	if (rval) {
-		ql_log(ql_log_warn, vha, 0x00bf,
-		       "Unable to initialize FCE (%d).\n", rval);
-		dma_free_coherent(&ha->pdev->dev, FCE_SIZE, tc, tc_dma);
-		return;
-	}
-
 	ql_dbg(ql_dbg_init, vha, 0x00c0,
 	       "Allocated (%d KB) for FCE...\n", FCE_SIZE / 1024);
 
-	ha->flags.fce_enabled = 1;
 	ha->fce_dma = tc_dma;
 	ha->fce = tc;
+	ha->fce_bufs = FCE_NUM_BUFFERS;
 }
 
 static void
-qla2x00_init_eft_trace(scsi_qla_host_t *vha)
+qla2x00_alloc_eft_trace(scsi_qla_host_t *vha)
 {
-	int rval;
 	dma_addr_t tc_dma;
 	void *tc;
 	struct qla_hw_data *ha = vha->hw;
@@ -3748,14 +3771,6 @@ qla2x00_init_eft_trace(scsi_qla_host_t *
 		return;
 	}
 
-	rval = qla2x00_enable_eft_trace(vha, tc_dma, EFT_NUM_BUFFERS);
-	if (rval) {
-		ql_log(ql_log_warn, vha, 0x00c2,
-		       "Unable to initialize EFT (%d).\n", rval);
-		dma_free_coherent(&ha->pdev->dev, EFT_SIZE, tc, tc_dma);
-		return;
-	}
-
 	ql_dbg(ql_dbg_init, vha, 0x00c3,
 	       "Allocated (%d KB) EFT ...\n", EFT_SIZE / 1024);
 
@@ -3763,13 +3778,6 @@ qla2x00_init_eft_trace(scsi_qla_host_t *
 	ha->eft = tc;
 }
 
-static void
-qla2x00_alloc_offload_mem(scsi_qla_host_t *vha)
-{
-	qla2x00_init_fce_trace(vha);
-	qla2x00_init_eft_trace(vha);
-}
-
 void
 qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
 {
@@ -3824,10 +3832,10 @@ qla2x00_alloc_fw_dump(scsi_qla_host_t *v
 		if (ha->tgt.atio_ring)
 			mq_size += ha->tgt.atio_q_length * sizeof(request_t);
 
-		qla2x00_init_fce_trace(vha);
+		qla2x00_alloc_fce_trace(vha);
 		if (ha->fce)
 			fce_size = sizeof(struct qla2xxx_fce_chain) + FCE_SIZE;
-		qla2x00_init_eft_trace(vha);
+		qla2x00_alloc_eft_trace(vha);
 		if (ha->eft)
 			eft_size = EFT_SIZE;
 	}
@@ -4257,7 +4265,6 @@ qla2x00_setup_chip(scsi_qla_host_t *vha)
 	struct qla_hw_data *ha = vha->hw;
 	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
 	unsigned long flags;
-	uint16_t fw_major_version;
 	int done_once = 0;
 
 	if (IS_P3P_TYPE(ha)) {
@@ -4324,7 +4331,6 @@ execute_fw_with_lr:
 					goto failed;
 
 enable_82xx_npiv:
-				fw_major_version = ha->fw_major_version;
 				if (IS_P3P_TYPE(ha))
 					qla82xx_check_md_needed(vha);
 				else
@@ -4353,12 +4359,11 @@ enable_82xx_npiv:
 				if (rval != QLA_SUCCESS)
 					goto failed;
 
-				if (!fw_major_version && !(IS_P3P_TYPE(ha)))
-					qla2x00_alloc_offload_mem(vha);
-
 				if (ql2xallocfwdump && !(IS_P3P_TYPE(ha)))
 					qla2x00_alloc_fw_dump(vha);
 
+				qla_enable_fce_trace(vha);
+				qla_enable_eft_trace(vha);
 			} else {
 				goto failed;
 			}
@@ -7491,7 +7496,6 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_
 int
 qla2x00_abort_isp(scsi_qla_host_t *vha)
 {
-	int rval;
 	uint8_t        status = 0;
 	struct qla_hw_data *ha = vha->hw;
 	struct scsi_qla_host *vp, *tvp;
@@ -7585,31 +7589,7 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 
 			if (IS_QLA81XX(ha) || IS_QLA8031(ha))
 				qla2x00_get_fw_version(vha);
-			if (ha->fce) {
-				ha->flags.fce_enabled = 1;
-				memset(ha->fce, 0,
-				    fce_calc_size(ha->fce_bufs));
-				rval = qla2x00_enable_fce_trace(vha,
-				    ha->fce_dma, ha->fce_bufs, ha->fce_mb,
-				    &ha->fce_bufs);
-				if (rval) {
-					ql_log(ql_log_warn, vha, 0x8033,
-					    "Unable to reinitialize FCE "
-					    "(%d).\n", rval);
-					ha->flags.fce_enabled = 0;
-				}
-			}
 
-			if (ha->eft) {
-				memset(ha->eft, 0, EFT_SIZE);
-				rval = qla2x00_enable_eft_trace(vha,
-				    ha->eft_dma, EFT_NUM_BUFFERS);
-				if (rval) {
-					ql_log(ql_log_warn, vha, 0x8034,
-					    "Unable to reinitialize EFT "
-					    "(%d).\n", rval);
-				}
-			}
 		} else {	/* failed the ISP abort */
 			vha->flags.online = 1;
 			if (test_bit(ISP_ABORT_RETRY, &vha->dpc_flags)) {



