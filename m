Return-Path: <stable+bounces-164985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6470B13F10
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 17:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C53F3AF17F
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79F0273811;
	Mon, 28 Jul 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4eP9emY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE94270EAE;
	Mon, 28 Jul 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717367; cv=none; b=RJTFBZFpwoREZDRkhbAPapPNQKgAUBxyHz9ZfHXiBqjBLy5c9VKZjTcnUOZUNh5F5Zm7yXRLqN88ENFDPciOJ6gqd18yqOqa3L36MtCJ7BAR2UFqNK//T8+o0HlSuBqynbD+bTBEanWgXHQw53HTe0k2vyDfcosrZTWN+l6ri40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717367; c=relaxed/simple;
	bh=w3T0G06ESTOQ1EHtto0LS3ZwEyHFZAzov8Mufn50fBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKa8z7zcE6wfeqZMGdp6YL5vhXtXFOT1VcR6Jvs8D2yIOpc8sQrv7SP2NTEgcbNPGdk649Vx5Fo4IBh1zzGAib7WgQm8Lc8AG3Oj4leNSQFltZeT3eoV/OYMsbsbm5/zabzVbQDfelNeU8k66La/2whByNWl5g61Fb8b+fZ1hCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4eP9emY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A397C4CEE7;
	Mon, 28 Jul 2025 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753717367;
	bh=w3T0G06ESTOQ1EHtto0LS3ZwEyHFZAzov8Mufn50fBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4eP9emYwGAp2iaGGtsqIIr3Idk+4EPUPnL8JUqix7WxrsW36kWPIOqscfuy+dglA
	 sQdE7s0D5HSwDkg1PncqBwag/x1SMJHcKOr5LrVhcul1kF8/vdbri7gCN8NC2hALaU
	 aV7brQFMihupQ/Pi9CMUphLMa1k4X2WZkSgh9tItNRN9mmv1BQBB2jdJNJdEqW2/8b
	 llgmDI+h6+/qMd/fF6XXKyPokfvByFnLoz7dVk1E3+jfbHQE4Rr4a+hRlSeuVj45Jm
	 H3AXrCfrrYG8BopAddawpOTXG7SareJGK8mKeVuAV2MDcgTZ51P1iTGDNtqrkQsj5I
	 ioxR2VP6SSeSg==
Date: Mon, 28 Jul 2025 08:42:44 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Alan J. Wylie" <alan@wylie.me.uk>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: "stack state/frame" and "jump dest instruction" errors (was Re:
 Linux 6.16)
Message-ID: <hla34nepia6wyi2fndx5ynud4dagxd7j75xnkevtxt365ihkjj@4p746zsu6s6z>
References: <CAHk-=wh0kuQE+tWMEPJqCR48F4Tip2EeYQU-mi+2Fx_Oa1Ehbw@mail.gmail.com>
 <871pq06728.fsf@wylie.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871pq06728.fsf@wylie.me.uk>

On Mon, Jul 28, 2025 at 09:41:35AM +0100, Alan J. Wylie wrote:
> #regzbot introduced: 6.15.8..6.16
> 
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > It's Sunday afternoon, and the release cycle has come to an end. Last
> > week was nice and calm, and there were no big show-stopper surprises
> > to keep us from the regular schedule, so I've tagged and pushed out
> > 6.16 as planned.
> 
> Even after a "make mrproper" and "git clean -fxd" I'm seeing lots of
> warnings and errors.
> 
> can't find jump dest instruction
> stack state mismatch
> return with modified stack frame
> objtool: can't decode instruction
> can't find starting instruction
> 
> gcc (Gentoo Hardened 14.3.0 p8) 14.3.0
> 
> I selected "Y" to the new config option "X86_NATIVE_CPU"
> 
> CPU is AMD FX-8350
> 
> .config attached

The problem is likely that CONFIG_X86_NATIVE_CPU is using some
AMD-specific instruction(s) which objtool doesn't know how to decode.

Building with KCFLAGS="-march=bdver2", I see the following:

0000000000000150 <amd_uncore_df_ctx_scan>:
     150:	f3 0f 1e fa          	endbr64
     154:	e8 00 00 00 00       	call   159 <amd_uncore_df_ctx_scan+0x9>	155: R_X86_64_PLT32	__fentry__-0x4
     159:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 160 <amd_uncore_df_ctx_scan+0x10>	15c: R_X86_64_PC32	boot_cpu_data+0x2c
     160:	a9 00 00 00 01       	test   $0x1000000,%eax
     165:	74 64                	je     1cb <amd_uncore_df_ctx_scan+0x7b>
     167:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	16a: R_X86_64_32S	cpu_info
     16e:	89 f6                	mov    %esi,%esi
     170:	53                   	push   %rbx
     171:	83 3d 00 00 00 00 01 	cmpl   $0x1,0x0(%rip)        # 178 <amd_uncore_df_ctx_scan+0x28>	173: R_X86_64_PC32	.bss-0x5
     178:	48 8b 0c f5 00 00 00 00 	mov    0x0(,%rsi,8),%rcx	17c: R_X86_64_32S	__per_cpu_offset
     180:	49 89 f9             	mov    %rdi,%r9
     183:	44 8b 84 01 ec 00 00 00 	mov    0xec(%rcx,%rax,1),%r8d
     18b:	b8 04 00 00 00       	mov    $0x4,%eax
     190:	7e 1a                	jle    1ac <amd_uncore_df_ctx_scan+0x5c>
     192:	b8 22 00 00 80       	mov    $0x80000022,%eax
     197:	31 c9                	xor    %ecx,%ecx
     199:	0f a2                	cpuid
     19b:	48 8b 0c f5 00 00 00 00 	mov    0x0(,%rsi,8),%rcx	19f: R_X86_64_32S	__per_cpu_offset
     1a3:	8f ea 78 10 c3 0a 06 00 00 	bextr  $0x60a,%ebx,%eax
     1ac:	0f b6 c0             	movzbl %al,%eax
     1af:	45 0f b6 c0          	movzbl %r8b,%r8d
     1b3:	49 8b 11             	mov    (%r9),%rdx
     1b6:	49 c1 e0 30          	shl    $0x30,%r8
     1ba:	48 c1 e0 20          	shl    $0x20,%rax
     1be:	4c 09 c0             	or     %r8,%rax
     1c1:	48 89 04 0a          	mov    %rax,(%rdx,%rcx,1)
     1c5:	5b                   	pop    %rbx
     1c6:	e9 00 00 00 00       	jmp    1cb <amd_uncore_df_ctx_scan+0x7b>	1c7: R_X86_64_PLT32	__x86_return_thunk-0x4
     1cb:	e9 00 00 00 00       	jmp    1d0 <amd_uncore_l3_event_init>	1cc: R_X86_64_PLT32	__x86_return_thunk-0x4

I don't have time to look at this for at least the next few days, but I
suspect this one:

     1a3:	8f ea 78 10 c3 0a 06 00 00 	bextr  $0x60a,%ebx,%eax

in which case the kernel's x86 decoder (which objtool also uses) needs
to be updated.

-- 
Josh

