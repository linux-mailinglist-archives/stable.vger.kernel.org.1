Return-Path: <stable+bounces-143859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F829AB4251
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3C03B736E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743F22BF994;
	Mon, 12 May 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkio7C3f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B82BF988
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073136; cv=none; b=oFN1qupTXgKXc2Jfh3OrvSst33hjtitOxQLSb6pOcV42unhEveSxIeFPWcoCmZ3aTh01rQlVq4if3K3ltkydcuZLJljYnaFWWxKf/HgUd49/boDCxW0+L7sTISxGL/Tj7gEyV8WraUp8YwmRLvVW36BUJPO2BHcbn4b4ScAbVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073136; c=relaxed/simple;
	bh=o+wmvr0aFl9775aaRDdZJTulseJVXhNOz11wiNopgzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtVmQ49m32jWS2qVHkoNMRNqua5kCRnimk9OVbXMczlAnBMB4cQZRXWzvRxuXe4+mwm83MNY13m49HnQ8Pg+7aay+uHfo9YqspfsMFYceU5q1aePdSVggt/GiVzUtEHd2hLr3MkBQAXVVOsfA4IPmQXQpz1hEYG1sYnd+7/qTMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkio7C3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3827AC4CEE9;
	Mon, 12 May 2025 18:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073135;
	bh=o+wmvr0aFl9775aaRDdZJTulseJVXhNOz11wiNopgzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dkio7C3fYdKmw86O9ECDYGZdfhrbT1YW+0TfcE9boRNiTu62aySspouTCuBHs/aQ2
	 AzkHM35Hb0PRQUbx9rmtgyqOiYODR5cHdLJFCgYXSB+MzoQfakQxJX1Vq6V4+CMir1
	 tDKw//lHQW88dxKrY7KkZe9t9AlaD1RdYV/XvnftXXTVfJOUnow8REQeV/x9m0voZc
	 zWl1VQbptSLsOELVV6rsoOc9FIgt9XDtYl7HOmzpJEkV3BwA4awitIf16qAlxeIQaq
	 zZSW1H7XX5CJRpSc3y88Sc/kj8X8Bryv/i+rXRAjip92svzDVEMXZt89kjEPxiZF7f
	 KyfdIcQE0tN0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Zhi.Yang@eng.windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] RDMA/core: Refactor rdma_bind_addr
Date: Mon, 12 May 2025 14:05:31 -0400
Message-Id: <20250511192601-c785336a16cb65ea@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509024447.3959342-1-Zhi.Yang@eng.windriver.com>
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

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 8d037973d48c026224ab285e6a06985ccac6f7bf

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhi Yang<Zhi.Yang@eng.windriver.com>
Commit author: Patrisious Haddad<phaddad@nvidia.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 88067197e97a)

Found fixes commits:
0e15863015d9 RDMA/core: Update CMA destination address on rdma_resolve_addr

Note: The patch differs from the upstream commit:
---
1:  8d037973d48c0 ! 1:  4144b6c866631 RDMA/core: Refactor rdma_bind_addr
    @@ Metadata
      ## Commit message ##
         RDMA/core: Refactor rdma_bind_addr
     
    +    commit 8d037973d48c026224ab285e6a06985ccac6f7bf upstream.
    +
         Refactor rdma_bind_addr function so that it doesn't require that the
         cma destination address be changed before calling it.
     
    @@ Commit message
         Reviewed-by: Mark Zhang <markzhang@nvidia.com>
         Link: https://lore.kernel.org/r/3d0e9a2fd62bc10ba02fed1c7c48a48638952320.1672819273.git.leonro@nvidia.com
         Signed-off-by: Leon Romanovsky <leon@kernel.org>
    +    Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/infiniband/core/cma.c ##
     @@ drivers/infiniband/core/cma.c: static int cma_resolve_ib_addr(struct rdma_id_private *id_priv)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

