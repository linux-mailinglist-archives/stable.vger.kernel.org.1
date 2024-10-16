Return-Path: <stable+bounces-86425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C1499FEAD
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 04:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EBE8B2458F
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 02:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99F158D93;
	Wed, 16 Oct 2024 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/gAVy8Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FFF1586D3;
	Wed, 16 Oct 2024 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044648; cv=none; b=oQeHDqDZ6oIGY4GrmfVWfUApAreB3h9GgRBodt0YBvT7mXXp7H50XkPsQtBKoP8luH+ap6uEythI38gVcmqG88QVNPJj1aumflL7vuy4ulH+eHVEUH2JhrUfupTi9/Oja8vCVlGHQoDkIyLyeEqu7lBDyKQ7IR1rOa7p0f6LNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044648; c=relaxed/simple;
	bh=JkUIGZNfmaj7qem7eaChoukIOjSZILLEEE0eS94aM58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDMxkS19dn4ImeohZuvA2niG/6dm0vnOHWNNfZYBsgCzcfJKpUo56nTAscxZVlpTBmWelgZnAA/qpFBfwtY6tGYh2d5h4RilQdEbfmegul8+v8uJrmmecow3iR6LjiF0TB52xP1R1K5c59Mvhf7DtgdBJaVscTklCH0QQef60c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/gAVy8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2835C4CEC6;
	Wed, 16 Oct 2024 02:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729044648;
	bh=JkUIGZNfmaj7qem7eaChoukIOjSZILLEEE0eS94aM58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/gAVy8YxNjwbTlTatVY2kT3t/dj5nfy4x4C4clrwBwimQpbJSogH7LRb0ln/8dCF
	 l3qajIB9MLDv2QJ0sUTAdnGEq8I+o1Dwf6OB2jg4TxhwEj1pxLNxKT/vuP8aZohrcb
	 9rXoxOCm6JwsiVr5rFirbIPqrwCMSMQ0BsJVZXU37TIopDkfnYtFihl0/yDUAem5OI
	 me1JGRAGo/kXVod9WsKl/BpoYw3RTIK8VquLdiXXi1fDtsb01mibFfipaemEfpgRnJ
	 645IlC93qY0vVNpqJqPV0O7CPhRaciVqe7YSt93ZaZJ3RpOSOLmf//sHBCAwt2MYJu
	 Lzpu8bTXRu1ug==
Date: Tue, 15 Oct 2024 19:10:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	x86@kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] x86/stackprotector: Work around strict Clang TLS
 symbol requirements
Message-ID: <20241016021045.GA1000009@thelio-3990X>
References: <20241009124352.3105119-2-ardb+git@google.com>
 <202410141357.3B2A71A340@keescook>
 <CAMj1kXF7aFyBOOxQQsvsAsnvo3FYrkU=KA1BiMeSuKq1KHC1qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF7aFyBOOxQQsvsAsnvo3FYrkU=KA1BiMeSuKq1KHC1qA@mail.gmail.com>

On Tue, Oct 15, 2024 at 12:56:57PM +0200, Ard Biesheuvel wrote:
> On Mon, 14 Oct 2024 at 22:59, Kees Cook <kees@kernel.org> wrote:
> >
> > On Wed, Oct 09, 2024 at 02:43:53PM +0200, Ard Biesheuvel wrote:
> > > However, if a non-TLS definition of the symbol in question is visible in
> > > the same compilation unit (which amounts to the whole of vmlinux if LTO
> > > is enabled), it will drop the per-CPU prefix and emit a load from a
> > > bogus address.
> >
> > I take this to mean that x86 32-bit kernels built with the stack
> > protector and using Clang LTO will crash very quickly?
> >
> 
> Yeah. The linked issue is not quite clear, but it does suggest things
> are pretty broken in that case.

Yeah, i386_defconfig with CONFIG_LTO_CLANG_FULL=y explodes on boot for
me without this change:

  [    0.000000] Linux version 6.12.0-rc3-00044-g2f87d0916ce0 (nathan@thelio-3990X) (ClangBuiltLinux clang version 19.1.2 (https://github.com/llvm/llvm-project.git 7ba7d8e2f7b6445b60679da826210cdde29eaf8b), ClangBuiltLinux LLD 19.1.2 (https://github.com/llvm/llvm-project.git 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)) #1 SMP PREEMPT_DYNAMIC Tue Oct 15 19:00:21 MST 2024
  ...
  [    0.631002] Freeing unused kernel image (initmem) memory: 936K
  [    0.631613] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: free_initmem+0x95/0x98
  [    0.632606] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc3-00044-g2f87d0916ce0 #1
  [    0.633467] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
  [    0.634583] Call Trace:
  [    0.634837]  panic+0xd4/0x2cc
  [    0.635146]  ? _vdso_rng_data+0xd80/0xd80
  [    0.635550]  ? _vdso_rng_data+0xd80/0xd80
  [    0.635965]  ? rest_init+0xb0/0xb0
  [    0.636312]  __stack_chk_fail+0x10/0x10
  [    0.636701]  ? free_initmem+0x95/0x98
  [    0.637074]  free_initmem+0x95/0x98
  [    0.637434]  ? _vdso_rng_data+0xd80/0xd80
  [    0.637838]  ? rest_init+0xb0/0xb0
  [    0.638196]  kernel_init+0x42/0x1e4
  [    0.638558]  ret_from_fork+0x2b/0x40
  [    0.638922]  ret_from_fork_asm+0x12/0x18
  [    0.639331]  entry_INT80_32+0x108/0x108
  [    0.639864] Kernel Offset: disabled
  [    0.640224] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: free_initmem+0x95/0x98 ]---

I can confirm that this patch resolves that issue for me and LKDTM's
REPORT_STACK_CANARY test passes with that configuration.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

I presume the '#ifndef CONFIG_X86_64' in arch/x86/entry/entry.S is
present because only X86_32 uses '-mstack-protector-guard-reg='? I
assume that will disappear when X86_64 supports this option (IIRC that
was the plan)?

Cheers,
Nathan

