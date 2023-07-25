Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096C3761476
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjGYLTk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjGYLTj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD799
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1D0861693
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA076C433C7;
        Tue, 25 Jul 2023 11:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283977;
        bh=BqH4ejyVMYR4brVEqnan6kOVNeR2uqfMv42XM4NPiQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpAPXrUc0soP/H5eDhIVIEyV6TgLauaYUd1RPpKx/pxEGgmZxEisyMnm4+DPtdcHo
         0AiEFNJCs9//MT/wEr55Iqv/TLPcaUTAkdkYOKF0bFt6kzgwQ4ZV3dQGffbUUsuqWx
         saLesfEHyZNDikLNPUB9lgPEIszO3sJESnTSPqWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Fabian Hemmer <copy@copy.sh>, Ian Rogers <irogers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 183/509] perf bench: Use unbuffered output when pipe/teeing to a file
Date:   Tue, 25 Jul 2023 12:42:02 +0200
Message-ID: <20230725104602.084174761@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sohaib Mohamed <sohaib.amhmd@gmail.com>

[ Upstream commit f0a29c9647ff8bbb424641f79bc1894e83dec218 ]

The output of 'perf bench' gets buffered when I pipe it to a file or to
tee, in such a way that I can see it only at the end.

E.g.

  $ perf bench internals synthesize -t
  < output comes out fine after each test run >

  $ perf bench internals synthesize -t | tee file.txt
  < output comes out only at the end of all tests >

This patch resolves this issue for 'bench' and 'test' subcommands.

See, also:

  $ perf bench mem all | tee file.txt
  $ perf bench sched all | tee file.txt
  $ perf bench internals all -t | tee file.txt
  $ perf bench internals all | tee file.txt

Committer testing:

It really gets staggered, i.e. outputs in bursts, when the buffer fills
up and has to be drained to make up space for more output.

Suggested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Fabian Hemmer <copy@copy.sh>
Cc: Ian Rogers <irogers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20211119061409.78004-1-sohaib.amhmd@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 16203e9cd018 ("perf bench: Add missing setlocale() call to allow usage of %'d style formatting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-bench.c      | 5 +++--
 tools/perf/tests/builtin-test.c | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 62a7b7420a448..609a941ae2963 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -225,7 +225,6 @@ static void run_collection(struct collection *coll)
 		if (!bench->fn)
 			break;
 		printf("# Running %s/%s benchmark...\n", coll->name, bench->name);
-		fflush(stdout);
 
 		argv[1] = bench->name;
 		run_bench(coll->name, bench->name, bench->fn, 1, argv);
@@ -246,6 +245,9 @@ int cmd_bench(int argc, const char **argv)
 	struct collection *coll;
 	int ret = 0;
 
+	/* Unbuffered output */
+	setvbuf(stdout, NULL, _IONBF, 0);
+
 	if (argc < 2) {
 		/* No collection specified. */
 		print_usage();
@@ -299,7 +301,6 @@ int cmd_bench(int argc, const char **argv)
 
 			if (bench_format == BENCH_FORMAT_DEFAULT)
 				printf("# Running '%s/%s' benchmark:\n", coll->name, bench->name);
-			fflush(stdout);
 			ret = run_bench(coll->name, bench->name, bench->fn, argc-1, argv+1);
 			goto end;
 		}
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 132bdb3e6c31a..73c911dd0c2ca 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -793,6 +793,9 @@ int cmd_test(int argc, const char **argv)
         if (ret < 0)
                 return ret;
 
+	/* Unbuffered output */
+	setvbuf(stdout, NULL, _IONBF, 0);
+
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list"))
 		return perf_test__list(argc - 1, argv + 1);
-- 
2.39.2



