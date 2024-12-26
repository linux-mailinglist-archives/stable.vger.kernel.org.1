Return-Path: <stable+bounces-106114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9413E9FC75B
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5746C7A1337
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0022914;
	Thu, 26 Dec 2024 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKC1gj8l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB4EC5
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176110; cv=none; b=NJs/yuC3zNYhtalINl9R3tvMPRqSVNahuPaR/NZiUef1mv7eTkrAM4Karz5bqLnhwnGDwR0oGyObLGYYcO2KbyIEeogyJLcKsP89PEqLFFgyKYhFhidU6hcHYAQRb+y0B2v+EJ9TxeZ//7fHTLCDWfrsDRmbllLRQ8znM3SYN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176110; c=relaxed/simple;
	bh=DkcH/aEb/UCAnn4bJ4P6SeP0881iqPZObWqrLvlBaMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/+OseIGB3Y69FmGPt4OhIedJcNID01zKcAYNmMwcZRx/XfwSfOJ9UNANpTCaEan+/H6B9TOQ8R/YsFBBlN7xTeOiPJk113NvWMU54XM3456om1HVugj/Lcs/kwnZsBDVcGvHQEZToFYqV67bE2GIF4sm+Onda80zM+d6pWZMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKC1gj8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE5CC4CECD;
	Thu, 26 Dec 2024 01:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176110;
	bh=DkcH/aEb/UCAnn4bJ4P6SeP0881iqPZObWqrLvlBaMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKC1gj8lVCVRlvW4QS3Zb6G2wiaTtDdqZiDoxYLN5Tzuzyh3Y9l6BZeCAxKur31pz
	 gr79fzR9J8/ZRrsXPFdZL/esYFg2CN4q8m1wKzEjS6EIQrtSQ4MFzkm+eJIg19GlBE
	 pSENZR/rVAy1r/P6p/AhJDbk1Eupn/y7NGdX2F21LMiAfng+Enl+4v55W9UhOsxB38
	 d34YGZSZQuYepj+yFALskzVwWjmsdwvme3c6Axh0iPvpqM8ZomSNGgeYi9U0kuSmF+
	 GLnEFr9dWxHUlY4AOD6kiUu+MQIKlUGD7mmFVbBOUq5o9UBPGICR+vEldJ8vqIujAO
	 BwFEW2tdyp6Qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] drm/amdgpu: Handle NULL bo->tbo.resource (again) in amdgpu_vm_bo_update
Date: Wed, 25 Dec 2024 20:21:48 -0500
Message-Id: <20241225180213-872a9f36b5f55e05@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241223153807.1065011-1-michel@daenzer.net>
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

Found matching upstream commit: 85230ee36d88e7a09fb062d43203035659dd10a5

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
Commit author: Michel Dänzer <mdaenzer@redhat.com>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  85230ee36d88 ! 1:  eb8466d83331 drm/amdgpu: Handle NULL bo->tbo.resource (again) in amdgpu_vm_bo_update
    @@ Commit message
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
         (cherry picked from commit 695c2c745e5dff201b75da8a1d237ce403600d04)
         Cc: stable@vger.kernel.org
    +    (cherry picked from commit 85230ee36d88e7a09fb062d43203035659dd10a5)
     
      ## drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c ##
     @@ drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c: int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
      	 * next command submission.
      	 */
    - 	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
    + 	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
     -		uint32_t mem_type = bo->tbo.resource->mem_type;
     -
     -		if (!(bo->preferred_domains &
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

