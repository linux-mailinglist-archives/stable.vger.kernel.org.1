Return-Path: <stable+bounces-220102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFumKPMno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 854151C4FA6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C930307ACC9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A8047B43F;
	Sat, 28 Feb 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iybTeFrx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530C450902;
	Sat, 28 Feb 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300009; cv=none; b=c5sQbageXmUu8O9Np5JX5VO6OMzj4HiemXTLnm4shxYI4d0nHsYszcUcZjuRPBqw5a8JBRETAVPJFtgrZVJSc/fVxkImRYzFulu172oPDmmS1mxl1zBPemAIdNam9+ff6BsUOXr48v0+Pd5aSsnPc9aU5Y/S8QIOgi9wPUkxb48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300009; c=relaxed/simple;
	bh=5heWpwcKAHRgxqAbeBFY0hVw+1VaYDXdi1vvfst4SY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgawUUb/krrzP5hhc9yMTAlaMR1Vcu6n7Ch3vjnFUE2JC+kLCINgQb4fXr6P83p10cLJzce4clAytU6C8r5zZkkEvCms6esp0gMjqhYHcoGALCBnQKVsnDKF+/VHtuLF48jghc63DTemsYHl/OokmRrtMTrPjNyCn9piN1GejHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iybTeFrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABECDC2BCAF;
	Sat, 28 Feb 2026 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300009;
	bh=5heWpwcKAHRgxqAbeBFY0hVw+1VaYDXdi1vvfst4SY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iybTeFrx+v5UldbmXXKH1MI5M8V7ALTNlQO0E3np8OvwYgh7eMyDPCA7a6wpSfqxx
	 46jzE2zxECcnBsAqqkySWofyopjp/AG2dzpcj1xUq3eIy6mSdtt2xtCvrJvccAi6Fh
	 fKokqXDsuwhN2MjrWU11Wv7y9W/FZuuMhWkrEUn1swBv+91jYyNOqf4F1ogoiiXlNQ
	 MRs051IUagi8acDy9EhT6tUsu95rGZRMPnY8A3XgppCaMo9iI8T1zIakA2WaEg0g+H
	 xo3cA6q6EXp2i/hRTnsj7JXBWBQKyf102n/P6BS+PZCet8zTsBrsqqA4qpWIMR6JcU
	 vHn7xTbnBhNtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 024/844] perf jevents: Handle deleted JSONS in out of source builds
Date: Sat, 28 Feb 2026 12:18:57 -0500
Message-ID: <20260228173244.1509663-25-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220102-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,intel.com:email,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 854151C4FA6
X-Rspamd-Action: no action

From: James Clark <james.clark@linaro.org>

[ Upstream commit 297c9d96e3085116c5cde18170dba716a1f2591e ]

Make the source folders a dependency for the generated folder root so
that whenever a file is deleted from the source it will force a new
fresh copy of all the JSON files and avoid stale deleted files.

JSON_DIRS_OUTPUT_ROOT needs to be a dependency of LEGACY_CACHE_JSON so
that the root folder doesn't get cleaned after the legacy JSON is
generated. But this is a no-op with in-source builds as
JSON_DIRS_OUTPUT_ROOT is unset.

JSON_DIRS is added as a dependency of PMU_EVENTS_C which also forces a
re-build for in source builds when JSON files are deleted. This could
have also resulted in stale builds, but never a broken one.

Closes: https://lore.kernel.org/linux-next/aW5XSAo88_LBPSYI@sirena.org.uk/
Fixes: 4bb55de4ff03db3e ("perf jevents: Support copying the source json files to OUTPUT")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: James Clark <james.clark@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/pmu-events/Build | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a46ab7b612dfc..4f9ef624ba70d 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,5 +1,6 @@
 pmu-events-y	+= pmu-events.o
 JSON		=  $(shell find pmu-events/arch -name '*.json' -o -name '*.csv')
+JSON_DIRS	=  $(shell find pmu-events/arch -type d)
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
@@ -31,16 +32,23 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 else
 # Copy checked-in json to OUTPUT for generation if it's an out of source build
 ifneq ($(OUTPUT),)
-$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
+# Remove all output directories when any source directory timestamp changes
+# so there are no stale deleted files
+JSON_DIRS_ROOT = $(OUTPUT)pmu-events/arch/
+$(JSON_DIRS_ROOT): $(JSON_DIRS)
+	$(Q)$(call echo-cmd,gen)rm -rf $@
+	$(Q)mkdir -p $@
+
+$(OUTPUT)pmu-events/arch/%: pmu-events/arch/% $(JSON_DIRS_ROOT)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 endif
 
-$(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
+$(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY) $(JSON_DIRS_ROOT)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(LEGACY_CACHE_PY) > $@
 
-GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
+GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON) $(JSON_DIRS)
 
 $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)
-- 
2.51.0


