Return-Path: <stable+bounces-128389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D962A7C8FE
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1DD18951C8
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07DA1C28E;
	Sat,  5 Apr 2025 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEsVh3nY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9398F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854272; cv=none; b=eRueW410Y86tGJR1tpcODMqgI1mFwgW6UfoOoIBLBNqCpkh1GC7bOKhwBZW/UnF7TLKm+QNf4Aow9A1zVHvKR5Sl8n8J1BY7W7JsM5JJGXaTuWcNK/gWBIGVSBk0NtGIaotDBemzz41Qc91HKHgzaXFkEFBVSrBc1xjnKPgMJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854272; c=relaxed/simple;
	bh=jRJNlbXke/aiNJ7XJCv9SLsgv9gqN4ukCtONxWGj1OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgZn7BAtTivlbanLH8KORG/TlbFOLR0lxgufXED8sRUs106ySE2cvsWo1dSplzzry9lYxG5gBaFbRdElKLJpzfqa11HAYbeFxitpTQsHyr13WEZ/PiDDumqMjFgDEUe2Ddau05DEFbGubZY0Ei8fgM2yN7mS1YNr53J4o/49+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEsVh3nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A62C4CEE4;
	Sat,  5 Apr 2025 11:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854271;
	bh=jRJNlbXke/aiNJ7XJCv9SLsgv9gqN4ukCtONxWGj1OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LEsVh3nY8vVK5TKdwUoEgF/AJbOZzUqg/fHsp0Vvtgk2FTvj9KaZkB8klk4UeiPX8
	 UiseG4j2gCcqBE4WfBNT50Byl1Y4yRvO9Ev0/+rE9n6qeTsBE0ivgYjiPQN1OOclso
	 u0+r6gYKo8Tn5kvOwHsUC8rvBiBv5BVuwvM2w30xmBM8t3Yyu2Vjx8q9h+1g5qftpz
	 m2etsx++gnEddBOIaJ5juGNUwW2t1AXxxn6NvSeYPABNxRjBMxRGZRlm5ZEVazf3zv
	 DeLIW4smG1m+HdYl/X9UyIzrNySTmTduvZ1nzMtTjG2y8T9ChEC/+cAwICvIITT0Xq
	 KfnANinob2g2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 03/12] arm64/fpsimd: Have KVM explicitly say which FP registers to save
Date: Sat,  5 Apr 2025 07:57:50 -0400
Message-Id: <20250405013250-5ba14c7dbe2afbd2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-3-cd5c9eb52d49@kernel.org>
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

The upstream commit SHA1 provided is correct: deeb8f9a80fdae5a62525656d65c7070c28bd3a4

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  deeb8f9a80fda ! 1:  d54de8ee29b5a arm64/fpsimd: Have KVM explicitly say which FP registers to save
    @@ Metadata
      ## Commit message ##
         arm64/fpsimd: Have KVM explicitly say which FP registers to save
     
    +    [ Upstream commit deeb8f9a80fdae5a62525656d65c7070c28bd3a4 ]
    +
         In order to avoid needlessly saving and restoring the guest registers KVM
         relies on the host FPSMID code to save the guest registers when we context
         switch away from the guest. This is done by binding the KVM guest state to
    @@ Commit message
         Reviewed-by: Marc Zyngier <maz@kernel.org>
         Link: https://lore.kernel.org/r/20221115094640.112848-4-broonie@kernel.org
         Signed-off-by: Will Deacon <will@kernel.org>
    +    [ Mark: trivial backport ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/fpsimd.h ##
     @@ arch/arm64/include/asm/fpsimd.h: extern void fpsimd_kvm_prepare(void);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

