Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0B2755345
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjGPURU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjGPURP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2437E40
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D0BC60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CBDC433C8;
        Sun, 16 Jul 2023 20:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538632;
        bh=/eCpOHVdDejXBXh6t0gTTlmuVTbygfJ3hKHPWPmuelg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7drjnIcFZu+wpWt4dl7fu40BT/VYDObEtHr45sQpg/F8zwNIj+5+KjjTFnwVaqZc
         EWE7plI5LNiFruB6Iu+m2CqEFtdnirgVO1m4eYPaqjaROpkiHVxxRaT/kP5sqNHZKV
         Sim5nkJ+XX5QisYu7Iw/S68UDU3eXua4l0dhRpiI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 493/800] perf test: Set PERF_EXEC_PATH for script execution
Date:   Sun, 16 Jul 2023 21:45:46 +0200
Message-ID: <20230716195000.532023390@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit e4ef3ef1bc0a3d2535427da78b8095ef657eb474 ]

The task-analyzer.py script (actually every other scripts too) requires
PERF_EXEC_PATH env to find dependent libraries and scripts. For scripts
test to run correctly, it needs to set PERF_EXEC_PATH to the perf tool
source directory.

Instead of blindly update the env, let's check the directory structure
to make sure it points to the correct location.

Fixes: e8478b84d6ba ("perf test: add new task-analyzer tests")
Cc: Petar Gligoric <petar.gligoric@rohde-schwarz.com>
Cc: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/test_task_analyzer.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index 1b7f3c1ec218b..365b61aea519a 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -5,6 +5,12 @@
 tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
 err=0
 
+# set PERF_EXEC_PATH to find scripts in the source directory
+perfdir=$(dirname "$0")/../..
+if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
+  export PERF_EXEC_PATH=$perfdir
+fi
+
 cleanup() {
   rm -f perf.data
   rm -f perf.data.old
-- 
2.39.2



