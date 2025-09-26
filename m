Return-Path: <stable+bounces-181772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C932BA4362
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 16:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF4717094B
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE71CEAD6;
	Fri, 26 Sep 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHHP65m4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D11B87F0
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897066; cv=none; b=j+JxoC7qyFq3KEFynow1NKtzawP/jRxaqkmZVwA0P/pwX9ym2TDxD+SNyycnN9d1sOQrgvczpS68Sdp4MrjamVmAm616lDwS9cumLjUJ2B3Ac2LAWPD7JAIcI/d9xTtb2NqBNud1kw89rl+Wt2qi4P0rH+bbBFli48hhcqWtMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897066; c=relaxed/simple;
	bh=IGdCqM/yTaiPyzZyhYs3irmCvSMu4bZkT42mEj1Liho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGbn0hEI8e48hDH8pOcAIeN26UlYuExtPtS9m5IpD4/Q4z3kRSwIM6trihbkYGQeJ2D3defGi8OBPMI1qz4/BGOiil4oRlxKQww4Ydk2oO2zAwQSU4quBEU3yX6dtO6ZYXch8i45E/M95dp5M+174wS9Ul8p15G18mWSMGB3YoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHHP65m4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2042720b3a.1
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758897064; x=1759501864; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eu75bAdjt5h24Mx1b29gb92p1XKKnNXBr/2FE3JcqU0=;
        b=nHHP65m405iqIZWXPLrVYY6B49xE6ICq0tyYEo+89liQiLzvCGRzprgyEjl2JFp0Z7
         ttBdnF3hfP1UpMxZIoFxvV9nIr1/mo2y23GSbWJaVcqaLnGSA7/Z6cZRtcKjdTYX3/MZ
         R+T5g42xY11+yrHSNkWxiSzq0IVOl8GrbTX4zOfJfqPtelIDmT0B7Xh23cPF5al3+rQe
         epxPYUMAuvN7Gl7yGNpxtnHusn/mxcc7r4c4TlziGQMsLUzyydxSKfLK0JUsA0v6hfLl
         m3dTraO9Czwje7jSfpA1j22W23lVCQdc+qXDAXJG7d0DjWPBiPSzephdLl3l7UlyxmCy
         Xzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897064; x=1759501864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eu75bAdjt5h24Mx1b29gb92p1XKKnNXBr/2FE3JcqU0=;
        b=a2WYGlszJTIFKORtrcjA+qSbnswMyawcxd07E8UCbozwGRriFgmkn7m4AKe7qrtwJP
         DWpUz/cFydj8yC7yEOOcoRo18XLBEMlcfgGDjn9AfJMdeTwTiu1BCkm4VfivN/0j84PP
         NbqL7oTh22e6wyxHzX45xBF5WlC9EUy5GrAkOgNuRpTdfSGaVrWgeeodAFyIaMdRni9L
         qfN/5k7orbax703/IEuq/eFLkD8o8X3SL/OHvsFC9YIzHVxx/fxEBYWOBdOPmGXPybdl
         R6FPoK9CVgygCn11BTxvgEHSKJ7UySNUEzSm91wnfjnDAPQQGAgF7mFr4GLblKG418bQ
         AAhw==
X-Forwarded-Encrypted: i=1; AJvYcCXr2NytLJL3cUTMSnxNmuPCEi/aNQQ4xFHkmOy0aiY7buDWD2xResTYCgAqmqQXisOXNTXSZ8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP92SPd6LPMpo/oX3q7OUqLhr2wGSGJl3a9LM3CjgYa88wiG5A
	nr0ZO6WUR+D0dVhrJUvkvwzvHnVfvWeLcQLGp/p6osC0T4GidLExupym
X-Gm-Gg: ASbGncuc3e5YexNojPuN8vhBHmFBD49q8WzrEWqh3yyH8ze71aMnphsId5SNf+7Fjx5
	cmB0LndZg4sv4TvpogZBU4JnzAERSFfiuOFBJSmLVQcVtBYRHFmMftzIG/bjZfGXhBrcrMH7yck
	Uckp6AV/a1X20b0sR+6G5J1bhE5GS/BqEJfbHUIHWOt3q0yD/7+knUSR3eI282v/JST8qhLUbBu
	VwYP/ApUNKJlIZmVoUVJr6FrSFlXTh5UdhtvCVNryk4P052ZKCciL2VHiww/wUBoJP5m2oPd0Cn
	4RfX2hshnrG5azncmIDbh2VT154vLuHP4/jyxfy0nTlIFYPswuU7Gyrtygf9fU5HwcYbPCqwblW
	x2hFbfKyEelzlGL9GkUKXb5BKZpbY2YaDLa4=
X-Google-Smtp-Source: AGHT+IGltOAbo12hajVKgocbpBnHZMZeOL2ERzr9t+RXZ6PnxdAexobpssI/N7xOALCEb6/v2s939A==
X-Received: by 2002:a05:6a21:7116:b0:2f9:4cde:34fb with SMTP id adf61e73a8af0-2f94cde4d16mr2209198637.1.1758897063477;
        Fri, 26 Sep 2025 07:31:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238cafasm4613070b3a.4.2025.09.26.07.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:31:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 26 Sep 2025 07:31:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH V2] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN
 enabled
