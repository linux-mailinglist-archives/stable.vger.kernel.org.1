Return-Path: <stable+bounces-184113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6E6BD06F6
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 18:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5FC3BB67A
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346EF2ED855;
	Sun, 12 Oct 2025 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bXm2Jar2"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF382ECD03;
	Sun, 12 Oct 2025 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760285969; cv=none; b=XS/5Zh9Dri0ouHMLZbaukZ1z31N7Jk5nPPH2J7caRfim6iOwmxqa7PGgyRoHl8l6yHEVVritIh7HrtPcDEKcpfrXE1CqetqkWi1+czC+afY0yi6EV0VC1pTUBVuOCZgQTIDWeaf48OPwJ+Pas4t1RYuob6cxyUSzUth8xtgIOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760285969; c=relaxed/simple;
	bh=h3Sj/XDUFEz4CZ/isFnfq8OGOz2czET06Bd7xy4sABA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Mdo9RvJa3/0vpndIqY4rsN+t5r0FdZViI8CzMnIxHZ3QTa2QIQZWLK9alt68cMjDCidWCv+bjmjbdVMr1Fsw6Wo2BZ6BYqXY274UAzEIE8MHPKVQW38nBgWHSx2gGlDEVp4njC4ggAjZgPwKLnC0ti8rz4SGq8kTvUDNlqoDCCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bXm2Jar2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59CGIlKX794038
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 12 Oct 2025 09:18:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59CGIlKX794038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760285928;
	bh=fo2vTwYB47GMCmpMK3dbluFhWiTUa36CVYs3xjxXrn8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bXm2Jar2ojNZLMikyCD/bTy/SNcd/MIo4vKt0vWpTCmSYaxAD3ocwJ0MUZcfeJdrv
	 Z+JAE73Jg8lFvslh41hzO9Ynf/MpfEfr38xmY3K0vPwWbxRPxV/MKRoJ/nr0XHNgzM
	 VV8aRqkueP/P4l5OBmZ67eKevps9DwITahzvxIGpJnx9Ie0QunHou8GXl02MN7SeLm
	 6BDEAmlOWV0Ap+n/1Ar5ytrmTb1Jpo5hqqTu93DOARk7vbTFi4J3evFXXDAi8PDEfA
	 KXBvuo+BKBpjgxZYe+3au15AAdKuLntqSec7v2XIxNfhMKyTjYtXPKUkH9IstwhfjA
	 t8f3AB4NRR7KQ==
Date: Sun, 12 Oct 2025 09:18:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>
CC: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        stable-commits@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_Patch_=22x86/vdso=3A_Fix_output_operand_size_o?=
 =?US-ASCII?Q?f_RDPID=22_has_been_added_to_the_6=2E16-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4a3Yb8g0VP7fcvnqe20k-rUdOyanSTx+9Sfc0sUmWvPUA@mail.gmail.com>
References: <20251012142017.2901623-1-sashal@kernel.org> <723ACFFB-1E5A-45ED-8753-9044A645D5C7@zytor.com> <CAFULd4b1oey5YntK9aY0HubiE21gQWqToC7F4HUCYX0GKEKuSQ@mail.gmail.com> <627794F9-8F8C-409B-876B-BF465D8A12C9@zytor.com> <CAFULd4a3Yb8g0VP7fcvnqe20k-rUdOyanSTx+9Sfc0sUmWvPUA@mail.gmail.com>
Message-ID: <7BABC45F-CF0F-435D-B3B9-E931D7B9CBDB@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 12, 2025 9:14:57 AM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote=
:
>On Sun, Oct 12, 2025 at 6:10=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>
>> On October 12, 2025 9:06:29 AM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> w=
rote:
>> >On Sun, Oct 12, 2025 at 6:00=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=2E=
com> wrote:
>> >>
>> >> On October 12, 2025 7:20:16 AM PDT, Sasha Levin <sashal@kernel=2Eorg=
> wrote:
>> >> >This is a note to let you know that I've just added the patch title=
d
>> >> >
>> >> >    x86/vdso: Fix output operand size of RDPID
>> >> >
>> >> >to the 6=2E16-stable tree which can be found at:
>> >> >    http://www=2Ekernel=2Eorg/git/?p=3Dlinux/kernel/git/stable/stab=
le-queue=2Egit;a=3Dsummary
>> >> >
>> >> >The filename of the patch is:
>> >> >     x86-vdso-fix-output-operand-size-of-rdpid=2Epatch
>> >> >and it can be found in the queue-6=2E16 subdirectory=2E
>> >> >
>> >> >If you, or anyone else, feels it should not be added to the stable =
tree,
>> >> >please let <stable@vger=2Ekernel=2Eorg> know about it=2E
>> >> >
>> >> >
>> >> >
>> >> >commit 9e09c5e5e76f1bb0480722f36d5a266d2faaf00d
>> >> >Author: Uros Bizjak <ubizjak@gmail=2Ecom>
>> >> >Date:   Mon Jun 16 11:52:57 2025 +0200
>> >> >
>> >> >    x86/vdso: Fix output operand size of RDPID
>> >> >
>> >> >    [ Upstream commit ac9c408ed19d535289ca59200dd6a44a6a2d6036 ]
>> >> >
>> >> >    RDPID instruction outputs to a word-sized register (64-bit on x=
86_64 and
>> >> >    32-bit on x86_32)=2E Use an unsigned long variable to store the=
 correct size=2E
