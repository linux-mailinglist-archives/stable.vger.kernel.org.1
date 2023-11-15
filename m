Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AFD7ECF56
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjKOTrz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjKOTry (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:47:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F21A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00972C433C9;
        Wed, 15 Nov 2023 19:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077670;
        bh=TO6f7ZLWSBsME4U2s9F3KCLp7V/huoDr4y+9WYfJT/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2qBjdhHgDCAHgbOIlc62uOzQcGp49iN0+HD/aQfuRoADzbq6U9qcLfxIZ63z01gZ
         tQ3iGqSkFh5gEb1GhJxXrxTUqCn5ATDqeVSFPhItrrVMw9TBLgUY58pFCwx2MwVbc4
         GaC174SB4ib/E4FQ+8/92vF+/VyDG5xMnDr4qsbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 423/603] perf kwork: Add the supported subcommands to the document
Date:   Wed, 15 Nov 2023 14:16:08 -0500
Message-ID: <20231115191642.090454324@linuxfoundation.org>
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

From: Yang Jihong <yangjihong1@huawei.com>

[ Upstream commit 76e0d8c821bbd952730799cc7af841f9de67b7f7 ]

Add missing report, latency and timehist subcommands to the document.

Fixes: f98919ec4fccdacf ("perf kwork: Implement 'report' subcommand")
Fixes: ad3d9f7a929ab2df ("perf kwork: Implement perf kwork latency")
Fixes: bcc8b3e88d6fa1a3 ("perf kwork: Implement perf kwork timehist")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20230812084917.169338-3-yangjihong1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Documentation/perf-kwork.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
index 3c36324712b6e..482d6c52e2edf 100644
--- a/tools/perf/Documentation/perf-kwork.txt
+++ b/tools/perf/Documentation/perf-kwork.txt
@@ -8,7 +8,7 @@ perf-kwork - Tool to trace/measure kernel work properties (latencies)
 SYNOPSIS
 --------
 [verse]
-'perf kwork' {record}
+'perf kwork' {record|report|latency|timehist}
 
 DESCRIPTION
 -----------
-- 
2.42.0



