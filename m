Return-Path: <stable+bounces-184109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B5BD06B9
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 18:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 903124E254A
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B601FC0EA;
	Sun, 12 Oct 2025 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6IbDTds"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812812B94
	for <stable@vger.kernel.org>; Sun, 12 Oct 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760285204; cv=none; b=O5mRY4So8tbohp8Yis8/aeXN09TYjyMhI9VaUaMxvFahrI52Aq4MjL+BiAyvN5IDGIYhpi0G7ka4H7ejzxJE6ArTuHvVi1y/bXriFiKwD5pOS2LYPDfDRUEegl0YcFpFduKxSQEKjA+Oco4GzQqK9ta5VugZKMOeGAIEYqnHZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760285204; c=relaxed/simple;
	bh=amflGvejSwbOAN4btIxMsTpVU60pAsWVsErUT2c9i6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0z2cJYElH/ylST/wYvcpswSIBjaLow1EeaFXTa9d1JWGKs2YjmBLc7V6I4F1UZzyLMhupJVD50F3+Li1jndjxEuaTR7oDsjWY7F8a+kF/A2+R6N11A4BCTh1b0UM+CKv/29D2I2Q+T5idk3V0jUYpbRBGowBwKzXt92H7+gTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6IbDTds; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-36a6a397477so35498471fa.3
        for <stable@vger.kernel.org>; Sun, 12 Oct 2025 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760285201; x=1760890001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40chywztAP64H86OZ45wnSFoMgeTGQrxMSotEsPv9a0=;
        b=Y6IbDTdskemaWWFHolIWzBUPq6/LXpVbBJ01r5qGrMyCv983v67/GlGbQkMHmkvnIz
         UCf4icxv3Li8jB0w9xTe3gp9ghzna5Qe9C/WDr+9yjI4OSqAFz/msUd/WEVU9tQwJyod
         Bu71nj2vqt0tIyhW0K/AgJ1gNfIKjxs3jmNTltI+6aBbNY4CTo8s308wBWnnyigrLb4S
         VWwHC4b31AOhX0lFb/6eDv5BQ08XA9VaW6MXSueoOIMHT0xPgiO07ZoSNZ/xOgYmJVhy
         mpo+l+lquDDvnDLoM8CE7KhO+6QBQFZoUhSe2QtxIcVSuiijFghHj4q11DalU0gP77gh
         EpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760285201; x=1760890001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40chywztAP64H86OZ45wnSFoMgeTGQrxMSotEsPv9a0=;
        b=UsSaFrf3mBpySRm84JaHJ8FUxeazU4pdksueAJcOwrTH1XI59NDUfEdtLj5aE8Mk5E
         XPqlsjMiQ8AOWuASO1jkgnUIC9RDtph8d6XpzrPZQFb1GzPgW+MeN54ureyfBRNLCCnd
         2BzLXjMivrnpW0f4Dj5atVIdV4YzQKQFNtc1bcKkLg+oFmFF/Ec321tAK7vFwZSeFNZV
         5UmubKuNdwj9zWMk3zSStFc39DiUkjau06E+kf4pszjUMNTDJKyOu0M0O1jIJHycxzg/
         IC+JIolaS4X32/u5eJqWZvAEJn4+2grtv8jgBIF3U4Rabq6pEl0OaI4TvxqdjQ9BLFDW
         4vWg==
X-Gm-Message-State: AOJu0YyqRO7Y/1v9wmbqo0Mdlv/M5nz5DUBI3wcZNWCtBH11ey85tCpX
	hddCMiNRwEzFAabujl75/O4EQF4YwKRMLLRaK3MJJdIz68DjZs7j7I/CMRC1SPycu5CpYWPKxMA
	NF09jSbuyQfp8b7hA6sUBQ0CK7O0PtJw=
X-Gm-Gg: ASbGncsNUcT6T6OIz24ZlMKYK4O8UfF9BPJldhvSNfUD/scsY4591Ai32ZL3eI7NxTh
	P6mdpeXHgHnWAAO6IepcF6OcgLNdy98Qoqf3Oh2PuGDW7/+XzrVQk2Eb7Igmd6ofxULKMKjQD0b
	vgbGZg9I6+aZ5EDvercqHh1wJdTmw+9T9PYGhqUawu2Z7AAyrHUZbGLX2TFw5Pg7wRsA+Va7EtW
	fZEFSEKpzx3Vh4okDZH+QPi4VxrdBDMFW/hkqXuIQNYLXQ=
