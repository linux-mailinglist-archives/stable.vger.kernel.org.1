Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036977E2518
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjKFN2O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjKFN2N (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:28:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2288892
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:28:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E4AC433C8;
        Mon,  6 Nov 2023 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277289;
        bh=ArGcf0pSKS5FAMQmVFDL6Rz0vzAQxi5YyI82Pfch0GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C87rAwsWagN/zUjELf4OuhC++NqJlsW5VblMTTCUramVteq/n6XfLosB8EMTAWHvD
         TZNv0raeLZonhHwu97YvWHCahhzOPgxqOdT+AY6IeogZ7SCDqMHPiYW/wJSC2QqZ1w
         yuj+yTlik4k+mKgkG08eWNuaXSbqc81IjFdFxtmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 103/128] perf evlist: Avoid frequency mode for the dummy event
Date:   Mon,  6 Nov 2023 14:04:23 +0100
Message-ID: <20231106130313.855579935@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit f9cdeb58a9cf46c09b56f5f661ea8da24b6458c3 ]

Dummy events are created with an attribute where the period and freq
are zero. evsel__config will then see the uninitialized values and
initialize them in evsel__default_freq_period. As fequency mode is
used by default the dummy event would be set to use frequency
mode. However, this has no effect on the dummy event but does cause
unnecessary timers/interrupts. Avoid this overhead by setting the
period to 1 for dummy events.

evlist__add_aux_dummy calls evlist__add_dummy then sets freq=0 and
period=1. This isn't necessary after this change and so the setting is
removed.

>From Stephane:

The dummy event is not counting anything. It is used to collect mmap
records and avoid a race condition during the synthesize mmap phase of
perf record. As such, it should not cause any overhead during active
profiling. Yet, it did. Because of a bug the dummy event was
programmed as a sampling event in frequency mode. Events in that mode
incur more kernel overheads because on timer tick, the kernel has to
look at the number of samples for each event and potentially adjust
the sampling period to achieve the desired frequency. The dummy event
was therefore adding a frequency event to task and ctx contexts we may
otherwise not have any, e.g.,

  perf record -a -e cpu/event=0x3c,period=10000000/.

On each timer tick the perf_adjust_freq_unthr_context() is invoked and
if ctx->nr_freq is non-zero, then the kernel will loop over ALL the
events of the context looking for frequency mode ones. In doing, so it
locks the context, and enable/disable the PMU of each hw event. If all
the events of the context are in period mode, the kernel will have to
traverse the list for nothing incurring overhead. The overhead is
multiplied by a very large factor when this happens in a guest kernel.
There is no need for the dummy event to be in frequency mode, it does
not count anything and therefore should not cause extra overhead for
no reason.

Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy constructor")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Yang Jihong <yangjihong1@huawei.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20230916035640.1074422-1-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/evlist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 63ef40543a9fe..9d0f2feb25671 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -248,6 +248,9 @@ int evlist__add_dummy(struct evlist *evlist)
 		.type	= PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_DUMMY,
 		.size	= sizeof(attr), /* to capture ABI version */
+		/* Avoid frequency mode for dummy events to avoid associated timers. */
+		.freq = 0,
+		.sample_period = 1,
 	};
 	struct evsel *evsel = evsel__new_idx(&attr, evlist->core.nr_entries);
 
@@ -268,8 +271,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 	evsel->core.attr.exclude_kernel = 1;
 	evsel->core.attr.exclude_guest = 1;
 	evsel->core.attr.exclude_hv = 1;
-	evsel->core.attr.freq = 0;
-	evsel->core.attr.sample_period = 1;
 	evsel->core.system_wide = system_wide;
 	evsel->no_aux_samples = true;
 	evsel->name = strdup("dummy:u");
-- 
2.42.0



