Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C6B70363D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbjEORIJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbjEORHu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:07:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E95E6E9B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 863DC62AE0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3D2C433D2;
        Mon, 15 May 2023 17:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170319;
        bh=ALqK/OCEqIMYl16HqqaGjde0UhCmhmdKxoSBUfnqnz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vEHpkXqgimGbMAhvyv29DQsw+yhULc5QnWUG7d/TWcmzHhaVeOWW77019MAGpRvIb
         1ffMNkOwG/GSu7dD75fE7cJqdicUvMyM3GJDn0J2UnHhKjUhY33I+D2o6t+iqpyWZi
         Rpw7k5UnlkdXNBGF00odNVgLWNJWq9p5ZKDFRb/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Jihong <yangjihong1@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 094/239] perf ftrace: Make system wide the default target for latency subcommand
Date:   Mon, 15 May 2023 18:25:57 +0200
Message-Id: <20230515161724.497339326@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yang Jihong <yangjihong1@huawei.com>

[ Upstream commit ecd4960d908e27e40b63a7046df2f942c148c6f6 ]

If no target is specified for 'latency' subcommand, the execution fails
because - 1 (invalid value) is written to set_ftrace_pid tracefs file.
Make system wide the default target, which is the same as the default
behavior of 'trace' subcommand.

Before the fix:

  # perf ftrace latency -T schedule
  failed to set ftrace pid

After the fix:

  # perf ftrace latency -T schedule
  ^C#   DURATION     |      COUNT | GRAPH                                          |
       0 - 1    us |          0 |                                                |
       1 - 2    us |          0 |                                                |
       2 - 4    us |          0 |                                                |
       4 - 8    us |       2828 | ####                                           |
       8 - 16   us |      23953 | ########################################       |
      16 - 32   us |        408 |                                                |
      32 - 64   us |        318 |                                                |
      64 - 128  us |          4 |                                                |
     128 - 256  us |          3 |                                                |
     256 - 512  us |          0 |                                                |
     512 - 1024 us |          1 |                                                |
       1 - 2    ms |          4 |                                                |
       2 - 4    ms |          0 |                                                |
       4 - 8    ms |          0 |                                                |
       8 - 16   ms |          0 |                                                |
      16 - 32   ms |          0 |                                                |
      32 - 64   ms |          0 |                                                |
      64 - 128  ms |          0 |                                                |
     128 - 256  ms |          4 |                                                |
     256 - 512  ms |          2 |                                                |
     512 - 1024 ms |          0 |                                                |
       1 - ...   s |          0 |                                                |

Fixes: 53be50282269b46c ("perf ftrace: Add 'latency' subcommand")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230324032702.109964-1-yangjihong1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-ftrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7de07bb16d235..4bc5b7cf3e04b 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1228,10 +1228,12 @@ int cmd_ftrace(int argc, const char **argv)
 		goto out_delete_filters;
 	}
 
+	/* Make system wide (-a) the default target. */
+	if (!argc && target__none(&ftrace.target))
+		ftrace.target.system_wide = true;
+
 	switch (subcmd) {
 	case PERF_FTRACE_TRACE:
-		if (!argc && target__none(&ftrace.target))
-			ftrace.target.system_wide = true;
 		cmd_func = __cmd_ftrace;
 		break;
 	case PERF_FTRACE_LATENCY:
-- 
2.39.2



