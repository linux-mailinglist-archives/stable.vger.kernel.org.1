Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7F74C399
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjGILeS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjGILeE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:34:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170CD198
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 963CC60BB7
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF01C433C7;
        Sun,  9 Jul 2023 11:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902442;
        bh=taG4qCBqQ9MsDoRemM+0S8nS4ghp6nvYQZ23pk+8r7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vr+M/okLy0vz2M4SoMqHwsRawmMwuwCxPuDN7F++FSXUMqg6LbIRTCEIw60Fi00Y5
         v6zF7cZs3fqEH92gfqcNDq12yiX9PxvE40k3KtPo5hjNw7v5mw+FbABvEUcy0cdb5i
         vFtFnzX3IS1/bmnqGMj162wFfI1VBh+vWzuGKSnU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ravi Bangoria <ravi.bangoria@amd.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Santosh Shukla <santosh.shukla@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 378/431] perf tool x86: Consolidate is_amd check into single function
Date:   Sun,  9 Jul 2023 13:15:26 +0200
Message-ID: <20230709111500.026814234@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@amd.com>

[ Upstream commit 0cd1ca4650c9cf5f318110f67d39cbebae3693b3 ]

There are multiple places where x86 specific code determines AMD vs
Intel arch and acts based on that. Consolidate those checks into a
single function.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ali Saidi <alisaidi@amazon.com>
Cc: Ananth Narayan <ananth.narayan@amd.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Santosh Shukla <santosh.shukla@amd.com>
Link: https://lore.kernel.org/r/20230613095506.547-3-ravi.bangoria@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 99d4850062a8 ("perf tool x86: Fix perf_env memory leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/arch/x86/util/Build        |  1 +
 tools/perf/arch/x86/util/env.c        | 19 +++++++++++++++++++
 tools/perf/arch/x86/util/env.h        |  7 +++++++
 tools/perf/arch/x86/util/evsel.c      | 16 ++--------------
 tools/perf/arch/x86/util/mem-events.c | 19 ++-----------------
 5 files changed, 31 insertions(+), 31 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/env.c
 create mode 100644 tools/perf/arch/x86/util/env.h

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 195ccfdef7aa1..005907cb97d8c 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -10,6 +10,7 @@ perf-y += evlist.o
 perf-y += mem-events.o
 perf-y += evsel.o
 perf-y += iostat.o
+perf-y += env.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/env.c
new file mode 100644
index 0000000000000..33b87f8ac1cc1
--- /dev/null
+++ b/tools/perf/arch/x86/util/env.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "linux/string.h"
+#include "util/env.h"
+#include "env.h"
+
+bool x86__is_amd_cpu(void)
+{
+	struct perf_env env = { .total_mem = 0, };
+	static int is_amd; /* 0: Uninitialized, 1: Yes, -1: No */
+
+	if (is_amd)
+		goto ret;
+
+	perf_env__cpuid(&env);
+	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 : -1;
+
+ret:
+	return is_amd >= 1 ? true : false;
+}
diff --git a/tools/perf/arch/x86/util/env.h b/tools/perf/arch/x86/util/env.h
new file mode 100644
index 0000000000000..d78f080b6b3f8
--- /dev/null
+++ b/tools/perf/arch/x86/util/env.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_ENV_H
+#define _X86_ENV_H
+
+bool x86__is_amd_cpu(void);
+
+#endif /* _X86_ENV_H */
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index ea3972d785d10..d72390cdf391d 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -7,6 +7,7 @@
 #include "linux/string.h"
 #include "evsel.h"
 #include "util/debug.h"
+#include "env.h"
 
 #define IBS_FETCH_L3MISSONLY   (1ULL << 59)
 #define IBS_OP_L3MISSONLY      (1ULL << 16)
@@ -97,23 +98,10 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
 {
 	struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
 	static int warned_once;
-	/* 0: Uninitialized, 1: Yes, -1: No */
-	static int is_amd;
 
-	if (warned_once || is_amd == -1)
+	if (warned_once || !x86__is_amd_cpu())
 		return;
 
-	if (!is_amd) {
-		struct perf_env *env = evsel__env(evsel);
-
-		if (!perf_env__cpuid(env) || !env->cpuid ||
-		    !strstarts(env->cpuid, "AuthenticAMD")) {
-			is_amd = -1;
-			return;
-		}
-		is_amd = 1;
-	}
-
 	evsel_pmu = evsel__find_pmu(evsel);
 	if (!evsel_pmu)
 		return;
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index f683ac702247c..efc0fae9ed0a7 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -4,6 +4,7 @@
 #include "map_symbol.h"
 #include "mem-events.h"
 #include "linux/string.h"
+#include "env.h"
 
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
@@ -26,28 +27,12 @@ static struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E("mem-ldst",	"ibs_op//",	"ibs_op"),
 };
 
-static int perf_mem_is_amd_cpu(void)
-{
-	struct perf_env env = { .total_mem = 0, };
-
-	perf_env__cpuid(&env);
-	if (env.cpuid && strstarts(env.cpuid, "AuthenticAMD"))
-		return 1;
-	return -1;
-}
-
 struct perf_mem_event *perf_mem_events__ptr(int i)
 {
-	/* 0: Uninitialized, 1: Yes, -1: No */
-	static int is_amd;
-
 	if (i >= PERF_MEM_EVENTS__MAX)
 		return NULL;
 
-	if (!is_amd)
-		is_amd = perf_mem_is_amd_cpu();
-
-	if (is_amd == 1)
+	if (x86__is_amd_cpu())
 		return &perf_mem_events_amd[i];
 
 	return &perf_mem_events_intel[i];
-- 
2.39.2



