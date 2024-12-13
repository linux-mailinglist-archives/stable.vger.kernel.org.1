Return-Path: <stable+bounces-104116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1BD9F108D
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99FD163E04
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8BD1E1A33;
	Fri, 13 Dec 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LogcwFJu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033231E1020
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102797; cv=none; b=bL6uH55tO6YIMccpU1f187vcCWM+de8SU7ZAWT/cakoKOHpZ+4hcKUd+2XBoKOU3IfEsQaSbMuV3UPozPQLfKl+Z0UTY2NHeFiRj7UOvezA4PHmMQQeuo/nC7MKwrRkgC9BtJNWfOJdhsDIt0kgTxLDHVeIljuO8wXtZbMQJgf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102797; c=relaxed/simple;
	bh=hP4pFE4jfcdOUzvFhaGNi7Yr0jjBWgzVLNs0iGPfa78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEM4dc+RC/jtRB25g39IZDds3obvt8lQJ6tv4MKx2HyV2ZPnDBLV0k68xjp/ApbNk1KrBZ7Oxp/OIbL18xZXx/XBuNbwRBXLqY1iOZdURA6tQLyf7u3cuus4yilldl44AHy6cx8JLD5oWTkn7LShU5A1O2Yu2VVQo8Ponq5bdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LogcwFJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D9FC4CED0;
	Fri, 13 Dec 2024 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102796;
	bh=hP4pFE4jfcdOUzvFhaGNi7Yr0jjBWgzVLNs0iGPfa78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LogcwFJuOrYEBOaQsTeGWNs56etEnkWALNJpTetAQdvdI2CatJ0Ya4DCeaOnSiENx
	 uydfPrZhPKomk0mhnS3MJisNbyLm5wGEeFzpx5KL+gG5NArEienR9UeKXisvpkE+m1
	 M5ycvTd1rSOGoAz8BmlYBroX3ddhXe6986/yrmkSTPx/CE0yTVh6IPfnv4EixBdqQC
	 ZqcggOo3kMJZr2DArwwVH+t++glNwXyOSO/LRGiDQsf3XWuujrKBdxCCfH47lx7ISr
	 mpzcU5v20pR3Qji1doclSUdcQPIb5qft806nJqcZnALE2YdZcvHFl+mNpSL5RGRAzo
	 CwLx3obrVnyuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V3][5.15.y] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Fri, 13 Dec 2024 10:13:14 -0500
Message-ID: <20241213101214-9e56d22f5b0ce85f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213081415.3363559-1-guocai.he.cn@windriver.com>
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
1:  78cfd17142ef7 ! 1:  bffeab8b4e293 bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
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

