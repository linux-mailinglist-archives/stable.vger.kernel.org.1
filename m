Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD795726D2D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjFGUkD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjFGUjp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:39:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F912710
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9696C645DF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859E9C433D2;
        Wed,  7 Jun 2023 20:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170362;
        bh=ToFbkCMOZEpK+4wwufmFmEGqsbFhKgV1sbz08FRgmSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDklBd49KrWcOKtfQ4X52pbtaqrWWcDQv93NgfS2pMzNZOa0bhO5EZua12LKTf5aa
         7Kpl8iKkYxooMwVItyzJrZro5MnerGvT4CeF7yOeizbxXfWEvcqQxXtu2yNT0kVMXS
         ZJB/DEHTJRQMwQc3WsdSfH1t+G8FR7NV0wNbCOFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 026/225] perf ftrace latency: Remove unnecessary "--" from --use-nsec option
Date:   Wed,  7 Jun 2023 22:13:39 +0200
Message-ID: <20230607200915.177713965@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 8d73259ef23f449329294dc187932f7470268126 ]

The option name should not have the dashes.  Current version shows four
dashes for the option.

  $ perf ftrace latency -h

   Usage: perf ftrace [<options>] [<command>]
      or: perf ftrace [<options>] -- [<command>] [<options>]
      or: perf ftrace {trace|latency} [<options>] [<command>]
      or: perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]

      -b, --use-bpf         Use BPF to measure function latency
      -n, ----use-nsec      Use nano-second histogram
      -T, --trace-funcs <func>
                            Show latency of given function

Fixes: 84005bb6148618cc ("perf ftrace latency: Add -n/--use-nsec option")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Changbin Du <changbin.du@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230525212038.3535851-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 4bc5b7cf3e04b..1d40f9bcb63bc 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1175,7 +1175,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
 		    "Use BPF to measure function latency"),
 #endif
-	OPT_BOOLEAN('n', "--use-nsec", &ftrace.use_nsec,
+	OPT_BOOLEAN('n', "use-nsec", &ftrace.use_nsec,
 		    "Use nano-second histogram"),
 	OPT_PARENT(common_options),
 	};
-- 
2.39.2



