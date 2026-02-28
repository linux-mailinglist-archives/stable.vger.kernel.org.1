Return-Path: <stable+bounces-220103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFLSGeQoo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:41:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 259E61C50A9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20EAA30C68EA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2581047CC89;
	Sat, 28 Feb 2026 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec2JHmwu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A646AEF1;
	Sat, 28 Feb 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300010; cv=none; b=VMPrcJjlcUJFOV68eJkGEnLqZmrTc1rdGGZasydBAhhVTDS6ZmQFWn+1yR5VPzxwxTl8U/sK44p9nEQ/9FLIG9DisL3T1bAhMreTPTvcy2VnNMIl4zht6RXiY4hrlqUdavUBkki61/athsmh85nGlF8TW99/QmYbQss02Zj5fWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300010; c=relaxed/simple;
	bh=Wm5Ozx2khlW+XZO3E5ippyq/P9BQL9xkCFfyFdNKLbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G34yyLNlhXAQthMKplMNaOj/4DktKpiytPVUwXVJafSB+7NBAGYvC1qrnGt4E3OktSlhbCmquk0MkIxumqF79kDfpWM/GSigF9rUjqyYZxeRsRA9WpNlN/i1S9MKgAFneLsg/t18I7uWtUpLCtvf+0FvRGQFKt3u8I/le6JEo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec2JHmwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C380C19423;
	Sat, 28 Feb 2026 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300010;
	bh=Wm5Ozx2khlW+XZO3E5ippyq/P9BQL9xkCFfyFdNKLbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ec2JHmwuYwqrV5pFORFXNjZLrbK85a0uDBBLs5M4K7asOYNW7WN0QnVwMdF4OsgCq
	 hH/aY7w7xxaV/pZ8EEJORP9Brvo0Tydv25dlsA4QPimLZhmTC1fipgrr5xcngyPKsJ
	 SWBEYn/6WC0NNh8k9+JhFQW7nkkI8a3S3pEcppEoAKDCRE8XzURa+s7PUtVSs7N7un
	 tNI8quzxZ81Q/Pa1tgE0Kr3J3CUbQuI4jBv99FDA+/x/saf/bnqF5Y5NKeHbxpaHwv
	 Jz0CG9IjjImljZDBUxNa+OpvkLI5d2bIK2kzyTYfdTTOVHgLP/z2aCydvCDg0NMseA
	 AY+ZrlPLRCg/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 025/844] perf build: Remove NO_LIBCAP that controls nothing
Date: Sat, 28 Feb 2026 12:18:58 -0500
Message-ID: <20260228173244.1509663-26-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220103-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 259E61C50A9
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit 169343cc8ff2bd59758760d867bd26adae866a2b ]

Using libcap was removed in commit e25ebda78e230283 ("perf cap: Tidy up
and improve capability testing") and improve capability testing"),
however, some build documentation and a use of the NO_LIBCAP=1 were
lingering.

Remove these left over bits.

Fixes: e25ebda78e230283 ("perf cap: Tidy up and improve capability testing")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.perf | 2 --
 tools/perf/tests/make    | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e6895626c1872..fbeb5c81c8072 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -86,8 +86,6 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBBPF if you do not want BPF support
 #
-# Define NO_LIBCAP if you do not want process capabilities considered by perf
-#
 # Define NO_SDT if you do not want to define SDT event in perf tools,
 # note that it doesn't disable SDT scanning support.
 #
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 6641701e48285..c721cd1bcaa9a 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -122,7 +122,7 @@ make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_LIBBPF=1
 make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
-make_minimal        += NO_LIBCAP=1 NO_CAPSTONE=1
+make_minimal        += NO_CAPSTONE=1
 
 # $(run) contains all available tests
 run := make_pure
-- 
2.51.0


