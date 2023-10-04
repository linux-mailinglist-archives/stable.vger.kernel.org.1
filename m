Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E154F7B87DD
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbjJDSKQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243907AbjJDSKP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:10:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC8AA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:10:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65246C433C8;
        Wed,  4 Oct 2023 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443012;
        bh=2nr6hw1t/kAGiTdEmk2oWVusqtPeuDrJdErtN+GXjjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okimJ2MiYdHytQAe9HoQcOGiyriow6qeCI1wMJL/c5Ubqw0qtJUqo5tpLhLzae6YI
         qel46SPHfl4B339fxpx/3fPsE6jRWy+HGSOJSHwxS2yilmErtWdiO4zoj1nK/u/NMk
         SnZ1bvSB5+zQVDyTsdD/NBuvwmu05+o072lbqFYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ian Rogers <rogers.email@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Perry Taylor <perry.taylor@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 151/183] perf metric: Return early if no CPU PMU table exists
Date:   Wed,  4 Oct 2023 19:56:22 +0200
Message-ID: <20231004175210.345761271@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 3f5df3ac646e21a79a421ae4037c4ef0632bcaa9 ]

Previous behavior is to segfault if there is no CPU PMU table and a
metric is sought. To reproduce compile with NO_JEVENTS=1 then request a
metric, for example, "perf stat -M IPC true".

Committer testing:

Before:

  $ make -k NO_JEVENTS=1 BUILD_BPF_SKEL=1 O=/tmp/build/perf-urgent -C tools/perf install-bin
  $ perf stat -M IPC true
  Segmentation fault (core dumped)
  $

After:

  $ perf stat -M IPC true

   Usage: perf stat [<options>] [<command>]

      -M, --metrics <metric/metric group list>
                            monitor specified metrics or metric groups (separated by ,)
  $

Fixes: 00facc760903be66 ("perf jevents: Switch build to use jevents.py")
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Caleb Biggers <caleb.biggers@intel.com>
Cc: Florian Fischer <florian.fischer@muhq.space>
Cc: Ian Rogers <rogers.email@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Perry Taylor <perry.taylor@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
Link: https://lore.kernel.org/r/20220830164846.401143-3-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/metricgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 29b747ac31c12..ee6c5582681bd 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1258,6 +1258,9 @@ int metricgroup__parse_groups(const struct option *opt,
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 	struct pmu_events_map *map = pmu_events_map__find();
 
+	if (!table)
+		return -EINVAL;
+
 	return parse_groups(perf_evlist, str, metric_no_group,
 			    metric_no_merge, NULL, metric_events, map);
 }
-- 
2.40.1



