Return-Path: <stable+bounces-250209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LcaAOsNDmqe5wUAu9opvQ
	(envelope-from <stable+bounces-250209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:39:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F4E5988E2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA9E3300842
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F33F1AAB;
	Wed, 20 May 2026 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="nqqFj02T"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FAF3E9C3D;
	Wed, 20 May 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294817; cv=none; b=nZOTUo7WS2i+VRC7Q8STPrKTYgOdR0HtiG68/LWhZWm4GUxu5zeNtpdEIcfQm3/iCh6JYAS7jmmfhdGSSxByWyYA4PcA2m2knOswhHX5zbqY/IQjoX7cP+kI4S5ikmAcyygFOao+AYj1zJ9G+st1JThmaXNiLB2oJAUCVOoC/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294817; c=relaxed/simple;
	bh=LRw5SU3M5IXzdbYaE9mpgc3ExjOv/zYLyK1fhSBO2ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJS5EyM4YsbA2ZYCgwKcI4uU3GyNRFkM5Js6pClECy3lF0ul44V8s+fMNQ5v69cXzisqeeK98K1I9lRW2l9Xe5cDuy6O3ajIpSBWeIJmluQPL/jd/u5G0s47mtYgEYfQ/odwJRyaRxKGkIlpHuQeiSfEhu8l6oJ/ajVm1Ci+P8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=nqqFj02T; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id ED187C001AC5;
	Wed, 20 May 2026 09:33:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com ED187C001AC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1779294815;
	bh=LRw5SU3M5IXzdbYaE9mpgc3ExjOv/zYLyK1fhSBO2ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqqFj02TDklLjqkmTNcu2jfCkYq2fypWSoUdxZ+cz+50SIop6nCZYxk1jXht2YubV
	 Yci8QMutQ9tErznbVSMwOSZNUmCgMQNA++gdgXE8ytpK4IcxY7JxI8bW8BoKnmfPBZ
	 vThXxVYBvZinIwg7ze7gpFt/Kv9N5y0DHInDLJ4A=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 671A7AEA3;
	Wed, 20 May 2026 12:33:33 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	bpf@vger.kernel.org (open list:BPF [MISC]),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.1 v2 5/5] perf build: Remove -Wno-unused-but-set-variable from the flex flags when building with clang < 13.0.0
Date: Wed, 20 May 2026 09:33:20 -0700
Message-Id: <20260520163320.3073037-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520163320.3073037-1-florian.fainelli@broadcom.com>
References: <20260520163320.3073037-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250209-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 93F4E5988E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnaldo Carvalho de Melo <acme@redhat.com>

clang < 13.0.0 doesn't grok -Wno-unused-but-set-variable, so just remove
it to avoid:

  error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
  make[4]: *** [/git/perf-6.5.0-rc4/tools/build/Makefile.build:128: /tmp/build/perf/util/pmu-flex.o] Error 1
  make[4]: *** Waiting for unfinished jobs....

Fixes: ddc8e4c966923ad1 ("perf build: Disable fewer bison warnings")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/ZNUSWr52jUnVaaa%2F@kernel.org/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Change-Id: I8db8a372d1e83d26fbe8beda2bcf4d1a871a2b80
---
 tools/perf/util/Build | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 036f9780b398..43f74f5b96f8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,3 +1,6 @@
+include $(srctree)/tools/scripts/Makefile.include
+include $(srctree)/tools/scripts/utilities.mak
+
 perf-y += arm64-frame-pointer-unwind-support.o
 perf-y += annotate.o
 perf-y += block-info.o
@@ -265,15 +268,22 @@ ifeq ($(FLEX_GE_26),1)
 else
   flex_flags := -w
 endif
-CFLAGS_parse-events-flex.o  += $(flex_flags)
-CFLAGS_pmu-flex.o           += $(flex_flags)
-CFLAGS_expr-flex.o          += $(flex_flags)
 
 # Some newer clang and gcc version complain about this
 # util/parse-events-bison.c:1317:9: error: variable 'parse_events_nerrs' set but not used [-Werror,-Wunused-but-set-variable]
 #  int yynerrs = 0;
 
 bison_flags := -DYYENABLE_NLS=0 -Wno-unused-but-set-variable
+
+# Old clangs don't grok -Wno-unused-but-set-variable, remove it
+ifeq ($(CC_NO_CLANG), 0)
+  CLANG_VERSION := $(shell $(CLANG) --version | head -1 | sed 's/.*clang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
+  ifeq ($(call version-lt3,$(CLANG_VERSION),13.0.0),1)
+    bison_flags := $(subst -Wno-unused-but-set-variable,,$(bison_flags))
+    flex_flags := $(subst -Wno-unused-but-set-variable,,$(flex_flags))
+  endif
+endif
+
 BISON_GE_382 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 382)
 ifeq ($(BISON_GE_382),1)
   bison_flags += -Wno-switch-enum
@@ -286,6 +296,10 @@ ifeq ($(BISON_LT_381),1)
   bison_flags += -DYYNOMEM=YYABORT
 endif
 
+CFLAGS_parse-events-flex.o  += $(flex_flags)
+CFLAGS_pmu-flex.o           += $(flex_flags)
+CFLAGS_expr-flex.o          += $(flex_flags)
+
 CFLAGS_parse-events-bison.o += $(bison_flags)
 CFLAGS_pmu-bison.o          += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
-- 
2.34.1


