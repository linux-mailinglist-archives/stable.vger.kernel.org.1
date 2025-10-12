Return-Path: <stable+bounces-184111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0707ABD06C5
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 18:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B57A3BAAA2
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502F31F4CB7;
	Sun, 12 Oct 2025 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCBEqRPc"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DBD17A303
	for <stable@vger.kernel.org>; Sun, 12 Oct 2025 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760285714; cv=none; b=FoR5CClh1Bohwtz3rXnjHFaDCJh8jio3lhjX0Ke7b23d3CTrkSKKzcQPa00Tu1Lu52Oe6/Q4XqMAWH1tOcpOlUFdIxWbF8Pq2Ih++t+IJBX7ASugIBGYTVadnQJyMom7Qa+1Hdo9phIm4tF/YIQ29srqACZHQKekXyzfj0azSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760285714; c=relaxed/simple;
	bh=yhxNHVeovF7dDgZDeFkhQdOTKewIjqAvQPgvb2yG1ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5WDgUsXjpzlmLw1s8jlC/NHmWlBVI16JzxSMkVXCDdbk3yOCAVDv6aKGaeAwEZMk835cSUpAf6O6VEbfJ0QoU3dlXMrsvOBXTBpaQDLDxusiNpXAWy+/WoqP/OZQG3xcaWkXD0BFX94VIQBwn9PBwPEcqV7dQGFq5pmtYgEciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCBEqRPc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57992ba129eso4292441e87.3
        for <stable@vger.kernel.org>; Sun, 12 Oct 2025 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760285710; x=1760890510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riAW0za8hovMZR9V0nD66JiUWa90XkeqB5N4U805HMI=;
        b=YCBEqRPcMFXrsvXoG1MW8J6zJ4fAbAAe0EMK6zRn9e5pfVmXRuSGOaqVul8oOBvBql
         XVnfMSFIgpAArmYCUro4t/t4qEqXq3wJUZnmXMfMwENFPlS2UedPIAmsViHrLD758ca4
         jFzceqz358t7jQQgqewzqDib8W2bPUzHqPPEWLXaRYjZf/DeGPoIaPFeS1eRHhYcYKkN
         R6lv0RvsEWbWidpfNsAOxxM3teHUingn0Ft0YdrQZfOc3RZQZRFqnJn071pMToiuk2Ct
         if1/7RrhRk0/HBuyykWQYhLw6evk+TgUWQ8UmTSwBzPNuVfo7pvnrdl3kkAwjkRj30aA
         cdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760285710; x=1760890510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riAW0za8hovMZR9V0nD66JiUWa90XkeqB5N4U805HMI=;
        b=cQVbB2CAO1Fvivgty0xRX0e06uiNFKeEwJMwO3WrMUpGa/dGNScRDM2fO25gzluCrr
         kWK1QWZ5xMsfU1GJ3NKKfGqAcj1zQ3dhWdqMDJwgQ4jP9SmPIBuariYLAa6uLNBA+HJg
         /YqnmAMx02XXJZJXdy5v3ogtQVy31BXk5yN8TunJ+P1il5+rWgdWydVNwfSnF1GMfQ/p
         kMoKw2K4jKvWRSHZ+HMG31N5bvoP/9v19LQFO3Tf9V5JvaaP2pkYr2kqtnwwZrOZtCsw
         6Rkxa/czfV85R/dbJlODvEKgrhvnXSVysxtJvSEmXN/ZDLquksSi7/4NaIfajbGcZEnl
         GQ3Q==
X-Gm-Message-State: AOJu0YwK0HylY6nxFwD15IIGV+yIPXs6GQyE60d4kKZxMYrUwkQOFPih
	arpdHTjZ5Y7aBBsO4TcdyKLXOvjHdV+ym1tEYdxM/9FXj8a2yfNgvc+fVFOp7M9ullLUSYQz0sP
	Kai381ZmDIpKPEIsXosIhtu5lqVVLwrw=
X-Gm-Gg: ASbGncvQeg+W59h30IZ2bWOIVDk/w2lKtwtYPwMtYBR/GDUoon27MygTjcxsYbDA/WC
	M3qIXJ9Uw0WrA1b0VaQRpdf2wUl0pyuLMhLxb9F/LyPPaov38USdGfJVTbzPCCNIGTd0AqNyPTE
	lFhoUOIKh3fqSXI1NnJuj6gETMb/hm6tdUV3Md/XPFE6NiLcf1iRS4lIsC5tPZ77W/Z8V7YkPwB
	NXa7NvxCMlcR1A6W+9NxRqUYUDV8dbi2HVqAdno3Ruoa2s=
X-Google-Smtp-Source: AGHT+IFltioM6f7wYP5B4zt7J7Jkv2DzFAWfDGz3bDqxppF+wU//9RD0O6A/TUVoUKeGRxuZj1YRReSoMWGLTvaAS4Y=
X-Received: by 2002:a2e:be0d:0:b0:372:8d1d:6952 with SMTP id
 38308e7fff4ca-37609f04d85mr48943951fa.41.1760285709967; Sun, 12 Oct 2025
 09:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012142017.2901623-1-sashal@kernel.org> <723ACFFB-1E5A-45ED-8753-9044A645D5C7@zytor.com>
 <CAFULd4b1oey5YntK9aY0HubiE21gQWqToC7F4HUCYX0GKEKuSQ@mail.gmail.com> <627794F9-8F8C-409B-876B-BF465D8A12C9@zytor.com>
