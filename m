Return-Path: <stable+bounces-135271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F186CA98978
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD1B1B605A8
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BA68632B;
	Wed, 23 Apr 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTtNvw/u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8D1119A
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410617; cv=none; b=INk0FzfGjt85NO/AruRyzFv1gFJ50b8/V4zjW4V8H0gd+mOnNotqcEBP94eWRib1dyjEWFc3F2EQVF4VlzNCsZEJY2xzndZoog0s69naj25YUzMxJqsWVHYpQL97Hks6Of06rgxb+AyeSIGs+nTWLSGi2KAHMueQnXPmk04T0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410617; c=relaxed/simple;
	bh=nIMJzBuMqJsuSyWGMtEVa3qb9omZXNnzCUlO/hzx4Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=map5kM47reVv7uJMojCVt2alyYAJTX+5+qWZKaewhHdjuKvlTKoiqLnucnO2A0CzC9yNtk8VgN6TvpXSt9ijlAjmDDPGlin7JlKMWhvD8SJafVV1njhrWFnZQPNIGnx3+RAYPVUXCbkb3Et1OqF38QfGz58tTtEn1+ibRlvKADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTtNvw/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3ADC4CEE2;
	Wed, 23 Apr 2025 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410616;
	bh=nIMJzBuMqJsuSyWGMtEVa3qb9omZXNnzCUlO/hzx4Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTtNvw/u1qyAXxEZZaAJcFsnbdP7A0JrPIU9PsWvvmJw9AN0tJKwn2OPJjuNGHRQk
	 8jPeT2Vh1JFmqw9tW6ESPdW6Jej4Ye/Z0rtE0ZMXDs/gX7hu2Dwub/SPM2G5qt83k2
	 Vj7PiD3nhdhMkbfnOCP/wiyxcIAK/MwbGPO47QDdkW5PLZtgPN0semwPo5CKF15d2n
	 T7eoIgh0cX5f4UGfHP2j00hCyzG2Mlmo+cMZg/7+45L3+ePyw8bIlA/5haN4epEjmO
	 XtEqvSW1OAgZNUXlp4bLK1f0Jv5/WHI8sBz0uhFjx7N8x54QIKk1tONqiD1HRwUAZD
	 Dg77qw66h7D3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shung-hsi.yu@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 4/8] bpf: check changes_pkt_data property for extension programs
Date: Wed, 23 Apr 2025 08:16:55 -0400
Message-Id: <20250423080247-4a3b6a2dd1fa3c82@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423055334.52791-5-shung-hsi.yu@suse.com>
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
ℹ️ This is part 4/8 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 81f6d0530ba031b5f038a091619bf2ff29568852

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Found fixes commits:
ac6542ad9275 bpf: fix null dereference when computing changes_pkt_data of prog w/o subprogs

Note: The patch differs from the upstream commit:
---
1:  81f6d0530ba03 ! 1:  55bebf976e68c bpf: check changes_pkt_data property for extension programs
    @@ Metadata
      ## Commit message ##
         bpf: check changes_pkt_data property for extension programs
     
    +    commit 81f6d0530ba031b5f038a091619bf2ff29568852 upstream.
    +
         When processing calls to global sub-programs, verifier decides whether
         to invalidate all packet pointers in current state depending on the
         changes_pkt_data property of the global sub-program.
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241210041100.1898468-6-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    [ shung-hsi.yu: both jits_use_priv_stack and priv_stack_requested fields are
    +    missing from context because "bpf: Support private stack for bpf progs" series
    +    is not present.]
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: struct bpf_prog_aux {
    + 	bool exception_cb;
    + 	bool exception_boundary;
      	bool is_extended; /* true if extended by freplace program */
    - 	bool jits_use_priv_stack;
    - 	bool priv_stack_requested;
     +	bool changes_pkt_data;
      	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
      	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

