Return-Path: <stable+bounces-184108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B6ABD06AA
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 18:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410873B8244
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9148828DF07;
	Sun, 12 Oct 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Wg0ZTk2q"
X-Original-To: stable@vger.kernel.org
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7681D516C;
	Sun, 12 Oct 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760284911; cv=none; b=kyfOBjkDnNdZR23a5mHaIQxLIFpQKK0l4EOhkbXWNsM4UN10NH2/zet1D6Gyx7pv1mNrlGynOAcpXOjNglGsggc5MsM2gzTEyz4e65Vut/hoAAlLrHTs1wWz5u0PMkc9Z4oLZEn09vUxuWjiL3419u/PsoZpqKQYoLrHH2g2Hhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760284911; c=relaxed/simple;
	bh=iv14ocH6KSu52eTqBSF9CBlgjFA98VB9GM5eJGsr38w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=U7V6Uwaj2dXQdVWH5q3V32ZIZsSp/h6d1BZnVl4ZfZLN2+DljWCLWjoii/2H3YjCcA8Nzk5yQ5ABi5bc7Mer7bOLeKNxzHgEu39WcR4tYk6rgVcayR7FRDB1OJzOaZoPebo0ZAsJLzz4xh1FAigjPxcUqXgwpTfvib9pM+NFT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Wg0ZTk2q; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59CG09ec786832
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 12 Oct 2025 09:00:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59CG09ec786832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760284810;
	bh=S2iXanXsOz4MqLT6rCWs0mUFWgjhfkWmcEnD42OkNks=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Wg0ZTk2qIMdEGIftDedwZhAH6Ql76rNNSWpo5tShlgdnsHbVlQyt3YqOi/LhJGCik
	 WFIgWJhumGFuXed+UoQQh/EXJ6aPU1khiBlRMMP4Z8Uot0hrDftf2Nhh8l5kAnmzRV
	 /S+trEnQiNObe0cX2jckLBmOpVjoThTFFJ4/WtBC5KyT3rwEIdd77q8G5rwl6qaSWx
	 p4sDu2Ih1tAf+8fo5wcMBb+E1kGQaL6xRLqJx4w94d73KEbwBkGfG/7i/aHCCMl1wZ
	 nAICoLheRMZQXYNyRg6JzUqHVHolYD1Hyhe9HAmUFuKgRu8QYdXrtev8OAVuHL40oh
	 MnnkPnCD4Qa9A==
Date: Sun, 12 Oct 2025 09:00:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        stable-commits@vger.kernel.org, ubizjak@gmail.com
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_Patch_=22x86/vdso=3A_Fix_output_operand_size_o?=
 =?US-ASCII?Q?f_RDPID=22_has_been_added_to_the_6=2E16-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251012142017.2901623-1-sashal@kernel.org>
References: <20251012142017.2901623-1-sashal@kernel.org>
Message-ID: <723ACFFB-1E5A-45ED-8753-9044A645D5C7@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 12, 2025 7:20:16 AM PDT, Sasha Levin <sashal@kernel=2Eorg> wrote=
:
>This is a note to let you know that I've just added the patch titled
>
>    x86/vdso: Fix output operand size of RDPID
>
>to the 6=2E16-stable tree which can be found at:
>    http://www=2Ekernel=2Eorg/git/?p=3Dlinux/kernel/git/stable/stable-que=
ue=2Egit;a=3Dsummary
>
>The filename of the patch is:
>     x86-vdso-fix-output-operand-size-of-rdpid=2Epatch
>and it can be found in the queue-6=2E16 subdirectory=2E
>
>If you, or anyone else, feels it should not be added to the stable tree,
>please let <stable@vger=2Ekernel=2Eorg> know about it=2E
>
>
>
>commit 9e09c5e5e76f1bb0480722f36d5a266d2faaf00d
>Author: Uros Bizjak <ubizjak@gmail=2Ecom>
>Date:   Mon Jun 16 11:52:57 2025 +0200
>
>    x86/vdso: Fix output operand size of RDPID
>   =20
>    [ Upstream commit ac9c408ed19d535289ca59200dd6a44a6a2d6036 ]
>   =20
>    RDPID instruction outputs to a word-sized register (64-bit on x86_64 =
and
>    32-bit on x86_32)=2E Use an unsigned long variable to store the corre=
ct size=2E
>   =20
>    LSL outputs to 32-bit register, use %k operand prefix to always print=
 the
>    32-bit name of the register=2E
>   =20
>    Use RDPID insn mnemonic while at it as the minimum binutils version o=
f
>    2=2E30 supports it=2E
>   =20
>      [ bp: Merge two patches touching the same function into a single on=
e=2E ]
>   =20
>    Fixes: ffebbaedc861 ("x86/vdso: Introduce helper functions for CPU an=
d node number")
>    Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>    Signed-off-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>    Link: https://lore=2Ekernel=2Eorg/20250616095315=2E230620-1-ubizjak@g=
mail=2Ecom
>    Signed-off-by: Sasha Levin <sashal@kernel=2Eorg>
>
>diff --git a/arch/x86/include/asm/segment=2Eh b/arch/x86/include/asm/segm=
ent=2Eh
>index 77d8f49b92bdd=2E=2Ef59ae7186940a 100644
>--- a/arch/x86/include/asm/segment=2Eh
>+++ b/arch/x86/include/asm/segment=2Eh
>@@ -244,7 +244,7 @@ static inline unsigned long vdso_encode_cpunode(int c=
pu, unsigned long node)
>=20
> static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
> {
>-	unsigned int p;
>+	unsigned long p;
>=20
> 	/*
> 	 * Load CPU and node number from the GDT=2E  LSL is faster than RDTSCP
>@@ -254,10 +254,10 @@ static inline void vdso_read_cpunode(unsigned *cpu,=
 unsigned *node)
> 	 *
> 	 * If RDPID is available, use it=2E
> 	 */
>-	alternative_io ("lsl %[seg],%[p]",
>-			"=2Ebyte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
>+	alternative_io ("lsl %[seg],%k[p]",
>+			"rdpid %[p]",
> 			X86_FEATURE_RDPID,
>-			[p] "=3Da" (p), [seg] "r" (__CPUNODE_SEG));
>+			[p] "=3Dr" (p), [seg] "r" (__CPUNODE_SEG));
>=20
> 	if (cpu)
> 		*cpu =3D (p & VDSO_CPUNODE_MASK);

What the actual hell?!

Doesn't *anyone* know that x86 zero-extends a 32-bit value to 64 bits?=20

All this code does is put a completely unnecessary REX prefix on RDPID=2E

