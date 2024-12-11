Return-Path: <stable+bounces-100661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F412B9ED1EB
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D47B284B37
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1CB1DD871;
	Wed, 11 Dec 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbuz/7EP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6461DDC13
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934766; cv=none; b=uymfOB3ljommU/Be3fal5ITYP/MS4UE3FaxmRktFyK7jrSR3C2IVViccBuO+hPrSms7uNg16iCr2h2VoF49bgQEzX2mjf8e+ijssAnLpNG4GIfbcfUPAfOJN8wYhL49xUqTcZvrqYFzc8IHG1O//LTYsRzz9kuc46/baCVYAXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934766; c=relaxed/simple;
	bh=UTan+9vrbO9IlXRRjjaUNuoz6B19pWUYf5s2dNuf9RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAbJbn+7abYV24xSJD/jjJHTPhGB4d4UhxQAsGVgkxWmrrS0oypIK6Ud9PFvY2sD3iCxXp2p9Po9HYsx8Cmkp39nPlxUxWErhyfuyw8N1MLTWq53DdDGaS0y7gHqmnlYj4HdSL6qczih/ZFiv2g9NPyliFvQAx6+hZSADIPuh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbuz/7EP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064E3C4CED2;
	Wed, 11 Dec 2024 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934765;
	bh=UTan+9vrbO9IlXRRjjaUNuoz6B19pWUYf5s2dNuf9RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nbuz/7EPQ3Fm8mbN6PDYqaxkJGySPemiFHldelnN5afgjojW+p/wGeW1QnQH9w+/o
	 q0UvpwwshITOgx0HqmW8gxp6WFKcBAokfVBYFXUY03UwARIM6Rj3TOznZ1JnNxjvEe
	 qhypgeOrUYeFzvd3Mr4k3HgvgF6TeeHD1xKLZ2sJA6+xkAl0yjfSpHAZDHPmRsKnIN
	 45ryrw+WawHrOBcxjurfkZGz3V5wlQpHNjcoR/z80kujvLBVLsleKnQNUEzNBFUQIO
	 VGqVlhLlXFgAac0MfdBlWGNMiVs1BnqxQqUGfjEa6Ed6Ml/p/QXoLvjBY25bUyn2T7
	 SKSHxZFNEqvHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH][5.15.y] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Wed, 11 Dec 2024 11:32:43 -0500
Message-ID: <20241211095907-be78aa4377689fcc@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211101759.3534900-1-guocai.he.cn@windriver.com>
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

The claimed upstream commit SHA1 (84d2f29152184f0d72ed7c9648c4ee6927df4e59) was not found.
However, I found a matching commit: 78cfd17142ef70599d6409cbd709d94b3da58659

WARNING: Author mismatch between patch and found commit:
Backport author: guocai.he.cn@windriver.com
Commit author: Michal Schmidt <mschmidt@redhat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a658f011d89d)
6.1.y | Present (different SHA1: 84d2f2915218)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  78cfd17142ef7 ! 1:  24ada176cb7fe bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
    @@ Metadata
      ## Commit message ##
         bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
     
    +    commit 84d2f29152184f0d72ed7c9648c4ee6927df4e59 upstream.
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

