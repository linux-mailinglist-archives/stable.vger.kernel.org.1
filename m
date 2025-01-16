Return-Path: <stable+bounces-109313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05BA1442D
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 22:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B1516BA8F
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631F236ED4;
	Thu, 16 Jan 2025 21:44:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45822CBF9;
	Thu, 16 Jan 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063872; cv=none; b=lifKTl/dimztVE2o5dSoBINhvw1qKMpt5pYpW55EzIZtM+dUdpQVoqopgjPa5LwOZ1TnsiCDIyU78tUTRuTMcJTpNZ4DCj7uq352Dsvlrt+6GJj2pIuXlm1R9pBuVg499mHylrxOISbJAJRWOISJNni1TFRcd6WuNmBSMXH5Mls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063872; c=relaxed/simple;
	bh=8UwU8P6hd5ekUuKU4t9A4gqzAaFTJfHAkHRwzdJm5Lw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WHNiLZzxIkrL6rkHpe81pcsyjAsGzB2gzePdZh8Vqw3/f3cEk2kRvzuArasB132vBWSKo2LHJT/49HGqHTFCLKHnKy4TnJ98OPz5xXpAlB3n0S/PrgQtj84qSkCuzyVlXYlCEVGxQ8XjvojhtYulea3jnoR7UQG/95g+6C2emCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA3EC4CEDF;
	Thu, 16 Jan 2025 21:44:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tYXfK-00000000yyC-46fX;
	Thu, 16 Jan 2025 16:44:38 -0500
Message-ID: <20250116214438.749504792@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 16 Jan 2025 16:41:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Petlan <mpetlan@redhat.com>,
 Veronika  Molnarova <vmolnaro@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v2 1/2] tracing: gfp: Fix the GFP enum values shown for user space tracing
 tools
References: <20250116214123.917928229@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Tracing tools like perf and trace-cmd read the /sys/kernel/tracing/events/*/*/format
files to know how to parse the data and also how to print it. For the
"print fmt" portion of that file, if anything uses an enum that is not
exported to the tracing system, user space will not be able to parse it.

The GFP flags use to be defines, and defines get translated in the print
fmt sections. But now they are converted to use enums, which is not.

