Return-Path: <stable+bounces-50546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB48906B30
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7AC1F23B90
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397C14386B;
	Thu, 13 Jun 2024 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1bcnbO/f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5061D143739;
	Thu, 13 Jun 2024 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278681; cv=none; b=u1c7qcRgBgs0+ccDkDfB75fHnTFPDGu303NYNW62tPKERAhMvyWC/5xa53nyAe5HCynpGxVxAQVE+eFZ+v+qv8LQK+8QXVzyEr/21IcWo3EDCSOftm7QTa4Hap20bGIuxqc8mKWRlIIatSQRkTVI4AiiDpJtMf7Cqrq6pGxPN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278681; c=relaxed/simple;
	bh=JT7qN+9Bx6I4lx+zSrrYQ+Kix46zsWQhsIUGezxCuOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2Rp29sOOXiVtDIyu2/yOsoDMG37lmeVcQoQalw/hk8zrx8ABGr90Nj7Wi5mdTIWWh5hXy6127ntvffPZm0NpGVCYV1H6g7nOYikV5q53NLlf2gMb3aU6PaKxYIvC7U3tnKrKZyMnNR1QE0dmSvEabQiapvJDVACYsvelxSMHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1bcnbO/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD0AC2BBFC;
	Thu, 13 Jun 2024 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718278680;
	bh=JT7qN+9Bx6I4lx+zSrrYQ+Kix46zsWQhsIUGezxCuOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1bcnbO/fVdV2+C0x3axBj4HCGaKMSuLaeyaCR3FN5KqOD79xBhvI6Q74d80t173xm
	 qJoz3Z8Pw+Z0oHc0SPk/zGGOKSP04XieiOxpoO4VLDsspl6mpPSRiJW4pr3pUtOMHL
	 NjaRaBHVkwPZo1P6oamoMpvmbegmW3dNR7673RPk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Avri Altman <avri.altman@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/213] scsi: ufs: cleanup struct utp_task_req_desc
Date: Thu, 13 Jun 2024 13:31:21 +0200
Message-ID: <20240613113229.276323633@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 391e388f853dad5d1d7462a31bb50ff2446e37f0 ]

Remove the pointless task_req_upiu and task_rsp_upiu indirections,
which are __le32 arrays always cast to given structures and just add
the members directly.  Also clean up variables names in use in the
callers a bit to make the code more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: e4a628877119 ("scsi: ufs: core: Perform read back after disabling interrupts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs.h    | 30 -----------------
 drivers/scsi/ufs/ufshcd.c | 68 ++++++++++++---------------------------
 drivers/scsi/ufs/ufshci.h | 25 +++++++-------
 3 files changed, 34 insertions(+), 89 deletions(-)

diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index c3bcaaec0fc5c..58f8d6002d5a1 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -519,36 +519,6 @@ struct utp_upiu_rsp {
 	};
 };
 
