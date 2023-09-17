Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9927A395C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbjIQTsS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbjIQTsE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:48:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F89F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:47:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B33C433C8;
        Sun, 17 Sep 2023 19:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980078;
        bh=as389TByuzmfIxj6W3nie1aVtyl7erOJgiRjG/kO0Wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Rswc55khFwmQKnePCdEKwOFDzi6Tv6EwE4KTDVo5un/RHJDClAbQxG1MiLbr3S3e
         aREeWlY5nDRnf+yFvHAMpZeO9zgv7/KSKvbwSjhxI7LLdsjqXgNs24fb1vjhFBjYZl
         18KIOUyEWB7FSr5YhZEppXlQAKe0Yo3ZXS47T2WU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Ross Zwisler <zwisler@chromium.org>,
        Sean Christopherson <seanjc@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 090/285] perf lock: Dont pass an ERR_PTR() directly to perf_session__delete()
Date:   Sun, 17 Sep 2023 21:11:30 +0200
Message-ID: <20230917191054.818124459@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit abaf1e0355abb050f9c11d2d13a513caec80f7ad ]

While debugging a segfault on 'perf lock contention' without an
available perf.data file I noticed that it was basically calling:

	perf_session__delete(ERR_PTR(-1))

Resulting in:

  (gdb) run lock contention
  Starting program: /root/bin/perf lock contention
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib64/libthread_db.so.1".
  failed to open perf.data: No such file or directory  (try 'perf record' first)
  Initializing perf session failed

  Program received signal SIGSEGV, Segmentation fault.
  0x00000000005e7515 in auxtrace__free (session=0xffffffffffffffff) at util/auxtrace.c:2858
  2858		if (!session->auxtrace)
  (gdb) p session
  $1 = (struct perf_session *) 0xffffffffffffffff
  (gdb) bt
  #0  0x00000000005e7515 in auxtrace__free (session=0xffffffffffffffff) at util/auxtrace.c:2858
  #1  0x000000000057bb4d in perf_session__delete (session=0xffffffffffffffff) at util/session.c:300
  #2  0x000000000047c421 in __cmd_contention (argc=0, argv=0x7fffffffe200) at builtin-lock.c:2161
  #3  0x000000000047dc95 in cmd_lock (argc=0, argv=0x7fffffffe200) at builtin-lock.c:2604
  #4  0x0000000000501466 in run_builtin (p=0xe597a8 <commands+552>, argc=2, argv=0x7fffffffe200) at perf.c:322
  #5  0x00000000005016d5 in handle_internal_command (argc=2, argv=0x7fffffffe200) at perf.c:375
  #6  0x0000000000501824 in run_argv (argcp=0x7fffffffe02c, argv=0x7fffffffe020) at perf.c:419
  #7  0x0000000000501b11 in main (argc=2, argv=0x7fffffffe200) at perf.c:535
  (gdb)

So just set it to NULL after using PTR_ERR(session) to decode the error
as perf_session__delete(NULL) is supported.

Fixes: eef4fee5e52071d5 ("perf lock: Dynamically allocate lockhash_table")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ross Zwisler <zwisler@chromium.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Yang Jihong <yangjihong1@huawei.com>
Link: https://lore.kernel.org/lkml/ZN4R1AYfsD2J8lRs@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-lock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index c15386cb10331..0cf1c5a2e0323 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2052,6 +2052,7 @@ static int __cmd_contention(int argc, const char **argv)
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
 		err = PTR_ERR(session);
+		session = NULL;
 		goto out_delete;
 	}
 
-- 
2.40.1



