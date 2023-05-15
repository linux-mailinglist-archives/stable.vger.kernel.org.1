Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00466703636
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbjEORHr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbjEORHb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81283AD05
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B299462AFB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC54FC4339B;
        Mon, 15 May 2023 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170357;
        bh=AovBjcm575drtSAMWsgUVVIaPf/JuNRsqrdn/SXp38o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAVOb4Sz9X/g5fQ16ytqn+gldZo9zUtnoHAeDb6G3YVyFs05HXG9BeH4lnROoGmYa
         VFJV5FrX9Iqz+gw1PZgMbKmpXz+i57A0o1HAJH/Ez81GH+YS5b+o6DAGa0SJzW6bxb
         8ksWo/movsPyN2bBPBNhIjfiSAmnfiq5ub6fDLvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Song Liu <song@kernel.org>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 105/239] perf stat: Separate bperf from bpf_profiler
Date:   Mon, 15 May 2023 18:26:08 +0200
Message-Id: <20230515161724.849239141@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitrii Dolgov <9erthalion6@gmail.com>

[ Upstream commit ecc68ee216c6c5b2f84915e1441adf436f1b019b ]

It seems that perf stat -b <prog id> doesn't produce any results:

    $ perf stat -e cycles -b 4 -I 10000 -vvv
    Control descriptor is not initialized
    cycles: 0 0 0
                time        counts unit      events
	10.007641640    <not supported>      cycles

Looks like this happens because fentry/fexit progs are getting loaded, but the
corresponding perf event is not enabled and not added into the events bpf map.
I think there is some mixing up between two type of bpf support, one for bperf
and one for bpf_profiler. Both are identified via evsel__is_bpf, based on which
perf events are enabled, but for the latter (bpf_profiler) a perf event is
required. Using evsel__is_bperf to check only bperf produces expected results:

    $ perf stat -e cycles -b 4 -I 10000 -vvv
    Control descriptor is not initialized
    ------------------------------------------------------------
    perf_event_attr:
      size                             136
      sample_type                      IDENTIFIER
      read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
      disabled                         1
      exclude_guest                    1
    ------------------------------------------------------------
    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
    ------------------------------------------------------------
    [...perf_event_attr for other CPUs...]
    ------------------------------------------------------------
    cycles: 309426 169009 169009
		time             counts unit events
	10.010091271             309426      cycles

The final numbers correspond (at least in the level of magnitude) to the
same metric obtained via bpftool.

Fixes: 112cb56164bc2108 ("perf stat: Introduce config stat.bpf-counter-events")
Reviewed-by: Song Liu <song@kernel.org>
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
Tested-by: Song Liu <song@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230412182316.11628-1-9erthalion6@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-stat.c | 4 ++--
 tools/perf/util/evsel.h   | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f6427e3a47421..a2c74a34e4a44 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -765,7 +765,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		counter->reset_group = false;
 		if (bpf_counter__load(counter, &target))
 			return -1;
-		if (!evsel__is_bpf(counter))
+		if (!(evsel__is_bperf(counter)))
 			all_counters_use_bpf = false;
 	}
 
@@ -781,7 +781,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		if (counter->reset_group || counter->errored)
 			continue;
-		if (evsel__is_bpf(counter))
+		if (evsel__is_bperf(counter))
 			continue;
 try_again:
 		if (create_perf_stat_counter(counter, &stat_config, &target,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 989865e16aadd..8ce30329a0772 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -263,6 +263,11 @@ static inline bool evsel__is_bpf(struct evsel *evsel)
 	return evsel->bpf_counter_ops != NULL;
 }
 
+static inline bool evsel__is_bperf(struct evsel *evsel)
+{
+	return evsel->bpf_counter_ops != NULL && list_empty(&evsel->bpf_counter_list);
+}
+
 #define EVSEL__MAX_ALIASES 8
 
 extern const char *const evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES];
-- 
2.39.2



