Return-Path: <stable+bounces-18453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2345E8482C8
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563261C22B08
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485404E1CC;
	Sat,  3 Feb 2024 04:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lkz4zLz9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711813AC6;
	Sat,  3 Feb 2024 04:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933810; cv=none; b=RAvnOCu99nqNPB/X8FSH8Q9vnKN0l9AcTSrKSkrnbgSqdFhIS/h6ACbh8kYuNFuUH2xxXDLjcW+l2sNGenUjHPkpOfGAmK/g8iBx6gKAzqOs3aAoBOAzzvuC/38f+yuwkeiX+d1RxTUAJZKoL8foex4snJQa4+AINFusQakpVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933810; c=relaxed/simple;
	bh=QqqoQNf5mPSwkHw3/GLMf5XkDr/12ARtLHixZm5cN9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4Sh0YmHPC7HI/ELaKxR6s/H7T4STwVqGEe5yKW8M01Q6xcPTjEOYpxFpdN26YJDrBfwNzE9M01LdZdZjcD6sc6WOe9rqOMqC7x50K3+jwjdvsQUfMH2rwFwl6EKUsjJrtcNB8Xx02AoEDPFgk/WJ3dBsAa5l30a/JI3r1H/SKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lkz4zLz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C213EC433F1;
	Sat,  3 Feb 2024 04:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933809;
	bh=QqqoQNf5mPSwkHw3/GLMf5XkDr/12ARtLHixZm5cN9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lkz4zLz9zZ+osSWQJ5tn9NpNPgDR0Thbnv00FrMK9US/diOeirRYql7JBK4K0kzpD
	 XG+3g4uTwl2csvResXKfYRJiP+D1AuiCXo9FoaVHxPC9+Euc0X9epvL9GCCfV+P/R8
	 7zQlKuqoa+keIGiWdTX6Q8BptMRhiNeMjz/fPOwU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 126/353] scsi: lpfc: Reinitialize an NPIVs VMID data structures after FDISC
Date: Fri,  2 Feb 2024 20:04:04 -0800
Message-ID: <20240203035407.713943231@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 8dc8eb89f4df74593ba4bf30c3d31a0fc6d3ea47 ]

After a follow up FDISC cmpl, an NPIV's VMID data structures are not
updated.

Fix by calling lpfc_reinit_vmid and copying the physical port's vmid_flag
to the NPIV's vmid_flag in the NPIV registration cmpl code path.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20231207224039.35466-3-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 0829fe6ddff8..7e9b93460e64 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -11130,6 +11130,14 @@ lpfc_cmpl_reg_new_vport(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	lpfc_nlp_put(ndlp);
 
 	mempool_free(pmb, phba->mbox_mem_pool);
+
+	/* reinitialize the VMID datastructure before returning.
+	 * this is specifically for vport
+	 */
+	if (lpfc_is_vmid_enabled(phba))
+		lpfc_reinit_vmid(vport);
+	vport->vmid_flag = vport->phba->pport->vmid_flag;
+
 	return;
 }
 
-- 
2.43.0




