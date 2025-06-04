Return-Path: <stable+bounces-151053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36324ACD31E
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF3A3A3116
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 01:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C4D25F995;
	Wed,  4 Jun 2025 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4BoQbgU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07314C62;
	Wed,  4 Jun 2025 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998861; cv=none; b=YHn1aCDrElnU5/vj+AFF1t6/DfJICskfJtc/Suci2pHZLvBvjIcgGsFpNOO6P6lDYHZ3nYeqrR0j8Du7M1S4r5KQXysgcbyZB/6sQ0jiWZzjvlrNbcQmbVACU8ypwYUtCLavYHne5bkY7jCg3zh0mL/B0WJxgUhVbgF/Dmn8AiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998861; c=relaxed/simple;
	bh=UsHKJzPzhXEVMQFJObMbn8adD6MkrVami/Z8gt7xMO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yem0qhAGaZH27LDbouhRjx1vvfeLN/rkHoswU7T+6sOfpmJW/t71Hs+ThOnfkPOWd8DRWoa9dLroJ80g/eccDRpCgniAZyFy/0KlCsP50LdtG4SkOZjACAZDbMQCNvLkKjNaoSHsBsspzjjAbTY8dFNDGwKjOfnGzzR/I1E9rWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4BoQbgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3330C4CEF2;
	Wed,  4 Jun 2025 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998861;
	bh=UsHKJzPzhXEVMQFJObMbn8adD6MkrVami/Z8gt7xMO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4BoQbgUlcrvNNdl5tD6efECQd/DL5tWEOO4f1D30p3m8ZpsOUjFaqADO7routo8x
	 RzBiA+CXYO+y+BRXDuBIgehheVMBP/X2XnWrd1NVkfcrmMbvaiO9kqitW5iKuU5BI3
	 j/Scg/h6sMx+77QN6zDkqPeq52B/YW3JS8Na9uCmJJXComiXdNa2yK06DNMTIPgDu/
	 qkZITy0DuQzLckCD1qS8HyIXSx+mVliJOiqcPx9iyAx62f89eAub0/Jrxq2N7F/e4V
	 0BssbI41dVn9dkobapye6fjgnFfNXYN8sVxSkIL1Hgm+eh2VUIQgrR13ycXe1VC1E7
	 N6N0GpsFUnttw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 56/93] scsi: lpfc: Fix lpfc_check_sli_ndlp() handling for GEN_REQUEST64 commands
Date: Tue,  3 Jun 2025 20:58:42 -0400
Message-Id: <20250604005919.4191884-56-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005919.4191884-1-sashal@kernel.org>
References: <20250604005919.4191884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 05ae6c9c7315d844fbc15afe393f5ba5e5771126 ]

In lpfc_check_sli_ndlp(), the get_job_els_rsp64_did remote_id assignment
does not apply for GEN_REQUEST64 commands as it only has meaning for a
ELS_REQUEST64 command.  So, if (iocb->ndlp == ndlp) is false, we could
erroneously return the wrong value.  Fix by replacing the fallthrough
statement with a break statement before the remote_id check.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20250425194806.3585-2-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: **Reasons for Backporting:** 1. **Fixes a Clear
Bug**: The commit addresses a specific logic error where
`CMD_GEN_REQUEST64_CR` commands incorrectly fall through to use
`get_job_els_rsp64_did()`, which is designed for ELS requests and may
return meaningless data for generic requests. 2. **Small and Contained
Change**: The fix is minimal (changing `fallthrough;` to `break;`) and
affects only the `lpfc_check_sli_ndlp()` function in
`drivers/scsi/lpfc/lpfc_hbadisc.c:5056`. 3. **Low Regression Risk**: The
change makes the code logic more precise by ensuring each command type
uses its appropriate validation method. This reduces the chance of false
matches rather than introducing new behavior. 4. **Affects Critical
Functionality**: The `lpfc_check_sli_ndlp()` function is used to match
IOCBs to node lists, which is fundamental for proper SCSI I/O handling
and could affect data integrity if nodes are incorrectly matched. 5.
**Similar to Accepted Backports**: This fix follows the same pattern as
Similar Commit #2 (Status: YES), which fixed missing validation in lpfc
node handling code. **Evidence from Code Analysis:** -
`get_job_els_rsp64_did()` extracts destination ID from ELS request
structures (`iocbq->wqe.els_req.wqe_dest` or
`iocbq->iocb.un.elsreq64.remoteID`) - For `CMD_GEN_REQUEST64_CR`
commands, these ELS-specific fields may contain unrelated data - The
incorrect fallthrough could cause `lpfc_check_sli_ndlp()` to return 1
(match) when it should return 0 (no match), potentially leading to I/O
being associated with wrong nodes **Stability Criteria Met:** - ✅
Important bug fix affecting I/O path - ✅ No new features introduced - ✅
No architectural changes - ✅ Minimal regression risk - ✅ Confined to
lpfc driver subsystem This is exactly the type of targeted bug fix that
stable trees are designed to include.

 drivers/scsi/lpfc/lpfc_hbadisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index f2e4237ff3d99..34f77b250387c 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -5082,7 +5082,7 @@ lpfc_check_sli_ndlp(struct lpfc_hba *phba,
 		case CMD_GEN_REQUEST64_CR:
 			if (iocb->ndlp == ndlp)
 				return 1;
-			fallthrough;
+			break;
 		case CMD_ELS_REQUEST64_CR:
 			if (remote_id == ndlp->nlp_DID)
 				return 1;
-- 
2.39.5


