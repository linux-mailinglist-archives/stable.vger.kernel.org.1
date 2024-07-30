Return-Path: <stable+bounces-63935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E34941B59
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD441F23231
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA691898EB;
	Tue, 30 Jul 2024 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jKoWm3nH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053A18801A;
	Tue, 30 Jul 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358427; cv=none; b=a3JO74U6evZ+OY3TqGf3GNbiAaIW6V1Qlg+R3vZXQAdoCejEwOZdgbgKambSO4dlpfTpfUVbcT+F0UwSh9QFSyXTShbd+rradxBZlkBzROIPGQjRVL/AcOlmMfdzrNGJmoBVfLPWnG4GTdQ6Q9XlGK0EDkI9uYWaODdFnEyIjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358427; c=relaxed/simple;
	bh=/xKMJ/n70afPwS2m2dKbkTd+ngjcxbB3I0HIDD8bIqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzJbW75814yH8Zd3zo4pSxIjaN4E+AgcJyF8bU8bUeePJohAJiYuHOibqDs4Kj5cwm2C+xECIEOo1rP94THofzIMOLQqxWjhuHROrTklW9Jube3F0B/5+y+oiqsGjchEV30BExrHjq7+3vZSzQrgTRTkipICh8ma7T2bAsIWaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jKoWm3nH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D600DC32782;
	Tue, 30 Jul 2024 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358427;
	bh=/xKMJ/n70afPwS2m2dKbkTd+ngjcxbB3I0HIDD8bIqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKoWm3nHfQJFZE4q7rcZOlYM1TAEB+DfSd7ActcdQ06kaAWCF26VEsLwIXhh7cNvv
	 PGjUIwd5e6bfWeIzg0PfJqoVI2PpVu7l7uITOm9CC5W5RHaraXWCW8UCM/MCfLty2R
	 CJiaZg9W3m11az0wgaydAbSmn4h+VI0TNzyADd5g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Clark <james.clark@arm.com>,
	Ian Rogers <irogers@google.com>,
	robin.murphy@arm.com,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 358/809] perf pmu: Restore full PMU name wildcard support
Date: Tue, 30 Jul 2024 17:43:54 +0200
Message-ID: <20240730151738.785389417@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Clark <james.clark@arm.com>

[ Upstream commit 3e0bf9fde29844694ad9912aa290fbdb2c3fa767 ]

Commit b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic
pmu events") gives the following example for wildcarding a subset of
PMUs:

  E.g., in a system with the following dynamic pmus:

        mypmu_0
        mypmu_1
        mypmu_2
        mypmu_4

  perf stat -e mypmu_[01]/<config>/

Since commit f91fa2ae6360 ("perf pmu: Refactor perf_pmu__match()"), only
"*" has been supported, removing the ability to subset PMUs, even though
parse-events.l still supports ? and [] characters.

Fix it by using fnmatch() when any glob character is detected and add a
test which covers that and other scenarios of
perf_pmu__match_ignoring_suffix().

Fixes: f91fa2ae6360 ("perf pmu: Refactor perf_pmu__match()")
Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: robin.murphy@arm.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240626145448.896746-2-james.clark@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/pmu.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  |  2 +-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index cc88b5920c3e2..fd07331b2d6e6 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -437,12 +437,90 @@ static int test__name_cmp(struct test_suite *test __maybe_unused, int subtest __
 	return TEST_OK;
 }
 
