Return-Path: <stable+bounces-121175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F0A542D8
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 07:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBC416BC83
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 06:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2591A01B9;
	Thu,  6 Mar 2025 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj3cHtnK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890A19C554;
	Thu,  6 Mar 2025 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242996; cv=none; b=mqUJ5+dUObOF1hy/BPd84zFPLcHWHd/Igyumi5v7pYmZanQqRRZi+wVT/hh/snygSW6nijfsTAPLYRORLnGhN/hAhfe0gkLrMY919GQFCNZUhGJKe5IVPzg/GiWextBjWzv0cPkpdVfLFZ7jUSBU5uYcx/54+cTgRoTXEYPKJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242996; c=relaxed/simple;
	bh=3gjOUzCOeobpo+bQrS61L5KTw/nl8QOpdeWmBF5tBl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNjGmLPjv2yLUuQXv0pGWLQBg1QQMnbAnVMe97H3ZiB3yF0ruKpgfQfOm4SJuNKQ0RaEO///DhnrUssVf1BGiFYNKhODnFdR/nDFbSi7HX6weoh3VvrRf/JqmJa4Q7/9440OUzIelc3iURmkaYNMp2CJepKJjfHs8gAjA2sJ8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj3cHtnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC78C4CEE9;
	Thu,  6 Mar 2025 06:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741242995;
	bh=3gjOUzCOeobpo+bQrS61L5KTw/nl8QOpdeWmBF5tBl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rj3cHtnKrurG1GOwFFmkNxNIjzde1+iQTGEkHB40RNWwdKs00wbIr7589+UfOzo1r
	 8A6hqP3mwunJdSXGQ4TGlZnK37/B31WgmNXszDXvCaD3wR40MoUBGT7pI9qzYJU4m/
	 3FVm/NjN5crPPu+E2vX6s5zAk4Tq0QaugdCa5YYxFfsE6dEA2zdtjqtx8fl2r1TI1L
	 4tqdmMwIuhUbsbOtjni7TjYC2wfixipdZscYCruUYl7izkE7JRd35eVpwPCOyTmipt
	 eRZLBFUWubbnx2jMfQ+tkvgX5qPcCpBi44gcTP6JwbyuUdF/1Rd/17bbqs0haCsiPI
	 ZnYc23h0Px48g==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so466474a12.1;
        Wed, 05 Mar 2025 22:36:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYqsYX3EDeNSh0aQJxNxR+HtL/DIo2m5VRm/lOW8G7nhF5wZ/8ep3GLLlzVEXLLJZi05h3UV3S1tBWPwU=@vger.kernel.org, AJvYcCWsFlJE3lTFNzTnGLyWLtz9VNpQDj8ojz/iY9dfeCtURXXuBl1jZbG2/t/7dw3pCq/I0q7n1vjG@vger.kernel.org
X-Gm-Message-State: AOJu0YzPTbWOMjz8dpN3//+L6FvKjSbUqwYhHH8Ecidf4NTA/T7nOYVy
	uejfPB9PwA7ytK/R4GP9xU3ZUgaDTSn+0FskTqnFOsgpUTJCdF3HBZeR2QG5XjjEFm8ljfwVGtT
	dVf2ooJZO5YJaxLfT6l2rsct2Bf4=
X-Google-Smtp-Source: AGHT+IGzRQmG6IWerhpKvupSsx10MS2/s0rwwZdeICWvvyWFMnHWE7lef7OcTQQRGEk7U3RkX/E4Iuxec3s/khFHBcc=
X-Received: by 2002:a17:907:6d12:b0:ac2:acf:84c1 with SMTP id
 a640c23a62f3a-ac20da8944cmr565485666b.46.1741242994224; Wed, 05 Mar 2025
 22:36:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306035314.2131976-1-maobibo@loongson.cn> <CAAhV-H45DobYbBFBatJtHPF22VAX=QWH8i=jzpWNvN-ELgWr4Q@mail.gmail.com>
 <b1fde3cf-f4ed-68cc-fd4d-8b8b089870f1@loongson.cn>
In-Reply-To: <b1fde3cf-f4ed-68cc-fd4d-8b8b089870f1@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 6 Mar 2025 14:36:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H47shgAGtB59Yth0tPVwaLFjsq-4nix5BXTExaVAHxa0A@mail.gmail.com>
X-Gm-Features: AQ5f1JqorG9glBtNWXwIgv-uVhK1qOmPSFS24TYERI6YqitAw7OpBKdqFhjY0Ok
Message-ID: <CAAhV-H47shgAGtB59Yth0tPVwaLFjsq-4nix5BXTExaVAHxa0A@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: mm: Set max_pfn with the PFN of the last page
To: bibo mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 2:26=E2=80=AFPM bibo mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2025/3/6 =E4=B8=8B=E5=8D=8812:06, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > On Thu, Mar 6, 2025 at 11:53=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> =
wrote:
> >>
> >> The current max_pfn equals to zero. In this case, it caused users cann=
ot
> >> get some page information through /proc such as kpagecount. The follow=
ing
> >> message is displayed by stress-ng test suite with the command
> >> "stress-ng --verbose --physpage 1 -t 1".
> >>
> >>   # stress-ng --verbose --physpage 1 -t 1
> >>   stress-ng: error: [1691] physpage: cannot read page count for addres=
s 0x134ac000 in /proc/kpagecount, errno=3D22 (Invalid argument)
> >>   stress-ng: error: [1691] physpage: cannot read page count for addres=
s 0x7ffff207c3a8 in /proc/kpagecount, errno=3D22 (Invalid argument)
> >>   stress-ng: error: [1691] physpage: cannot read page count for addres=
s 0x134b0000 in /proc/kpagecount, errno=3D22 (Invalid argument)
> >>   ...
> >>
> >> After applying this patch, the kernel can pass the test.
> >>   # stress-ng --verbose --physpage 1 -t 1
> >>   stress-ng: debug: [1701] physpage: [1701] started (instance 0 on CPU=
 3)
> >>   stress-ng: debug: [1701] physpage: [1701] exited (instance 0 on CPU =
3)
> >>   stress-ng: debug: [1700] physpage: [1701] terminated (success)
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: ff6c3d81f2e8 ("NUMA: optimize detection of memory with no node =
id assigned by firmware")
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   arch/loongarch/kernel/setup.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/set=
up.c
> >> index edcfdfcad7d2..a9c1184ab893 100644
> >> --- a/arch/loongarch/kernel/setup.c
> >> +++ b/arch/loongarch/kernel/setup.c
> >> @@ -390,6 +390,7 @@ static void __init arch_mem_init(char **cmdline_p)
> >>          if (usermem)
> >>                  pr_info("User-defined physical RAM map overwrite\n");
> >>
> >> +       max_low_pfn =3D max_pfn =3D PHYS_PFN(memblock_end_of_DRAM());
> > max_low_pfn is already calculated for all three cases, so here just
> > need "max_pfn =3D max_low_pfn".
> In theory it should be.
>
> However there are potential problems, it should be recalculated in
> function early_parse_mem() also if commandline "mem=3D" is added.
>
Yes, you are right, thanks.

Huacai

> The other thing is that calculation init_numa_memory() is unnecessary
> since it is already calculated in memblock_init(). Memory block
> information comes from UEFI table or FDT table, and ACPI srat
> information only adds node information.
>
> Regards
> Bibo Mao
> >
> > Huacai
> >
> >>          check_kernel_sections_mem();
> >>
> >>          /*
> >>
> >> base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
> >> --
> >> 2.39.3
> >>
>
>

