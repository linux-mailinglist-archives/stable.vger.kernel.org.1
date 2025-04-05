Return-Path: <stable+bounces-128386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450F7A7C8FB
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9367D3BC219
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517A1E1DFB;
	Sat,  5 Apr 2025 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0eWOFE4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313918F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854266; cv=none; b=b1bcsXdXi5/eh6FldpvOkttftzcoszeTTBMePyj6ZFgeqcH5+rC8Y+/DARKLBU5RlrMS72GOkkrUORtytI7Y7rBocLrk8FLw3dBOR2GXUrdt5H+awY2OveAwOGJ6AK8Mii+3eIy45jh5OXaLZQdKcW9iLHnktNp3nlErnZYeWyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854266; c=relaxed/simple;
	bh=7xqen/OgMlRunOlF+gu+YyGJnmXRwSLv35NaJRaupTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s58qjEg4PSMGInQfoKHw5aVvMxoRjmzWs0g6Jzyu4/oXHlJnStzv8XR0ITq0adanJv0zMkxxufP2D205H/zFeT6m6OnqIwhIrTQxFJI7OnLBQE/GpY5t7x5o5pYkK9gVWB542mzOwnJV2i6qQ8o9TPacnKtF7p/991+hmyDuVxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0eWOFE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E9CC4CEE4;
	Sat,  5 Apr 2025 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854266;
	bh=7xqen/OgMlRunOlF+gu+YyGJnmXRwSLv35NaJRaupTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0eWOFE4w5xRz9uCtpjoaR7Dtm+MqDgTo6uMIWNu9zUlNJNSOV8RSXhiARscyRGyq
	 zkTWTIEAhhdML5GizUNaKArWTa3A9r+cxAqYaiOnUqFAYnuQqG8mUNn2n0oaTwBzd/
	 WC+XVpNJLwY9+8n+tLbUXB9JxPD6tUX57RxuGuBxTaRTMz25+w+tOQPTmJX8jGYvMe
	 0OMtn8h+onjJTcNO++LwsxtB0/snhzqQhvUv1sC5XdvEJLYqyvpedMLvMki4lZ2KS8
	 geGghercmYJ9PkWOUayTGa6SmFqewXpmWOd7RaayELSp6IUhGRk0KuoMVEbw7ANuRZ
	 ecbim3WpPW3gQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 02/12] arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE
Date: Sat,  5 Apr 2025 07:57:44 -0400
Message-Id: <20250405004608-f9e6ab16e8295af9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-2-cd5c9eb52d49@kernel.org>
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

The upstream commit SHA1 provided is correct: baa8515281b30861cff3da7db70662d2a25c6440

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  baa8515281b30 ! 1:  dd25288bc37b5 arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE
    @@ Metadata
      ## Commit message ##
         arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE
     
    +    [ Upstream commit baa8515281b30861cff3da7db70662d2a25c6440 ]
    +
         When we save the state for the floating point registers this can be done
         in the form visible through either the FPSIMD V registers or the SVE Z and
         P registers. At present we track which format is currently used based on
    @@ Commit message
         Reviewed-by: Marc Zyngier <maz@kernel.org>
         Link: https://lore.kernel.org/r/20221115094640.112848-3-broonie@kernel.org
         Signed-off-by: Will Deacon <will@kernel.org>
    +    [ Mark: fix conflicts due to earlier backports ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/fpsimd.h ##
     @@ arch/arm64/include/asm/fpsimd.h: extern void fpsimd_kvm_prepare(void);
    @@ arch/arm64/kernel/fpsimd.c: int vec_set_vector_length(struct task_struct *task,
     +		task->thread.fp_type = FP_STATE_FPSIMD;
     +	}
      
    - 	if (system_supports_sme() && type == ARM64_VEC_SME) {
    - 		task->thread.svcr &= ~(SVCR_SM_MASK |
    + 	if (system_supports_sme()) {
    + 		if (type == ARM64_VEC_SME ||
     @@ arch/arm64/kernel/fpsimd.c: static void sve_init_regs(void)
      		fpsimd_bind_task_to_cpu();
      	} else {
      		fpsimd_to_sve(current);
     +		current->thread.fp_type = FP_STATE_SVE;
    + 		fpsimd_flush_task_state(current);
      	}
      }
    - 
     @@ arch/arm64/kernel/fpsimd.c: void fpsimd_flush_thread(void)
      		current->thread.svcr = 0;
      	}
    @@ arch/arm64/kernel/ptrace.c: static int sve_set_common(struct task_struct *target
      	}
      
     @@ arch/arm64/kernel/ptrace.c: static int sve_set_common(struct task_struct *target,
    - 	 */
      	fpsimd_sync_to_sve(target);
    - 	set_tsk_thread_flag(target, TIF_SVE);
    + 	if (type == ARM64_VEC_SVE)
    + 		set_tsk_thread_flag(target, TIF_SVE);
     +	target->thread.fp_type = FP_STATE_SVE;
      
      	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

