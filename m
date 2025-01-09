Return-Path: <stable+bounces-108132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3F7A07D28
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 17:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2066A18806B2
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0A21764D;
	Thu,  9 Jan 2025 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhesjzDL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5477FD;
	Thu,  9 Jan 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439382; cv=none; b=f9+Zw21XYL20ZqzuVKP4TvOCVB7YvP7kZXMnTLv6SHzn1mxzUBKFScvTSSebdggb4C200yCl5aHb/IyVKmERCUf/UEtMo8DYi0mTfQZ11gHLGQ5+0lsk++gehAra4CD0sh/prvw0INE7f0kpqXAZ9uq61jRpgihFnWESLDsCjq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439382; c=relaxed/simple;
	bh=JbWDKBRIac68JZfYCDScQslJZun2nbBr1DkEqLzKpJg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BANXNYh5GejMy+6tz1HVWN1lRVVMN8lloiVccbIsoU9FXy/7+dIhcy7hCemz5SXGoZ8NX0wiwHNNYDV+b1o6zHzlz+mLxiOAR4zov0neqJJZ83QGtP6Dik+j4RHWLSp3rxrHbydwutY1lMFgv+b5hRweN9wRa4PpPNsp5hypxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhesjzDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F633C4CED3;
	Thu,  9 Jan 2025 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439381;
	bh=JbWDKBRIac68JZfYCDScQslJZun2nbBr1DkEqLzKpJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YhesjzDLLGGN+NIcaSK+Ufh5ObnT5njRu4WalUn+Cb0hxWW6gQJZ2V4Vu5nMoKK2r
	 Avu9vOG73Tp0tW7/FdWGAQGeYd9vXomL8ZDF7KyplnitpqBBYigydMHKror6zblh5H
	 upUJoVkJcg+fgD57F9gJJF6X9SvPfCKmNTgQBK9jU1cE0MHd00bcaQQuIn1Ma9jRoy
	 IpyMAXssL7ZfZIhrBPt8yW6H+GHzC5MozGSSJkEUstULPBsHAr5V8cs220WrJ+hgW6
	 9T6RXoNf2rO9Yo0S4jyqMfM6Hx0kdoo4w01Zie17qIR2F+8uULIxhf6UQM5u87vvUo
	 9GBr5sRRcJuow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71433380A97D;
	Thu,  9 Jan 2025 16:16:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix sleeping in invalid context in die()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173643940326.1375203.17540794932675045582.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:16:43 +0000
References: <20241118091333.1185288-1-namcao@linutronix.de>
In-Reply-To: <20241118091333.1185288-1-namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, bjorn@rivosinc.com,
 schwab@suse.de, songshuaishuai@tinylab.org, coelacanthushex@gmail.com,
 bigeasy@linutronix.de, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 18 Nov 2024 10:13:33 +0100 you wrote:
> die() can be called in exception handler, and therefore cannot sleep.
> However, die() takes spinlock_t which can sleep with PREEMPT_RT enabled.
> That causes the following warning:
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 285, name: mutex
> preempt_count: 110001, expected: 0
> RCU nest depth: 0, expected: 0
> CPU: 0 UID: 0 PID: 285 Comm: mutex Not tainted 6.12.0-rc7-00022-ge19049cf7d56-dirty #234
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
>     dump_backtrace+0x1c/0x24
>     show_stack+0x2c/0x38
>     dump_stack_lvl+0x5a/0x72
>     dump_stack+0x14/0x1c
>     __might_resched+0x130/0x13a
>     rt_spin_lock+0x2a/0x5c
>     die+0x24/0x112
>     do_trap_insn_illegal+0xa0/0xea
>     _new_vmalloc_restore_context_a0+0xcc/0xd8
> Oops - illegal instruction [#1]
> 
> [...]

Here is the summary with links:
  - riscv: Fix sleeping in invalid context in die()
    https://git.kernel.org/riscv/c/6a97f4118ac0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



