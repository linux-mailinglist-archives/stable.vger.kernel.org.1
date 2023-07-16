Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D0D75530F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGPUO4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjGPUOz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CB7E43
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A975C60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CF0C433C8;
        Sun, 16 Jul 2023 20:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538493;
        bh=531KIonvJdfc0DRqDAojvyWakR17Ajh0wyuLD6V0wXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsXsJkNpHert3LKFFqIbHGeMP3H3MMv0jdOCRlzN5NrMVxL3OCEh+bLcVpbKYceK3
         Ow16eqOFkCPlXaVh32oD7I+8273ep2cKACvamkiKvQQVjsq6hW89pI37CIC8VlvM4F
         0ReH1KH0eJWeXWnCXG23wSXAtxPp9e6rgmS+83xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 471/800] perf metric: Fix no group check
Date:   Sun, 16 Jul 2023 21:45:24 +0200
Message-ID: <20230716195000.021306290@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit e4c4e8a538a0db071d291bc2dca487e1882a7d4f ]

The no group check fails if there is more than one meticgroup in the
metricgroup_no_group.

The first parameter of the match_metric() should be the string, while
the substring should be the second parameter.

Fixes: ccc66c6092802d68 ("perf metric: JSON flag to not group events if gathering a metric group")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ahmad Yasin <ahmad.yasin@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lore.kernel.org/r/20230607162700.3234712-2-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 5e9c657dd3f7a..b659b149e5b41 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1146,7 +1146,7 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
 
 	if (pm->metric_expr && match_pm_metric(pm, data->metric_name)) {
 		bool metric_no_group = data->metric_no_group ||
-			match_metric(data->metric_name, pm->metricgroup_no_group);
+			match_metric(pm->metricgroup_no_group, data->metric_name);
 
 		data->has_match = true;
 		ret = add_metric(data->list, pm, data->modifier, metric_no_group,
-- 
2.39.2



