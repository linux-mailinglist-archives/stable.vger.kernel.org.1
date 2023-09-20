Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC47A8191
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjITMqk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjITMqj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:46:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C392EF0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:46:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D5AC433CA;
        Wed, 20 Sep 2023 12:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213989;
        bh=GhHn7z7pT4T8Lyy/OVsC4TQSNE5PsW5IxF4LHM9Lm6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HS0KJ3chT1Retjubs86OdDEMvBxu7zbkKziXbJlKGR4HdamQLXS1rXIgB8RMJoeZR
         NSK+h9Zl8oq7coDf33mYxo3jCa/H0wSbH+cmNT0XJAKs6rBD8YMEL77p9xQFzReSQS
         P4ynJD32fOl178ygwg6cGJ/nx+TGGVnt80eDPXFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Song Liu <song@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 072/110] perf test shell stat_bpf_counters: Fix test on Intel
Date:   Wed, 20 Sep 2023 13:32:10 +0200
Message-ID: <20230920112833.126246427@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 68ca249c964f520af7f8763e22f12bd26b57b870 ]

As of now, bpf counters (bperf) don't support event groups.  But the
default perf stat includes topdown metrics if supported (on recent Intel
machines) which require groups.  That makes perf stat exiting.

  $ sudo perf stat --bpf-counter true
  bpf managed perf events do not yet support groups.

Actually the test explicitly uses cycles event only, but it missed to
pass the option when it checks the availability of the command.

Fixes: 2c0cb9f56020d2ea ("perf test: Add a shell test for 'perf stat --bpf-counters' new option")
Reviewed-by: Song Liu <song@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230825164152.165610-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 13473aeba489c..6bf24b85294c7 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -22,10 +22,10 @@ compare_number()
 }
 
 # skip if --bpf-counters is not supported
-if ! perf stat --bpf-counters true > /dev/null 2>&1; then
+if ! perf stat -e cycles --bpf-counters true > /dev/null 2>&1; then
 	if [ "$1" = "-v" ]; then
 		echo "Skipping: --bpf-counters not supported"
-		perf --no-pager stat --bpf-counters true || true
+		perf --no-pager stat -e cycles --bpf-counters true || true
 	fi
 	exit 2
 fi
-- 
2.40.1



