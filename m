Return-Path: <stable+bounces-182915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C01BAFDEB
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 11:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41293B550E
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4573C2D9485;
	Wed,  1 Oct 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxJWr6HC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32522765EC;
	Wed,  1 Oct 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311173; cv=none; b=bIeh41vxEZhaujkOWUZ5J/hEwgYKeVHOSAFRcZoOUcd7usZdsgU78THSCvhc8FjsPmULs7yrlP0MZcdoK+9O4dYsXd2vIVSLPbB+AcVcJg5KrKbuBsx8pv1osK4K9cH2WW3tY3CjX68bmkumOxtKa1QlcWIZkWBGoUa15fWBebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311173; c=relaxed/simple;
	bh=UJ5Nrj//XI4MYIzbnakq8QPry+1jzsB8A4m7sh8T2gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X95X0eH3+J2TrAM7E3gSXwI/hA08qNNtK2ziMH1A1a5WWpIc4P1RmBxKTTwMrmZWQ6pbI0RTF2JeD9p1Kg7+pBTv54/y7DQMLcfG8Fp3lFOlZVWF0JlcNQe5Qo+4gSjNxFvXgOu6bEFFC01VPpSLfwXP1m8HeH6o6ZJ2KXIw/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxJWr6HC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02C5C4CEF4;
	Wed,  1 Oct 2025 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759311171;
	bh=UJ5Nrj//XI4MYIzbnakq8QPry+1jzsB8A4m7sh8T2gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxJWr6HCADQ9SHytSVb/WM8rkT5Hl/hXX+JyJIO5LalLr0RzMDHRv1dc0VvekL+D1
	 23vRK/27KxUmvCPzn3AO2jUDXVCo5nLygHKcOoHwHLW6cqSHs8CHFaol9FD+0CL6l6
	 fxVhrkzxLSPo8y0CCrlmojDvYL+Rsyge2tm4eLvjdkWCc43WHud7OLkMPhCfAlKTF8
	 Fmq5grfl9oz2tbArCTErEJ/PpqhGTo6bouJ9LQ+2J/zAU63tM/LMgSFiHg29Buf54C
	 wcVqHKEFNywNwzSNLS/LLEgGNl66mspsZZQRag8IrTRKGavS6VfvYF0Jm8Q+5DhL+1
	 OVZQvQPXTM2MQ==
Date: Wed, 1 Oct 2025 10:32:46 +0100
From: Will Deacon <will@kernel.org>
To: Kenneth Van Alstyne <kvanals@kvanals.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	catalin.marinas@arm.com, ardb@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, maz@kernel.org
Subject: Re: KVM: arm64: Regression in at least linux-6.1.y tree with recent
 FPSIMD/SVE/SME fix
Message-ID: <aNz1PnARMC4DPeYb@willie-the-truck>
References: <010001999bae0958-4d80d25d-8dda-4006-a6b9-798f3e774f6c-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001999bae0958-4d80d25d-8dda-4006-a6b9-798f3e774f6c-000000@email.amazonses.com>

Hi Kenneth,

Thanks for the report.

On Tue, Sep 30, 2025 at 05:31:38PM +0000, Kenneth Van Alstyne wrote:
> Sending via plain text email -- apologies if you receive this twice.
> 
> If this isn't the process for reporting a regression in a LTS kernel per
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html,
> I'm happy to follow another process.
> 
> Kernel 6.1.149 introduced a regression, at least on our ARM Cortex
> A57-based platforms, via commit 8f4dc4e54eed4bebb18390305eb1f721c00457e1
> in arch/arm64/kernel/fpsimd.c where booting KVM VMs eventually leads to a
> spinlock recursion BUG and crash of the box.
> 
> Reverting that commit via the below reverts to the old (working) behavior:
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 837d1937300a57..bc42163a7fd1f0 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1851,10 +1851,10 @@ void fpsimd_save_and_flush_cpu_state(void)
>   if (!system_supports_fpsimd())
>   return;
>   WARN_ON(preemptible());
> - get_cpu_fpsimd_context();
> + __get_cpu_fpsimd_context();
>   fpsimd_save();
>   fpsimd_flush_cpu_state();
> - put_cpu_fpsimd_context();
> + __put_cpu_fpsimd_context();
>  }
>   #ifdef CONFIG_KERNEL_MODE_NEON

