Return-Path: <stable+bounces-101293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9259EEBAD
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239CC16908F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68283212B0F;
	Thu, 12 Dec 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CBX2gQUn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE21487CD;
	Thu, 12 Dec 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017052; cv=none; b=HXry/7uS8HvjiQkXPac9RIFrZTkBW4n/d6S7bqLrdQ2SgSwFyZPAueRMWMDJfWJmJMAa/d1b/h+gxKpWS3ehWzg7wt8QamCqlzl4T9tFZa7qXDz2kH5u0oRO07EL3lUUVhuRpgF2SJkdxvR3lrpfy9lADMDLT/njLFXLxbf5VRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017052; c=relaxed/simple;
	bh=fgP0dmyl38ex68i95UcFOEjE3g/w3KQAgIUUS2xhH7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9atUJtBL+UPfaR0KSC5s6Q2RNpOV+e0uyMXhL1Ckd72E+mCaCrHWoaXmTXWppxEkgwb0dpwu13+xS/7fWcEAvS9KEmpcKCydw6r60QtQnzYR9CUED6rHbvtxF6/o6f/uj7XyCusMIUvNiVUETGdKXVL08SnbGEKk804uvPU1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CBX2gQUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944D6C4CECE;
	Thu, 12 Dec 2024 15:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017052;
	bh=fgP0dmyl38ex68i95UcFOEjE3g/w3KQAgIUUS2xhH7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBX2gQUn9hEgy5xfOQsOzzdlZyiYtw6LuJsqCmKUux7qexzGl6boQFyKi9cd+sXR+
	 jI6jTJBGsG39wtSLb2Ug9Bbn9I5XHpvuD2WcMWPJs8R8wSK5IUELMSnC8rTflawtB/
	 1sFlz8KUJvtBzl/Ty2j3Gv+ch7E45bSoQQyLMvls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 369/466] scsi: lpfc: Check SLI_ACTIVE flag in FDMI cmpl before submitting follow up FDMI
Date: Thu, 12 Dec 2024 15:58:58 +0100
Message-ID: <20241212144321.355462896@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 98f8d3588097e321be70f83b844fa67d4828fe5c ]

The lpfc_cmpl_ct_disc_fdmi() routine has incorrect logic that treats an
FDMI completion with error LOCAL_REJECT/SLI_ABORTED as a success status.
Under the erroneous assumption of successful completion, the routine
proceeds to issue follow up FDMI commands, which may never complete if
the HBA is in an errata state as indicated by the errored completion
status.  Fix by freeing FDMI cmd resources and early return when the
LPFC_SLI_ACTIVE flag is not set and a LOCAL_REJECT/SLI_ABORTED or
SLI_DOWN status is received.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20241031223219.152342-6-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_ct.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 134bc96dd1340..ce3a1f42713dd 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -2226,6 +2226,11 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		ulp_status, ulp_word4, latt);
 
 	if (latt || ulp_status) {
+		lpfc_printf_vlog(vport, KERN_WARNING, LOG_DISCOVERY,
+				 "0229 FDMI cmd %04x failed, latt = %d "
+				 "ulp_status: (x%x/x%x), sli_flag x%x\n",
+				 be16_to_cpu(fdmi_cmd), latt, ulp_status,
+				 ulp_word4, phba->sli.sli_flag);
 
 		/* Look for a retryable error */
 		if (ulp_status == IOSTAT_LOCAL_REJECT) {
@@ -2234,8 +2239,16 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			case IOERR_SLI_DOWN:
 				/* Driver aborted this IO.  No retry as error
 				 * is likely Offline->Online or some adapter
-				 * error.  Recovery will try again.
+				 * error.  Recovery will try again, but if port
+				 * is not active there's no point to continue
+				 * issuing follow up FDMI commands.
 				 */
+				if (!(phba->sli.sli_flag & LPFC_SLI_ACTIVE)) {
+					free_ndlp = cmdiocb->ndlp;
+					lpfc_ct_free_iocb(phba, cmdiocb);
+					lpfc_nlp_put(free_ndlp);
+					return;
+				}
 				break;
 			case IOERR_ABORT_IN_PROGRESS:
 			case IOERR_SEQUENCE_TIMEOUT:
@@ -2256,12 +2269,6 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				break;
 			}
 		}
-
-		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
-				 "0229 FDMI cmd %04x latt = %d "
-				 "ulp_status: x%x, rid x%x\n",
-				 be16_to_cpu(fdmi_cmd), latt, ulp_status,
-				 ulp_word4);
 	}
 
 	free_ndlp = cmdiocb->ndlp;
-- 
2.43.0




