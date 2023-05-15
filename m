Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EA67034E7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243242AbjEOQxy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243179AbjEOQxa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:53:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0465B5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88A5162033
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62066C433D2;
        Mon, 15 May 2023 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169587;
        bh=8UhImnYKD/cheR8rqjeWIXSP6mgZTjvymyqqjJIXPiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fI1geG5hxxKU1+CWjmhiPJZE9hMw9ofnBLARhGTIuE//x+9uGt34NmtMu9ZPJR7f6
         pSsAQ40p9++QGi9e1+YZ/SGU1QImIUMuTo19wseDKd3QklMEkKqU5ceNnDS7/fGe+Y
         6R+Wsw66/aHd0ehAdftItMaVhG/ifL98CuUhzw8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 105/246] perf test: Fix wrong size expectation for Setup struct perf_event_attr
Date:   Mon, 15 May 2023 18:25:17 +0200
Message-Id: <20230515161725.731178863@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 30df88a80f32ccca5c5cdcf2710d1fb2de5e314d ]

The test case "perf test 'Setup struct perf_event_attr'" is failing.

On s390 this output is observed:

 # ./perf test -Fvvvv 17
 17: Setup struct perf_event_attr                                    :
 --- start ---
 running './tests/attr/test-stat-C0'
 Using CPUID IBM,8561,703,T01,3.6,002f
 .....
 Event event:base-stat
      fd = 1
      group_fd = -1
      flags = 0|8
      cpu = *
      type = 0
      size = 128     <<<--- wrong, specified in file base-stat
      config = 0
      sample_period = 0
      sample_type = 65536
      ...
 'PERF_TEST_ATTR=/tmp/tmpgw574wvg ./perf stat -o \
	/tmp/tmpgw574wvg/perf.data -e cycles -C 0 kill >/dev/null \
	2>&1 ret '1', expected '1'
  loading result events
    Event event-0-0-4
      fd = 4
      group_fd = -1
      cpu = 0
      pid = -1
      flags = 8
      type = 0
      size = 136     <<<--- actual size used in system call
      .....
  compare
    matching [event-0-0-4]
      to [event:base-stat]
      [cpu] 0 *
      [flags] 8 0|8
      [type] 0 0
      [size] 136 128
    ->FAIL
    match: [event-0-0-4] matches []
  expected size=136, got 128
  FAILED './tests/attr/test-stat-C0' - match failure

This mismatch is caused by
commit 09519ec3b19e ("perf: Add perf_event_attr::config3")
which enlarges the structure perf_event_attr by 8 bytes.

Fix this by adjusting the expected value of size.

Output after:
 # ./perf test -Fvvvv 17
 17: Setup struct perf_event_attr                                    :
 --- start ---
 running './tests/attr/test-stat-C0'
 Using CPUID IBM,8561,703,T01,3.6,002f
 ...
  matched
  compare
    matching [event-0-0-4]
      to [event:base-stat]
      [cpu] 0 *
      [flags] 8 0|8
      [type] 0 0
      [size] 136 136
      ....
   ->OK
   match: [event-0-0-4] matches ['event:base-stat']
 matched

Fixes: 09519ec3b19e4144 ("perf: Add perf_event_attr::config3")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20230322094731.1768281-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/attr/base-record       | 2 +-
 tools/perf/tests/attr/base-stat         | 2 +-
 tools/perf/tests/attr/system-wide-dummy | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 3ef07a12aa142..27c21271a16c9 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0|1
-size=128
+size=136
 config=0
 sample_period=*
 sample_type=263
diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
index 4081644565306..a21fb65bc012e 100644
--- a/tools/perf/tests/attr/base-stat
+++ b/tools/perf/tests/attr/base-stat
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0
-size=128
+size=136
 config=0
 sample_period=0
 sample_type=65536
diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
index 8fec06eda5f90..2f3e3eb728eb4 100644
--- a/tools/perf/tests/attr/system-wide-dummy
+++ b/tools/perf/tests/attr/system-wide-dummy
@@ -7,7 +7,7 @@ cpu=*
 pid=-1
 flags=8
 type=1
-size=128
+size=136
 config=9
 sample_period=4000
 sample_type=455
-- 
2.39.2



