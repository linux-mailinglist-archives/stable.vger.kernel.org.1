Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B56FA418
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjEHJzN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjEHJzM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAD22573A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50C1B62215
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E52C433EF;
        Mon,  8 May 2023 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539709;
        bh=o7HrmJqT70cp5lLg7funq2PL/u8Rl6uMfy+uZthYiAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eB8kSsLX9cmcnsjX+U0/f4NWNxQN3eHBLYRHewxiQiDB5+kB2i4MEGuXWvQXZJm5z
         hL3iWS1urUC1l0tF5HIpYbG72fGNYuZoOI34c+6c3ePtgHkVOAFGrZsRm22D7fGz6I
         o4cE7QXceOlAO8LRQNt5ZmjVDL1I0p5pBsjh6Al8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 113/611] kunit: improve KTAP compliance of KUnit test output
Date:   Mon,  8 May 2023 11:39:15 +0200
Message-Id: <20230508094425.943897555@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Rae Moar <rmoar@google.com>

[ Upstream commit 6c738b52316c58ae8a87abf0907f87a7b5e7a109 ]

Change KUnit test output to better comply with KTAP v1 specifications
found here: https://kernel.org/doc/html/latest/dev-tools/ktap.html.
1) Use "KTAP version 1" instead of "TAP version 14" as test output header
2) Remove '-' between test number and test name on test result lines
2) Add KTAP version lines to each subtest header as well

Note that the new KUnit output still includes the “# Subtest” line now
located after the KTAP version line. This does not completely match the
KTAP v1 spec but since it is classified as a diagnostic line, it is not
expected to be disruptive or break any existing parsers. This
“# Subtest” line comes from the TAP 14 spec
(https://testanything.org/tap-version-14-specification.html) and it is
used to define the test name before the results.

Original output:

 TAP version 14
 1..1
   # Subtest: kunit-test-suite
   1..3
   ok 1 - kunit_test_1
   ok 2 - kunit_test_2
   ok 3 - kunit_test_3
 # kunit-test-suite: pass:3 fail:0 skip:0 total:3
 # Totals: pass:3 fail:0 skip:0 total:3
 ok 1 - kunit-test-suite

New output:

 KTAP version 1
 1..1
   KTAP version 1
   # Subtest: kunit-test-suite
   1..3
   ok 1 kunit_test_1
   ok 2 kunit_test_2
   ok 3 kunit_test_3
 # kunit-test-suite: pass:3 fail:0 skip:0 total:3
 # Totals: pass:3 fail:0 skip:0 total:3
 ok 1 kunit-test-suite

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: f9a301c3317d ("kunit: fix bug in the order of lines in debugfs logs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/debugfs.c  | 2 +-
 lib/kunit/executor.c | 6 +++---
 lib/kunit/test.c     | 9 ++++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 1048ef1b8d6ec..de0ee2e03ed60 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -63,7 +63,7 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
 	kunit_suite_for_each_test_case(suite, test_case)
 		debugfs_print_result(seq, suite, test_case);
 
-	seq_printf(seq, "%s %d - %s\n",
+	seq_printf(seq, "%s %d %s\n",
 		   kunit_status_to_ok_not_ok(success), 1, suite->name);
 	return 0;
 }
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 9bbc422c284bf..74982b83707ca 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -166,7 +166,7 @@ static void kunit_exec_run_tests(struct suite_set *suite_set)
 {
 	size_t num_suites = suite_set->end - suite_set->start;
 
-	pr_info("TAP version 14\n");
+	pr_info("KTAP version 1\n");
 	pr_info("1..%zu\n", num_suites);
 
 	__kunit_test_suites_init(suite_set->start, num_suites);
@@ -177,8 +177,8 @@ static void kunit_exec_list_tests(struct suite_set *suite_set)
 	struct kunit_suite * const *suites;
 	struct kunit_case *test_case;
 
-	/* Hack: print a tap header so kunit.py can find the start of KUnit output. */
-	pr_info("TAP version 14\n");
+	/* Hack: print a ktap header so kunit.py can find the start of KUnit output. */
+	pr_info("KTAP version 1\n");
 
 	for (suites = suite_set->start; suites < suite_set->end; suites++)
 		kunit_suite_for_each_test_case((*suites), test_case) {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 2a6992fe7c3e4..0391159d0c235 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -149,6 +149,7 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
 static void kunit_print_suite_start(struct kunit_suite *suite)
 {
+	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
 		  suite->name);
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
@@ -175,13 +176,13 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 	 * representation.
 	 */
 	if (suite)
-		pr_info("%s %zd - %s%s%s\n",
+		pr_info("%s %zd %s%s%s\n",
 			kunit_status_to_ok_not_ok(status),
 			test_number, description, directive_header,
 			(status == KUNIT_SKIPPED) ? directive : "");
 	else
 		kunit_log(KERN_INFO, test,
-			  KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
+			  KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
 			  kunit_status_to_ok_not_ok(status),
 			  test_number, description, directive_header,
 			  (status == KUNIT_SKIPPED) ? directive : "");
@@ -542,6 +543,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			test.param_value = test_case->generate_params(NULL, param_desc);
+			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+				  "KTAP version 1\n");
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "# Subtest: %s", test_case->name);
 
@@ -555,7 +558,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 				kunit_log(KERN_INFO, &test,
 					  KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
-					  "%s %d - %s",
+					  "%s %d %s",
 					  kunit_status_to_ok_not_ok(test.status),
 					  test.param_index + 1, param_desc);
 
-- 
2.39.2



