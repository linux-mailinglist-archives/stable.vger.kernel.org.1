Return-Path: <stable+bounces-125761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB9A6C16D
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D671B604FD
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F622D7B2;
	Fri, 21 Mar 2025 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAXm/iMW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1401DEFFC
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577950; cv=none; b=WO4AQDNRLmBBhiEGeS+E3THQkVpoK15bewXTFbnqsYFgqGU9XF9d75YKaw4LaHC42fRlY0+kLAgAzIA8+f5Ne8tkQ94JPVOUkttyAf1wY3t+wA0RlwISdQlOgGhjhFiD8kcvyUN7pPwLr108gu8WYncJHa3lwbBYybWwEz0HaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577950; c=relaxed/simple;
	bh=fRZi2OdN5hZx6ICgxtlGLcTjBK7mYG1ule/w4YOljfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvkNgu3uavm4AWYVMBuJVrNm84ofm2paZ2Jfdh8Q85WHZu2V0qNKRvKiP4QxCXN6cuX+LJXAjA6KVFyXejLuRtOtJXSdx4U6isL+mIrBzyxyer/9x4B54+ek67IN3UP33M1eqigozGKyFbgPh2vaTQakkwSjCwIB1sYZP5nAd18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAXm/iMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49995C4CEEA;
	Fri, 21 Mar 2025 17:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577949;
	bh=fRZi2OdN5hZx6ICgxtlGLcTjBK7mYG1ule/w4YOljfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAXm/iMWTcuVX46q9zv6lJcp8PA3laMuBqRBoEW+uW2VqgHjqUY6V70Q9vbCyMH9K
	 OuIB81oARahbRwWMClc/nq5A5Kqsja9H482ocwllLTXiSOyKbJBbpfmOVAqvmnnoPj
	 f522MaJK2oNIAjqc38HNnVQHqBH1R2KEh/H3GangFZqaEa6OEcBP9OM++FaJOZhITY
	 7mofUAJ2xRcBLktls1C4VhSc7a2NNNv1sIyPZ34wAb2X8jJjn6EqUVsYTZJvG9YLfQ
	 6bHi7z8KnDqxcqUAIDRymXIlI09c3lqt7PWiiM5r1LXbzZkk6/IKuFOo+lPN3UHNbL
	 bafvJSCt+oyBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v2 6/8] KVM: arm64: Refactor exit handlers
Date: Fri, 21 Mar 2025 13:25:37 -0400
Message-Id: <20250321111958-2e23752f95b11f0c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-12-v2-6-417ca2278d18@kernel.org>
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

The upstream commit SHA1 provided is correct: 9b66195063c5a145843547b1d692bd189be85287

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 4c68a146aaaa)

Note: The patch differs from the upstream commit:
---
1:  9b66195063c5a ! 1:  33e42968ad9d7 KVM: arm64: Refactor exit handlers
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Refactor exit handlers
     
    +    [ Upstream commit 9b66195063c5a145843547b1d692bd189be85287 ]
    +
         The hyp exit handling logic is largely shared between VHE and nVHE/hVHE,
         with common logic in arch/arm64/kvm/hyp/include/hyp/switch.h. The code
         in the header depends on function definitions provided by
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-7-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kvm/hyp/include/hyp/switch.h ##
     @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

