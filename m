Return-Path: <stable+bounces-132170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26867A84911
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312169C3CCA
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54FF1EB5E1;
	Thu, 10 Apr 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuKXYQkb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A81EA7F1
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300593; cv=none; b=hMvBAAcXgvlZa7pJgOlHbNABm2wYu00FegPwffpZGtEkY/HLF5wE0r7fdDwPXPOkrNFP2NnAi0qiqJYhZ8pO9O3b1VLyyNJWcCGtl6pO7SffoS2rVvRbGK/fhv937yyHZIjx5GoNV1S5a9mRV/GFUWe0s1SKdLMhuSvb43gAZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300593; c=relaxed/simple;
	bh=LwqSw5WujaZB6Fc8MKhNDFUcRAOkjjpJTsySC1NuPZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/STfRdzfglGDsjarytuKutgsmCjEyuvTNth8k2iHDQRdCvvqMSYAZWkga050pwHw3EGRBVeUShMv0sUi3+kq4ucHe1BSjUEIBPRDG+4IXvczZHVqX61NmnjD9zFOvyP3hfUBrrxlycRsHmuCRysA111aKzNf6SePlh6FU+sTPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuKXYQkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1EFC4CEDD;
	Thu, 10 Apr 2025 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300593;
	bh=LwqSw5WujaZB6Fc8MKhNDFUcRAOkjjpJTsySC1NuPZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BuKXYQkbKGhOXLLOf8v7Uml5tRFHXqHIlHCSoI69zoqxclmoiI9L4XP/j41EM5bRY
	 2gENE7zMZ0GNHPjnNWBEHU2+EcN7SP0UjtJr1jHh1moD3XYyv24a8AORExD7qccXX0
	 mrCvdPN4zbZybelPqbH9EzQDOhxxVfNLbGm8sIn1cg78eIloaiyOd1qKg+OvnoiSqq
	 AIG8xtSAiYrAQ8KEWe5i0GkQGqR4Lo8N+Dmkhyvqd7NpFT+GUyiTwblaqyiyexGyg6
	 Orwgtm2eo5qGXfdx/W9yvYklWEJ5VfHy7DaJTLU+U/KtLQe0BCWyWOBBRCyjES8Scl
	 wU0X5nj3ka0yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] drm/i915/gt: Cleanup partial engine discovery failures
Date: Thu, 10 Apr 2025 11:56:31 -0400
Message-Id: <20250409224916-ba8330d1497bcfee@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250409025809.2812082-1-Zhi.Yang@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 78a033433a5ae4fee85511ee075bc9a48312c79e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhi Yang<Zhi.Yang@eng.windriver.com>
Commit author: Chris Wilson<chris.p.wilson@intel.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 5c855bcc7306)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  78a033433a5ae ! 1:  e10201240d55f drm/i915/gt: Cleanup partial engine discovery failures
    @@ Metadata
      ## Commit message ##
         drm/i915/gt: Cleanup partial engine discovery failures
     
    +    commit 78a033433a5ae4fee85511ee075bc9a48312c79e upstream.
    +
         If we abort driver initialisation in the middle of gt/engine discovery,
         some engines will be fully setup and some not. Those incompletely setup
         engines only have 'engine->release == NULL' and so will leak any of the
    @@ Commit message
         Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
         Reviewed-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
         Link: https://patchwork.freedesktop.org/patch/msgid/20220915232654.3283095-2-matthew.d.roper@intel.com
    +    Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/gpu/drm/i915/gt/intel_engine_cs.c ##
     @@ drivers/gpu/drm/i915/gt/intel_engine_cs.c: int intel_engines_init(struct intel_gt *gt)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

