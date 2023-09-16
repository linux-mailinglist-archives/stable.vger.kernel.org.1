Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0557F7A3013
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbjIPM2E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239323AbjIPM1h (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:27:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB6ACED
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:27:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F90DC433C8;
        Sat, 16 Sep 2023 12:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867251;
        bh=cQ/rzFLDddt54ppzD9uXQHQGXQjZh5ur3cnPdeOfBOc=;
        h=Subject:To:Cc:From:Date:From;
        b=EQvTYnmeJAXEd8f4jNRqJpnQkYl/gEAnr08YOyv/mhU6VKoz/8gHuDdsuB4eVaWmi
         dM4IoH1dwk04lpNSdtwHGZJxfsEuaihHCA224YXlJd19ajNgWK2Tqkr56LwzpmVJu1
         2ejzlkO45DVx7xaLXBgR7kfplGFh8N941RsppBlA=
Subject: FAILED: patch "[PATCH] perf tools: Handle old data in PERF_RECORD_ATTR" failed to apply to 4.19-stable tree
To:     namhyung@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        irogers@google.com, jolsa@kernel.org, mingo@kernel.org,
        peterz@infradead.org, zanussi@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:27:28 +0200
Message-ID: <2023091628-endurance-silencer-f1f0@gregkh>
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 9bf63282ea77a531ea58acb42fb3f40d2d1e4497
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091628-endurance-silencer-f1f0@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

9bf63282ea77 ("perf tools: Handle old data in PERF_RECORD_ATTR")
b0031c22819a ("libperf: Add perf_evlist__id_add() function")
ff47d86a0d9b ("libperf: Add perf_evlist__read_format() function")
515dbe48f620 ("libperf: Add perf_evlist__first()/last() functions")
70c20369ee95 ("libperf: Add perf_evsel__alloc_id/perf_evsel__free_id functions")
1d5af02d7a92 ("libperf: Move 'heads' from 'struct evlist' to 'struct perf_evlist'")
e7eb9002d451 ("libperf: Move 'ids' from 'struct evsel' to 'struct perf_evsel'")
deaf321913a7 ("libperf: Move 'id' from 'struct evsel' to 'struct perf_evsel'")
8cd36f3ef492 ("libperf: Move 'sample_id' from 'struct evsel' to 'struct perf_evsel'")
40cb2d5141bd ("libperf: Move 'pollfd' from 'struct evlist' to 'struct perf_evlist'")
f6fa43757793 ("libperf: Move 'mmap_len' from 'struct evlist' to 'struct perf_evlist'")
c976ee11a0e1 ("libperf: Move 'nr_mmaps' from 'struct evlist' to 'struct perf_evlist'")
648b5af3f3ae ("libperf: Move 'system_wide' from 'struct evsel' to 'struct perf_evsel'")
2cf07b294a60 ("libperf: Add 'fd' to struct perf_mmap")
4fd0cef2c7b6 ("libperf: Add 'mask' to struct perf_mmap")
547740f7b357 ("libperf: Add perf_mmap struct")
e0fcfb086fbb ("perf evlist: Adopt backwards ring buffer state enum")
9521b5f2d9d3 ("perf tools: Rename perf_evlist__mmap() to evlist__mmap()")
a583053299c1 ("perf tools: Rename 'struct perf_mmap' to 'struct mmap'")
ce095c9ac293 ("perf test: Fix spelling mistake "allos" -> "allocate"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9bf63282ea77a531ea58acb42fb3f40d2d1e4497 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 25 Aug 2023 08:25:49 -0700
Subject: [PATCH] perf tools: Handle old data in PERF_RECORD_ATTR

The PERF_RECORD_ATTR is used for a pipe mode to describe an event with
attribute and IDs.  The ID table comes after the attr and it calculate
size of the table using the total record size and the attr size.

  n_ids = (total_record_size - end_of_the_attr_field) / sizeof(u64)

This is fine for most use cases, but sometimes it saves the pipe output
in a file and then process it later.  And it becomes a problem if there
is a change in attr size between the record and report.

  $ perf record -o- > perf-pipe.data  # old version
  $ perf report -i- < perf-pipe.data  # new version

For example, if the attr size is 128 and it has 4 IDs, then it would
save them in 168 byte like below:

   8 byte: perf event header { .type = PERF_RECORD_ATTR, .size = 168 },
 128 byte: perf event attr { .size = 128, ... },
  32 byte: event IDs [] = { 1234, 1235, 1236, 1237 },

But when report later, it thinks the attr size is 136 then it only read
the last 3 entries as ID.

   8 byte: perf event header { .type = PERF_RECORD_ATTR, .size = 168 },
 136 byte: perf event attr { .size = 136, ... },
  24 byte: event IDs [] = { 1235, 1236, 1237 },  // 1234 is missing

So it should use the recorded version of the attr.  The attr has the
size field already then it should honor the size when reading data.

Fixes: 2c46dbb517a10b18 ("perf: Convert perf header attrs into attr events")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230825152552.112913-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 99c61cdffa54..e13f4bab7c49 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4378,7 +4378,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct evlist **pevlist)
 {
-	u32 i, ids, n_ids;
+	u32 i, n_ids;
+	u64 *ids;
 	struct evsel *evsel;
 	struct evlist *evlist = *pevlist;
 
@@ -4394,9 +4395,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 
 	evlist__add(evlist, evsel);
 
-	ids = event->header.size;
-	ids -= (void *)&event->attr.id - (void *)event;
-	n_ids = ids / sizeof(u64);
+	n_ids = event->header.size - sizeof(event->header) - event->attr.attr.size;
+	n_ids = n_ids / sizeof(u64);
 	/*
 	 * We don't have the cpu and thread maps on the header, so
 	 * for allocating the perf_sample_id table we fake 1 cpu and
@@ -4405,8 +4405,9 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 	if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
 		return -ENOMEM;
 
+	ids = (void *)&event->attr.attr + event->attr.attr.size;
 	for (i = 0; i < n_ids; i++) {
-		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, event->attr.id[i]);
+		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ids[i]);
 	}
 
 	return 0;

