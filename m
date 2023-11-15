Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB07E7E2590
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjKFNda (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjKFNd3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:33:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D389A9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:33:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8A5C433C8;
        Mon,  6 Nov 2023 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277606;
        bh=ERtyUS4eoJND5siG8YLiIKNCX993T0cMMDSShq51OVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRWh2tZkL+VWKT1qu04Xgxd69vKk11K/hhGa8kBp3PY2F4e3farVylvFoB0Z/lvk9
         EUCD63mXPoKMIjx/784CDT+KGGBXBCvTRFDSc2C1+n6s1qGwL/KMimJZLfWmh5s7b7
         EdqZ9bXjp80cBZFUBg2x7OyEHoV9/LjnVbCVRpyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 75/95] perf evlist: Add evlist__add_dummy_on_all_cpus()
Date:   Mon,  6 Nov 2023 14:04:43 +0100
Message-ID: <20231106130307.463179782@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 126d68fdcabed8c2ca5ffaba785add93ef722da8 ]

Add evlist__add_dummy_on_all_cpus() to enable creating a system-wide dummy
event that sets up the system-wide maps before map propagation.

For convenience, add evlist__add_aux_dummy() so that the logic can be used
whether or not the event needs to be system-wide.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Link: https://lore.kernel.org/r/20220524075436.29144-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: f9cdeb58a9cf ("perf evlist: Avoid frequency mode for the dummy event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/evlist.c | 45 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  5 +++++
 2 files changed, 50 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 98ae432470cdd..117420abdc325 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -261,6 +261,51 @@ int evlist__add_dummy(struct evlist *evlist)
 	return 0;
 }
 
+static void evlist__add_on_all_cpus(struct evlist *evlist, struct evsel *evsel)
+{
+	evsel->core.system_wide = true;
+
+	/*
+	 * All CPUs.
+	 *
+	 * Note perf_event_open() does not accept CPUs that are not online, so
+	 * in fact this CPU list will include only all online CPUs.
+	 */
+	perf_cpu_map__put(evsel->core.own_cpus);
+	evsel->core.own_cpus = perf_cpu_map__new(NULL);
+	perf_cpu_map__put(evsel->core.cpus);
+	evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
+
+	/* No threads */
+	perf_thread_map__put(evsel->core.threads);
+	evsel->core.threads = perf_thread_map__new_dummy();
+
+	evlist__add(evlist, evsel);
+}
+
+struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
+{
+	struct evsel *evsel = evlist__dummy_event(evlist);
+
+	if (!evsel)
+		return NULL;
+
+	evsel->core.attr.exclude_kernel = 1;
+	evsel->core.attr.exclude_guest = 1;
+	evsel->core.attr.exclude_hv = 1;
+	evsel->core.attr.freq = 0;
+	evsel->core.attr.sample_period = 1;
+	evsel->no_aux_samples = true;
+	evsel->name = strdup("dummy:u");
+
+	if (system_wide)
+		evlist__add_on_all_cpus(evlist, evsel);
+	else
+		evlist__add(evlist, evsel);
+
+	return evsel;
+}
+
 static int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
 {
 	struct evsel *evsel, *n;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 9298fce53ea31..eb36f85ba3f3e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -111,6 +111,11 @@ int __evlist__add_default_attrs(struct evlist *evlist,
 	__evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
 
 int evlist__add_dummy(struct evlist *evlist);
+struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
+static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
+{
+	return evlist__add_aux_dummy(evlist, true);
+}
 
 int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
-- 
2.42.0



