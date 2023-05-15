Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9862B703772
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbjEORVR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244073AbjEORVB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:21:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FE212EBD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:18:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF8C96205E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D82C433D2;
        Mon, 15 May 2023 17:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171131;
        bh=m7i8Y8IHu/njLCDUUr8smsA3tgSYIqo4RuzfNnHOmXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFJ5tLgwB1NhI8rxr5I8C4CxZSefwT86YLjyZAKECPkqr4O9Tsew7Q/WkcD8LB+L6
         mwBNx5yGRLY5SkMGv5vBmbZMhsRsjhGbKITdhylGtHZ3fOP9EolbFkRH6BoOo87sDC
         e/QfgRREx4sWOerR0a6lwkpYXUZhbBGqFmS7C42E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, elfring@users.sourceforge.net,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 103/242] perf map: Delete two variable initialisations before null pointer checks in sort__sym_from_cmp()
Date:   Mon, 15 May 2023 18:27:09 +0200
Message-Id: <20230515161724.992300832@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Markus Elfring <Markus.Elfring@web.de>

[ Upstream commit c160118a90d4acf335993d8d59b02ae2147a524e ]

Addresses of two data structure members were determined before
corresponding null pointer checks in the implementation of the function
“sort__sym_from_cmp”.

Thus avoid the risk for undefined behaviour by removing extra
initialisations for the local variables “from_l” and “from_r” (also
because they were already reassigned with the same value behind this
pointer check).

This issue was detected by using the Coccinelle software.

Fixes: 1b9e97a2a95e4941 ("perf tools: Fix report -F symbol_from for data without branch info")
Signed-off-by: <elfring@users.sourceforge.net>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: German Gomez <german.gomez@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/cocci/54a21fea-64e3-de67-82ef-d61b90ffad05@web.de/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/sort.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2bf3f88276972..22808643ab725 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -966,8 +966,7 @@ static int hist_entry__dso_to_filter(struct hist_entry *he, int type,
 static int64_t
 sort__sym_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	struct addr_map_symbol *from_l = &left->branch_info->from;
-	struct addr_map_symbol *from_r = &right->branch_info->from;
+	struct addr_map_symbol *from_l, *from_r;
 
 	if (!left->branch_info || !right->branch_info)
 		return cmp_null(left->branch_info, right->branch_info);
-- 
2.39.2



