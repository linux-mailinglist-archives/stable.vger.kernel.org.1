Return-Path: <stable+bounces-103904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E219EFA1A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422AF292AA0
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF28B1C5F07;
	Thu, 12 Dec 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC5PqS+x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826CA205517
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026255; cv=none; b=AFti3lG4FFKiPhazB36pzWQV2g7nkd6IjFJvIm2sYSSAPXoP/xLZ1GUH9EKQuec60ParqrH9Y6vX43f9Q36dxlkRH4dl3vEpsTndXXhgOKcvRw+vZMcPNX+xfZDbsfCC0kyAat1eRH+MivzoBbccw9aAOZ6EP2a2R4BaJznUb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026255; c=relaxed/simple;
	bh=0v9REYSoKMJwCd/hxhO/52mHhTSyHGlxIkJEz4FLyQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwZM6u4D4joWv49ZtB4em+77jRbB9LAfvsyBGYs3b4YRCRRJvqtgH+FikdKNAnFEMgHE0AgFH+j3hjJ8wMxQrBxfQxE5Y2KuABquE/WauI4kCRmiZGymLlLGDnczJMIz21J3US4WlaYLIVpEkuSnaSQLeoNGmqid7ApjLjd1qiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vC5PqS+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD4FC4CED0;
	Thu, 12 Dec 2024 17:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026255;
	bh=0v9REYSoKMJwCd/hxhO/52mHhTSyHGlxIkJEz4FLyQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vC5PqS+xpo7SuTudZFLAvS7/z5mwaXSrPdDX/at5/i3qziIvlZyppt8mlm/GLygOI
	 BZIoHGWhIRBNEzf7yTrHr+wJbI5V0fKViHg0lhtm1yVytziPLBAyRrB/TeXfSeiqKg
	 rx/larzNSagXTOdvaeG3tx5OtAPX+sB4d3a/GYp/7EQ/yLDwm+JYfsGmBOUtF5l6pX
	 J/UgIZvoSuBWWWCK7dC9LnMul5pel8EWYtvb98zBiev79gQgaOYWUZv8Co1XnZ0wZM
	 Yx43FxTVitDLRBsXL1yPhFeJ/s67qCaG0zlleVwxGiIm31eWjxfpw1z9RYYwpBe1zl
	 HzlZOw/A+JtQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2][5.15.y] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Thu, 12 Dec 2024 12:57:33 -0500
Message-ID: <20241212070709-c310fc7b4dc789cb@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241212022121.618415-1-guocai.he.cn@windriver.com>
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
1:  78cfd17142ef7 ! 1:  51e93e317df96 bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
    @@ Metadata
      ## Commit message ##
         bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
     
    +    V2: Corrected the upstream commit id.
    +
    +    commit 78cfd17142ef70599d6409cbd709d94b3da58659 upstream.
    +
         Undefined behavior is triggered when bnxt_qplib_alloc_init_hwq is called
         with hwq_attr->aux_depth != 0 and hwq_attr->aux_stride == 0.
         In that case, "roundup_pow_of_two(hwq_attr->aux_stride)" gets called.
    @@ Commit message
         Link: https://lore.kernel.org/r/20240507103929.30003-1-mschmidt@redhat.com
         Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
         Signed-off-by: Leon Romanovsky <leon@kernel.org>
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

