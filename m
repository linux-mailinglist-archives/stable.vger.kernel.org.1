Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE217A818C
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjITMqc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbjITMqb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:46:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D71E5
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:46:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CFFC433CA;
        Wed, 20 Sep 2023 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213981;
        bh=bwmSVeVpTrBQxzs5bqjJfJoDpD7pEnmS0H8Bf20zJVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLILL0RdiSfo5LfeWPsySn+Xluy4m7Lbj3ytR4+lmc0U0ssO8KmTnc8fhIad1hYGd
         3i/Ytov1z75CSM9CZlf44lyyqih1WeqmbyzbAZ0c8VdVKtgEDLS7eG2fbUHRrgAXb+
         wvrJYoeeGT3cSo33mmUGUFCTX/Toz/16AF6ab8cc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Felix Fietkau <nbd@nbd.name>,
        Ian Rogers <rogers.email@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Like Xu <likexu@tencent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Forrington <nick.forrington@arm.com>,
        Paul Clarke <pc@us.ibm.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Liu <liuqi115@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Santosh Shukla <santosh.shukla@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Will Deacon <will@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 069/110] perf jevents: Switch build to use jevents.py
Date:   Wed, 20 Sep 2023 13:32:07 +0200
Message-ID: <20230920112833.006069792@linuxfoundation.org>
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

From: Ian Rogers <rogers.email@gmail.com>

[ Upstream commit 00facc760903be6675870c2749e2cd72140e396e ]

Generate pmu-events.c using jevents.py rather than the binary built from
jevents.c.

Add a new config variable NO_JEVENTS that is set when there is no
architecture json or an appropriate python interpreter isn't present.

When NO_JEVENTS is defined the file pmu-events/empty-pmu-events.c is
copied and used as the pmu-events.c file.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: John Garry <john.garry@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ananth Narayan <ananth.narayan@amd.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrew Kilroy <andrew.kilroy@arm.com>
Cc: Caleb Biggers <caleb.biggers@intel.com>
Cc: Felix Fietkau <nbd@nbd.name>
Cc: Ian Rogers <rogers.email@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc: Like Xu <likexu@tencent.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Forrington <nick.forrington@arm.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Perry Taylor <perry.taylor@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qi Liu <liuqi115@huawei.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Santosh Shukla <santosh.shukla@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
Link: https://lore.kernel.org/r/20220629182505.406269-4-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 7822a8913f4c ("perf build: Update build rule for generated files")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.config               |  19 +++
 tools/perf/Makefile.perf                 |   1 +
 tools/perf/pmu-events/Build              |  13 +-
 tools/perf/pmu-events/empty-pmu-events.c | 158 +++++++++++++++++++++++
 4 files changed, 189 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/pmu-events/empty-pmu-events.c

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 973c0d5ed8d8b..e1077c4d30fff 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -857,6 +857,25 @@ else
   endif
 endif
 
