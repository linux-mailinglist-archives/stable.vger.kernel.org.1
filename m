Return-Path: <stable+bounces-250202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGbKELENDmqe5wUAu9opvQ
	(envelope-from <stable+bounces-250202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:38:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A27A6598879
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6C5533FF50C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22836494B;
	Wed, 20 May 2026 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DdzHuhUz"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B4833B97A;
	Wed, 20 May 2026 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294810; cv=none; b=DYdXn3OZ055WlujtJ1ntYhIXHOev70snz9yLmiT/x9HfRxKN84Av9Zet8K5A5Y+DbRh6NqjyvrtjXc3B/IejwAsgS8Yd7NQInG9DOUOakp5LhNN6NiBAj3RePbuS0Hl8doL6kOogqded3UG/w4TTtlLFHs90iaATYfbneJiJPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294810; c=relaxed/simple;
	bh=m9bIK7//CZw/Q1o2xMpgB+DPsJNKtAtp6MpgiVd2b0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OU8JRBa0nammRFSjn3cqAK0U8L5JFzs/VTA4O010hiZU/tF0bN8Ceap3svmNZT9q08tclqmxrKDcTer/oR1c8KlVqzTXXmqI72l0kiRxPKVjVfrGwmEvLvueuVZDcBzuucTlfV2jd0NsKZ0NP7HhVTWUQDyJ5+eHykPh//HM29M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DdzHuhUz; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E2E06C001AC3;
	Wed, 20 May 2026 09:33:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E2E06C001AC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1779294807;
	bh=m9bIK7//CZw/Q1o2xMpgB+DPsJNKtAtp6MpgiVd2b0U=;
	h=From:To:Cc:Subject:Date:From;
	b=DdzHuhUzX2PXwNjY62kyPQedxFPqVksi0HoDBI8VXBoS4k7nRtz254UeA8pe/tk1e
	 ghTGQeSQ5oGo3AdoJDIy+GUy1ly1vA6UxFCrevkRAaARiC6lho47fOPffFoRBVE3l0
	 LT0DKWnZ//qhBA593N7qbvLXR2gVBvTjRtpunzh4=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 74CFBAEA2;
	Wed, 20 May 2026 12:33:25 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	bpf@vger.kernel.org (open list:BPF [MISC]),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.1 v2 0/5] perf build fixes
Date: Wed, 20 May 2026 09:33:15 -0700
Message-Id: <20260520163320.3073037-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-250202-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: A27A6598879
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series contains "perf" build fixes specific to 6.1. We have
seen occasional build failures in our CI looking like these:

util/parse-events-bison.c: In function 'yy_symbol_print':
util/parse-events-bison.c:901: error: unterminated #if
  901 | #if YYDEBUG
      |
util/parse-events-bison.c:1020:62: error: '_p' undeclared (first use in this function)
 1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _parse_state, scanner);
      |                                                              ^~
util/parse-events-bison.c:1020:62: note: each undeclared identifier is reported only once for each function it appears in
util/parse-events-bison.c:1020:64: error: expected ')' at end of input
 1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _parse_state, scanner);
      |                         ~                                      ^
      |                                                                )
 1021 |   YYFPRINTF (yyo, ")");
      |
util/parse-events-bison.c:1020:3: error: too few arguments to function 'yy_symbol_value_print'
 1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _parse_state, scanner);
      |   ^~~~~~~~~~~~~~~~~~~~~
util/parse-events-bison.c:991:1: note: declared here
  991 | yy_symbol_value_print (FILE *yyo,
      | ^~~~~~~~~~~~~~~~~~~~~

which are resolved by these patches.

Changes in v2:

- backport change adding version-lt3 macro
- added fix for "perf build: Disable fewer bison warnings" per Sasha's review

Arnaldo Carvalho de Melo (2):
  tools build: Add 3-component logical version comparators
  perf build: Remove -Wno-unused-but-set-variable from the flex flags
    when building with clang < 13.0.0

Ian Rogers (3):
  perf build: Conditionally define NDEBUG
  perf parse-events: Make YYDEBUG dependent on doing a debug build
  perf build: Disable fewer bison warnings

 tools/perf/Makefile.config     |  1 +
 tools/perf/util/Build          | 32 +++++++++++++++++++++++++-------
 tools/perf/util/expr.y         |  4 +++-
 tools/perf/util/parse-events.y |  3 +++
 tools/perf/util/pmu.y          |  3 +++
 tools/scripts/utilities.mak    | 20 ++++++++++++++++++++
 6 files changed, 55 insertions(+), 8 deletions(-)

-- 
2.34.1


