Return-Path: <stable+bounces-103899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB09EFA2D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F38168EA7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD46721660B;
	Thu, 12 Dec 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az1Z3JzG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89877208984
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026244; cv=none; b=DRGU5ELS5VUEllkBIPpkzXhe6VHpSOU9hnOYVJ4IqBQPmqAEeaxZ3D46Vzz37/l6j9aucmgn0tfoZiew7vm6ybdhAT1KvjLMNKUPwA5t6tcYB67MXY0OtV3mF8OQF6eYiJecNj9U29pxD96bAU3AcU7MqHQ90GvoJNuz3y4LZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026244; c=relaxed/simple;
	bh=CqdOg3aCzHiW5iFg4hpJDfgxP2o9D9wZ4UUbg3RvuOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deAQLUAG7c9Uxgvxqxu6IzG/lGGyObPAWElezhzyjQPjVj1gAy1gl5ixDc6aoeOSBhOvOpEDKlkK7FohkonfAy3Mvb2TT5k5EKxtWHVtseB8PJI9ffuTam60Wcs4BjyRxFI+9MRMxldIDL3n3u/hMvPxW0jFEyDP04fby76xRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az1Z3JzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96142C4CECE;
	Thu, 12 Dec 2024 17:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026244;
	bh=CqdOg3aCzHiW5iFg4hpJDfgxP2o9D9wZ4UUbg3RvuOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Az1Z3JzGxZfZx9kjmiloAHZ3hLgisezSqZcouaOfBABWIbKcCPorxxOp4ReFIaQa4
	 gvqNtX/RueDQ7dtGgx0pc16J7MPsVMt1CB8cjwgWYrdDk8kwxivHXJiOTNhXrI6gwD
	 5JFSK28YB+t5bcDFKJjdyXxwFXUBceQcYb6vX2a7n+W3+x0CxxjuSYC2jCeVs00jw4
	 JYcagiewe1ea0+LGlpOzes4VIvQKAkniOlWyaT2Mbxd1e7L5SsQQSjdqlN0AB99ndC
	 7PPBhMJ2q/qWf6o6kE/wDxXhEWpeIrta+zDAdaEQAfPTgnw7Z/DaPDQRRTRyU9C8F4
	 Xk01Ljbz9GNfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2][5.15.y] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Thu, 12 Dec 2024 12:57:22 -0500
Message-ID: <20241212065112-60528060b35eff48@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241212064846.1079097-1-guocai.he.cn@windriver.com>
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
1:  78cfd17142ef7 ! 1:  b6bf18a2edb26 bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
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