+ifneq ($(NO_JEVENTS),1)
+  ifeq ($(wildcard pmu-events/arch/$(SRCARCH)/mapfile.csv),)
+    NO_JEVENTS := 1
+  endif
+endif
+ifneq ($(NO_JEVENTS),1)
+  NO_JEVENTS := 0
+  ifndef PYTHON
+    $(warning No python interpreter disabling jevent generation)
+    NO_JEVENTS := 1
+  else
+    # jevents.py uses f-strings present in Python 3.6 released in Dec. 2016.
+    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 6) else "0")' 2> /dev/null)
+    ifneq ($(JEVENTS_PYTHON_GOOD), 1)
+      $(warning Python interpreter too old (older than 3.6) disabling jevent generation)
+      NO_JEVENTS := 1
+    endif
+  endif
+endif
 
 ifndef NO_LIBBFD
   ifeq ($(feature-libbfd), 1)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b856afa6eb52e..b82f2d89d74c4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -649,6 +649,7 @@ JEVENTS       := $(OUTPUT)pmu-events/jevents
 JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
 
 PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+export NO_JEVENTS
 
 export JEVENTS
 
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a055dee6a46af..5ec5ce8c31bab 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -9,10 +9,19 @@ JSON		=  $(shell [ -d $(JDIR) ] &&				\
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
+JEVENTS_PY	=  pmu-events/jevents.py
 
 #
 # Locate/process JSON files in pmu-events/arch/
 # directory and create tables in pmu-events.c.
 #
-$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS)
-	$(Q)$(call echo-cmd,gen)$(JEVENTS) $(SRCARCH) pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c $(V)
+
+ifeq ($(NO_JEVENTS),1)
+$(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)cp $< $@
+else
+$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(SRCARCH) pmu-events/arch $@
+endif
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
new file mode 100644
index 0000000000000..77e655c6f1162
--- /dev/null
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * An empty pmu-events.c file used when there is no architecture json files in
+ * arch or when the jevents.py script cannot be run.
+ *
+ * The test cpu/soc is provided for testing.
+ */
+#include "pmu-events/pmu-events.h"
+
+static const struct pmu_event pme_test_soc_cpu[] = {
+	{
+		.name = "l3_cache_rd",
+		.event = "event=0x40",
+		.desc = "L3 cache access, read",
+		.topic = "cache",
+		.long_desc = "Attributable Level 3 cache access, read",
+	},
+	{
+		.name = "segment_reg_loads.any",
+		.event = "event=0x6,period=200000,umask=0x80",
+		.desc = "Number of segment register loads",
+		.topic = "other",
+	},
+	{
+		.name = "dispatch_blocked.any",
+		.event = "event=0x9,period=200000,umask=0x20",
+		.desc = "Memory cluster signals to block micro-op dispatch for any reason",
+		.topic = "other",
+	},
+	{
+		.name = "eist_trans",
+		.event = "event=0x3a,period=200000,umask=0x0",
+		.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
+		.topic = "other",
+	},
+	{
+		.name = "uncore_hisi_ddrc.flux_wcmd",
+		.event = "event=0x2",
+		.desc = "DDRC write commands. Unit: hisi_sccl,ddrc ",
+		.topic = "uncore",
+		.long_desc = "DDRC write commands",
+		.pmu = "hisi_sccl,ddrc",
+	},
+	{
+		.name = "unc_cbo_xsnp_response.miss_eviction",
+		.event = "event=0x22,umask=0x81",
+		.desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core. Unit: uncore_cbox ",
+		.topic = "uncore",
+		.long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+		.pmu = "uncore_cbox",
+	},
+	{
+		.name = "event-hyphen",
+		.event = "event=0xe0,umask=0x00",
+		.desc = "UNC_CBO_HYPHEN. Unit: uncore_cbox ",
+		.topic = "uncore",
+		.long_desc = "UNC_CBO_HYPHEN",
+		.pmu = "uncore_cbox",
+	},
+	{
+		.name = "event-two-hyph",
+		.event = "event=0xc0,umask=0x00",
+		.desc = "UNC_CBO_TWO_HYPH. Unit: uncore_cbox ",
+		.topic = "uncore",
+		.long_desc = "UNC_CBO_TWO_HYPH",
+		.pmu = "uncore_cbox",
+	},
+	{
+		.name = "uncore_hisi_l3c.rd_hit_cpipe",
+		.event = "event=0x7",
+		.desc = "Total read hits. Unit: hisi_sccl,l3c ",
+		.topic = "uncore",
+		.long_desc = "Total read hits",
+		.pmu = "hisi_sccl,l3c",
+	},
+	{
+		.name = "uncore_imc_free_running.cache_miss",
+		.event = "event=0x12",
+		.desc = "Total cache misses. Unit: uncore_imc_free_running ",
+		.topic = "uncore",
+		.long_desc = "Total cache misses",
+		.pmu = "uncore_imc_free_running",
+	},
+	{
+		.name = "uncore_imc.cache_hits",
+		.event = "event=0x34",
+		.desc = "Total cache hits. Unit: uncore_imc ",
+		.topic = "uncore",
+		.long_desc = "Total cache hits",
+		.pmu = "uncore_imc",
+	},
+	{
+		.name = "bp_l1_btb_correct",
+		.event = "event=0x8a",
+		.desc = "L1 BTB Correction",
+		.topic = "branch",
+	},
+	{
+		.name = "bp_l2_btb_correct",
+		.event = "event=0x8b",
+		.desc = "L2 BTB Correction",
+		.topic = "branch",
+	},
+	{
+		.name = 0,
+		.event = 0,
+		.desc = 0,
+	},
+};
+
+const struct pmu_events_map pmu_events_map[] = {
+	{
+		.cpuid = "testcpu",
+		.version = "v1",
+		.type = "core",
+		.table = pme_test_soc_cpu,
+	},
+	{
+		.cpuid = 0,
+		.version = 0,
+		.type = 0,
+		.table = 0,
+	},
+};
+
+static const struct pmu_event pme_test_soc_sys[] = {
+	{
+		.name = "sys_ddr_pmu.write_cycles",
+		.event = "event=0x2b",
+		.desc = "ddr write-cycles event. Unit: uncore_sys_ddr_pmu ",
+		.compat = "v8",
+		.topic = "uncore",
+		.pmu = "uncore_sys_ddr_pmu",
+	},
+	{
+		.name = "sys_ccn_pmu.read_cycles",
+		.event = "config=0x2c",
+		.desc = "ccn read-cycles event. Unit: uncore_sys_ccn_pmu ",
+		.compat = "0x01",
+		.topic = "uncore",
+		.pmu = "uncore_sys_ccn_pmu",
+	},
+	{
+		.name = 0,
+		.event = 0,
+		.desc = 0,
+	},
+};
+
+const struct pmu_sys_events pmu_sys_event_tables[] = {
+	{
+		.table = pme_test_soc_sys,
+		.name = "pme_test_soc_sys",
+	},
+	{
+		.table = 0
+	},
+};
-- 
2.40.1



