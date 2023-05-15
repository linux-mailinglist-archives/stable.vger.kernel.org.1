Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820097034E1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243130AbjEOQxk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243157AbjEOQxN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:53:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7036165BB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E9DA629AC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346F3C4339C;
        Mon, 15 May 2023 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169574;
        bh=11s5hQQIt6oPe7E9J4D/Sy1kgwU/vDLELyPypGElEkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SaUHcagtaQigPvlmWnvsETr48WGfxPriPkLfKA39U55LgPcCe88lp9aZzIrQTTQ2h
         hrXOV1ylgcr2mPnrA2gQLrqKG5ZgNlFSIgt9wTF6ophPPXfCxXqug1L+asrZ7T/VCP
         13WXAbgWyqRBUOwOsa0Ghy+BLrG7Ky0Lhb2exSbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 102/246] perf test: Fix "PMU event table sanity" for NO_JEVENTS=1
Date:   Mon, 15 May 2023 18:25:14 +0200
Message-Id: <20230515161725.643260317@linuxfoundation.org>
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

From: Ian Rogers <irogers@google.com>

[ Upstream commit 07fc5921a014e227bd3b622d31a8a35ff3f19afb ]

A table was renamed and needed to be renamed in the empty case.

Fixes: 62774db2a05dc878 ("perf jevents: Generate metrics and events as separate tables")
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230308002714.1755698-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/pmu-events/empty-pmu-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index a938b74cf487c..e74defb5284ff 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -227,7 +227,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 	},
 };
 
-static const struct pmu_event pme_test_soc_sys[] = {
+static const struct pmu_event pmu_events__test_soc_sys[] = {
 	{
 		.name = "sys_ddr_pmu.write_cycles",
 		.event = "event=0x2b",
@@ -258,8 +258,8 @@ struct pmu_sys_events {
 
 static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	{
-		.table = { pme_test_soc_sys },
-		.name = "pme_test_soc_sys",
+		.table = { pmu_events__test_soc_sys },
+		.name = "pmu_events__test_soc_sys",
 	},
 	{
 		.table = { 0 }
-- 
2.39.2



