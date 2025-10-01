Return-Path: <stable+bounces-182986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E720ABB1657
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 19:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE3F189208A
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 17:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7094D255F5E;
	Wed,  1 Oct 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvanals.org header.i=@kvanals.org header.b="Zs3VeK4e";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="szcpz0Bd"
X-Original-To: stable@vger.kernel.org
Received: from a48-94.smtp-out.amazonses.com (a48-94.smtp-out.amazonses.com [54.240.48.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2D34BA32
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340882; cv=none; b=BEzjtsGjV2ZEXdfpspYWJyjKo3QuWu9OkXMgvCPG4yJfe2T2giN31ZmpcVOiSIObbxKxQDZdpu1bkqDsRFhqtHi4hkg/gNJdqEozoevL70dQNPiHp6VVtc4YfIaOwylGwhsCbeqnW7icCBaMMLqISWKnqzCrHhiok2iOBZl1tDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340882; c=relaxed/simple;
	bh=aBM58zz7LIm5qVT9yhJTwKXLHuaEoiEGSu/GD9elgxw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-ID:References:To; b=n3p3nPSVQLMs4KgbShvBaXVOl3KdjoEpgKdjiRYEIwxM2bZQULmgzhnXNgHc2pQbkOkzIOu0NeuonkliJuV4CMaH1K5do2MIRnQgZXGP4R2rhKlxHKDDqHZPe/toV/TQvj+cOmDkuGA2Zd6rA08e+hgS0NjF6Um39yYuRBenUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kvanals.org; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=kvanals.org header.i=@kvanals.org header.b=Zs3VeK4e; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=szcpz0Bd; arc=none smtp.client-ip=54.240.48.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kvanals.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=xojwidlurxakxokupknu2uvuxvz4uggf; d=kvanals.org; t=1759340878;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:To;
	bh=aBM58zz7LIm5qVT9yhJTwKXLHuaEoiEGSu/GD9elgxw=;
	b=Zs3VeK4eH7akdmeuFEMA6S80Ogqod0D5imEX76WD0mOXSiVydr4ho2/9KPZeadpW
	Qliu6eql10u1xgQiOTeMgQliu+ZpkMgFGEMRFQC9QBbSJ/+dHd7E21TXSbCXLz6ko6l
	jv05ErBjtAl0q+I+5VcR3zhIKI5SyV84ajL5xORkt9IKQrrVvjGtVoHvYHnLEkmCd43
	nxakYPGbU+oTZXdjMQBFK6FfvarRDFMV4B4EdnMigdWG0xUwTJDhoVOE6cPO0K1x9A2
	0ScZfqGLQtZEVZo9g0sfJ/UBOZYZmPXVMvDMVKOZOff1aD9Gvx42tZrRvq5fP6Zp+v8
	HzEwjfE0OA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1759340878;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:To:Feedback-ID;
	bh=aBM58zz7LIm5qVT9yhJTwKXLHuaEoiEGSu/GD9elgxw=;
	b=szcpz0Bd//xaJWMRd0OlMMdk2Z0zmSKxEOdaBGcymQWFOy0fK4pyXT6agRQrTeMq
	PsE9lQzxgoiJevp5y7E19lJXNM3+X16tMf1y61K9KfM1mp5CEkblfLEPZAddwxIp13g
	Acq/wDj0AkzQHgqAYRk1UI5lXB9+49Bqg1z7Exa0=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: KVM: arm64: Regression in at least linux-6.1.y tree with recent
 FPSIMD/SVE/SME fix
From: Kenneth Van Alstyne <kvanals@kvanals.org>
In-Reply-To: <aNz1PnARMC4DPeYb@willie-the-truck>
Date: Wed, 1 Oct 2025 17:47:58 +0000
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	catalin.marinas@arm.com, ardb@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, maz@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-ID: <01000199a0e35b65-1c5cae69-ae59-43ad-b6ac-491cc43f5ca5-000000@email.amazonses.com>
References: <010001999bae0958-4d80d25d-8dda-4006-a6b9-798f3e774f6c-000000@email.amazonses.com>
 <aNz1PnARMC4DPeYb@willie-the-truck>
To: Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (olympus.kvanals.org [IPv6:2600:1f18:42d5:300:0:0:0:ffff]); Wed, 01 Oct 2025 17:47:58 +0000 (UTC)
Feedback-ID: ::1.us-east-1.5jHMwTu/Jzmoolk7Ak3w+RKcSxXCCShHRX8XGxXgrSs=:AmazonSES
X-SES-Outgoing: 2025.10.01-54.240.48.94

Hi Will, thanks for the prompt reply and thorough explanation!

On the 6.1 branch, those functions have additional logic around realtime =
kernels, like so:

static void get_cpu_fpsimd_context(void)
{
        if (!IS_ENABLED(CONFIG_PREEMPT_RT))
                local_bh_disable();
        else
                preempt_disable();
        __get_cpu_fpsimd_context();
}

...

static void put_cpu_fpsimd_context(void)
{
        __put_cpu_fpsimd_context();
        if (!IS_ENABLED(CONFIG_PREEMPT_RT))
                local_bh_enable();
        else
                preempt_enable();
}


Honestly, we don't even set CONFIG_PREEMPT_RT for our ARM64 kernels, but =
in the interest of being complete, should we also not call =
preempt_enable/disable if (!irqs_disabled()) ?

I'm assuming this will get queued up for a fix in the stable branches =
soon in any case.

Thanks,

--
Kenneth Van Alstyne, Jr.
(228) 547-8045

> On Oct 1, 2025, at 05:32, Will Deacon <will@kernel.org> wrote:
>=20
> Hi Kenneth,
>=20
> Thanks for the report.
>=20
> On Tue, Sep 30, 2025 at 05:31:38PM +0000, Kenneth Van Alstyne wrote:
>> Sending via plain text email -- apologies if you receive this twice.
>>=20
>> If this isn't the process for reporting a regression in a LTS kernel =
per
>> =
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html,
>> I'm happy to follow another process.
>>=20
>> Kernel 6.1.149 introduced a regression, at least on our ARM Cortex
>> A57-based platforms, via commit =
8f4dc4e54eed4bebb18390305eb1f721c00457e1
>> in arch/arm64/kernel/fpsimd.c where booting KVM VMs eventually leads =
to a
>> spinlock recursion BUG and crash of the box.
>>=20
>> Reverting that commit via the below reverts to the old (working) =
behavior:
>>=20
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 837d1937300a57..bc42163a7fd1f0 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -1851,10 +1851,10 @@ void fpsimd_save_and_flush_cpu_state(void)
>>  if (!system_supports_fpsimd())
>>  return;
>>  WARN_ON(preemptible());
>> - get_cpu_fpsimd_context();
>> + __get_cpu_fpsimd_context();
>>  fpsimd_save();
>>  fpsimd_flush_cpu_state();
>> - put_cpu_fpsimd_context();
>> + __put_cpu_fpsimd_context();
>> }
>>  #ifdef CONFIG_KERNEL_MODE_NEON
>=20
> Hmm, the problem with doing that is it will reintroduce the bug that
> 8f4dc4e54eed ("KVM: arm64: Fix kernel BUG() due to bad backport of
> FPSIMD/SVE/SME fix") was trying to fix (see the backtrace in the =
commit
> message). So the old behaviour is still broken, just in a slightly
> different way.
>=20
>> It's not entirely clear to me if this is specific to our firmware,
>> specific to ARM Cortex A57, or more systemic as we lack sufficiently
>> differentiated hardware to know.  I've tested on the latest 6.1 =
kernel in
>> addition to the one in the log below and have also tested a number of
>> firmware versions available for these boxes.
>>=20
>> Steps to reproduce:
>>=20
>> Boot VM in qemu-system-aarch64 with "-accel kvm" and "-cpu host" =
flags set -- no other arguments seem to matter
>> Generate CPU load in VM
>>=20
>> Kernel log:
>>=20
>> [sjc1] root@si-compute-kvm-e0fff70016b4:/# [  805.905413] BUG: =
spinlock recursion on CPU#7, CPU 3/KVM/57616
>> [  805.905452]  lock: 0xffff3045ef850240, .magic: dead4ead, .owner: =
CPU 3/KVM/57616, .owner_cpu: 7
>> [  805.905477] CPU: 7 PID: 57616 Comm: CPU 3/KVM Tainted: G           =
O       6.1.152 #1
>> [  805.905495] Hardware name: SoftIron SoftIron Platform =
Mainboard/SoftIron Platform Mainboard, BIOS 1.31 May 11 2023
>> [  805.905516] Call trace:
>> [  805.905524]  dump_backtrace+0xe4/0x110
>> [  805.905538]  show_stack+0x20/0x30
>> [  805.905548]  dump_stack_lvl+0x6c/0x88
>> [  805.905561]  dump_stack+0x18/0x34
>> [  805.905571]  spin_dump+0x98/0xac
>> [  805.905583]  do_raw_spin_lock+0x70/0x128
>> [  805.905596]  _raw_spin_lock+0x18/0x28
>> [  805.905607]  raw_spin_rq_lock_nested+0x18/0x28
>> [  805.905620]  update_blocked_averages+0x70/0x550
>> [  805.905634]  run_rebalance_domains+0x50/0x70
>> [  805.905645]  handle_softirqs+0x198/0x328
>> [  805.905659]  __do_softirq+0x1c/0x28
>> [  805.905669]  ____do_softirq+0x18/0x28
>> [  805.905680]  call_on_irq_stack+0x30/0x48
>> [  805.905691]  do_softirq_own_stack+0x24/0x30
>> [  805.905703]  do_softirq+0x74/0x90
>> [  805.905714]  __local_bh_enable_ip+0x64/0x80
>=20
> Argh, this is because we can't simply mask/unmask softirqs and so when
> they get re-enabled we process anything pending. I _think_ irqs are
> disabled at this point, so perhaps we should only bother with
> disabling/enabling softirqs if hardirqs are enabled, a bit like the =
hack
> Ard had in:
>=20
> =
https://lore.kernel.org/all/20250924152651.3328941-13-ardb+git@google.com/=

>=20
> Hacky diff at the end.
>=20
>> [  805.905727]  fpsimd_save_and_flush_cpu_state+0x5c/0x68
>> [  805.905740]  kvm_arch_vcpu_put_fp+0x4c/0x88
>> [  805.905752]  kvm_arch_vcpu_put+0x28/0x88
>> [  805.905764]  kvm_sched_out+0x38/0x58
>=20
> (I think we run context_switch() =3D> prepare_task_switch() here, so =
irqs
> are disabled)
>=20
> Will
>=20
> --->8
>=20
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index fc51cdd5aaa7..a79df0804d67 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -184,7 +184,8 @@ static void __get_cpu_fpsimd_context(void)
>  */
> static void get_cpu_fpsimd_context(void)
> {
> -       local_bh_disable();
> +       if (!irqs_disabled())
> +               local_bh_disable();
>        __get_cpu_fpsimd_context();
> }
>=20
> @@ -205,7 +206,8 @@ static void __put_cpu_fpsimd_context(void)
> static void put_cpu_fpsimd_context(void)
> {
>        __put_cpu_fpsimd_context();
> -       local_bh_enable();
> +       if (!irqs_disabled())
> +               local_bh_enable();
> }
>=20
> static bool have_cpu_fpsimd_context(void)


