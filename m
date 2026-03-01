Return-Path: <stable+bounces-222412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDLpL6Tdo2l5QQUAu9opvQ
	(envelope-from <stable+bounces-222412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:33:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 430751CEA2C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE51E301842C
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0CE1C549F;
	Sun,  1 Mar 2026 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu1z7KcL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCAA30BF72
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772346783; cv=none; b=IRYfE60Q9MwZUWY4ZNcyYOMqAkX5nqbzG49RQ0GamJRYn0l5eS1yRMx3WbViRyZjGbLtokr3s1NHwI25wBwy6YEYqF76h2mTQFRbnnDL+TImZZQRzLCOUhYXiIocnOQgtLwiSWtWJhiOFPWtl/FQ7r8rIsECpOt0oLtCemLNIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772346783; c=relaxed/simple;
	bh=1qw1RuXaslaONg1rnL1B3YeaTAUvwOQSUOC8m2sNsU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slCtltmgnbjMkXPJI/W5kTf6ojuygLaiXZfM/TFOdOPeIwiQIsNajNwhHtJQU6+Cel2m26QjgFdI7gd4ulgVcgiJLlbldCgYp5y0HCveUPXYC20YnRL/IsV0b2CTvkImyMvTt/fJ3JfGqTKEHWx+ypbm2atmOEwvBAFlvEpkw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu1z7KcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6458DC4AF0C
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772346783;
	bh=1qw1RuXaslaONg1rnL1B3YeaTAUvwOQSUOC8m2sNsU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Eu1z7KcLOGhATxuAGmLhQUC9iBqk/tPICTv2Sjv6PDNnLMBr7TjJmsGpJlgCOeRv+
	 7a7et7+S/EL7TyeIWnz/V09xUPCjBWpmAZMFU6knSwfB324g5/XGQNXYCtrI3DR9gK
	 JVsvhV++KXumJ5+LldRs4dvKb9kLkpokj4UVqFWxVIAttudyHGL2lAzcpnXv+i3XDu
	 o6X9KxbMIyLDy59hmOGwhWx4OhQI9JcPBfet8ekNOUUnC4ymnxwmbc3ZeuQgf/dRGQ
	 vuoZ5fGs5t3Pd1tK8GXrFmxVou7TOnyatKJjSK6YJ1cJGPwzYZ5GV2+9REoa3HsSvY
	 EiJh1XrHGTvhQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65f980cea07so4895416a12.0
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:33:03 -0800 (PST)
X-Gm-Message-State: AOJu0YwXM7+8LWWZmdczxtMK777K1oJlE6nLlM3iXTTsSt4YOzIrFkS7
	DRvOrRhhusRzF/fi0E5kjXY9lPMB2CLqgFvwb/mg59+WzRZ1BAbBnv/VR5gQnZczNXOdY4GnUbJ
	Zm6P5BpkMMioT016OFU5JAegskGDia4Y=
X-Received: by 2002:a05:6402:5113:b0:65f:88f7:da0 with SMTP id
 4fb4d7f45d1cf-65fddaf6e1cmr5264647a12.15.1772346781918; Sat, 28 Feb 2026
 22:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301012749.1685415-1-sashal@kernel.org>
In-Reply-To: <20260301012749.1685415-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:32:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ZrV0EJG-4zEj6xtkusB+=AihzQW3s9Mi4JZJZZG36PA@mail.gmail.com>
X-Gm-Features: AaiRm50BJJVC7RT0cVN1Z6Ko-W-_z29EWpZzqi4t7mY_IDr-i4jfO2Yg3-Ms9cw
Message-ID: <CAAhV-H6ZrV0EJG-4zEj6xtkusB+=AihzQW3s9Mi4JZJZZG36PA@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Disable instrumentation for
 setup_ptwalker()" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, yangtiezhu@loongson.cn, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222412-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,loongson.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 430751CEA2C
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:27=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I'm very confused because it can be applied and already here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.12

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

