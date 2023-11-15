Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20547ECD43
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjKOTf0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjKOTfZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8683A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E49CC433C8;
        Wed, 15 Nov 2023 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076921;
        bh=guVRoEQMD75IbyjnJ1f/XPqWAdhUFoX2rzdZwiHVTJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZLndVz2A/xXB0+wKJ1ay+Nri4MGwgqObnDnLSjE65/dzpxHl1rCcUF+c5N8jmVce
         D/FZzLM9SOQjBjJPuthyUAmQh1JUbzWcpyixxgI9dp7VBFGAQgSqXW+o1pHjlgEYM+
         MQUdZ5B6Q19bJ5i0fL+jcQKJTD8pMFNA5uNwqApQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 446/550] perf vendor events intel: Add broadwellde two metrics
Date:   Wed, 15 Nov 2023 14:17:10 -0500
Message-ID: <20231115191631.727276816@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 19a214bffdf7abb8d472895bb944d9c269ab1699 ]

Add tma_info_system_socket_clks and uncore_freq metrics that require a
broadwellx style uncore event for UNC_CLOCK.

The associated converter script fix is in:
https://github.com/intel/perfmon/pull/112

Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell variant events/metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Caleb Biggers <caleb.biggers@intel.com>
Cc: Perry Taylor <perry.taylor@intel.com>
Link: https://lore.kernel.org/r/20230926205948.1399594-2-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../arch/x86/broadwellde/bdwde-metrics.json          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index d0ef46c9bb612..e1f55fcfa0d02 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -48,6 +48,12 @@
         "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_time / 1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "Percentage of cycles spent in System Management Interrupts.",
         "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0 else 0)",
@@ -690,6 +696,12 @@
         "MetricGroup": "SMT",
         "MetricName": "tma_info_system_smt_2t_utilization"
     },
+    {
+        "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricExpr": "cbox_0@event\\=0x0@",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_system_socket_clks"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
-- 
2.42.0



