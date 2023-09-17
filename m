Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1208B7A3B0C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbjIQUMT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240709AbjIQUMO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:12:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86334CD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:11:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739C0C433C9;
        Sun, 17 Sep 2023 20:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981509;
        bh=wdmoY8+kdG06jJj+hrcDjtrPt9p3kn+wgn2IlYU27l8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EwLDADVSj3XKnOPx1my9ZBC/NSC0ayhreJvOeN5FceG4lC3xp2+7ApYLYSCi0+cxQ
         Gmvadfqj5YRyOnjdOEsyw0AzsAWE9DVtRPD+67l0grTJdy9guUWUqHBN8wFqDHpMCs
         g+AwA4BJ8HwMkC3LHm3PAIrUS2uX0h3HA47lRzQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fenghua Yu <fenghua.yu@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 5.15 065/511] selftests/resctrl: Make resctrl_tests run using kselftest framework
Date:   Sun, 17 Sep 2023 21:08:12 +0200
Message-ID: <20230917191115.452478531@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

[ Upstream commit b733143cc455bf83fa5fbd2e0eac63fb2d302461 ]

In kselftest framework, all tests can be build/run at a time,
and a sub test also can be build/run individually. As follows:
$ make kselftest-all TARGETS=resctrl
$ make -C tools/testing/selftests run_tests
$ make -C tools/testing/selftests TARGETS=resctrl run_tests

However, resctrl_tests cannot be run using kselftest framework,
users have to change directory to tools/testing/selftests/resctrl/,
run "make" to build executable file "resctrl_tests",
and run "sudo ./resctrl_tests" to execute the test.

To build/run resctrl_tests using kselftest framework.
Modify tools/testing/selftests/Makefile
and tools/testing/selftests/resctrl/Makefile.

Even after this change, users can still build/run resctrl_tests
without using framework as before.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com> # resctrl changes
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: 8e289f454289 ("selftests/resctrl: Add resctrl.h into build deps")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/Makefile         |  1 +
 tools/testing/selftests/resctrl/Makefile | 17 ++++-------------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 56a4873a343cf..c16e4da988257 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -52,6 +52,7 @@ TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
+TARGETS += resctrl
 TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 6bcee2ec91a9c..bee5fa8f1ac9d 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,17 +1,8 @@
-CC = $(CROSS_COMPILE)gcc
 CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
-SRCS=$(wildcard *.c)
-OBJS=$(SRCS:.c=.o)
+CFLAGS += $(KHDR_INCLUDES)
 
-all: resctrl_tests
+TEST_GEN_PROGS := resctrl_tests
 
-$(OBJS): $(SRCS)
-	$(CC) $(CFLAGS) -c $(SRCS)
+include ../lib.mk
 
-resctrl_tests: $(OBJS)
-	$(CC) $(CFLAGS) -o $@ $^
-
-.PHONY: clean
-
-clean:
-	$(RM) $(OBJS) resctrl_tests
+$(OUTPUT)/resctrl_tests: $(wildcard *.c)
-- 
2.40.1



