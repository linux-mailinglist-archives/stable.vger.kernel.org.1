Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158AB6FA6E1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjEHKZN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjEHKYr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C52524E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 433B7625A4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44282C433D2;
        Mon,  8 May 2023 10:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541455;
        bh=baqG6dGB//IdB+Wpz3W7UFAndcKgfP+rfunxPbTdjks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+lJ79jHY6KliiacxMKHMGUOWczl/jhoBW+kfUt2+b4lnuWZKi8q1ieSPJZiWirxQ
         gTjuHScMN1jpCrXE09lW/3lLPVxlx0n8ZNHA9q2kij/T8eYygvXTrRxjGJ2tZtbwOv
         oDwRLYg1rKoGNBnliCs2gtV6z8gSSq61h4l/SUQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 120/663] selftests/resctrl: Allow ->setup() to return errors
Date:   Mon,  8 May 2023 11:39:06 +0200
Message-Id: <20230508094432.409860474@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit fa10366cc6f4cc862871f8938426d85c2481f084 ]

resctrl_val() assumes ->setup() always returns either 0 to continue
tests or < 0 in case of the normal termination of tests after x runs.
The latter overlaps with normal error returns.

Define END_OF_TESTS (=1) to differentiate the normal termination of
tests and return errors as negative values. Alter callers of ->setup()
to handle errors properly.

Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/cache.c       | 4 +++-
 tools/testing/selftests/resctrl/cat_test.c    | 2 +-
 tools/testing/selftests/resctrl/cmt_test.c    | 2 +-
 tools/testing/selftests/resctrl/mba_test.c    | 2 +-
 tools/testing/selftests/resctrl/mbm_test.c    | 2 +-
 tools/testing/selftests/resctrl/resctrl.h     | 2 ++
 tools/testing/selftests/resctrl/resctrl_val.c | 4 +++-
 7 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 68ff856d36f0b..0485863a169f2 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -244,10 +244,12 @@ int cat_val(struct resctrl_val_param *param)
 	while (1) {
 		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
 			ret = param->setup(1, param);
-			if (ret) {
+			if (ret == END_OF_TESTS) {
 				ret = 0;
 				break;
 			}
+			if (ret < 0)
+				break;
 			ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
 			if (ret)
 				break;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 1c5e90c632548..2d3c7c77ab6cb 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -40,7 +40,7 @@ static int cat_setup(int num, ...)
 
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
-		return -1;
+		return END_OF_TESTS;
 
 	if (p->num_of_runs == 0) {
 		sprintf(schemata, "%lx", p->mask);
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 8968e36db99d7..3b0454e7fc826 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -32,7 +32,7 @@ static int cmt_setup(int num, ...)
 
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
-		return -1;
+		return END_OF_TESTS;
 
 	p->num_of_runs++;
 
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 1a1bdb6180cf2..f32289ae17aeb 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -41,7 +41,7 @@ static int mba_setup(int num, ...)
 		return 0;
 
 	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
-		return -1;
+		return END_OF_TESTS;
 
 	sprintf(allocation_str, "%d", allocation);
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 8392e5c55ed02..280187628054d 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -95,7 +95,7 @@ static int mbm_setup(int num, ...)
 
 	/* Run NUM_OF_RUNS times */
 	if (num_of_runs++ >= NUM_OF_RUNS)
-		return -1;
+		return END_OF_TESTS;
 
 	va_start(param, num);
 	p = va_arg(param, struct resctrl_val_param *);
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index f0ded31fb3c7c..f44fa2de4d986 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -37,6 +37,8 @@
 #define ARCH_INTEL     1
 #define ARCH_AMD       2
 
+#define END_OF_TESTS	1
+
 #define PARENT_EXIT(err_msg)			\
 	do {					\
 		perror(err_msg);		\
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 787546a528493..00864242d76c6 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -735,10 +735,12 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
 		ret = param->setup(1, param);
-		if (ret) {
+		if (ret == END_OF_TESTS) {
 			ret = 0;
 			break;
 		}
+		if (ret < 0)
+			break;
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-- 
2.39.2



