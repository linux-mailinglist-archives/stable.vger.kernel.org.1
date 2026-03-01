Return-Path: <stable+bounces-222413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TswPGfndo2klQgUAu9opvQ
	(envelope-from <stable+bounces-222413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:34:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F291CEA34
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A931301D32A
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38736314D1F;
	Sun,  1 Mar 2026 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx0RMDCb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC901C549F
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772346869; cv=none; b=ikw9LGbo258ThqqAgzCAX6ZPXGkDjCE6iAjiWf5Z/qj31NjpsgBW//YI/dkNUC4jIOJf21TWdODsCm3P3mBtyOlEcZS6lR3zh8iILaX0569Ns0iKQSFiSxL/kaWwtCYGYuvQt4XbNsBv0klCOF+TaDYI6eLFnkLYv/3h8431YTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772346869; c=relaxed/simple;
	bh=4kW78VB6HvJ7HwLv3XkvQWHjvP50yh/DiNDuEin0xv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkhfEZJSxV+vzdG6GxQsUvXoI2Uq+RmNTe7rKlZKn9y75i7ca8CUdIsHMocEIDQ+w9s/9RcCZk2k1vVRirFHIoPL1WjntYbGDZT7b2cDNiu2CEirHSycTAEjOSooSB4qQRNvjlAyqkZAUKRcT0BW/pcCxRg5L3h/gCkQcxuqExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx0RMDCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26BFC4AF0B
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772346868;
	bh=4kW78VB6HvJ7HwLv3XkvQWHjvP50yh/DiNDuEin0xv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hx0RMDCbBG/7uEUtJfY7AZdEzRYTsTXLWCk85YIX0kq5R6x6DPHr7Vo2a/IcOQ62i
	 KJnfxljCXOCOjeM3Y/ikmcJ77M9chF0ETgqi49VWjWOVJ8YQx3EzoVJiagPKALCb4V
	 Bu9Av3E0PO9R94jcjrUVMKJiLDbUfeA0AEVPFWtgMMwPoks4OL2Pu2ar0+oMKmPMuq
	 ax/fosTfwY/L4JcI1RhaibGuYftkD7Cc0OiWCTISuL9U/ib1K+2l3Ayp5U/GUM+tcQ
	 IRFzZJVf4aM6yu6gict0iQmA7Q68ES8oMc18rU0xAP3d0lFbP5wTGRUEful8SZ54hi
	 oxzFaGIOPG6BA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65c187dfc82so5347033a12.2
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:34:28 -0800 (PST)
X-Gm-Message-State: AOJu0Yw/XMTesCU/gol+lOJ5yEHf7wRrULQsxrFrMlOslfeS6FNv+qKd
	8iWMjV4XVy+uvZ195Tr29qfv+b+X4QxMte3YZ8NBaY2iEakFymReXVDCG6h10tdVQ8NMIk8CMgM
	Dph0XCDl/Uefie+WisatPEeNVBBPVM8c=
X-Received: by 2002:a05:6402:42c4:b0:65c:2170:67d2 with SMTP id
 4fb4d7f45d1cf-65fddcebdcamr5308457a12.16.1772346867383; Sat, 28 Feb 2026
 22:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301012737.1685164-1-sashal@kernel.org>
In-Reply-To: <20260301012737.1685164-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:34:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5th1nFb92g2PN9-OKym6n5w1FuYcFsn8DBL5rrV0rjog@mail.gmail.com>
X-Gm-Features: AaiRm50sdsa9Q1QX9fbwa919mYlErSNYDuxC69Hv3GRV489YLWP-xJNx_W__o4k
Message-ID: <CAAhV-H5th1nFb92g2PN9-OKym6n5w1FuYcFsn8DBL5rrV0rjog@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Handle percpu handler address for ORC
 unwinder" failed to apply to 6.12-stable tree
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222413-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B0F291CEA34
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:27=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.12-stable tree.
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

