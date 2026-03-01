Return-Path: <stable+bounces-222423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEAVJnPho2lYRAUAu9opvQ
	(envelope-from <stable+bounces-222423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:49:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 012FE1CEAF9
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE54D30185B9
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C153C3161BA;
	Sun,  1 Mar 2026 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtfcCxEc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414123D7CF
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347758; cv=none; b=JQr4pnJ4mugNOhv5QnPE9T1BZq8j3cS4z8A9DKiQuaxXnDBnlwm9vZoY5I6p46Dd7mnSkEhb5XDJC1jW7hrlVbZo0kQlJ5Xvi6Pn9MuJSYwxvWDUWD1gHztI+uyauVJRHvqjcOzG0porfmXCe9+bcGCeqX2hly0QTSroJk7xIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347758; c=relaxed/simple;
	bh=xPvs5GerX7U1TS3JHlMdvormyYoyyl11VTFg/9+mW5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImgqTLBSIApTxWC0dPjfFmVFLa8MYR5gmUh9DOOG3KVfG4zNR/4UFFTf4XyZh+CLzdnIaZysDH9tqbzLyPIUbyPqjFc83PYi7/dcdJEy2EL2+SbWwwXjYDBGDlGvBEK0LgciNZqC0ZKUYMsKu0A2LbVBx6sCdCJVuJ+21+nad/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtfcCxEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5B4C2BC87
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772347758;
	bh=xPvs5GerX7U1TS3JHlMdvormyYoyyl11VTFg/9+mW5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OtfcCxEcG8pbt6HI7nANxn4aAzhyxk9xZh1uwt5VXskY/IC/LCOSuRqVBkMzk8cf2
	 5LojD2xKfDPBnRcavsQtPRFtxnKcijRw0IkE6+iQzTvkZt0gptJxh5zVRmdRhyewNO
	 oxU3KWr1ik6BlhTxYVjJI+p8e4gFuAsjnrP+Qx0Js/3nJOrFz0pkJeBHGY/Efb286j
	 2JyMh2av0AeD2sKelA7tiI2TNOE/O9Lqj81Vg1j9lJBa0SpiNz/CkF33O5Y0qGk9KC
	 DIP3QmpjOISh8aYAIheid4G0XFOIvRUoe5otgkiC5ROip71+bov0vYRRqbeJyVhKpD
	 mYEFRW0CI28BA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c5a7785b4so5046830a12.1
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:49:18 -0800 (PST)
X-Gm-Message-State: AOJu0YwfsHg1pC/ustnbvcR9vBn2Ntw07g6nM2n53sQQJXK2bfpv54wC
	tBEPeOMgOG0HhT1tgZRx0P3DkU/r5AY+sRSsPOy/RAqp/UwsieXivE8CdBWvf4z/teh33D+hN1A
	RXavoWv/f3Vdx3xCSsxsrG6WRLwHRdFg=
X-Received: by 2002:a05:6402:3508:b0:658:cb40:6701 with SMTP id
 4fb4d7f45d1cf-65fdd6bdb3amr4924372a12.7.1772347756791; Sat, 28 Feb 2026
 22:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301014656.1710036-1-sashal@kernel.org>
In-Reply-To: <20260301014656.1710036-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:49:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4HODcY4gwjTd7GJtSuOCyGnNfWbhQ4TYXiEVLyx37seg@mail.gmail.com>
X-Gm-Features: AaiRm53LsORNy_ujK6ToSvQlnWPZtzY4mKGAwctzX8HvFN8c1trS_zRecrt55SM
Message-ID: <CAAhV-H4HODcY4gwjTd7GJtSuOCyGnNfWbhQ4TYXiEVLyx37seg@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Disable instrumentation for
 setup_ptwalker()" failed to apply to 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, yangtiezhu@loongson.cn, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222423-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 012FE1CEAF9
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:46=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I'm very confused because it can be applied and already here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.1

Huacai
>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From 7cb37af61f09c9cfd90c43c9275307c16320cbf2 Mon Sep 17 00:00:00 2001
> From: Tiezhu Yang <yangtiezhu@loongson.cn>
> Date: Tue, 10 Feb 2026 19:31:17 +0800
> Subject: [PATCH] LoongArch: Disable instrumentation for setup_ptwalker()
>
> According to Documentation/dev-tools/kasan.rst, software KASAN modes use
> compiler instrumentation to insert validity checks. Such instrumentation
> might be incompatible with some parts of the kernel, and therefore needs
> to be disabled, just use the attribute __no_sanitize_address to disable
> instrumentation for the low level function setup_ptwalker().
>
> Otherwise bringing up the secondary CPUs failed when CONFIG_KASAN is set
> (especially when PTW is enabled), here are the call chains:
>
>     smpboot_entry()
>       start_secondary()
>         cpu_probe()
>           per_cpu_trap_init()
>             tlb_init()
>               setup_tlb_handler()
>                 setup_ptwalker()
>
> The reason is the PGD registers are configured in setup_ptwalker(), but
> KASAN instrumentation may cause TLB exceptions before that.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/mm/tlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index 4014c44695878..aaf7d685cc2aa 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -202,7 +202,7 @@ void __update_tlb(struct vm_area_struct *vma, unsigne=
d long address, pte_t *ptep
>         local_irq_restore(flags);
>  }
>
> -static void setup_ptwalker(void)
> +static void __no_sanitize_address setup_ptwalker(void)
>  {
>         unsigned long pwctl0, pwctl1;
>         unsigned long pgd_i =3D 0, pgd_w =3D 0;
> --
> 2.51.0
>
>
>
>
>

