Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A07ECF78
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbjKOTsk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjKOTsj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:48:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CA112C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:48:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59094C433C8;
        Wed, 15 Nov 2023 19:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077716;
        bh=ZNm0KlcioNsv2bJKEN5LxcsaOv7QuoLm17omQRXy05I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VxwidKGLLZG1R3X1qgNICRRnFUtR4qk0gP0oaRhwguECZ5kj2fTMg4JLGNowjOTEN
         DiadIsWpsuqN840NdlUfdWUqPJzccdVKrYeqnfcMGMU3B7H9qxHeFJE22YtCe5443r
         PrLZjtiMvYR/wDNEAao3EbTbz1SESspEWcJW5WIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Disha Goel <disgoel@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, maddy@linux.ibm.com,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 475/603] perf vendor events: Update PMC used in PM_RUN_INST_CMPL event for power10 platform
Date:   Wed, 15 Nov 2023 14:17:00 -0500
Message-ID: <20231115191645.334767960@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kajol Jain <kjain@linux.ibm.com>

[ Upstream commit 3f8b6e5b11192dacb721d2d28ea4589917f5e822 ]

The CPI_STALL_RATIO metric group can be used to present the high
level CPI stall breakdown metrics in powerpc, which will show:

- DISPATCH_STALL_CPI ( Dispatch stall cycles per insn )
- ISSUE_STALL_CPI ( Issue stall cycles per insn )
- EXECUTION_STALL_CPI ( Execution stall cycles per insn )
- COMPLETION_STALL_CPI ( Completion stall cycles per insn )

Commit cf26e043c2a9 ("perf vendor events power10: Add JSON
metric events to present CPI stall cycles in powerpc)" which added
the CPI_STALL_RATIO metric group, also modified
the PMC value used in PM_RUN_INST_CMPL event from PMC4 to PMC5,
to avoid multiplexing of events.
But that got revert in recent changes. Fix this issue by changing
back the PMC value used in PM_RUN_INST_CMPL to PMC5.

Result with the fix:

 ./perf stat --metric-no-group -M CPI_STALL_RATIO <workload>

 Performance counter stats for 'workload':

        68,745,426      PM_CMPL_STALL                    #     0.21 COMPLETION_STALL_CPI
         7,692,827      PM_ISSUE_STALL                   #     0.02 ISSUE_STALL_CPI
       322,638,223      PM_RUN_INST_CMPL                 #     0.05 DISPATCH_STALL_CPI
                                                  #     0.48 EXECUTION_STALL_CPI
        16,858,553      PM_DISP_STALL_CYC
       153,880,133      PM_EXEC_STALL

       0.089774592 seconds time elapsed

"--metric-no-group" is used for forcing PM_RUN_INST_CMPL to be scheduled
in all group for more accuracy.

Fixes: 7d473f475b2a ("perf vendor events: Move JSON/events to appropriate files for power10 platform")
Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Tested-by: Disha Goel<disgoel@linux.ibm.com>
Cc: maddy@linux.ibm.com
Link: https://lore.kernel.org/r/20231016143110.244255-1-kjain@linux.ibm.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/pmu-events/arch/powerpc/power10/pmc.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
index c606ae03cd27d..0e0253d0e7577 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
@@ -195,7 +195,7 @@
     "BriefDescription": "Threshold counter exceeded a value of 128."
   },
   {
-    "EventCode": "0x400FA",
+    "EventCode": "0x500FA",
     "EventName": "PM_RUN_INST_CMPL",
     "BriefDescription": "PowerPC instruction completed while the run latch is set."
   }
-- 
2.42.0



