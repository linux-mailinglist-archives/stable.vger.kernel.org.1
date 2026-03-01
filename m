Return-Path: <stable+bounces-222419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCJAIEXgo2lPQwUAu9opvQ
	(envelope-from <stable+bounces-222419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:44:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEC91CEABA
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B393300809D
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51CB27AC48;
	Sun,  1 Mar 2026 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Slte34qq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97551261B6D
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347453; cv=none; b=XXM4B6n3X9pDShA5BIJ/t4+BqbLBVMkT4mjV8fhSaBrmhKuFZsAGn4Rew38Hp2wb8HZhpMP8TmSe+XmNwMP7TudJIuc2RVHO7Foo1LAoiNatINI7AfL6a7MgwbLsx+4C9pzUmlp9RxncxGljm8C7wfGhdIMb9dK6iMN2B1eM2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347453; c=relaxed/simple;
	bh=XFGpLYN03reP+5l6hA30SCAITxDf85HOumCDhZqztm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyvMw1iz1uUPPMo+8L6/gVsEJsWryhlrdkfQ6JM7v+VZNjWWXEx31Ng/fbjfkzRfECvRTDHuGerUeje+LNUwkDAZ1p8uNcWqQ1YB7HlWgp9VBU3DvZoJflCY3TcGdk8cLFOOgLiUt5FZ89DgQlRFKL2z9uJpd2okhiHtUJXxtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Slte34qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D20C116C6
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772347453;
	bh=XFGpLYN03reP+5l6hA30SCAITxDf85HOumCDhZqztm0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Slte34qq1nC/CA0hwhslB4E2Z/dKxIeD5MGIzYiCkZmEvl6BhhRttE0wgCNeXkMdZ
	 D0iLznXbi1udMbJ6CiwydbuEBoV2+y5DuUStJWZU+DEy+AkkEyk/oc7I5fgLiNBH3O
	 23hpLw4VZ6N6FGqC6vHJtfC3jCRDlrmQtGR68zSRoyEp63zSAvnKeJX0uAV2bZcK+W
	 t277XvnVkWE8o8zZ6Bt++pPkAUcOjR2RLcw4VEx6ux6eV+WZObNZOiAjGGQDs6S1Ee
	 ZO4d35CjL4ArzgMAtHOMKWWcr3esJw65bvu+9FbZzcZkJg/yJiO1uHNaVHBRVQuPR/
	 1tSV0ylNhaUcw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65b9d8d6b7dso5574859a12.2
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:44:13 -0800 (PST)
X-Gm-Message-State: AOJu0YzWL4ZdK/I8h2sn5Kj0pfgcDUsUjUrjNJJVckiSlm/d3nTYnmPR
	uVY4AH3JeO4pct+9L2uTMxboSxeMLP11ao8w2kbowkUtO54Iv/ShSS9/GYtAk995cuSTNn0YZWm
	Eid+mHSHWuSY7Ef10aiEwpd6X1aX62Mw=
X-Received: by 2002:a05:6402:4508:b0:65c:420:d30 with SMTP id
 4fb4d7f45d1cf-65fdd6c0beamr3560059a12.12.1772347451941; Sat, 28 Feb 2026
 22:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301013752.1698147-1-sashal@kernel.org>
In-Reply-To: <20260301013752.1698147-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:44:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Bv_n1OW70sjtSXvLia53BbMuHB1VPpDN5kDMYC=knng@mail.gmail.com>
X-Gm-Features: AaiRm53v3UndjOIglK-lx4rUOL8gYuM2ftLZut-EYx4catgZY2WxXuIWOW2uVZU
Message-ID: <CAAhV-H6Bv_n1OW70sjtSXvLia53BbMuHB1VPpDN5kDMYC=knng@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Handle percpu handler address for ORC
 unwinder" failed to apply to 6.6-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, yangtiezhu@loongson.cn, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222419-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BEC91CEABA
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:37=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Please do the same thing here:
https://lore.kernel.org/loongarch/CAAhV-H46pdrJgJ0tg493nK8S8X6NQrXu+jHO-yDp=
BBdyDpRQKw@mail.gmail.com/T/#t

Huacai

>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From 055c7e75190e0be43037bd663a3f6aced194416e Mon Sep 17 00:00:00 2001
> From: Tiezhu Yang <yangtiezhu@loongson.cn>
> Date: Tue, 10 Feb 2026 19:31:13 +0800
> Subject: [PATCH] LoongArch: Handle percpu handler address for ORC unwinde=
r
>
> After commit 4cd641a79e69 ("LoongArch: Remove unnecessary checks for ORC
> unwinder"), the system can not boot normally under some configs (such as
> enable KASAN), there are many error messages "cannot find unwind pc".
>
> The kernel boots normally with the defconfig, so no problem found out at
> the first time. Here is one way to reproduce:
>
>   cd linux
>   make mrproper defconfig -j"$(nproc)"
>   scripts/config -e KASAN
>   make olddefconfig all -j"$(nproc)"
>   sudo make modules_install
>   sudo make install
>   sudo reboot
>
> The address that can not unwind is not a valid kernel address which is
> between "pcpu_handlers[cpu]" and "pcpu_handlers[cpu] + vec_sz" due to
> the code of eentry was copied to the new area of pcpu_handlers[cpu] in
> setup_tlb_handler(), handle this special case to get the valid address
> to unwind normally.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/setup.h |  3 +++
>  arch/loongarch/kernel/unwind_orc.c | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/=
asm/setup.h
> index 3c2fb16b11b64..f81375e5e89c0 100644
> --- a/arch/loongarch/include/asm/setup.h
> +++ b/arch/loongarch/include/asm/setup.h
> @@ -7,6 +7,7 @@
>  #define _LOONGARCH_SETUP_H
>
>  #include <linux/types.h>
> +#include <linux/threads.h>
>  #include <asm/sections.h>
>  #include <uapi/asm/setup.h>
>
> @@ -14,6 +15,8 @@
>
>  extern unsigned long eentry;
>  extern unsigned long tlbrentry;
> +extern unsigned long pcpu_handlers[NR_CPUS];
> +extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
>  extern char init_command_line[COMMAND_LINE_SIZE];
>  extern void tlb_init(int cpu);
>  extern void cpu_cache_init(void);
> diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/u=
nwind_orc.c
> index d6b3688a1ce97..11ba3e4ac9eee 100644
> --- a/arch/loongarch/kernel/unwind_orc.c
> +++ b/arch/loongarch/kernel/unwind_orc.c
> @@ -352,6 +352,22 @@ static inline unsigned long bt_address(unsigned long=
 ra)
>  {
>         extern unsigned long eentry;
>
> +#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
> +       int cpu;
> +       int vec_sz =3D sizeof(exception_handlers);
> +
> +       for_each_possible_cpu(cpu) {
> +               if (!pcpu_handlers[cpu])
> +                       continue;
> +
> +               if (ra >=3D pcpu_handlers[cpu] &&
> +                   ra < pcpu_handlers[cpu] + vec_sz) {
> +                       ra =3D ra + eentry - pcpu_handlers[cpu];
> +                       break;
> +               }
> +       }
> +#endif
> +
>         if (ra >=3D eentry && ra < eentry +  EXCCODE_INT_END * VECSIZE) {
>                 unsigned long func;
>                 unsigned long type =3D (ra - eentry) / VECSIZE;
> --
> 2.51.0
>
>
>
>
>