>> >> >
>> >> >    LSL outputs to 32-bit register, use %k operand prefix to always=
 print the
>> >> >    32-bit name of the register=2E
>> >> >
>> >> >    Use RDPID insn mnemonic while at it as the minimum binutils ver=
sion of
>> >> >    2=2E30 supports it=2E
>> >> >
>> >> >      [ bp: Merge two patches touching the same function into a sin=
gle one=2E ]
>> >> >
>> >> >    Fixes: ffebbaedc861 ("x86/vdso: Introduce helper functions for =
CPU and node number")
>> >> >    Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>> >> >    Signed-off-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>> >> >    Link: https://lore=2Ekernel=2Eorg/20250616095315=2E230620-1-ubi=
zjak@gmail=2Ecom
>> >> >    Signed-off-by: Sasha Levin <sashal@kernel=2Eorg>
>> >> >
>> >> >diff --git a/arch/x86/include/asm/segment=2Eh b/arch/x86/include/as=
m/segment=2Eh
>> >> >index 77d8f49b92bdd=2E=2Ef59ae7186940a 100644
>> >> >--- a/arch/x86/include/asm/segment=2Eh
>> >> >+++ b/arch/x86/include/asm/segment=2Eh
>> >> >@@ -244,7 +244,7 @@ static inline unsigned long vdso_encode_cpunode=
(int cpu, unsigned long node)
>> >> >
>> >> > static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node=
)
>> >> > {
>> >> >-      unsigned int p;
>> >> >+      unsigned long p;
>> >> >
>> >> >       /*
>> >> >        * Load CPU and node number from the GDT=2E  LSL is faster t=
han RDTSCP
>> >> >@@ -254,10 +254,10 @@ static inline void vdso_read_cpunode(unsigned=
 *cpu, unsigned *node)
>> >> >        *
>> >> >        * If RDPID is available, use it=2E
>> >> >        */
>> >> >-      alternative_io ("lsl %[seg],%[p]",
>> >> >-                      "=2Ebyte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax=
/rax */
>> >> >+      alternative_io ("lsl %[seg],%k[p]",
>> >> >+                      "rdpid %[p]",
>> >> >                       X86_FEATURE_RDPID,
>> >> >-                      [p] "=3Da" (p), [seg] "r" (__CPUNODE_SEG));
>> >> >+                      [p] "=3Dr" (p), [seg] "r" (__CPUNODE_SEG));
>> >> >
>> >> >       if (cpu)
>> >> >               *cpu =3D (p & VDSO_CPUNODE_MASK);
>> >>
>> >> What the actual hell?!
>> >>
>> >> Doesn't *anyone* know that x86 zero-extends a 32-bit value to 64 bit=
s?
>> >
>> >Yes, this is what %k does with LSL=2E
>> >
>> >> All this code does is put a completely unnecessary REX prefix on RDP=
ID=2E
>> >
>> >No, it doesn't=2E
>> >
>> >$ more rdpid=2Es
>> >       rdpid %eax
>> >$ gcc -c rdpid=2Es
>> >rdpid=2Es: Assembler messages:
>> >rdpid=2Es:1: Error: operand size mismatch for `rdpid'
>> >
>> >$ more rdpid=2Es
>> >       rdpid %rax
>> >$ gcc -c rdpid=2Es
>> >$ objdump -dr rdpid=2Eo
>> >
>> >rdpid=2Eo:     file format elf64-x86-64
>> >
>> >
>> >Disassembly of section =2Etext:
>> >
>> >0000000000000000 <=2Etext>:
>> >  0:   f3 0f c7 f8             rdpid  %rax
>> >
>> >Uros=2E
>> >
>>
>> Ok, that's just gas being stupid and overinterpreting the fuzzy languag=
e in the SDM, then=2E It would have been a very good thing to put in the co=
mmit or, even better, a comment=2E
>
>SDM says:
>
>Opcode/Instruction  |  Op/En  |  64/32-bit Mode  |  CPUID Feature Flag
> |  Description
>F3 0F C7 /7  |  RDPID r32  |  R  |  N=2EE=2E/V  |  RDPID  |  Read
>IA32_TSC_AUX into r32=2E
>F3 0F C7 /7  |  RDPID r64  |  R  |  V/N=2EE=2E  |  RDPID  |  Read
>IA32_TSC_AUX into r64=2E
>
>So, it is perfectly clear from the Mode column that r32 is not
>available in 64-bit mode and vice versa=2E
>
>Uros=2E
>

And it is complete bunk=2E Both cases output a 32-bit number, which gets z=
ero-extended to 64 bits in 64-bit mode just because that's how *everything*=
 is handled=2E=20

Whomever wrote that was trying to be helpful in the sense of telling peopl=
e not to put a bogus REX prefix=2E Unfortunately the SDM is full of that ki=
nd of stuff=2E

