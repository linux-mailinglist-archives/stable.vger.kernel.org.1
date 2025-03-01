Return-Path: <stable+bounces-119999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF89A4A885
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD999189C38F
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872616F858;
	Sat,  1 Mar 2025 04:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdSs/fPo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8052C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802880; cv=none; b=traRYJETqTL+3PILVXR7q5yDdTrHC5PU72mgxV3ZCuEw8/nZDTOz66Jrnhi2wPgCu6Z0BB7tQ0d10lp6q745SnNJr7iSz2iIpCujkKSNb5zUYAdJpE3pUwny8r0eOc9y/Zu5Ie+dOT7n/BD6x2/WeDGQ8QkRGKQdgrL7XR67lys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802880; c=relaxed/simple;
	bh=WR8lueD6bq/qA/qRwGitr+YAvDEtag0jYFABe06VFD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpBjaaPe8GnW2iZ/h77G+wYOut2jgdbD0Swe6oIh4B4g8auYMzZc9oY2aOIad6PFFvdD4S5XO00CodU8Oxv3IE46a51J6LPpP6geSGghX6y3/mnPXZS7gpbo2zBnrTa6e+9n+aic0jVMttiC3WNjSeWz4oOMZoB/8icd5J3g6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdSs/fPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCA6C4CEF3;
	Sat,  1 Mar 2025 04:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802880;
	bh=WR8lueD6bq/qA/qRwGitr+YAvDEtag0jYFABe06VFD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdSs/fPoIoy4+xTlQ5qFunOKh/hjuFMH0feSml2DdQ+PtxYx3wEVIHrMVI53iCzSv
	 98YoNbvi9Q2vhyT8o4/D18tvFmMWr4rwPGRQMR8N+rEBGbLNMChwoXJaApA63NxgLM
	 iOWaasb1rziuGRFnzrRm2QIZt2iE9v6t4GQIFqzwV3s5IPJ+Kx5HZBCLXRyANmTZOF
	 IaZQ/+uNvhwhnAUV8fS8b6ZEGmmUv6gs/Ehz8T5HTbj3a3JXGtDcB+8DbHX0FeHjaU
	 XnLoNUNeelS9HPN8DcCvXNO2JylgrI7+MP0varkzTdPsMHCbkqKH1fqvVndiLVNVzx
	 HbuIFYkbt4wow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jetlan9@163.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
Date: Fri, 28 Feb 2025 23:20:57 -0500
Message-Id: <20250228190050-95ea9581dba954cc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228065056.1232-1-jetlan9@163.com>
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

The upstream commit SHA1 provided is correct: 0e881c0a4b6146b7e856735226208f48251facd8

WARNING: Author mismatch between patch and upstream commit:
Backport author: jetlan9@163.com
Commit author: Tuo Li<islituo@gmail.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  0e881c0a4b614 ! 1:  81de9644dc48c scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
    @@ Metadata
      ## Commit message ##
         scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
     
    +    [ Upstream commit 0e881c0a4b6146b7e856735226208f48251facd8 ]
    +
         The variable phba->fcf.fcf_flag is often protected by the lock
         phba->hbalock() when is accessed. Here is an example in
         lpfc_unregister_fcf_rescan():
    @@ Commit message
         Reviewed-by: Justin Tee <justin.tee@broadcom.com>
         Reviewed-by: Laurence Oberman <loberman@redhat.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Wenshan Lan <jetlan9@163.com>
     
      ## drivers/scsi/lpfc/lpfc_hbadisc.c ##
     @@ drivers/scsi/lpfc/lpfc_hbadisc.c: lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