+/**
+ * Test perf_pmu__match() that's used to search for a PMU given a name passed
+ * on the command line. The name that's passed may also be a filename type glob
+ * match.
+ */
+static int test__pmu_match(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_pmu test_pmu;
+
+	test_pmu.name = "pmuname";
+	TEST_ASSERT_EQUAL("Exact match", perf_pmu__match(&test_pmu, "pmuname"),	     true);
+	TEST_ASSERT_EQUAL("Longer token", perf_pmu__match(&test_pmu, "longertoken"), false);
+	TEST_ASSERT_EQUAL("Shorter token", perf_pmu__match(&test_pmu, "pmu"),	     false);
+
+	test_pmu.name = "pmuname_10";
+	TEST_ASSERT_EQUAL("Diff suffix_", perf_pmu__match(&test_pmu, "pmuname_2"),  false);
+	TEST_ASSERT_EQUAL("Sub suffix_",  perf_pmu__match(&test_pmu, "pmuname_1"),  true);
+	TEST_ASSERT_EQUAL("Same suffix_", perf_pmu__match(&test_pmu, "pmuname_10"), true);
+	TEST_ASSERT_EQUAL("No suffix_",   perf_pmu__match(&test_pmu, "pmuname"),    true);
+	TEST_ASSERT_EQUAL("Underscore_",  perf_pmu__match(&test_pmu, "pmuname_"),   true);
+	TEST_ASSERT_EQUAL("Substring_",   perf_pmu__match(&test_pmu, "pmuna"),      false);
+
+	test_pmu.name = "pmuname_ab23";
+	TEST_ASSERT_EQUAL("Diff suffix hex_", perf_pmu__match(&test_pmu, "pmuname_2"),    false);
+	TEST_ASSERT_EQUAL("Sub suffix hex_",  perf_pmu__match(&test_pmu, "pmuname_ab"),   true);
+	TEST_ASSERT_EQUAL("Same suffix hex_", perf_pmu__match(&test_pmu, "pmuname_ab23"), true);
+	TEST_ASSERT_EQUAL("No suffix hex_",   perf_pmu__match(&test_pmu, "pmuname"),      true);
+	TEST_ASSERT_EQUAL("Underscore hex_",  perf_pmu__match(&test_pmu, "pmuname_"),     true);
+	TEST_ASSERT_EQUAL("Substring hex_",   perf_pmu__match(&test_pmu, "pmuna"),	 false);
+
+	test_pmu.name = "pmuname10";
+	TEST_ASSERT_EQUAL("Diff suffix", perf_pmu__match(&test_pmu, "pmuname2"),  false);
+	TEST_ASSERT_EQUAL("Sub suffix",  perf_pmu__match(&test_pmu, "pmuname1"),  true);
+	TEST_ASSERT_EQUAL("Same suffix", perf_pmu__match(&test_pmu, "pmuname10"), true);
+	TEST_ASSERT_EQUAL("No suffix",   perf_pmu__match(&test_pmu, "pmuname"),   true);
+	TEST_ASSERT_EQUAL("Underscore",  perf_pmu__match(&test_pmu, "pmuname_"),  false);
+	TEST_ASSERT_EQUAL("Substring",   perf_pmu__match(&test_pmu, "pmuna"),     false);
+
+	test_pmu.name = "pmunameab23";
+	TEST_ASSERT_EQUAL("Diff suffix hex", perf_pmu__match(&test_pmu, "pmuname2"),    false);
+	TEST_ASSERT_EQUAL("Sub suffix hex",  perf_pmu__match(&test_pmu, "pmunameab"),   true);
+	TEST_ASSERT_EQUAL("Same suffix hex", perf_pmu__match(&test_pmu, "pmunameab23"), true);
+	TEST_ASSERT_EQUAL("No suffix hex",   perf_pmu__match(&test_pmu, "pmuname"),     true);
+	TEST_ASSERT_EQUAL("Underscore hex",  perf_pmu__match(&test_pmu, "pmuname_"),    false);
+	TEST_ASSERT_EQUAL("Substring hex",   perf_pmu__match(&test_pmu, "pmuna"),	false);
+
+	/*
+	 * 2 hex chars or less are not considered suffixes so it shouldn't be
+	 * possible to wildcard by skipping the suffix. Therefore there are more
+	 * false results here than above.
+	 */
+	test_pmu.name = "pmuname_a3";
+	TEST_ASSERT_EQUAL("Diff suffix 2 hex_", perf_pmu__match(&test_pmu, "pmuname_2"),  false);
+	/*
+	 * This one should be false, but because pmuname_a3 ends in 3 which is
+	 * decimal, it's not possible to determine if it's a short hex suffix or
+	 * a normal decimal suffix following text. And we want to match on any
+	 * length of decimal suffix. Run the test anyway and expect the wrong
+	 * result. And slightly fuzzy matching shouldn't do too much harm.
+	 */
+	TEST_ASSERT_EQUAL("Sub suffix 2 hex_",  perf_pmu__match(&test_pmu, "pmuname_a"),  true);
+	TEST_ASSERT_EQUAL("Same suffix 2 hex_", perf_pmu__match(&test_pmu, "pmuname_a3"), true);
+	TEST_ASSERT_EQUAL("No suffix 2 hex_",   perf_pmu__match(&test_pmu, "pmuname"),    false);
+	TEST_ASSERT_EQUAL("Underscore 2 hex_",  perf_pmu__match(&test_pmu, "pmuname_"),   false);
+	TEST_ASSERT_EQUAL("Substring 2 hex_",   perf_pmu__match(&test_pmu, "pmuna"),	  false);
+
+	test_pmu.name = "pmuname_5";
+	TEST_ASSERT_EQUAL("Glob 1", perf_pmu__match(&test_pmu, "pmu*"),		   true);
+	TEST_ASSERT_EQUAL("Glob 2", perf_pmu__match(&test_pmu, "nomatch*"),	   false);
+	TEST_ASSERT_EQUAL("Seq 1",  perf_pmu__match(&test_pmu, "pmuname_[12345]"), true);
+	TEST_ASSERT_EQUAL("Seq 2",  perf_pmu__match(&test_pmu, "pmuname_[67890]"), false);
+	TEST_ASSERT_EQUAL("? 1",    perf_pmu__match(&test_pmu, "pmuname_?"),	   true);
+	TEST_ASSERT_EQUAL("? 2",    perf_pmu__match(&test_pmu, "pmuname_1?"),	   false);
+
+	return TEST_OK;
+}
+
 static struct test_case tests__pmu[] = {
 	TEST_CASE("Parsing with PMU format directory", pmu_format),
 	TEST_CASE("Parsing with PMU event", pmu_events),
 	TEST_CASE("PMU event names", pmu_event_names),
 	TEST_CASE("PMU name combining", name_len),
 	TEST_CASE("PMU name comparison", name_cmp),
+	TEST_CASE("PMU cmdline match", pmu_match),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 888ce99122759..22291f48e4da1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2143,7 +2143,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok)
 {
 	const char *name = pmu->name;
-	bool need_fnmatch = strchr(tok, '*') != NULL;
+	bool need_fnmatch = strisglob(tok);
 
 	if (!strncmp(tok, "uncore_", 7))
 		tok += 7;
-- 
2.43.0




