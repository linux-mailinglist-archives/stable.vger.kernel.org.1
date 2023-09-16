Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3227A3010
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbjIPM1e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbjIPM1U (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:27:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F179F194
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:27:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458E7C433C7;
        Sat, 16 Sep 2023 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867235;
        bh=4OfNXdIalXJLOEvF0H9XhjWQvElYXXv7tz6VVABdtiw=;
        h=Subject:To:Cc:From:Date:From;
        b=oIgxX5dHV4MzRRQvpMtqQp1d+ZKPefkZm2vf7rU1ihQ5L7ODWA46bxajnIgZed12Y
         sPDfgVZC+IBKVMWq68iKe9LHUADHFXkGVqct1H650NYnCYqJ5LG+4sqRVs8AT4/WaT
         7fpbdRCW/Fa4tRa3+qhivpLVvk1kGoj6vKLv4SB0=
Subject: FAILED: patch "[PATCH] perf test shell stat_bpf_counters: Fix test on Intel" failed to apply to 5.15-stable tree
To:     namhyung@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        irogers@google.com, jolsa@kernel.org, mingo@kernel.org,
        peterz@infradead.org, song@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:27:08 +0200
Message-ID: <2023091607-discuss-pointing-8b33@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 68ca249c964f520af7f8763e22f12bd26b57b870
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091607-discuss-pointing-8b33@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

68ca249c964f ("perf test shell stat_bpf_counters: Fix test on Intel")
c8b947642d23 ("perf test: Remove bash construct from stat_bpf_counters.sh test")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 68ca249c964f520af7f8763e22f12bd26b57b870 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 25 Aug 2023 09:41:51 -0700
Subject: [PATCH] perf test shell stat_bpf_counters: Fix test on Intel

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

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 513cd1e58e0e..a87bb2814b4c 100755
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

