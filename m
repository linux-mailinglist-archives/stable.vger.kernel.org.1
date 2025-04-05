Return-Path: <stable+bounces-128393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E89A7C901
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1F33BC085
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3381C28E;
	Sat,  5 Apr 2025 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK9Qf4eJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08178F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854280; cv=none; b=B6LjSE7dSu8HWNGLIIbhu+hpI47BGZrV/N2Ktl3c7FFTU3Ujg+UL4l/AVkBm6aIqqVTXTSYqtd0trcLU/TOkSsq1BDNj4CON+9tBFVERP9KBLBBd9yiQJCc7bC2KBSd+VeZErCQIUxaB6jZpt1dMW/2zKRJvWe6c7X5EIRc2kew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854280; c=relaxed/simple;
	bh=unnLvLujLDO3AdQdHowNjKzI/dl45yq73jsh5yYpEiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrPDRDC2yZfLuPbiqEPv6b8s+Vhr9jDYQhhFIFilJjbtdvhsV5nPH79LD9qmJqWTPCZUXLUbCMPkswdSlFy69Qn8nC7a/58lXNFVyiQM64mPDcwQ2lb8fmzpKDLEJh4x0Xd0ZDacJ8JNStnMhsAlCGGNnXJgp4/JH/x44t1Mbs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK9Qf4eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7CFC4CEE4;
	Sat,  5 Apr 2025 11:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854280;
	bh=unnLvLujLDO3AdQdHowNjKzI/dl45yq73jsh5yYpEiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KK9Qf4eJ/xmMaoieLESTf5zsRgYQkEHuTpQjrkwMF7/vBO1FXeDmGSTBzc1VdhFjw
	 6jM0yT+CU//v8hKELSEAQZz7orzGcJvSwrA1JHWAJzKiNiF26IVS86zHTzM2D8tRue
	 +UKDkDZyKFBZxo1OIyc0RQ6NNsJp59sflkDpMWVtCVnJCL7dkZr+q6bN6a/2BrCrf8
	 fWx9IpCvbMi7DkDr2vIe+i6FSSPHJD56bLt+nwnf0l374uFQF2OZETKCyAEWt5s3g5
	 +6/MQTwcGK0esiFZfpM3tT6IJ8IfHrvUZFmnXkRlClNROrJxP4HECrbVmDcNa/jA0Q
	 SR3TCwIJOfglg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	broonie@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 01/12] KVM: arm64: Discard any SVE state when entering KVM guests
Date: Sat,  5 Apr 2025 07:57:58 -0400
Message-Id: <20250404235555-f68c8da0b6aa9e05@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-1-cd5c9eb52d49@kernel.org>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 93ae6b01bafee8fa385aa25ee7ebdb40057f6abe

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Found fixes commits:
fbc7e61195e2 KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state

Note: The patch differs from the upstream commit:
---
1:  93ae6b01bafee ! 1:  4f6496e37d54f KVM: arm64: Discard any SVE state when entering KVM guests
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Discard any SVE state when entering KVM guests
     
    +    [ Upstream commit 93ae6b01bafee8fa385aa25ee7ebdb40057f6abe ]
    +
         Since 8383741ab2e773a99 (KVM: arm64: Get rid of host SVE tracking/saving)
         KVM has not tracked the host SVE state, relying on the fact that we
         currently disable SVE whenever we perform a syscall. This may not be true
    @@ Commit message
         Reviewed-by: Marc Zyngier <maz@kernel.org>
         Link: https://lore.kernel.org/r/20221115094640.112848-2-broonie@kernel.org
         Signed-off-by: Will Deacon <will@kernel.org>
    +    [ Mark: trivial backport to v6.1 ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/fpsimd.h ##
     @@ arch/arm64/include/asm/fpsimd.h: extern void fpsimd_signal_preserve_current_state(void);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

