Return-Path: <stable+bounces-132781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5440A8AA3A
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B525916B431
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3E825744B;
	Tue, 15 Apr 2025 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGzpSOvQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF5253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753387; cv=none; b=YB31UUR9uUVzp5IhiryR5zGS3LQk7yI5SLWvFgWZhlaAvNSaqDHRA7GQNv4YL+BWKwEUs1sbRM4Vt1D+imItLKl1wpTNRNkM/pEvrQQnE+qyCFYiLnrKdtiGtCrhsRQunLxPz8bd1icfIZdJ5y0HXKX5A3SKFgwcPKlyOZciZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753387; c=relaxed/simple;
	bh=6hmxkXZ2awZpoSQ+cMZ1miTpdcpLMY5L9KKKB0b/UYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUXWiGXIBuRHzXkjSR8NrnrOIFXj3WVmforYNhVGnPEVry3rXYP8sSHGtE29M18T5l7HSw0pyhOvqhk4ivuR2ikBkaAyksL19FpagPXUFqm0xSQ3mCCB6x3fmvZdKvgOLivHtTFwi+3yIbr8ucrkDeAZK9WfBG0EHr+hadDPvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGzpSOvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5045C4CEE7;
	Tue, 15 Apr 2025 21:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753385;
	bh=6hmxkXZ2awZpoSQ+cMZ1miTpdcpLMY5L9KKKB0b/UYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGzpSOvQ1XmVYVzRb5PK2aPSzZtc8+t6HiNjAaeWcONRPIdYelPUosCDCrxrsMDuM
	 J0o2wHw7CHRlELQhHEyrHXd+cJ5bk4gpQ1Al696LMK0vEiFj8VZRUtXuywTCKxEYeJ
	 xJJZ0X0CMs1f2NXIsiVrEHoIlJ3sewZbporlJjqsoZqsJNv0D6x5AMaV/DyLKiXJhT
	 qJBwbCz9lQHlPY/lHJArJ7S3I2r9x9WgL+bXjQ9igkVej54svOH1HovasYFZ6QpZfT
	 wAR3YCw4EmRt1SUwgNFGhTCGzq5+Zddo0cMIUXkJl5J9iP1VjBAoHeXq3NMe3fVebX
	 xA7HrlQz20tOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 2/6] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Tue, 15 Apr 2025 17:43:03 -0400
Message-Id: <20250415123245-3d9742a335725087@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414185023.2165422-3-harshit.m.mogalapalli@oracle.com>
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

The upstream commit SHA1 provided is correct: 78cfd17142ef70599d6409cbd709d94b3da58659

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli<harshit.m.mogalapalli@oracle.com>
Commit author: Michal Schmidt<mschmidt@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a658f011d89d)
6.1.y | Present (different SHA1: 84d2f2915218)

Note: The patch differs from the upstream commit:
---
1:  78cfd17142ef7 ! 1:  2baf62a035300 bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
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
    +    [Harshit: backport to 5.15.y, this is a clean cherrypick from 6.1.y
    +    commit ]
    +    Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
     
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
| stable/linux-6.1.y        |  Success    |  Success   |