Hmm, the problem with doing that is it will reintroduce the bug that
8f4dc4e54eed ("KVM: arm64: Fix kernel BUG() due to bad backport of
FPSIMD/SVE/SME fix") was trying to fix (see the backtrace in the commit
message). So the old behaviour is still broken, just in a slightly
different way.

> It's not entirely clear to me if this is specific to our firmware,
> specific to ARM Cortex A57, or more systemic as we lack sufficiently
> differentiated hardware to know.  I've tested on the latest 6.1 kernel in
> addition to the one in the log below and have also tested a number of
> firmware versions available for these boxes.
> 
> Steps to reproduce:
> 
> Boot VM in qemu-system-aarch64 with "-accel kvm" and "-cpu host" flags set -- no other arguments seem to matter
> Generate CPU load in VM
> 
> Kernel log:
> 
> [sjc1] root@si-compute-kvm-e0fff70016b4:/# [  805.905413] BUG: spinlock recursion on CPU#7, CPU 3/KVM/57616
> [  805.905452]  lock: 0xffff3045ef850240, .magic: dead4ead, .owner: CPU 3/KVM/57616, .owner_cpu: 7
> [  805.905477] CPU: 7 PID: 57616 Comm: CPU 3/KVM Tainted: G           O       6.1.152 #1
> [  805.905495] Hardware name: SoftIron SoftIron Platform Mainboard/SoftIron Platform Mainboard, BIOS 1.31 May 11 2023
> [  805.905516] Call trace:
> [  805.905524]  dump_backtrace+0xe4/0x110
> [  805.905538]  show_stack+0x20/0x30
> [  805.905548]  dump_stack_lvl+0x6c/0x88
> [  805.905561]  dump_stack+0x18/0x34
> [  805.905571]  spin_dump+0x98/0xac
> [  805.905583]  do_raw_spin_lock+0x70/0x128
> [  805.905596]  _raw_spin_lock+0x18/0x28
> [  805.905607]  raw_spin_rq_lock_nested+0x18/0x28
> [  805.905620]  update_blocked_averages+0x70/0x550
> [  805.905634]  run_rebalance_domains+0x50/0x70
> [  805.905645]  handle_softirqs+0x198/0x328
> [  805.905659]  __do_softirq+0x1c/0x28
> [  805.905669]  ____do_softirq+0x18/0x28
> [  805.905680]  call_on_irq_stack+0x30/0x48
> [  805.905691]  do_softirq_own_stack+0x24/0x30
> [  805.905703]  do_softirq+0x74/0x90
> [  805.905714]  __local_bh_enable_ip+0x64/0x80

Argh, this is because we can't simply mask/unmask softirqs and so when
they get re-enabled we process anything pending. I _think_ irqs are
disabled at this point, so perhaps we should only bother with
disabling/enabling softirqs if hardirqs are enabled, a bit like the hack
Ard had in:

https://lore.kernel.org/all/20250924152651.3328941-13-ardb+git@google.com/

Hacky diff at the end.

> [  805.905727]  fpsimd_save_and_flush_cpu_state+0x5c/0x68
> [  805.905740]  kvm_arch_vcpu_put_fp+0x4c/0x88
> [  805.905752]  kvm_arch_vcpu_put+0x28/0x88
> [  805.905764]  kvm_sched_out+0x38/0x58

(I think we run context_switch() => prepare_task_switch() here, so irqs
are disabled)

Will

--->8

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index fc51cdd5aaa7..a79df0804d67 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -184,7 +184,8 @@ static void __get_cpu_fpsimd_context(void)
  */
 static void get_cpu_fpsimd_context(void)
 {
-       local_bh_disable();
+       if (!irqs_disabled())
+               local_bh_disable();
        __get_cpu_fpsimd_context();
 }
 
@@ -205,7 +206,8 @@ static void __put_cpu_fpsimd_context(void)
 static void put_cpu_fpsimd_context(void)
 {
        __put_cpu_fpsimd_context();
-       local_bh_enable();
+       if (!irqs_disabled())
+               local_bh_enable();
 }
 
 static bool have_cpu_fpsimd_context(void)