Message-ID: <899f2dec-e8b9-44f4-ab8d-001e160a2aed@roeck-us.net>
References: <20250910091033.725716-1-chenhuacai@loongson.cn>
 <20250920234836.GA3857420@ax162>
 <CAAhV-H5S8VKKBkNyrWfeuCVv8jS6tNED6YNeAD=i-+wkaoRSDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5S8VKKBkNyrWfeuCVv8jS6tNED6YNeAD=i-+wkaoRSDQ@mail.gmail.com>

On Sun, Sep 21, 2025 at 09:07:38AM +0800, Huacai Chen wrote:
> Hi, Nathan,
> 
> On Sun, Sep 21, 2025 at 7:48 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Huacai,
> >
> > On Wed, Sep 10, 2025 at 05:10:33PM +0800, Huacai Chen wrote:
> > > ARCH_STRICT_ALIGN is used for hardware without UAL, now it only control
> > > the -mstrict-align flag. However, ACPI structures are packed by default
> > > so will cause unaligned accesses.
> > >
> > > To avoid this, define ACPI_MISALIGNMENT_NOT_SUPPORTED in asm/acenv.h to
> > > align ACPI structures if ARCH_STRICT_ALIGN enabled.
> > >
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > Suggested-by: Xi Ruoyao <xry111@xry111.site>
> > > Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > > V2: Modify asm/acenv.h instead of Makefile.
> > >
> > >  arch/loongarch/include/asm/acenv.h | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/loongarch/include/asm/acenv.h b/arch/loongarch/include/asm/acenv.h
> > > index 52f298f7293b..483c955f2ae5 100644
> > > --- a/arch/loongarch/include/asm/acenv.h
> > > +++ b/arch/loongarch/include/asm/acenv.h
> > > @@ -10,9 +10,8 @@
> > >  #ifndef _ASM_LOONGARCH_ACENV_H
> > >  #define _ASM_LOONGARCH_ACENV_H
> > >
> > > -/*
> > > - * This header is required by ACPI core, but we have nothing to fill in
> > > - * right now. Will be updated later when needed.
> > > - */
> > > +#ifdef CONFIG_ARCH_STRICT_ALIGN
> > > +#define ACPI_MISALIGNMENT_NOT_SUPPORTED
> > > +#endif /* CONFIG_ARCH_STRICT_ALIGN */
> > >
> > >  #endif /* _ASM_LOONGARCH_ACENV_H */
> >
> > I am seeing several ACPI errors in my QEMU testing after this change in
> > Linus's tree as commit a9d13433fe17 ("LoongArch: Align ACPI structures
> > if ARCH_STRICT_ALIGN enabled").
> >
> >   $ make -skj"$(nproc)" ARCH=loongarch CROSS_COMPILE=loongarch64-linux- clean defconfig vmlinuz.efi
> >   kernel/sched/fair.o: warning: objtool: sched_update_scaling() falls through to next function init_entity_runnable_average()
> >   mm/mempolicy.o: warning: objtool: alloc_pages_bulk_mempolicy_noprof+0x380: stack state mismatch: reg1[30]=-1+0 reg2[30]=-2-80
> >   lib/crypto/mpi/mpih-div.o: warning: objtool: mpihelp_divrem+0x2d0: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-16
> >   In file included from include/acpi/acpi.h:24,
> >                    from drivers/acpi/acpica/tbprint.c:10:
> >   drivers/acpi/acpica/tbprint.c: In function 'acpi_tb_print_table_header':
> >   include/acpi/actypes.h:530:43: warning: 'strncmp' argument 1 declared attribute 'nonstring' is smaller than the specified bound 8 [-Wstringop-overread]
> >     530 | #define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
> >         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   drivers/acpi/acpica/tbprint.c:105:20: note: in expansion of macro 'ACPI_VALIDATE_RSDP_SIG'
> >     105 |         } else if (ACPI_VALIDATE_RSDP_SIG(ACPI_CAST_PTR(struct acpi_table_rsdp,
> >         |                    ^~~~~~~~~~~~~~~~~~~~~~
> >   In file included from include/acpi/acpi.h:26:
> >   include/acpi/actbl.h:69:14: note: argument 'signature' declared here
> >      69 |         char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;       /* ASCII table signature */
> >         |              ^~~~~~~~~
> >From this link this seems a comiler issue (at least not an
> arch-specific kernel issue):
> https://github.com/AOSC-Tracking/linux/commit/1e9ee413357ef58dd902f6ec55013d2a2f2043eb
> 

I see that the patch made it into the upstream kernel, now breaking both
mainline and 6.16.y test builds of loongarch64:allmodconfig with gcc.

Since this is apparently intentional, I'll stop build testing
loongarch64:allmodconfig. So far it looks like my qemu tests
are not affected, so I'll continue testing those for the time being.

Guenter

