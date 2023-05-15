Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837657034EE
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243168AbjEOQyU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243210AbjEOQxs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:53:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1076EAC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:53:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7294462063
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7A2C433EF;
        Mon, 15 May 2023 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169601;
        bh=CQLT/bsvAJd2jCdkCfQb3EdAHZfQbieJuhsfPHb1y0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHx831KGzsz0KA2td/8Z7bIpPsXsjqPOM0zEGOxbAwt05vFiHQ3xSjmZw25yLKqSX
         O+6czkNOUMFZ5/Q+Zht+VKaPApjO4W44fqE7uV1RdnnRXDsS0XK9Noc9Mvw0zah9Dt
         z8UYWQ4tQVxWlKuQpnMeQaDr1Kwue0InOaTpZH1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 110/246] perf vendor events power9: Remove UTF-8 characters from JSON files
Date:   Mon, 15 May 2023 18:25:22 +0200
Message-Id: <20230515161725.876570435@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Kajol Jain <kjain@linux.ibm.com>

[ Upstream commit 5d9df8731c0941f3add30f96745a62586a0c9d52 ]

Commit 3c22ba5243040c13 ("perf vendor events powerpc: Update POWER9
events") added and updated power9 PMU JSON events. However some of the
JSON events which are part of other.json and pipeline.json files,
contains UTF-8 characters in their brief description.  Having UTF-8
character could breaks the perf build on some distros.

Fix this issue by removing the UTF-8 characters from other.json and
pipeline.json files.

Result without the fix:

  [command]# file -i pmu-events/arch/powerpc/power9/*
  pmu-events/arch/powerpc/power9/cache.json:          application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/floating-point.json: application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/frontend.json:       application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/marked.json:         application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/memory.json:         application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/metrics.json:        application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/nest_metrics.json:   application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/other.json:          application/json; charset=utf-8
  pmu-events/arch/powerpc/power9/pipeline.json:       application/json; charset=utf-8
  pmu-events/arch/powerpc/power9/pmc.json:            application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/translation.json:    application/json; charset=us-ascii
  [command]#

Result with the fix:

  [command]# file -i pmu-events/arch/powerpc/power9/*
  pmu-events/arch/powerpc/power9/cache.json:          application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/floating-point.json: application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/frontend.json:       application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/marked.json:         application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/memory.json:         application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/metrics.json:        application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/nest_metrics.json:   application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/other.json:          application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/pipeline.json:       application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/pmc.json:            application/json; charset=us-ascii
  pmu-events/arch/powerpc/power9/translation.json:    application/json; charset=us-ascii
  [command]#

Fixes: 3c22ba5243040c13 ("perf vendor events powerpc: Update POWER9 events")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Disha Goel <disgoel@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lore.kernel.org/lkml/ZBxP77deq7ikTxwG@kernel.org/
Link: https://lore.kernel.org/r/20230328112908.113158-1-kjain@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/pmu-events/arch/powerpc/power9/other.json    | 4 ++--
 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 3f69422c21f99..f10bd554521a0 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -1417,7 +1417,7 @@
   {
     "EventCode": "0x45054",
     "EventName": "PM_FMA_CMPL",
-    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only. "
+    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only."
   },
   {
     "EventCode": "0x201E8",
@@ -2017,7 +2017,7 @@
   {
     "EventCode": "0xC0BC",
     "EventName": "PM_LSU_FLUSH_OTHER",
-    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the “bad dval” back and flush all younger ops)"
+    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the 'bad dval' back and flush all younger ops)"
   },
   {
     "EventCode": "0x5094",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
index d0265f255de2b..723bffa41c448 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
@@ -442,7 +442,7 @@
   {
     "EventCode": "0x4D052",
     "EventName": "PM_2FLOP_CMPL",
-    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg "
+    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg"
   },
   {
     "EventCode": "0x1F142",
-- 
2.39.2