X-Google-Smtp-Source: AGHT+IH8r62FvMlzwfvIYc72SXBmGUxPnNf/INqHpn/LwOiiGHTiLd2TgbP1wn/oDxgzAxDpM7CY8NGWSGQWUiwPn3w=
X-Received: by 2002:a05:651c:2119:b0:36b:b0eb:9d65 with SMTP id
 38308e7fff4ca-37609d67792mr44020051fa.10.1760285200528; Sun, 12 Oct 2025
 09:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012142017.2901623-1-sashal@kernel.org> <723ACFFB-1E5A-45ED-8753-9044A645D5C7@zytor.com>
In-Reply-To: <723ACFFB-1E5A-45ED-8753-9044A645D5C7@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 12 Oct 2025 18:06:29 +0200
X-Gm-Features: AS18NWBjaZEs58SUcXb7mz5Iv8njJ5iwHew4OESPHb7XJ3Xb6Wt9VYqgS8zlPQ4
Message-ID: <CAFULd4b1oey5YntK9aY0HubiE21gQWqToC7F4HUCYX0GKEKuSQ@mail.gmail.com>
Subject: Re: Patch "x86/vdso: Fix output operand size of RDPID" has been added
 to the 6.16-stable tree
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	stable-commits@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 6:00=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On October 12, 2025 7:20:16 AM PDT, Sasha Levin <sashal@kernel.org> wrote=
:
> >This is a note to let you know that I've just added the patch titled
> >
> >    x86/vdso: Fix output operand size of RDPID
> >
> >to the 6.16-stable tree which can be found at:
> >    http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.=
git;a=3Dsummary
> >
> >The filename of the patch is:
> >     x86-vdso-fix-output-operand-size-of-rdpid.patch
> >and it can be found in the queue-6.16 subdirectory.
> >
> >If you, or anyone else, feels it should not be added to the stable tree,
> >please let <stable@vger.kernel.org> know about it.
> >
> >
> >
> >commit 9e09c5e5e76f1bb0480722f36d5a266d2faaf00d
> >Author: Uros Bizjak <ubizjak@gmail.com>
> >Date:   Mon Jun 16 11:52:57 2025 +0200
> >
> >    x86/vdso: Fix output operand size of RDPID
> >
> >    [ Upstream commit ac9c408ed19d535289ca59200dd6a44a6a2d6036 ]
> >
> >    RDPID instruction outputs to a word-sized register (64-bit on x86_64=
 and
> >    32-bit on x86_32). Use an unsigned long variable to store the correc=
t size.
> >
> >    LSL outputs to 32-bit register, use %k operand prefix to always prin=
t the
> >    32-bit name of the register.
> >
> >    Use RDPID insn mnemonic while at it as the minimum binutils version =
of
> >    2.30 supports it.
> >
> >      [ bp: Merge two patches touching the same function into a single o=
ne. ]
> >
> >    Fixes: ffebbaedc861 ("x86/vdso: Introduce helper functions for CPU a=
nd node number")
> >    Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> >    Link: https://lore.kernel.org/20250616095315.230620-1-ubizjak@gmail.=
com
> >    Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segme=
nt.h
> >index 77d8f49b92bdd..f59ae7186940a 100644
> >--- a/arch/x86/include/asm/segment.h
> >+++ b/arch/x86/include/asm/segment.h
> >@@ -244,7 +244,7 @@ static inline unsigned long vdso_encode_cpunode(int =
cpu, unsigned long node)
> >
> > static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
> > {
> >-      unsigned int p;
> >+      unsigned long p;
> >
> >       /*
> >        * Load CPU and node number from the GDT.  LSL is faster than RDT=
SCP
> >@@ -254,10 +254,10 @@ static inline void vdso_read_cpunode(unsigned *cpu=
, unsigned *node)
> >        *
> >        * If RDPID is available, use it.
> >        */
> >-      alternative_io ("lsl %[seg],%[p]",
> >-                      ".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
> >+      alternative_io ("lsl %[seg],%k[p]",
> >+                      "rdpid %[p]",
> >                       X86_FEATURE_RDPID,
> >-                      [p] "=3Da" (p), [seg] "r" (__CPUNODE_SEG));
> >+                      [p] "=3Dr" (p), [seg] "r" (__CPUNODE_SEG));
> >
> >       if (cpu)
> >               *cpu =3D (p & VDSO_CPUNODE_MASK);
>
> What the actual hell?!
>
> Doesn't *anyone* know that x86 zero-extends a 32-bit value to 64 bits?

Yes, this is what %k does with LSL.

> All this code does is put a completely unnecessary REX prefix on RDPID.

No, it doesn't.

$ more rdpid.s
       rdpid %eax
$ gcc -c rdpid.s
rdpid.s: Assembler messages:
rdpid.s:1: Error: operand size mismatch for `rdpid'

$ more rdpid.s
       rdpid %rax
$ gcc -c rdpid.s
$ objdump -dr rdpid.o

rdpid.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <.text>:
  0:   f3 0f c7 f8             rdpid  %rax

Uros.