In-Reply-To: <627794F9-8F8C-409B-876B-BF465D8A12C9@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 12 Oct 2025 18:14:57 +0200
X-Gm-Features: AS18NWA3aFwDpd6Ovz_ecbwnoga0BjA7PQVz9HKCnKaLR8j_H0xxIvDF6n7jG0w
Message-ID: <CAFULd4a3Yb8g0VP7fcvnqe20k-rUdOyanSTx+9Sfc0sUmWvPUA@mail.gmail.com>
Subject: Re: Patch "x86/vdso: Fix output operand size of RDPID" has been added
 to the 6.16-stable tree
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	stable-commits@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 6:10=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On October 12, 2025 9:06:29 AM PDT, Uros Bizjak <ubizjak@gmail.com> wrote=
:
> >On Sun, Oct 12, 2025 at 6:00=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> w=
rote:
> >>
> >> On October 12, 2025 7:20:16 AM PDT, Sasha Levin <sashal@kernel.org> wr=
ote:
> >> >This is a note to let you know that I've just added the patch titled
> >> >
> >> >    x86/vdso: Fix output operand size of RDPID
> >> >
> >> >to the 6.16-stable tree which can be found at:
> >> >    http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-que=
ue.git;a=3Dsummary
> >> >
> >> >The filename of the patch is:
> >> >     x86-vdso-fix-output-operand-size-of-rdpid.patch
> >> >and it can be found in the queue-6.16 subdirectory.
> >> >
> >> >If you, or anyone else, feels it should not be added to the stable tr=
ee,
> >> >please let <stable@vger.kernel.org> know about it.
> >> >
> >> >
> >> >
> >> >commit 9e09c5e5e76f1bb0480722f36d5a266d2faaf00d
> >> >Author: Uros Bizjak <ubizjak@gmail.com>
> >> >Date:   Mon Jun 16 11:52:57 2025 +0200
> >> >
> >> >    x86/vdso: Fix output operand size of RDPID
> >> >
> >> >    [ Upstream commit ac9c408ed19d535289ca59200dd6a44a6a2d6036 ]
> >> >
> >> >    RDPID instruction outputs to a word-sized register (64-bit on x86=
_64 and
> >> >    32-bit on x86_32). Use an unsigned long variable to store the cor=
rect size.
> >> >
> >> >    LSL outputs to 32-bit register, use %k operand prefix to always p=
rint the
> >> >    32-bit name of the register.
> >> >
> >> >    Use RDPID insn mnemonic while at it as the minimum binutils versi=
on of
> >> >    2.30 supports it.
> >> >
> >> >      [ bp: Merge two patches touching the same function into a singl=
e one. ]
> >> >
> >> >    Fixes: ffebbaedc861 ("x86/vdso: Introduce helper functions for CP=
U and node number")
> >> >    Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >> >    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> >> >    Link: https://lore.kernel.org/20250616095315.230620-1-ubizjak@gma=
il.com
> >> >    Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> >
> >> >diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/se=
gment.h
> >> >index 77d8f49b92bdd..f59ae7186940a 100644
> >> >--- a/arch/x86/include/asm/segment.h
> >> >+++ b/arch/x86/include/asm/segment.h
> >> >@@ -244,7 +244,7 @@ static inline unsigned long vdso_encode_cpunode(i=
nt cpu, unsigned long node)
> >> >
> >> > static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
> >> > {
> >> >-      unsigned int p;
> >> >+      unsigned long p;
> >> >
> >> >       /*
> >> >        * Load CPU and node number from the GDT.  LSL is faster than =
RDTSCP
> >> >@@ -254,10 +254,10 @@ static inline void vdso_read_cpunode(unsigned *=
cpu, unsigned *node)
> >> >        *
> >> >        * If RDPID is available, use it.
> >> >        */
> >> >-      alternative_io ("lsl %[seg],%[p]",
> >> >-                      ".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax=
 */
> >> >+      alternative_io ("lsl %[seg],%k[p]",
> >> >+                      "rdpid %[p]",
> >> >                       X86_FEATURE_RDPID,
> >> >-                      [p] "=3Da" (p), [seg] "r" (__CPUNODE_SEG));
> >> >+                      [p] "=3Dr" (p), [seg] "r" (__CPUNODE_SEG));
> >> >
> >> >       if (cpu)
> >> >               *cpu =3D (p & VDSO_CPUNODE_MASK);
> >>
> >> What the actual hell?!
> >>
> >> Doesn't *anyone* know that x86 zero-extends a 32-bit value to 64 bits?
> >
> >Yes, this is what %k does with LSL.
> >
> >> All this code does is put a completely unnecessary REX prefix on RDPID=
.
> >
> >No, it doesn't.
> >
> >$ more rdpid.s
> >       rdpid %eax
> >$ gcc -c rdpid.s
> >rdpid.s: Assembler messages:
> >rdpid.s:1: Error: operand size mismatch for `rdpid'
> >
> >$ more rdpid.s
> >       rdpid %rax
> >$ gcc -c rdpid.s
> >$ objdump -dr rdpid.o
> >
> >rdpid.o:     file format elf64-x86-64
> >
> >
> >Disassembly of section .text:
> >
> >0000000000000000 <.text>:
> >  0:   f3 0f c7 f8             rdpid  %rax
> >
> >Uros.
> >
>
> Ok, that's just gas being stupid and overinterpreting the fuzzy language =
in the SDM, then. It would have been a very good thing to put in the commit=
 or, even better, a comment.

SDM says:

Opcode/Instruction  |  Op/En  |  64/32-bit Mode  |  CPUID Feature Flag
 |  Description
F3 0F C7 /7  |  RDPID r32  |  R  |  N.E./V  |  RDPID  |  Read
IA32_TSC_AUX into r32.
F3 0F C7 /7  |  RDPID r64  |  R  |  V/N.E.  |  RDPID  |  Read
IA32_TSC_AUX into r64.

So, it is perfectly clear from the Mode column that r32 is not
available in 64-bit mode and vice versa.

Uros.

