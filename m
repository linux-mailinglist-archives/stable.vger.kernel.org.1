Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C457034DE
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbjEOQxc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243211AbjEOQxG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9B6E9A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:52:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 299F0629B5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF87C4339C;
        Mon, 15 May 2023 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169565;
        bh=iH6muFLsBl4cq/ZQjPh2dctKTGePJn46wlTWW4YhjpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2tfsSwQxpe8fDPtzNUK8bPwCrUoXWcLTonGa8hdVfPPUcNHhZ62O6vi7boCeVJj4
         7wSb/rpDh2yxPUnGsy/Y+nfIBJbPk6XidB/M8cp29l33HfBhLFlKk9txcaj97lZcdb
         w7GSd0cPzbwaZ7meL6aXcGk6FIDixCKi/C6Rw3/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 099/246] perf record: Fix "read LOST count failed" msg with sample read
Date:   Mon, 15 May 2023 18:25:11 +0200
Message-Id: <20230515161725.554726716@linuxfoundation.org>
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

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 07d85ba9d04e1ebd282f656a29ddf08c5b7b32a2 ]

Hundreds of "read LOST count failed" error messages may be displayed,
when the below command is launched.

perf record -e '{cpu/mem-loads-aux/,cpu/event=0xcd,umask=0x1/}:S' -a

According to the commit 89e3106fa25fb1b6 ("libperf: Handle read format
in perf_evsel__read()"), the PERF_FORMAT_GROUP is only available for
the leader. However, the record__read_lost_samples() goes through every
entry of an evlist, which includes both leader and member. The member
event errors out and triggers the error message. Since there may be
hundreds of CPUs on a server, the message will be printed hundreds of
times, which is very annoying.

The message itself is correct, but the pr_err is a overkill. Other error
messages in the record__read_lost_samples() are all pr_debug. To make
the output format consistent, change the pr_err("read LOST count
failed\n"); to pr_debug("read LOST count failed\n");.
User can still get the message via -v option.

Fixes: e3a23261ad06d598 ("perf record: Read and inject LOST_SAMPLES events")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230301150413.27011-1-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8374117e66f6e..be7c0c29d15b0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1866,7 +1866,7 @@ static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
 	int id_hdr_size;
 
 	if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
-		pr_err("read LOST count failed\n");
+		pr_debug("read LOST count failed\n");
 		return;
 	}
 
-- 
2.39.2



