Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E661B7ECD2D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbjKOTev (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjKOTeu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:34:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B631B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5052C433CC;
        Wed, 15 Nov 2023 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076887;
        bh=0sRD3+sdo2B7h8zDiSYprFFrcHxTV0bCyMce08O3QM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sA58jONFB36yeeP9x9Cc+Tp/G8fUF6t2MPupMVC6Lu3AxhedNyvYyEr4MXBrqfDfs
         mdOtiGJyCBm+wUga1wY6kaz2h1kZ65tJxGVS5054TQFUvp7x9cee/IJjKM2eIpXk7P
         hU+gup+gEDfHeTpxlV6/6V7SOBebmzAAEX2yT6dM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 445/550] perf vendor events intel: Fix broadwellde tma_info_system_dram_bw_use metric
Date:   Wed, 15 Nov 2023 14:17:09 -0500
Message-ID: <20231115191631.650701649@linuxfoundation.org>
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

[ Upstream commit 3779416eed25a843364b940decee452620a1de4b ]

Broadwell-de has a consumer core and server uncore. The uncore_arb PMU
isn't present and the broadwellx style cbox PMU should be used
instead. Fix the tma_info_system_dram_bw_use metric to use the server
metric rather than client.

The associated converter script fix is in:
https://github.com/intel/perfmon/pull/111

Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell variant events/metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Caleb Biggers <caleb.biggers@intel.com>
Cc: Perry Taylor <perry.taylor@intel.com>
Link: https://lore.kernel.org/r/20230926031034.1201145-1-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 8fc62b8f667d8..d0ef46c9bb612 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -652,7 +652,7 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
-        "MetricExpr": "64 * (arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@) / 1e6 / duration_time / 1e3",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e9 / duration_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
         "PublicDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth, tma_sq_full"
-- 
2.42.0



