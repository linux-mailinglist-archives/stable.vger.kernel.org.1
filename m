Return-Path: <stable+bounces-136462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06739A996FE
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 19:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2571898609
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B0228BA95;
	Wed, 23 Apr 2025 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7ypJdgp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDA41C69
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430469; cv=none; b=nSDgqpmVppFJ896EAC6PZ3hlgH6iDbSUnZaIHrZxvWKbVvsVyfSxOp8m6CHFrMuTRHq9VV47eAAT7so/50Zoeprdc+JoBAPD2UxfJhK8ui6+bdjY9WEzmXrua4wgrYlk4elWqKTuA7LJ0IzE6N0fRVnPc81ZUF7W0O7hi1bMghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430469; c=relaxed/simple;
	bh=RjQSY9IZjrkQwD1GdLzVnqjOrQYMUXS1u4tmvORqREY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgthNpvwJLdusyzqIJMWmZEHu/s3CVod5hckO5YPUYK89DMr7Qu1ghOrBFK+wb0pcWLKRGlrlfWys6PuSoFP2jt1MUVQ+yBXxWDWTTEf+bp6i7/GXgkntLssn++J1TL05l/4dxr2n7YT0QH5AKBQvOE4qNeP9mj7++t7DNbun98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7ypJdgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B77C4CEE8;
	Wed, 23 Apr 2025 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745430468;
	bh=RjQSY9IZjrkQwD1GdLzVnqjOrQYMUXS1u4tmvORqREY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7ypJdgptzlDkx2MknKJtk4CfHio/sC/+ib4fn/GFJ6KqBuwUPqFWKvYPBoKnMkOQ
	 HzCoh6Wl47JdQg/EQBWKIuepXyN2l78StOzyVT55aaKlUGTRD1l945Sn4r2n3NQ6Dm
	 t1xe9WhCfWtL7M7EGicsWbAoYz6WqtrICFdRmAva9TK34d+f3lG5UZHVdnzW5ztLiy
	 aGAcFdhUi7C4b1a4zERYQNkNP05CfPyGN0AQS74ayBLf+Ttfl40OcZbAV6XWLtYNM2
	 mgdb09VM5F9tBtR2xQXHyVHtcbj6zgG6yZb/9DGnta3AFfhjPl8PgzxR0GrCPDeNSG
	 xFNcokaPZAHWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] scsi: lpfc: Fix null pointer dereference after failing to issue FLOGI and PLOGI
Date: Wed, 23 Apr 2025 13:47:46 -0400
Message-Id: <20250423124236-db305a4c20aa9e11@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423115644.1585421-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 577a942df3de2666f6947bdd3a5c9e8d30073424

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: James Smart<jsmart2021@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  577a942df3de2 ! 1:  84e3972d52302 scsi: lpfc: Fix null pointer dereference after failing to issue FLOGI and PLOGI
    @@ Metadata
      ## Commit message ##
         scsi: lpfc: Fix null pointer dereference after failing to issue FLOGI and PLOGI
     
    +    [ Upstream commit 577a942df3de2666f6947bdd3a5c9e8d30073424 ]
    +
         If lpfc_issue_els_flogi() fails and returns non-zero status, the node
         reference count is decremented to trigger the release of the nodelist
         structure. However, if there is a prior registration or dev-loss-evt work
    @@ Commit message
         Signed-off-by: Justin Tee <justin.tee@broadcom.com>
         Signed-off-by: James Smart <jsmart2021@gmail.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    [Minor context change fixed.]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/scsi/lpfc/lpfc_els.c ##
     @@ drivers/scsi/lpfc/lpfc_els.c: lpfc_initial_flogi(struct lpfc_vport *vport)
    - 	/* Reset the Fabric flag, topology change may have happened */
    - 	vport->fc_flag &= ~FC_FABRIC;
    + 	}
    + 
      	if (lpfc_issue_els_flogi(vport, ndlp, 0)) {
     -		/* This decrement of reference count to node shall kick off
     -		 * the release of the node.
    @@ drivers/scsi/lpfc/lpfc_els.c: lpfc_initial_fdisc(struct lpfc_vport *vport)
      	}
      	return 1;
     @@ drivers/scsi/lpfc/lpfc_els.c: lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
    + 	struct lpfc_dmabuf *prsp;
      	int disc;
      	struct serv_parm *sp = NULL;
    - 	u32 ulp_status, ulp_word4, did, iotag;
     +	bool release_node = false;
      
      	/* we pass cmdiocb to state machine which needs rspiocb as well */
    @@ drivers/scsi/lpfc/lpfc_els.c: lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct
      		/* Good status, call state machine */
      		prsp = list_entry(((struct lpfc_dmabuf *)
     @@ drivers/scsi/lpfc/lpfc_els.c: lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
    + 	struct lpfc_nodelist *ndlp;
    + 	char *mode;
      	u32 loglevel;
    - 	u32 ulp_status;
    - 	u32 ulp_word4;
     +	bool release_node = false;
      
      	/* we pass cmdiocb to state machine which needs rspiocb as well */
    @@ drivers/scsi/lpfc/lpfc_els.c: lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct l
      		/* Good status, call state machine.  However, if another
      		 * PRLI is outstanding, don't call the state machine
     @@ drivers/scsi/lpfc/lpfc_els.c: lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
    + 	IOCB_t *irsp;
      	struct lpfc_nodelist *ndlp;
      	int  disc;
    - 	u32 ulp_status, ulp_word4, tmo;
     +	bool release_node = false;
      
      	/* we pass cmdiocb to state machine which needs rspiocb as well */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

