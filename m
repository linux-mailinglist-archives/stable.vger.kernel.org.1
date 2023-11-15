Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B0C7E2516
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjKFN2I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjKFN2G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:28:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497EEA9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:28:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E06AC433C8;
        Mon,  6 Nov 2023 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277284;
        bh=afgH8ug/BvbIXVPoC/dddxzwpcgIFT7bsJpk92+Xw/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XD7pgJ03Wte5B/sS6rEqDS/JXNtuC8o5SCDEaSOlx9kVC7fQfe43OKRGijdCGLKqF
         kvh3c9IYuEohAAEeWvUcAUqJPQO7TslxeKYI6a1qAK1z5uEXcqejPRxs6NGKjWJIFw
         pIFJUe9Y9XdVxymdpfJffjz2XinOI3HxHDr5NFHM=
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
Subject: [PATCH 5.15 101/128] perf evlist: Add evlist__add_dummy_on_all_cpus()
Date:   Mon,  6 Nov 2023 14:04:21 +0100
Message-ID: <20231106130313.750783324@linuxfoundation.org>
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
index 39d294f6c3218..a75cdcf381308 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -258,6 +258,51 @@ int evlist__add_dummy(struct evlist *evlist)
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
index ec177f783ee67..decf5c944adba 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -112,6 +112,11 @@ int __evlist__add_default_attrs(struct evlist *evlist,
 int arch_evlist__add_default_attrs(struct evlist *evlist);
 
 int evlist__add_dummy(struct evlist *evlist);
+struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
+static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
+{
+	return evlist__add_aux_dummy(evlist, true);
+}
 
 int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
 			 evsel__sb_cb_t cb, void *data);
-- 
2.42.0



