Return-Path: <stable+bounces-271444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GCI4KoGbRmoVaAsAu9opvQ
	(envelope-from <stable+bounces-271444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:10:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F16FB14A
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:10:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Gc22ADgs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271444-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271444-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F1F833147F0
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0682FFF9D;
	Thu,  2 Jul 2026 16:59:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF9230C141;
	Thu,  2 Jul 2026 16:59:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011560; cv=none; b=hVfblEMaODW/2Q5Sl1R69p9ng8zgofY1M1id7kym++gixEit1xxQCR00GWB4f5XUUnNnMHIMkEweTco4iqbkpIXJ+kZub4jAA1ZzSQYzVAxqOs1SNT8hPvVBTeUEWRFiYg5Cw4bkAXjjPESqYCHPtb2jWDWfwMUZqN1ezASYMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011560; c=relaxed/simple;
	bh=mTI23MHcVNnDSL3v8TVaJ9BTR0RixEo9iFF4Hoo09+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQ15QlR62665P776GMSsCsVpdIdE2TDerTvCUBHeEA1ZLlDV3eacqtbHJLmkEOFXpDMblJ4WO+XffpQFEVTxny66pHa/uiKA2ELkDh1fi86RmYGgQmvn2ET0+pj7HBIEH7VyB+a7pntzUNUoEZJ55WMpoJMgxJHevOdLmS6gJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gc22ADgs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F661F00A3A;
	Thu,  2 Jul 2026 16:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011559;
	bh=CaQF3RtUqQbp8bWptuJ25OBt50cb0nFKz+2i0Pp4pTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gc22ADgsp65A2jiL7qJmHKg16Yvo32Bc00rrDikwqTE7KGjukZI6tsXg+q6cQw01N
	 vy3YyVu7ZILwEpneTa5Q5+SVptHn5PWwxSauqUZ8jpcej/BjAAeJEXeYolmeJdw68t
	 M1wyoty0s44F9YSFEydb0bx48nVCnMJgaMD/Jg+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.1 044/120] gcov: use atomic counter updates to fix concurrent access crashes
Date: Thu,  2 Jul 2026 18:20:40 +0200
Message-ID: <20260702155113.873475268@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:khorenko@virtuozzo.com,m:arnd@arndb.de,m:oberpar@linux.ibm.com,m:masahiroy@kernel.org,m:ojeda@kernel.org,m:zaslonko@linux.ibm.com,m:nathan@kernel.org,m:ptikhomirov@virtuozzo.com,m:linux@weissschuh.net,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-271444-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,arndb.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,weissschuh.net:email,virtuozzo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE2F16FB14A

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Khorenko <khorenko@virtuozzo.com>

commit 56cb9b7d96b28a1173a510ab25354b6599ad3a33 upstream.

GCC's GCOV instrumentation can merge global branch counters with loop
induction variables as an optimization.  In inflate_fast(), the inner copy
loops get transformed so that the GCOV counter value is loaded multiple
times to compute the loop base address, start index, and end bound.  Since
GCOV counters are global (not per-CPU), concurrent execution on different
CPUs causes the counter to change between loads, producing inconsistent
values and out-of-bounds memory writes.

The crash manifests during IPComp (IP Payload Compression) processing when
inflate_fast() runs concurrently on multiple CPUs:

  BUG: unable to handle page fault for address: ffffd0a3c0902ffa
  RIP: inflate_fast+1431
  Call Trace:
   zlib_inflate
   __deflate_decompress
   crypto_comp_decompress
   ipcomp_decompress [xfrm_ipcomp]
   ipcomp_input [xfrm_ipcomp]
   xfrm_input

At the crash point, the compiler generated three loads from the same
global GCOV counter (__gcov0.inflate_fast+216) to compute base, start, and
end for an indexed loop.  Another CPU modified the counter between loads,
making the values inconsistent - the write went 3.4 MB past a 65 KB
buffer.

Add -fprofile-update=prefer-atomic to CFLAGS_GCOV at the global level in
the top-level Makefile, guarded by a try-run compile test.  The test
compiles a minimal program with and without -fprofile-update=prefer-atomic
using the full KBUILD_CFLAGS, then compares undefined symbols in the
resulting object files.  If prefer-atomic introduces new undefined
references (such as __atomic_fetch_add_8 on i386 or __aarch64_ldadd8_relax
on arm64 with outline-atomics), the flag is not added -- the kernel does
not link against libatomic.

On architectures where GCC inlines 64-bit atomic counter updates (x86_64,
s390, ...) the test passes and the flag is enabled, preventing the
compiler from merging counters with loop induction variables and fixing
the observed concurrent-access crash.

On architectures where the flag would introduce libatomic dependencies, it
is silently omitted and behaviour is no worse than before this patch.

Move the CFLAGS_GCOV block from its original position (before the arch
Makefile include) to after the core KBUILD_CFLAGS assignments but before
the scripts/Makefile.gcc-plugins include.  This placement ensures the
try-run test sees arch-specific flags (-m32, -march=,
-mno-outline-atomics) while avoiding GCC plugin flags (-fplugin=) that
would break the test on clean builds when plugin shared objects do not yet
exist.

Link: https://lore.kernel.org/20260511105052.417187-2-khorenko@virtuozzo.com
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -827,12 +827,6 @@ endif # KBUILD_EXTMOD
 # Defaults to vmlinux, but the arch makefile usually adds further targets
 all: vmlinux
 
-CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage
-ifdef CONFIG_CC_IS_GCC
-CFLAGS_GCOV	+= -fno-tree-loop-im
-endif
-export CFLAGS_GCOV
-
 # The arch Makefiles can override CC_FLAGS_FTRACE. We may also append it later.
 ifdef CONFIG_FUNCTION_TRACER
   CC_FLAGS_FTRACE := -pg
@@ -1150,6 +1144,27 @@ endif
 # Ensure compilers do not transform certain loops into calls to wcslen()
 KBUILD_CFLAGS += -fno-builtin-wcslen
 
+CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage
+ifdef CONFIG_CC_IS_GCC
+CFLAGS_GCOV	+= -fno-tree-loop-im
+# Use atomic counter updates to avoid concurrent-access crashes in GCOV.
+# Only enable if -fprofile-update=prefer-atomic does not introduce new
+# undefined symbols (e.g. libatomic calls that the kernel cannot link).
+CFLAGS_GCOV	+= $(call try-run,\
+	echo 'long long x; void f(void){x++;}' | \
+	$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -w -fprofile-arcs \
+	-ftest-coverage -x c - -c -o "$$TMP.base" && \
+	echo 'long long x; void f(void){x++;}' | \
+	$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -w -fprofile-arcs \
+	-ftest-coverage -fprofile-update=prefer-atomic \
+	-x c - -c -o "$$TMP" && \
+	$(NM) "$$TMP.base" | grep ' U ' > "$$TMP.ubase" || true ; \
+	$(NM) "$$TMP" | grep ' U ' > "$$TMP.utest" || true ; \
+	cmp -s "$$TMP.ubase" "$$TMP.utest",\
+	-fprofile-update=prefer-atomic)
+endif
+export CFLAGS_GCOV
+
 # change __FILE__ to the relative path to the source directory
 ifdef building_out_of_srctree
 KBUILD_CPPFLAGS += -fmacro-prefix-map=$(srcroot)/=



