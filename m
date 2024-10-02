Return-Path: <stable+bounces-79906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 134FC98DAD7
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B099EB263B3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F551D0E0F;
	Wed,  2 Oct 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tGWsEAj/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5911D1E90;
	Wed,  2 Oct 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878814; cv=none; b=fWbu/g6MxH81jo3CPdpTmygHSsXNHRkO1cXOiY1zwqDs+j3cB+eWuP06pmjp9/xa7wPAgyHtmdX98/QJGqIwSVi4HTHokdvinzBmqxBIOE05FA4wbNWgDVqz+fHRjiaY8PC6CwYp/W5yEymHFuWT7KijsOqydtcLL20/aBe5T0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878814; c=relaxed/simple;
	bh=JW6d69BIapuXLWCBUeXbDpH9k/bMZKdakfpFDG7lHw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eB5K3tyUSEak33kFRuGoQHEUVPOyfTUnf5sS6wr7Cep27x3RZOeBpobUpUb/jhA5gbYbyWNCd7i7MkjvRLUcI1uXRvhRJ8KteLJw7Rt0kKNhMBm+zIsuM4tUJXHNo8lN/zODc+yvo/WBLRVCFRY9PLhhlX/33oTt6TeJT8WiLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tGWsEAj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ECFC4CEC5;
	Wed,  2 Oct 2024 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878814;
	bh=JW6d69BIapuXLWCBUeXbDpH9k/bMZKdakfpFDG7lHw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGWsEAj/UMl9mTAXIa9N5LwvlCR76KmeOgE/zrx6m8o33h6oUrABNuB7mJIaTNNOK
	 iTS0Lm72qj79fprdO3YdMQqpFAr2XvNHo/acOjpIJ1fGIcYQEYA5ZZXBCtOTxBbU4d
	 ZdtdlsP9ptLtIe/w55NjxpqQ2Rtt2QlDoNtLQBZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.10 510/634] scsi: lpfc: Restrict support for 32 byte CDBs to specific HBAs
Date: Wed,  2 Oct 2024 15:00:10 +0200
Message-ID: <20241002125831.235696743@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Tee <justin.tee@broadcom.com>

commit 05ab4e7846f1103377133c00295a9a910cc6dfc2 upstream.

An older generation of HBAs are failing FCP discovery due to usage of an
outdated field in FCP command WQEs.

Fix by checking the SLI Interface Type register for applicable support of
32 Byte CDB commands, and restore a setting for a WQE path using normal 16
byte CDBs.

Fixes: af20bb73ac25 ("scsi: lpfc: Add support for 32 byte CDBs")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240912232447.45607-4-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_hw4.h  |    3 +++
 drivers/scsi/lpfc/lpfc_init.c |   21 ++++++++++++++++++---
 drivers/scsi/lpfc/lpfc_scsi.c |    2 +-
 3 files changed, 22 insertions(+), 4 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -4847,6 +4847,7 @@ struct fcp_iwrite64_wqe {
 #define	cmd_buff_len_SHIFT  16
 #define	cmd_buff_len_MASK  0x00000ffff
 #define	cmd_buff_len_WORD  word3
+/* Note: payload_offset_len field depends on ASIC support */
 #define payload_offset_len_SHIFT 0
 #define payload_offset_len_MASK 0x0000ffff
 #define payload_offset_len_WORD word3
@@ -4863,6 +4864,7 @@ struct fcp_iread64_wqe {
 #define	cmd_buff_len_SHIFT  16
 #define	cmd_buff_len_MASK  0x00000ffff
 #define	cmd_buff_len_WORD  word3
+/* Note: payload_offset_len field depends on ASIC support */
 #define payload_offset_len_SHIFT 0
 #define payload_offset_len_MASK 0x0000ffff
 #define payload_offset_len_WORD word3
@@ -4879,6 +4881,7 @@ struct fcp_icmnd64_wqe {
 #define	cmd_buff_len_SHIFT  16
 #define	cmd_buff_len_MASK  0x00000ffff
 #define	cmd_buff_len_WORD  word3
+/* Note: payload_offset_len field depends on ASIC support */
 #define payload_offset_len_SHIFT 0
 #define payload_offset_len_MASK 0x0000ffff
 #define payload_offset_len_WORD word3
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4699,6 +4699,7 @@ lpfc_create_port(struct lpfc_hba *phba,
 	uint64_t wwn;
 	bool use_no_reset_hba = false;
 	int rc;
+	u8 if_type;
 
 	if (lpfc_no_hba_reset_cnt) {
 		if (phba->sli_rev < LPFC_SLI_REV4 &&
@@ -4773,10 +4774,24 @@ lpfc_create_port(struct lpfc_hba *phba,
 	shost->max_id = LPFC_MAX_TARGET;
 	shost->max_lun = vport->cfg_max_luns;
 	shost->this_id = -1;
-	if (phba->sli_rev == LPFC_SLI_REV4)
-		shost->max_cmd_len = LPFC_FCP_CDB_LEN_32;
-	else
+
+	/* Set max_cmd_len applicable to ASIC support */
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		if_type = bf_get(lpfc_sli_intf_if_type,
+				 &phba->sli4_hba.sli_intf);
+		switch (if_type) {
+		case LPFC_SLI_INTF_IF_TYPE_2:
+			fallthrough;
+		case LPFC_SLI_INTF_IF_TYPE_6:
+			shost->max_cmd_len = LPFC_FCP_CDB_LEN_32;
+			break;
+		default:
+			shost->max_cmd_len = LPFC_FCP_CDB_LEN;
+			break;
+		}
+	} else {
 		shost->max_cmd_len = LPFC_FCP_CDB_LEN;
+	}
 
 	if (phba->sli_rev == LPFC_SLI_REV4) {
 		if (!phba->cfg_fcp_mq_threshold ||
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4760,7 +4760,7 @@ static int lpfc_scsi_prep_cmnd_buf_s4(st
 
 	 /* Word 3 */
 	bf_set(payload_offset_len, &wqe->fcp_icmd,
-	       sizeof(struct fcp_cmnd32) + sizeof(struct fcp_rsp));
+	       sizeof(struct fcp_cmnd) + sizeof(struct fcp_rsp));
 
 	/* Word 6 */
 	bf_set(wqe_ctxt_tag, &wqe->generic.wqe_com,



