Return-Path: <stable+bounces-268125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lt3VEbelO2ouawgAu9opvQ
	(envelope-from <stable+bounces-268125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:39:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C3A6BCFFA
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:39:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=BXJkkgGD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268125-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268125-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4736C3006443
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4C3AE184;
	Wed, 24 Jun 2026 09:38:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA339BFED;
	Wed, 24 Jun 2026 09:38:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293938; cv=none; b=lKcGK5f5HvQntY8lXKa9nSz3vgHbN2hSiC2e86jI91VtU4D/gIazyEvBPHGXUNdohITc5ETjlyWaO2gPWHBTFiWAvI88B4p9RFNSTRhAlPtk2Vl/9PnDZyQ4Q7C3HOnpkXqysr5259uNYAWSVppSVKwYcVk4PnFHWd5Ua9BpxoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293938; c=relaxed/simple;
	bh=Ig0qug2I/Az2rFpPjAA8R35/bN9spPpqR1YFwjD4zzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDjEFyWL8holBsBVy4Wcz4o/mI8X+fYHWEuGkVMf0hr+aA5OdT2HnTi5ZlNbOuP4fstflKHYlrGB5X5TBrzUoo1FvnlQvONq8f1YY4C9rsFu/Dm88B4m+Bpsb4n7QQDYxq37H4R4lYE4FjFLrRPe3BotftGAzOa0iy769w4/5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BXJkkgGD; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lX806ff/J16u4dwImlE38JzQyqABU8n1P1+oNc6Rc+c=; b=BXJkkgGDBhZ6Ntfge1O8rysW6d
	WjsYWdv0ytk/Xzo98JPSDLu4aWLUVFuH1dpMrrx4gGu2cUlt05TbLMaKXhhCJnn/URVK3D2Z5Uon1
	waoyW5jBYSN0OzbHPsfb0K27+ZD34M8rXby2tHYCWd04YRvdW0IzYa+fahJMSDOEcBvtQoNsbXigC
	tBBZNN3vW5xW1sqT32nLs6F3NGA6vc8bbmDiOxfg9L6GRaeGAfiz7eFHLwskh6MRR8LNi1ag/PVEs
	vtrMuQ8qs5g9UJRjRf6W07BGXK9Qpx4GcyqVn4GtJ3O0UJgETYtL9ZkhdgvwPjjhuEdweW1b0ErtJ
	RlyL4C9g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcK4G-00000007nH3-1oBJ;
	Wed, 24 Jun 2026 09:38:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 427F0300400; Wed, 24 Jun 2026 11:38:48 +0200 (CEST)
Date: Wed, 24 Jun 2026 11:38:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Disable jump tables for clang
Message-ID: <20260624093848.GA48970@noisy.programming.kicks-ass.net>
References: <20260623-x86-boot-compressed-disable-jt-clang-v1-1-575fccd58107@kernel.org>
 <ajulLtY29HtgWokg@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajulLtY29HtgWokg@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268125-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@kernel.org,m:nathan@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:ardb@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:stable@vger.kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,noisy.programming.kicks-ass.net:mid,infradead.org:dkim,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2C3A6BCFFA

On Wed, Jun 24, 2026 at 11:36:46AM +0200, Ingo Molnar wrote:
> 
> * Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > After a recent upstream LLVM change to start generating jump and lookup
> > tables in switch statements in more instances [1], linking the
> > compressed x86 boot image when CONFIG_KERNEL_ZSTD is enabled fails with:
> > 
> >   ld.lld: error: Unexpected run-time relocations (.rela) detected!
> > 
> > Dumping the relocations in misc.o, which is the only file influenced by
> > CONFIG_KERNEL_ZSTD in the decompressor, shows dynamic relocations to
> > some string constants, which correspond to the string literals in the
> > switch statement in handle_zstd_error():
> > 
> >   Relocation section '.rela.data.rel.ro' at offset 0x277b0 contains 31 entries:
> >       Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> >   0000000000000000  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 73a
> >   0000000000000008  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
> >   0000000000000010  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
> >   0000000000000018  0000006600000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 78e
> >   ...
> > 
> > This optimization is problematic for the decompressor environment, as it
> > is built as -fPIE without any explicit absolute references (as described
> > at the top of misc.c) while not applying any dynamic relocations, hence
> > the linker assertion. To opt out of this optimization, which is of
> > little value in this special early boot code, disable jump tables in the
> > decompressor when building with clang. This mirrors the other x86
> > startup code in arch/x86/boot/startup.
> > 
> > Cc: stable@vger.kernel.org
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/2165
> > Link: https://github.com/llvm/llvm-project/commit/fa02a6ed66b1700c996b49c96c6bc0eb014c9518 [1]
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  arch/x86/boot/compressed/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 07e0e64b9a98..1c0d29e3eeba 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -31,6 +31,7 @@ KBUILD_CFLAGS += -Wundef
> >  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> >  cflags-$(CONFIG_X86_32) := -march=i386
> >  cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
> > +cflags-$(CONFIG_CC_IS_CLANG) += -fno-jump-tables
> 
> So, shouldn't we just use -fno-jump-tables for *all* compilers,
> like we do in arch/x86/boot/startup/Makefile?
> 
> The point wouldn't be to just work around any Clang
> jump-table optimization complications alone, but also
> to synchronize the build options of very early code and such.

I'm sitting on a patch to unconditionally disable jump-tables for
x86_64:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/syscall

I need to fix the robot fallout and then actually post this.

