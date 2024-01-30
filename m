Return-Path: <stable+bounces-17363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A22841937
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 03:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027B0288CB5
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 02:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BDB374F0;
	Tue, 30 Jan 2024 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsT8H/pL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD72364CF
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581531; cv=none; b=av/11X9G6spGXHob6WhgNnMdvNGjSHfe8WwcqcOIWA6g31lC6dN+6HDhlFXYWj89aWizVjpspVrGrgvWyOpQ0SsaONK9YvLCO4R8gH2oZLA6eYycn1CQEsW4Fy3c2nvHF6iqElXlPG3bmMI+chy/fS5VI+qKdqdpFRuLeRNNA5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581531; c=relaxed/simple;
	bh=F/O8O2rczfooHHfnmMLVEVLbZjrq+rG8HdgnVzx/KfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGitjV7Obf7Etd6rJpc678wt481E7BJmd6c74hmag2Sk6ynzaWwzGsKX6ZQjDNWcV8w88j2Ps+ftoZPaTCrQ0fCAq0SQp80BsVlmdlk9SOwdvyK7M/rM0tEimoOH8+ZTEd9viHKcthgzL2MLoYzCgPwYuHgiXHbPGYl7M7aGJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsT8H/pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35446C433F1
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 02:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706581531;
	bh=F/O8O2rczfooHHfnmMLVEVLbZjrq+rG8HdgnVzx/KfA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WsT8H/pLkwD7Yjh+CPbFHsa2mJb8U94JqTFuFYNtM1WfusqyFyAw0ZCtYtJZ+R9fd
	 15T9GJ4W2CyLAcWXY1tHLqFWK/l9EW0t04XOXQaza3aXOCPZc3qvivpwqydLonGQN9
	 OnJMQke46nRyIK5nBO6n8T65Zh6DugSe6nUqIfp8aUngpV6HhDlK7bgnFmj9jgoxpy
	 BQt0H9+fgcKljOolba9p46FQC8Sdaxn2e67pWSObbJKdnwvFA+01iLJyi6Xnw9ZOIQ
	 uD5D+yZLYtRH12kxmUoAKJxgHedW5uoSFjNF4kYcr5c/0s+khXaGe0S/u5b+Fqm3qp
	 IFDj1AWJC/Bhw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so3139721a12.1
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 18:25:31 -0800 (PST)
X-Gm-Message-State: AOJu0YxlqsvLS5trY5jA+3qJpc0s34yemwa0ljRzbdU8QjfMPPj3smwK
	9d44XpPR5kPf9TIYmeKYKRQAU239Jtjy2Vi9zsI8jMRrjRG0g/VMlhq4wE8On5QyiQNFj6vjz2k
	mvWm1ScQqWxIGVTadCyhwS/w7r0I=
X-Google-Smtp-Source: AGHT+IG07a4S+5y5xeslAFyOzS2VSxigZaMo4XVziP4t0XryUCZaNoE0NnGnMULSCNPLV9lQ4VKuxMtNpL4gbGu7HEk=
X-Received: by 2002:a05:6402:60f:b0:55f:27ee:d52d with SMTP id
 n15-20020a056402060f00b0055f27eed52dmr1206918edv.42.1706581529619; Mon, 29
 Jan 2024 18:25:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024012911-outright-violin-e677@gregkh>
In-Reply-To: <2024012911-outright-violin-e677@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 30 Jan 2024 10:25:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H44QUho8cq4cG6rpovboBH_28vfiw-akMWoLMLR6Qgu1w@mail.gmail.com>
Message-ID: <CAAhV-H44QUho8cq4cG6rpovboBH_28vfiw-akMWoLMLR6Qgu1w@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] LoongArch/smp: Call rcutree_report_cpu_starting()
 at" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: chenhuacai@loongson.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Greg,

On Tue, Jan 30, 2024 at 12:53=E2=80=AFAM <gregkh@linuxfoundation.org> wrote=
:
>
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 5056c596c3d1848021a4eaa76ee42f4c05c50346
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012911-=
outright-violin-e677@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>
> Possible dependencies:
>
> 5056c596c3d1 ("LoongArch/smp: Call rcutree_report_cpu_starting() at tlb_i=
nit()")
Similar to the commit which it fixes, please change
rcutree_report_cpu_starting() to rcu_cpu_starting() in the code.

Huacai

>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 5056c596c3d1848021a4eaa76ee42f4c05c50346 Mon Sep 17 00:00:00 2001
> From: Huacai Chen <chenhuacai@kernel.org>
> Date: Fri, 26 Jan 2024 16:22:07 +0800
> Subject: [PATCH] LoongArch/smp: Call rcutree_report_cpu_starting() at
>  tlb_init()
>
> Machines which have more than 8 nodes fail to boot SMP after commit
> a2ccf46333d7b2cf96 ("LoongArch/smp: Call rcutree_report_cpu_starting()
> earlier"). Because such machines use tlb-based per-cpu base address
> rather than dmw-based per-cpu base address, resulting per-cpu variables
> can only be accessed after tlb_init(). But rcutree_report_cpu_starting()
> is now called before tlb_init() and accesses per-cpu variables indeed.
>
> Since the original patch want to avoid the lockdep warning caused by
> page allocation in tlb_init(), we can move rcutree_report_cpu_starting()
> to tlb_init() where after tlb exception configuration but before page
> allocation.
>
> Fixes: a2ccf46333d7b2cf96 ("LoongArch/smp: Call rcutree_report_cpu_starti=
ng() earlier")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index a16e3dbe9f09..2b49d30eb7c0 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -509,7 +509,6 @@ asmlinkage void start_secondary(void)
>         sync_counter();
>         cpu =3D raw_smp_processor_id();
>         set_my_cpu_offset(per_cpu_offset(cpu));
> -       rcutree_report_cpu_starting(cpu);
>
>         cpu_probe();
>         constant_clockevent_init();
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index 2c0a411f23aa..0b95d32b30c9 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -284,12 +284,16 @@ static void setup_tlb_handler(int cpu)
>                 set_handler(EXCCODE_TLBNR * VECSIZE, handle_tlb_protect, =
VECSIZE);
>                 set_handler(EXCCODE_TLBNX * VECSIZE, handle_tlb_protect, =
VECSIZE);
>                 set_handler(EXCCODE_TLBPE * VECSIZE, handle_tlb_protect, =
VECSIZE);
> -       }
> +       } else {
> +               int vec_sz __maybe_unused;
> +               void *addr __maybe_unused;
> +               struct page *page __maybe_unused;
> +
> +               /* Avoid lockdep warning */
> +               rcutree_report_cpu_starting(cpu);
> +
>  #ifdef CONFIG_NUMA
> -       else {
> -               void *addr;
> -               struct page *page;
> -               const int vec_sz =3D sizeof(exception_handlers);
> +               vec_sz =3D sizeof(exception_handlers);
>
>                 if (pcpu_handlers[cpu])
>                         return;
> @@ -305,8 +309,8 @@ static void setup_tlb_handler(int cpu)
>                 csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_EENTRY);
>                 csr_write64(pcpu_handlers[cpu], LOONGARCH_CSR_MERRENTRY);
>                 csr_write64(pcpu_handlers[cpu] + 80*VECSIZE, LOONGARCH_CS=
R_TLBRENTRY);
> -       }
>  #endif
> +       }
>  }
>
>  void tlb_init(int cpu)
>

