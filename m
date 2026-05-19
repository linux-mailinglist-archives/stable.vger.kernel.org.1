Return-Path: <stable+bounces-249670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EDsIJuzDGrClAUAu9opvQ
	(envelope-from <stable+bounces-249670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:01:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F8583F6E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9C01304C114
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDAE382F1C;
	Tue, 19 May 2026 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="peXehMHK"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFE383C83;
	Tue, 19 May 2026 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217236; cv=none; b=cgerhH37Lylt7+K1gvwH9tUp1KIrB5IvSqWyPRJSfEP4lNt4JBDoud4cXq15Kv3LjBxsz26pnO4YaARFY5E+p81etX+iDgsHQewanxyMUjie3QzLglsD7zbh2bpx8GGx6/Z8JRp+E0wK1WEp5Q9AEpbq72hsPQwb0qztpaEle7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217236; c=relaxed/simple;
	bh=44BIJcFcaBVpyaPZoO1Hf42KZ9fVcWyJ8e9soWxSrYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N8tliZF7W9Hth+65iZcGU4IsT+imgYSouBp4g6YcqxhUbk15eP4e5ryNEuy8kaQfNAl9reCwEyhuovbRJ+69aIc4Qwuv6RRcBKpCQwzGzvCVyiXzocaGYSi+iqy+E7deDP6cD6Q8yERobRJpfdBHzfApz1tZD5UYEbLetLmWQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=peXehMHK; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E2259C002598;
	Tue, 19 May 2026 11:51:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E2259C002598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1779216716;
	bh=44BIJcFcaBVpyaPZoO1Hf42KZ9fVcWyJ8e9soWxSrYs=;
	h=From:To:Cc:Subject:Date:From;
	b=peXehMHKI4cD8wmknt45hVmB8MvfmCMWG0ISHKroGN1vkchVM/B4q0c2VjKJAKB3J
	 Dp5wj2LiwDzLzqrIbxqKXlmBbyHQabAe1xqsx9YyFXDN5lOqndbn4ubIweyB/6s9Su
	 Z+oCWIySIMlN4WTebGRx2kUPHuVK4JEPTK7RM9fQ=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id AACE4AEA2;
	Tue, 19 May 2026 14:51:55 -0400 (EDT)
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
Subject: [PATCH stable 6.1 0/3] perf build fixes
Date: Tue, 19 May 2026 11:51:51 -0700
Message-Id: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
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
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249670-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 029F8583F6E
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

Ian Rogers (3):
  perf build: Conditionally define NDEBUG
  perf parse-events: Make YYDEBUG dependent on doing a debug build
  perf build: Disable fewer bison warnings

 tools/perf/Makefile.config     |  1 +
 tools/perf/util/Build          | 12 ++++++++----
 tools/perf/util/expr.y         |  4 +++-
 tools/perf/util/parse-events.y |  3 +++
 tools/perf/util/pmu.y          |  3 +++
 5 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.34.1


