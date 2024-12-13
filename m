Return-Path: <stable+bounces-104114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A299F1099
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBFD1883563
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D551E1A28;
	Fri, 13 Dec 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W99tMYAQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859B1E04BF
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102792; cv=none; b=ScENnkeqNgrJMVrTNoUy4tBUZqkxKy9TJjZIikmD61svgS5yyWFOc7mo4DfDslyVmVuGAHSMQ56WhYj2yHVXoWBy7gjbR6r/YnrwyBlp+Da1sL/KzAmvsfTqWMhTJdTUtRhfpzwgPHIWvlI2uPxNZ71pt/gbzwueggkuhpQ1E8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102792; c=relaxed/simple;
	bh=znGfpKv0iHFkaQbZ7dpsfsG4MN38MFyYpexAFtvDXeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcAdIZFlgVcZTJigy5me07wket04+TYAtvjhIYKI8JRlSFFmIob1k760qyvR7hzvmM8ohup9MHH27obMer/t1hoR7IsaP+MhEmXpfjyP2g4i4DT9ZD8D3B7YWZOXJZEPkeoFcpZNZJHitBCr/QZngQYDBDt2tsthDQyYa2jaKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W99tMYAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03F7C4CED0;
	Fri, 13 Dec 2024 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102792;
	bh=znGfpKv0iHFkaQbZ7dpsfsG4MN38MFyYpexAFtvDXeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W99tMYAQDZKZjrSRBxwxTrtFYFjBb8jgqNuh6f3q1k0XA0LAYqettEyFZkAIrFPgr
	 u+WjrFdQ8pXQCNz9JS/q2N9BSKrBt+8eqsa3ARGSHGp3NGzO2fcsnm2uMnQaeolJqH
	 t2C6lcX1I4/B/6eIq7GueKQxePB8e7YoIA+UxEzWqLE1uqDvk7IHIsYr0hupD2jmLO
	 WTwqJF1VXvVxRMSxIB/togi6cVMaBA/ZxxlGXXxek/dGszGbxsATZozTnyFXNurKYY
	 7Ra1yVn5gq5svkVpeShtIjxbLbke4yq8Wk+rKRpV/otCMmIgkVBma3n7RToG47jzXc
	 RmeTMutrFP0og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V3][5.15.y] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Fri, 13 Dec 2024 10:13:10 -0500
Message-ID: <20241213093100-1acefff1b39519c7@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213034620.2897953-1-guocai.he.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 78cfd17142ef70599d6409cbd709d94b3da58659

WARNING: Author mismatch between patch and upstream commit:
Backport author: guocai.he.cn@windriver.com
Commit author: Michal Schmidt <mschmidt@redhat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a658f011d89d)
6.1.y | Present (different SHA1: 84d2f2915218)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  78cfd17142ef7 ! 1:  4272f6c4d467b bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
    @@ Metadata
      ## Commit message ##
         bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
     
    +    commit 78cfd17142ef70599d6409cbd709d94b3da58659 upstream.
    +
         Undefined behavior is triggered when bnxt_qplib_alloc_init_hwq is called
         with hwq_attr->aux_depth != 0 and hwq_attr->aux_stride == 0.
         In that case, "roundup_pow_of_two(hwq_attr->aux_stride)" gets called.
    @@ Commit message
         Link: https://lore.kernel.org/r/20240507103929.30003-1-mschmidt@redhat.com
         Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
         Signed-off-by: Leon Romanovsky <leon@kernel.org>
    +    Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
     
      ## drivers/infiniband/hw/bnxt_re/qplib_fp.c ##
     @@ drivers/infiniband/hw/bnxt_re/qplib_fp.c: int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
    @@ drivers/infiniband/hw/bnxt_re/qplib_fp.c: int bnxt_qplib_create_qp(struct bnxt_q
     -	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
     +	hwq_attr.aux_depth = psn_sz ? bnxt_qplib_set_sq_size(sq, qp->wqe_mode)
     +				    : 0;
    - 	/* Update msn tbl size */
    - 	if (BNXT_RE_HW_RETX(qp->dev_cap_flags) && psn_sz) {
    - 		hwq_attr.aux_depth = roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
    + 	hwq_attr.type = HWQ_TYPE_QUEUE;
    + 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
    + 	if (rc)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

