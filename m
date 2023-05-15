Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81FB703633
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbjEORHo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243439AbjEORHT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:07:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD8A5F6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B126362AF8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE45C433A0;
        Mon, 15 May 2023 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170354;
        bh=NaZNEGS6O5ILStabR1IvWojNITJtGUYuoha+BNTrc/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FS+Wyxsmm2JdM8nNFHoD2bCm7i4JVV0mlVMAAeTm+zM91/m8nzqEPEXWu2p0Zz/x0
         UzMUMmgvrEPsZWvgHcMGB/hC5Q5N30YCyDVxfjybnFE9e0KU9+xf5od17cTmGCejMX
         pG3aYDoGd9PTGB7yb+fGx1vVGV7PL0E7TjA1z48o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 104/239] perf tracepoint: Fix memory leak in is_valid_tracepoint()
Date:   Mon, 15 May 2023 18:26:07 +0200
Message-Id: <20230515161724.805432096@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Yang Jihong <yangjihong1@huawei.com>

[ Upstream commit 9b86c49710eec7b4fbb78a0232b2dd0972a2b576 ]

When is_valid_tracepoint() returns 1, need to call put_events_file() to
free `dir_path`.

Fixes: 25a7d914274de386 ("perf parse-events: Use get/put_events_file()")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230421025953.173826-1-yangjihong1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/tracepoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoint.c
index 89ef56c433110..92dd8b455b902 100644
--- a/tools/perf/util/tracepoint.c
+++ b/tools/perf/util/tracepoint.c
@@ -50,6 +50,7 @@ int is_valid_tracepoint(const char *event_string)
 				 sys_dirent->d_name, evt_dirent->d_name);
 			if (!strcmp(evt_path, event_string)) {
 				closedir(evt_dir);
+				put_events_file(dir_path);
 				closedir(sys_dir);
 				return 1;
 			}
-- 
2.39.2



