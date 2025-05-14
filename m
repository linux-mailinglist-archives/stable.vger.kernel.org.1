Return-Path: <stable+bounces-144359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B38DAB6A4F
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 13:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F7367A555E
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC0C270EDD;
	Wed, 14 May 2025 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F1w38Fzm"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E97270ECB
	for <stable@vger.kernel.org>; Wed, 14 May 2025 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222798; cv=none; b=Iqim9csdAjfvNsxBlz8CkF55glUB10KLL/GxJaRC7Q3DEqgxJ/aK5/NoOjVVAep7eQNQ/GGi7Jhyec4r2h/BkfiTMwm5JUtEYqxq2uy1XYso4h0+f1bMGZQGV3yaqLy1/m+fEmk+NwfYbHvG9u6w2BYFeWnAEnRCsNgIElFANC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222798; c=relaxed/simple;
	bh=yi26aSsknFOHc7V/oGjCZNcmAeZMnwzGMWYpNpSsIp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuKewBHurO0ZRoJO9Rp+sIDkXBBpy6CYvWU8JSuTo94nzrTY8dK6e0hgENkCDcW/xfyycYjGwwSzzhSzAGDi2ixYs1LhpISxf6woId+OVvWpij5k75zBQ98QQex7XHWrBc+/XTn1EGWxowSDfEgyJcSixIJ0IRtzofkyQc7sRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F1w38Fzm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qlVrDuIIkuyiU2zqEkrXZlf093Zr1XfJNdtahxw6+GI=; b=F1w38FzmpScjup3hTiAPJfewVc
	baCdxBLEC+dFKON6G+3tk9QbP0/p3g5p6vshkkVyHR+SpXUr8hqzn7MzFbEY9kLxLUYKb6gj9x7nQ
	xCKO51whN5YJXO+Av8W5BPQNLvwKaax+ghS4hm4frShmDhoRb7iUNT3BgJYTHgHRA3E+LRXz2a+qk
	8VVnuUcINwvcZlxVoygvfU+L13Tx7UeqS6hzzt3Y8+0g1AERtvtRfvT93xcqXAarwU+u3iPEDTwmB
	esmP1gGsb1lYc3zuhhGfcadcB8GuN/e2n1DQHzjNqhEHJsr3nyGjSn+ujsPBMqeJX4BU+6A60ByWD
	Dop78ljQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFASn-0000000CEKb-0Qqk;
	Wed, 14 May 2025 11:39:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A7AB6300717; Wed, 14 May 2025 13:39:52 +0200 (CEST)
Date: Wed, 14 May 2025 13:39:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: 6.14.7-rc1: undefined reference to
 `__x86_indirect_its_thunk_array' when CONFIG_CPU_MITIGATIONS is off
Message-ID: <20250514113952.GB16434@noisy.programming.kicks-ass.net>
References: <0fd6d544-c045-4cf5-e5ab-86345121b76a@applied-asynchrony.com>
 <f88e97c3-aaa0-a24f-3ef6-f6da38706839@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f88e97c3-aaa0-a24f-3ef6-f6da38706839@applied-asynchrony.com>

On Wed, May 14, 2025 at 12:13:29PM +0200, Holger Hoffstätte wrote:
> cc: peterz
> 
> On 2025-05-14 09:45, Holger Hoffstätte wrote:
> > While trying to build 6.14.7-rc1 with CONFIG_CPU_MITIGATIONS unset:
> > 
> >    LD      .tmp_vmlinux1
> > ld: arch/x86/net/bpf_jit_comp.o: in function `emit_indirect_jump':
> > /tmp/linux-6.14.7/arch/x86/net/bpf_jit_comp.c:660:(.text+0x97e): undefined reference to `__x86_indirect_its_thunk_array'
> > make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> > make[1]: *** [/tmp/linux-6.14.7/Makefile:1234: vmlinux] Error 2
> > make: *** [Makefile:251: __sub-make] Error 2
> > 
> > - applying 9f35e33144ae aka "x86/its: Fix build errors when CONFIG_MODULES=n"
> > did not help
> > 
> > - mainline at 9f35e33144ae does not have this problem (same config)
> > 
> > Are we missing a commit in stable?
> 
> It seems commit e52c1dc7455d ("x86/its: FineIBT-paranoid vs ITS") [1]
> is missing in the stable queue. It replaces the direct array reference
> in bpf_jit_comp.c:emit_indirect_jump() with a mostly-empty function stub
> when !CONFIG_MITIGATION_ITS, which is why mainline built and -stable
> does not.
> 
> Unfortunately it does not seem to apply on top of 6.14.7-rc1 at all.
> Any good suggestions?
> 
> thanks
> Holger
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e52c1dc7455d32c8a55f9949d300e5e87d011fa6

Right, this is forever the problem with these embargoed things that
side-step the normal development cycle and need to be backported to hell
:/

Let me go update this stable.git thing.

/me twiddles thumbs for a bit, this is one fat tree it is..

Argh, I needed stable-rc.git

more thumb twiddling ...

simply picking the few hunks from that fineibt commit should do the
trick I think.

/me stomps on it some ... voila! Not the prettiest thing, but definilty
good enough I suppose. Builds now, must be perfect etc.. :-)

---

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 47948ebbb409..f2294784babc 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -6,6 +6,7 @@
 #include <linux/stringify.h>
 #include <linux/objtool.h>
 #include <asm/asm.h>
+#include <asm/bug.h>
 
 #define ALT_FLAGS_SHIFT		16
 
@@ -128,10 +129,17 @@ static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
 extern void its_init_mod(struct module *mod);
 extern void its_fini_mod(struct module *mod);
 extern void its_free_mod(struct module *mod);
+extern u8 *its_static_thunk(int reg);
 #else /* CONFIG_MITIGATION_ITS */
 static inline void its_init_mod(struct module *mod) { }
 static inline void its_fini_mod(struct module *mod) { }
 static inline void its_free_mod(struct module *mod) { }
+static inline u8 *its_static_thunk(int reg)
+{
+	WARN_ONCE(1, "ITS not compiled in");
+
+	return NULL;
+}
 #endif
 
 #if defined(CONFIG_MITIGATION_RETHUNK) && defined(CONFIG_OBJTOOL)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7a10e3ed5d0b..48fd04e90114 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -240,6 +272,13 @@ static void *its_allocate_thunk(int reg)
 	return its_init_thunk(thunk, reg);
 }
 
+u8 *its_static_thunk(int reg)
+{
+	u8 *thunk = __x86_indirect_its_thunk_array[reg];
+
+	return thunk;
+}
+
 #endif
 
 /*
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a5b65c09910b..a31e58c6d89e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -663,7 +663,7 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 
 	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
 		OPTIMIZER_HIDE_VAR(reg);
-		emit_jump(&prog, &__x86_indirect_its_thunk_array[reg], ip);
+		emit_jump(&prog, its_static_thunk(reg), ip);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
 		EMIT_LFENCE();
 		EMIT2(0xFF, 0xE0 + reg);


