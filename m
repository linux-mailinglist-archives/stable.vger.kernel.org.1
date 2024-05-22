Return-Path: <stable+bounces-45560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE0B8CBCAA
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 10:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF591F21CFD
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 08:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BAB7F483;
	Wed, 22 May 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ub7dQRRY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBB7F484;
	Wed, 22 May 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365293; cv=none; b=PrLQdPCScf1kgggKV738k9opTkwzFYojGtoxxpAcIr8NLTbefXRXcAcUZPBEu5/tHzcdAPPrXGDQREEZxBEj+ALkNmvXhfFolBxkZbxigUALBqXEOeXADm+TGE07xkyiYiSJznu9offi8HwZWvGsDdDtEwM84/3Ke5JJzQyEBco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365293; c=relaxed/simple;
	bh=XsVorddufHJHW9jCOTtwIqAeudeLJX7nT1NbKFEuzSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfCU2W4aeL5Un6WU6Q7aSscHbRDfx+kNPCGiQehEy01vl69opQEMGswV2dwiza7CoigwQcU9dNMrpsdUXhMlIbYkYcrZBxifMDAS16ymA3n9hpYBgm7WjA+NusrTaf8HH/0sLnQpyzPAfJtIA7GoTTZha9s37jdeoRzFZsdZWu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ub7dQRRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE70C4AF09;
	Wed, 22 May 2024 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716365293;
	bh=XsVorddufHJHW9jCOTtwIqAeudeLJX7nT1NbKFEuzSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ub7dQRRYmgvGQIXOKkzcALnqKjdM+kZsOun7dJb4WOMFCtRCQ6V0yqAVNS+H+zhHw
	 xkU1tyazOtIdw3SzINSIjctScF0rx5MEFgSwgiWSZtLfFhX4rhkY4oLAJBWlVUdwJh
	 kQ1lvutc25IUT12jL0ca6Q/8hjIkbXin+2EkNxTdqNObXC0E0T/0xU4YEbk0PAn8OS
	 isDDEVKBw5YBZtGcW94r7rF2qi+X28SIkuwWXgeXyV11s7cPFUEB+p9f6o5tR9+sg2
	 OlvSMsAX/GNRfNsLzO7ZtAcRvL/w36Cz7rL66F3R/GHCa9Z6RpACM7XOxGPXNQQ0OF
	 rgtZ3Zlm6+BQQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5238b7d0494so6259471e87.3;
        Wed, 22 May 2024 01:08:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUM+1mdMv44phN1sm93CR73wEq/ShahYZD4fEIh3Ct9aHel+OYEe9mV6HXTUgv7rPadJYDuIOWsOP2nin0CkOTqX6+NtknEMBUAsgP3rhSQ41AjkeO23z8h/7jbRqVPpD3wbvPM
X-Gm-Message-State: AOJu0YwRLRM2N5MWqlRPokAVp++VlaaQYVdF3IT3bzLqdDOtx08yEklS
	SugaZXyy8a2qKN5ip7EO2MA2d3gXpgSDWYeY08MH0bhYRvlXf9nrCxDSljwA70S5IVAE+MaXz9/
	J3j+ahTJg7bSecIXS+qYpfbDXEGo=
X-Google-Smtp-Source: AGHT+IFAwGmgLyWddo6GG2KC4+9FOm3Fivw6BZNWf4Z82XgHm/o2gbsmxHaMbRAHB6CWe4Pb1CXzQJ+VgCtRrBSM6SM=
X-Received: by 2002:ac2:4884:0:b0:524:34ad:ba7d with SMTP id
 2adb3069b0e04-526c0a68f31mr1201735e87.42.1716365291354; Wed, 22 May 2024
 01:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com> <20240522-loongarch-booting-fixes-v2-2-727edb96e548@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v2-2-727edb96e548@flygoat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 22 May 2024 16:07:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4r=2LbOBsM8oas=ewXGA+4Z=Y==iSgZfsdSk7GHOrieA@mail.gmail.com>
Message-ID: <CAAhV-H4r=2LbOBsM8oas=ewXGA+4Z=Y==iSgZfsdSk7GHOrieA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] LoongArch: smp: Add all CPUs enabled by fdt to
 NUMA node 0
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jiaxun,

On Wed, May 22, 2024 at 2:30=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> NUMA enabled kernel on FDT based machine fails to boot
> because CPUs are all in NUMA_NO_NODE and mm subsystem
> won't accept that.
>
> Fix by adding them to default NUMA node for now.
>
> Cc: stable@vger.kernel.org
> Fixes: 88d4d957edc7 ("LoongArch: Add FDT booting support from efi system =
table")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/loongarch/kernel/smp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 0dfe2388ef41..866757b76ecb 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -273,7 +273,6 @@ static void __init fdt_smp_setup(void)
>
>                 if (cpuid =3D=3D loongson_sysconf.boot_cpu_id) {
>                         cpu =3D 0;
> -                       numa_add_cpu(cpu);
>                 } else {
>                         cpu =3D cpumask_next_zero(-1, cpu_present_mask);
>                 }
> @@ -283,6 +282,10 @@ static void __init fdt_smp_setup(void)
>                 set_cpu_present(cpu, true);
>                 __cpu_number_map[cpuid] =3D cpu;
>                 __cpu_logical_map[cpu] =3D cpuid;
> +
> +               early_numa_add_cpu(cpu, 0);
> +               set_cpuid_to_node(cpuid, 0);
> +               numa_add_cpu(cpu);
What's wrong exactly? Real machine has no problem here, and at least
numa_add_cpu() should not be called for non-zero cpu so early, because
it need per-cpu area be setup. I guess the root cause is that there is
something wrong and "cpuid =3D=3D loongson_sysconf.boot_cpu_id" is
skipped.

Huacai

>         }
>
>         loongson_sysconf.nr_cpus =3D num_processors;
>
> --
> 2.43.0
>

