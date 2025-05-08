Return-Path: <stable+bounces-142884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C18AB0017
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DB51BC6626
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516F4280CCE;
	Thu,  8 May 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjAmYx32"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200422422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721074; cv=none; b=T+mWpfXJrmq8zS62BB9kV5MIlEIZIFAOsqTtbbGQI0SZwn7XFgxBZHAPnWpO6Sw3AoPxps9VRDNMl8Qx4ieuFJcJR2ZmoaeKFPmCVpw7hRhKa/hNQlLXI49jrvMiEmXNI2yRgujIGb7uqqEsv684+Jgf6TvkjsWWc1hZPemH/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721074; c=relaxed/simple;
	bh=pfWUCU2y4IW90AR91SqpfEv41y3VmDl/YPURYWtN4vM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emQS2dVbe4/cft+ILP3DGNBbLqJPLhaLtV5wBDVz4c22imfiLa0ujTVmov+WGeYl1GI0uVoav5ec3/lk7mTuQswM/8B4M/myWv0bUt2qi/LU+bGaZJaZyddwKucZnFBKl8IpYje/mRPFRTmE3Xhq6NoLjoPTk3OfiBehUVpvVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjAmYx32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5EAC4CEF1;
	Thu,  8 May 2025 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721072;
	bh=pfWUCU2y4IW90AR91SqpfEv41y3VmDl/YPURYWtN4vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjAmYx32Ixhq8HH+GLFtfmeNpj4rqmAbPjXp2jyFXA7RdPid4bjLbRURffryM6TUw
	 XX6xT6xKHo/t4kQoWUww/7in1HuftMB+3kJROisj1J1TWA/rcTUD9r7qTBh34ys1vR
	 Sh/SUGIlqqueCNRJlE6tpWHsauaYo2XJj3QCEnoUN1jhhXwRZY28oXceovIi8izni2
	 UqjUAhejKtx8fCksppg/OSxmgsHMZUS/15RV/A2/LTtNE/ej8hdq4KKRmJO7d/80ID
	 kA/LQ77U13g4ZaDZKLcKq02CKGx1aQ9TdTAKRdhsYAC61SPodn+iJv7bA2yjCtkQCF
	 BYDDHsr+Ci5lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable v6.6] riscv: Pass patch_text() the length in bytes
Date: Thu,  8 May 2025 12:17:47 -0400
Message-Id: <20250507075823-74ae3d0ba9940f62@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250506201752.1915639-1-namcao@linutronix.de>
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

The upstream commit SHA1 provided is correct: 51781ce8f4486c3738a6c85175b599ad1be71f89

WARNING: Author mismatch between patch and upstream commit:
Backport author: Nam Cao<namcao@linutronix.de>
Commit author: Samuel Holland<samuel.holland@sifive.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  51781ce8f4486 ! 1:  1bc29061a4457 riscv: Pass patch_text() the length in bytes
    @@ Metadata
      ## Commit message ##
         riscv: Pass patch_text() the length in bytes
     
    +    [ Upstream commit 51781ce8f4486c3738a6c85175b599ad1be71f89 ]
    +
         patch_text_nosync() already handles an arbitrary length of code, so this
         removes a superfluous loop and reduces the number of icache flushes.
     
    @@ Commit message
         Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
         Link: https://lore.kernel.org/r/20240327160520.791322-6-samuel.holland@sifive.com
         Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
    +    [apply to v6.6]
    +    Signed-off-by: Nam Cao <namcao@linutronix.de>
     
      ## arch/riscv/include/asm/patch.h ##
     @@
    @@ arch/riscv/kernel/probes/kprobes.c: post_kprobe_handler(struct kprobe *, struct
     +	p->ainsn.api.restore = (unsigned long)p->addr + len;
      
     -	patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
    --	patch_text_nosync(p->ainsn.api.insn + offset, &insn, 1);
    +-	patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
     +	patch_text_nosync(p->ainsn.api.insn, &p->opcode, len);
    -+	patch_text_nosync(p->ainsn.api.insn + len, &insn, GET_INSN_LENGTH(insn));
    ++	patch_text_nosync((void *)p->ainsn.api.insn + len, &insn, GET_INSN_LENGTH(insn));
      }
      
      static void __kprobes arch_prepare_simulate(struct kprobe *p)
    -@@ arch/riscv/kernel/probes/kprobes.c: int __kprobes arch_prepare_kprobe(struct kprobe *p)
    +@@ arch/riscv/kernel/probes/kprobes.c: void *alloc_insn_page(void)
      /* install breakpoint in text */
      void __kprobes arch_arm_kprobe(struct kprobe *p)
      {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

