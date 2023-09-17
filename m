Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486C57A38CB
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbjIQTkW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbjIQTkP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:40:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8126DD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:40:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CA9C433C7;
        Sun, 17 Sep 2023 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979609;
        bh=o48EqMlfIXFVaImhYipgBxT/5hzopEd7FMMDyq3jZTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6E7CzMyyWt/LUEuJAhWGZ6GSpVl2fT5m6wo19jkwn7o/s0MLpm1YwDDcy8jGV1YD
         s/jRyttQ/aSFzSDzn3ZmwHUxJdRnol4oeMe5a0hJzZAiHKZvk2VOsxOVZH8JEDifU2
         8TTL8U+xBylvBzVCJAtIPPsLWkYmkm/5zI+JPZdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jeremie Galarneau <jeremie.galarneau@efficios.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Shawn Landden <shawn@git.icu>,
        Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 338/406] perf top: Dont pass an ERR_PTR() directly to perf_session__delete()
Date:   Sun, 17 Sep 2023 21:13:12 +0200
Message-ID: <20230917191110.207009186@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit ef23cb593304bde0cc046fd4cc83ae7ea2e24f16 ]

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

The same problem was found in 'perf top' after an audit of all
perf_session__new() failure handling.

Fixes: 6ef81c55a2b6584c ("perf session: Return error code for perf_session__new() function on failure")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Shawn Landden <shawn@git.icu>
Cc: Song Liu <songliubraving@fb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: https://lore.kernel.org/lkml/ZN4Q2rxxsL08A8rd@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-top.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7c64134472c77..ee30372f77133 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1743,6 +1743,7 @@ int cmd_top(int argc, const char **argv)
 	top.session = perf_session__new(NULL, false, NULL);
 	if (IS_ERR(top.session)) {
 		status = PTR_ERR(top.session);
+		top.session = NULL;
 		goto out_delete_evlist;
 	}
 
-- 
2.40.1