-/**
- * struct utp_upiu_task_req - Task request UPIU structure
- * @header - UPIU header structure DW0 to DW-2
- * @input_param1: Input parameter 1 DW-3
- * @input_param2: Input parameter 2 DW-4
- * @input_param3: Input parameter 3 DW-5
- * @reserved: Reserved double words DW-6 to DW-7
- */
-struct utp_upiu_task_req {
-	struct utp_upiu_header header;
-	__be32 input_param1;
-	__be32 input_param2;
-	__be32 input_param3;
-	__be32 reserved[2];
-};
-
-/**
- * struct utp_upiu_task_rsp - Task Management Response UPIU structure
- * @header: UPIU header structure DW0-DW-2
- * @output_param1: Ouput parameter 1 DW3
- * @output_param2: Output parameter 2 DW4
- * @reserved: Reserved double words DW-5 to DW-7
- */
-struct utp_upiu_task_rsp {
-	struct utp_upiu_header header;
-	__be32 output_param1;
-	__be32 output_param2;
-	__be32 reserved[3];
-};
-
 /**
  * struct ufs_query_req - parameters for building a query request
  * @query_func: UPIU header query function
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b45cd6c98bad7..2239dda35fd70 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -341,14 +341,11 @@ static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
 		const char *str)
 {
-	struct utp_task_req_desc *descp;
-	struct utp_upiu_task_req *task_req;
 	int off = (int)tag - hba->nutrs;
+	struct utp_task_req_desc *descp = &hba->utmrdl_base_addr[off];
 
-	descp = &hba->utmrdl_base_addr[off];
-	task_req = (struct utp_upiu_task_req *)descp->task_req_upiu;
-	trace_ufshcd_upiu(dev_name(hba->dev), str, &task_req->header,
-			&task_req->input_param1);
+	trace_ufshcd_upiu(dev_name(hba->dev), str, &descp->req_header,
+			&descp->input_param1);
 }
 
 static void ufshcd_add_command_trace(struct ufs_hba *hba,
@@ -490,22 +487,13 @@ void ufshcd_print_trs(struct ufs_hba *hba, unsigned long bitmap, bool pr_prdt)
 
 static void ufshcd_print_tmrs(struct ufs_hba *hba, unsigned long bitmap)
 {
-	struct utp_task_req_desc *tmrdp;
 	int tag;
 
 	for_each_set_bit(tag, &bitmap, hba->nutmrs) {
-		tmrdp = &hba->utmrdl_base_addr[tag];
+		struct utp_task_req_desc *tmrdp = &hba->utmrdl_base_addr[tag];
+
 		dev_err(hba->dev, "TM[%d] - Task Management Header\n", tag);
-		ufshcd_hex_dump("TM TRD: ", &tmrdp->header,
-				sizeof(struct request_desc_header));
-		dev_err(hba->dev, "TM[%d] - Task Management Request UPIU\n",
-				tag);
-		ufshcd_hex_dump("TM REQ: ", tmrdp->task_req_upiu,
-				sizeof(struct utp_upiu_req));
-		dev_err(hba->dev, "TM[%d] - Task Management Response UPIU\n",
-				tag);
-		ufshcd_hex_dump("TM RSP: ", tmrdp->task_rsp_upiu,
-				sizeof(struct utp_task_req_desc));
+		ufshcd_hex_dump("", tmrdp, sizeof(*tmrdp));
 	}
 }
 
@@ -4680,31 +4668,22 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
  */
 static int ufshcd_task_req_compl(struct ufs_hba *hba, u32 index, u8 *resp)
 {
-	struct utp_task_req_desc *task_req_descp;
-	struct utp_upiu_task_rsp *task_rsp_upiup;
+	struct utp_task_req_desc *treq = hba->utmrdl_base_addr + index;
 	unsigned long flags;
 	int ocs_value;
-	int task_result;
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
 
 	/* Clear completed tasks from outstanding_tasks */
 	__clear_bit(index, &hba->outstanding_tasks);
 
-	task_req_descp = hba->utmrdl_base_addr;
-	ocs_value = ufshcd_get_tmr_ocs(&task_req_descp[index]);
+	ocs_value = ufshcd_get_tmr_ocs(treq);
 
-	if (ocs_value == OCS_SUCCESS) {
-		task_rsp_upiup = (struct utp_upiu_task_rsp *)
-				task_req_descp[index].task_rsp_upiu;
-		task_result = be32_to_cpu(task_rsp_upiup->output_param1);
-		task_result = task_result & MASK_TM_SERVICE_RESP;
-		if (resp)
-			*resp = (u8)task_result;
-	} else {
+	if (ocs_value != OCS_SUCCESS)
 		dev_err(hba->dev, "%s: failed, ocs = 0x%x\n",
 				__func__, ocs_value);
-	}
+	else if (resp)
+		*resp = be32_to_cpu(treq->output_param1) & MASK_TM_SERVICE_RESP;
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	return ocs_value;
@@ -5682,8 +5661,7 @@ static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag)
 static int ufshcd_issue_tm_cmd(struct ufs_hba *hba, int lun_id, int task_id,
 		u8 tm_function, u8 *tm_response)
 {
-	struct utp_task_req_desc *task_req_descp;
-	struct utp_upiu_task_req *task_req_upiup;
+	struct utp_task_req_desc *treq;
 	struct Scsi_Host *host;
 	unsigned long flags;
 	int free_slot;
@@ -5701,29 +5679,23 @@ static int ufshcd_issue_tm_cmd(struct ufs_hba *hba, int lun_id, int task_id,
 	ufshcd_hold(hba, false);
 
 	spin_lock_irqsave(host->host_lock, flags);
-	task_req_descp = hba->utmrdl_base_addr;
-	task_req_descp += free_slot;
+	treq = hba->utmrdl_base_addr + free_slot;
 
 	/* Configure task request descriptor */
-	task_req_descp->header.dword_0 = cpu_to_le32(UTP_REQ_DESC_INT_CMD);
-	task_req_descp->header.dword_2 =
-			cpu_to_le32(OCS_INVALID_COMMAND_STATUS);
+	treq->header.dword_0 = cpu_to_le32(UTP_REQ_DESC_INT_CMD);
+	treq->header.dword_2 = cpu_to_le32(OCS_INVALID_COMMAND_STATUS);
 
 	/* Configure task request UPIU */
-	task_req_upiup =
-		(struct utp_upiu_task_req *) task_req_descp->task_req_upiu;
 	task_tag = hba->nutrs + free_slot;
-	task_req_upiup->header.dword_0 =
-		UPIU_HEADER_DWORD(UPIU_TRANSACTION_TASK_REQ, 0,
-					      lun_id, task_tag);
-	task_req_upiup->header.dword_1 =
-		UPIU_HEADER_DWORD(0, tm_function, 0, 0);
+	treq->req_header.dword_0 = UPIU_HEADER_DWORD(UPIU_TRANSACTION_TASK_REQ,
+			0, lun_id, task_tag);
+	treq->req_header.dword_1 = UPIU_HEADER_DWORD(0, tm_function, 0, 0);
 	/*
 	 * The host shall provide the same value for LUN field in the basic
 	 * header and for Input Parameter.
 	 */
-	task_req_upiup->input_param1 = cpu_to_be32(lun_id);
-	task_req_upiup->input_param2 = cpu_to_be32(task_id);
+	treq->input_param1 = cpu_to_be32(lun_id);
+	treq->input_param2 = cpu_to_be32(task_id);
 
 	ufshcd_vops_setup_task_mgmt(hba, free_slot, tm_function);
 
diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index bb5d9c7f3353a..6fa889de5ee5e 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -433,22 +433,25 @@ struct utp_transfer_req_desc {
 	__le16  prd_table_offset;
 };
 
-/**
- * struct utp_task_req_desc - UTMRD structure
- * @header: UTMRD header DW-0 to DW-3
- * @task_req_upiu: Pointer to task request UPIU DW-4 to DW-11
- * @task_rsp_upiu: Pointer to task response UPIU DW12 to DW-19
+/*
+ * UTMRD structure.
  */
 struct utp_task_req_desc {
-
 	/* DW 0-3 */
 	struct request_desc_header header;
 
-	/* DW 4-11 */
-	__le32 task_req_upiu[TASK_REQ_UPIU_SIZE_DWORDS];
-
-	/* DW 12-19 */
-	__le32 task_rsp_upiu[TASK_RSP_UPIU_SIZE_DWORDS];
+	/* DW 4-11 - Task request UPIU structure */
+	struct utp_upiu_header	req_header;
+	__be32			input_param1;
+	__be32			input_param2;
+	__be32			input_param3;
+	__be32			__reserved1[2];
+
+	/* DW 12-19 - Task Management Response UPIU structure */
+	struct utp_upiu_header	rsp_header;
+	__be32			output_param1;
+	__be32			output_param2;
+	__be32			__reserved2[3];
 };
 
 #endif /* End of Header */
-- 
2.43.0