The mm_page_alloc trace event format use to have:

  print fmt: "page=%p pfn=0x%lx order=%d migratetype=%d gfp_flags=%s",
    REC->pfn != -1UL ? (((struct page *)vmemmap_base) + (REC->pfn)) : ((void
    *)0), REC->pfn != -1UL ? REC->pfn : 0, REC->order, REC->migratetype,
    (REC->gfp_flags) ? __print_flags(REC->gfp_flags, "|", {( unsigned
    long)(((((((( gfp_t)(0x400u|0x800u)) | (( gfp_t)0x40u) | (( gfp_t)0x80u) |
    (( gfp_t)0x100000u)) | (( gfp_t)0x02u)) | (( gfp_t)0x08u) | (( gfp_t)0)) |
    (( gfp_t)0x40000u) | (( gfp_t)0x80000u) | (( gfp_t)0x2000u)) & ~((
    gfp_t)(0x400u|0x800u))) | (( gfp_t)0x400u)), "GFP_TRANSHUGE"}, {( unsigned
    long)((((((( gfp_t)(0x400u|0x800u)) | (( gfp_t)0x40u) | (( gfp_t)0x80u) |
    (( gfp_t)0x100000u)) | (( gfp_t)0x02u)) | (( gfp_t)0x08u) | (( gfp_t)0)) ...

Where the GFP values are shown and not their names. But after the GFP
flags were converted to use enums, it has:

  print fmt: "page=%p pfn=0x%lx order=%d migratetype=%d gfp_flags=%s",
    REC->pfn != -1UL ? (vmemmap + (REC->pfn)) : ((void *)0), REC->pfn != -1UL
    ? REC->pfn : 0, REC->order, REC->migratetype, (REC->gfp_flags) ?
    __print_flags(REC->gfp_flags, "|", {( unsigned long)((((((((
    gfp_t)(((((1UL))) << (___GFP_DIRECT_RECLAIM_BIT))|((((1UL))) <<
    (___GFP_KSWAPD_RECLAIM_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_IO_BIT)))
    | (( gfp_t)((((1UL))) << (___GFP_FS_BIT))) | (( gfp_t)((((1UL))) <<
    (___GFP_HARDWALL_BIT)))) | (( gfp_t)((((1UL))) << (___GFP_HIGHMEM_BIT))))
    | (( gfp_t)((((1UL))) << (___GFP_MOVABLE_BIT))) | (( gfp_t)0)) | ((
    gfp_t)((((1UL))) << (___GFP_COMP_BIT))) ...

Where the enums names like ___GFP_KSWAPD_RECLAIM_BIT are shown and not their
values. User space has no way to convert these names to their values and
the output will fail to parse. What is shown is now:

  mm_page_alloc:  page=0xffffffff981685f3 pfn=0x1d1ac1 order=0 migratetype=1 gfp_flags=0x140cca

The TRACE_DEFINE_ENUM() macro was created to handle enums in the print fmt
files. This causes them to be replaced at boot up with the numbers, so
that user space tooling can parse it. By using this macro, the output is
back to the human readable:

  mm_page_alloc: page=0xffffffff981685f3 pfn=0x122233 order=0 migratetype=1 gfp_flags=GFP_HIGHUSER_MOVABLE|__GFP_COMP

Cc: stable@vger.kernel.org
Reported-by: Michael Petlan <mpetlan@redhat.com>
Closes: https://lore.kernel.org/all/87be5f7c-1a0-dad-daa0-54e342efaea7@redhat.com/
Fixes: 772dd0342727c ("mm: enumerate all gfp flags")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250116132359.1f20cdec@gandalf.local.home

- Moved the updates to only include/trace/events/mmflags.h

- Removed the macro call in include/trace/events/kmem.h

- Use an internal TRACE_GFP_EM() macro in TRACE_GFP_FLAGS to allow
  it to be expanded later for use with the __def_gfpflags_names()
  macro

 include/trace/events/mmflags.h | 63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index bb8a59c6caa2..d36c857dd249 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -13,6 +13,69 @@
  * Thus most bits set go first.
  */
 
+/* These define the values that are enums (the bits) */
+#define TRACE_GFP_FLAGS_GENERAL			\
+	TRACE_GFP_EM(DMA)			\
+	TRACE_GFP_EM(HIGHMEM)			\
+	TRACE_GFP_EM(DMA32)			\
+	TRACE_GFP_EM(MOVABLE)			\
+	TRACE_GFP_EM(RECLAIMABLE)		\
+	TRACE_GFP_EM(HIGH)			\
+	TRACE_GFP_EM(IO)			\
+	TRACE_GFP_EM(FS)			\
+	TRACE_GFP_EM(ZERO)			\
+	TRACE_GFP_EM(DIRECT_RECLAIM)		\
+	TRACE_GFP_EM(KSWAPD_RECLAIM)		\
+	TRACE_GFP_EM(WRITE)			\
+	TRACE_GFP_EM(NOWARN)			\
+	TRACE_GFP_EM(RETRY_MAYFAIL)		\
+	TRACE_GFP_EM(NOFAIL)			\
+	TRACE_GFP_EM(NORETRY)			\
+	TRACE_GFP_EM(MEMALLOC)			\
+	TRACE_GFP_EM(COMP)			\
+	TRACE_GFP_EM(NOMEMALLOC)		\
+	TRACE_GFP_EM(HARDWALL)			\
+	TRACE_GFP_EM(THISNODE)			\
+	TRACE_GFP_EM(ACCOUNT)			\
+	TRACE_GFP_EM(ZEROTAGS)
+
+#ifdef CONFIG_KASAN_HW_TAGS
+# define TRACE_GFP_FLAGS_KASAN			\
+	TRACE_GFP_EM(SKIP_ZERO)			\
+	TRACE_GFP_EM(SKIP_KASAN)
+#else
+# define TRACE_GFP_FLAGS_KASAN
+#endif
+
+#ifdef CONFIG_LOCKDEP
+# define TRACE_GFP_FLAGS_LOCKDEP		\
+	TRACE_GFP_EM(NOLOCKDEP)
+#else
+# define TRACE_GFP_FLAGS_LOCKDEP
+#endif
+
+#ifdef CONFIG_SLAB_OBJ_EXT
+# define TRACE_GFP_FLAGS_SLAB			\
+	TRACE_GFP_EM(NO_OBJ_EXT)
+#else
+# define TRACE_GFP_FLAGS_SLAB
+#endif
+
+#define TRACE_GFP_FLAGS				\
+	TRACE_GFP_FLAGS_GENERAL			\
+	TRACE_GFP_FLAGS_KASAN			\
+	TRACE_GFP_FLAGS_LOCKDEP			\
+	TRACE_GFP_FLAGS_SLAB
+
+#undef TRACE_GFP_EM
+#define TRACE_GFP_EM(a) TRACE_DEFINE_ENUM(___GFP_##a##_BIT);
+
+TRACE_GFP_FLAGS
+
+/* Just in case these are ever used */
+TRACE_DEFINE_ENUM(___GFP_UNUSED_BIT);
+TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
+
 #define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
 
 #define __def_gfpflag_names			\
-- 
2.45.2



