Return-Path: <stable+bounces-176817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB1B3DEAB
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB4A1894F7E
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF9B2FE58C;
	Mon,  1 Sep 2025 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uMGkd0SX"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476325A341;
	Mon,  1 Sep 2025 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719371; cv=none; b=JXTcEjF1NCjaqimmOqiCBPiPCCEHA5t1J5BG5BMEN0oFyG1KMJPIE8ckoUAgIg/47rEUnYtDLzCTqR18Dty12Ft4ZT18pQp2R4iFFytIWtwP1ATyikBPwHTCli87SryUZlUVaSpkOKetCD1lKh7XBMwhYktAk487GUc7qFU3KPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719371; c=relaxed/simple;
	bh=PiwqZJCg0JTa1pZ56Fd6Wyt0Ul+2iqKvO05eQAGWYJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+/Jb2nD6B2Q3sk2NH8/bo4+6mfVaBvio9vUwhPxKCwmfvlW6Euz0lmVTFpbFO2DAgDpAVa1Alz8MiIv8R9tkmBsvxWD8VqBSjsjr7IPBtFLLYTStDpgsmNKKppgj9VvC5A62O3d2cigV1Q5SKAwU25Q2BDA1Y7D6llLWRVkvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uMGkd0SX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ekHLxl+xZQ2A1ir8y9wQNeOzde7UET8G9p+labbm86Y=; b=uMGkd0SXjOX6DaEyvBh3Qu7kez
	TEGFd4x814gtOxoseuX5pqredDxyu0PfoIUoCxzS6Bm88fUHP445cnSWQ5OpwMUA9zABqZMy1fS/g
	qc6POcitKwjQFoq7QV0J2PuPF+QKj1hFuGWsmZXYtTlnmdiIYTNdXE//Bh81t7EFMhT93Hy3KOUfY
	NTpiSmMltDWcL9LXXpBSZwOJzOHXa8bNhDud3ED0kdYwWDN4eR48u6l9XYMvS18bCPCsZRevo4YJP
	rH+v+dK/109d/xsjt71Tbi693zTy5ta78MoaVnDK9zXgKCcJh3LN6YI1ppdGMW7FDAXwjVgHx5rLj
	NwxnP1aw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut0xE-000000063tK-33Dy;
	Mon, 01 Sep 2025 09:36:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5A362300342; Mon, 01 Sep 2025 11:36:00 +0200 (CEST)
Date: Mon, 1 Sep 2025 11:36:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Eero Tamminen <oak@helsinkinet.fi>, Will Deacon <will@kernel.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Message-ID: <20250901093600.GF4067720@noisy.programming.kicks-ass.net>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825071247.GO3245006@noisy.programming.kicks-ass.net>
 <58dac4d0-2811-182a-e2c1-4edfe4759759@linux-m68k.org>
 <20250825114136.GX3245006@noisy.programming.kicks-ass.net>
 <9453560f-2240-ab6f-84f1-0bb99d118998@linux-m68k.org>
 <20250827115447.GR3289052@noisy.programming.kicks-ass.net>
 <10b5aaae-5947-53a9-88bb-802daafd83d4@linux-m68k.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b5aaae-5947-53a9-88bb-802daafd83d4@linux-m68k.org>

On Thu, Aug 28, 2025 at 07:53:52PM +1000, Finn Thain wrote:

> > Anyway, I'm not opposed to adding an explicit alignment to atomic_t.
> > Isn't s32 or __s32 already having this?
> > 
> 
> For Linux/m68k, __alignof__(__s32) == 2 and __alignof__(s32) == 2.

Hmm, somehow I thought one of those enforced natural alignment. Oh well.

> > But I think it might make sense to have a DEBUG alignment check right
> > along with adding that alignment, just to make sure things are indeed /
> > stay aligned.
> > 
> 
> A run-time assertion seems surperfluous as long as other architectures 
> already trap for misaligned locks. 

Right, but those architectures have natural alignment. m68k is 'special'
in that it doesn't have this.

> For m68k, perhaps we could have a compile-time check:

I don't think build-time is sufficient. There is various code that casts
to atomic types and other funny stuff like that.

If you want to ensure 'atomics' are always naturally aligned, the only
sound way is to have a runtime test/trap.

Something like the completely untested below should do I suppose.

---
diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 711a1f0d1a73..e39cdfe5a59e 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -67,6 +67,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
 {
 	kasan_check_read(v, size);
 	kcsan_check_atomic_read(v, size);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 3));
 }
 
 /**
@@ -81,6 +82,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 3));
 }
 
 /**
@@ -95,6 +97,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 3));
 }
 
 /**
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dc0e0c6ed075..1c7e30cdfe04 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1363,6 +1363,16 @@ config DEBUG_PREEMPT
 	  depending on workload as it triggers debugging routines for each
 	  this_cpu operation. It should only be used for debugging purposes.
 
+config DEBUG_ATOMIC
+	bool "Debug atomic variables"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here then the kernel will add a runtime alignment check
+	  to atomic accesses. Useful for architectures that do not have trap on
+	  mis-aligned access.
+
+	  This option has potentially significant overhead.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT

