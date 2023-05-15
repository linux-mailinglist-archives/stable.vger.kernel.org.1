Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19E2703645
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbjEORIe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbjEORIK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:08:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2215C7EF5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 034CC62AA7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC853C4339B;
        Mon, 15 May 2023 17:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170400;
        bh=juDafpz7RvokxVeP1ZBHO36gTU4svrzkoC32vHZhsz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KB+uFMYn21EjtjR+Ppd7DTT52KMCwTC8G99oSl44zBK775HNFbVO/+28SkM8/EuUQ
         BzsMwosY6bNvvrFhJMbMtQEEUtYYom0CB8D/sMUCCMaEbI5YPjX8QE+k6Ycebe04XK
         B4pwyzPRzKad6y3sPCE6kNuc32VODgW1E5hdx1F8=
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
Subject: [PATCH 6.1 090/239] perf record: Fix "read LOST count failed" msg with sample read
Date:   Mon, 15 May 2023 18:25:53 +0200
Message-Id: <20230515161724.373552625@linuxfoundation.org>
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
index 48c3461b496c4..7314183cdcb6c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1864,7 +1864,7 @@ static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
 	int id_hdr_size;
 
 	if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
-		pr_err("read LOST count failed\n");
+		pr_debug("read LOST count failed\n");
 		return;
 	}
 
-- 
2.39.2



