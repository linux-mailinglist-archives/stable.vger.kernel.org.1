Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01077ECC63
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjKOTaF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjKOTaE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:30:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D7C12C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:30:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A4C433C8;
        Wed, 15 Nov 2023 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076600;
        bh=eXmhYSOb7uXsfT3wIBu7CIioGaEWkH8q56gRqJKAUmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oK3nKhhtjfBdPC/5v4XyllCs+CdqMu5GG7oUNSqeiHEmPlP70AxfXawPvzS35rWDr
         gtej046YAPQInP1VvdfZ3G5Lx8w4S9htYnQUkOSr6hBXkTE8SjhuAZbIs9zz9OHcCM
         yMKwZ0RFTrOfDHQRG+MPaaaDkORf7HMJ8Hrjsr74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 299/550] selftests/pidfd: Fix ksft print formats
Date:   Wed, 15 Nov 2023 14:14:43 -0500
Message-ID: <20231115191621.538101275@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

[ Upstream commit 4d7f4e8158b62f63031510cdc24acc520956c091 ]

Compiling pidfd selftest after adding a __printf() attribute to
ksft_print_msg() and ksft_test_result_pass() exposes -Wformat warnings
in error_report(), test_pidfd_poll_exec_thread(),
child_poll_exec_test(), test_pidfd_poll_leader_exit_thread(),
child_poll_leader_exit_test().

The ksft_test_result_pass() in error_report() expects a string but
doesn't provide any argument after the format string. All the other
calls to ksft_print_msg() in the functions mentioned above have format
strings that don't match with other passed arguments.

Fix format specifiers so they match the passed variables.

Add a missing variable to ksft_test_result_pass() inside
error_report() so it matches other cases in the switch statement.

Fixes: 2def297ec7fb ("pidfd: add tests for NSpid info in fdinfo")

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c |  2 +-
 tools/testing/selftests/pidfd/pidfd_test.c        | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index 4e86f927880c3..01cc37bf611c3 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -62,7 +62,7 @@ static void error_report(struct error *err, const char *test_name)
 		break;
 
 	case PIDFD_PASS:
-		ksft_test_result_pass("%s test: Passed\n");
+		ksft_test_result_pass("%s test: Passed\n", test_name);
 		break;
 
 	default:
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 00a07e7c571cd..c081ae91313aa 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -381,13 +381,13 @@ static int test_pidfd_send_signal_syscall_support(void)
 
 static void *test_pidfd_poll_exec_thread(void *priv)
 {
-	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
+	ksft_print_msg("Child Thread: starting. pid %d tid %ld ; and sleeping\n",
 			getpid(), syscall(SYS_gettid));
 	ksft_print_msg("Child Thread: doing exec of sleep\n");
 
 	execl("/bin/sleep", "sleep", str(CHILD_THREAD_MIN_WAIT), (char *)NULL);
 
-	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n",
+	ksft_print_msg("Child Thread: DONE. pid %d tid %ld\n",
 			getpid(), syscall(SYS_gettid));
 	return NULL;
 }
@@ -427,7 +427,7 @@ static int child_poll_exec_test(void *args)
 {
 	pthread_t t1;
 
-	ksft_print_msg("Child (pidfd): starting. pid %d tid %d\n", getpid(),
+	ksft_print_msg("Child (pidfd): starting. pid %d tid %ld\n", getpid(),
 			syscall(SYS_gettid));
 	pthread_create(&t1, NULL, test_pidfd_poll_exec_thread, NULL);
 	/*
@@ -480,10 +480,10 @@ static void test_pidfd_poll_exec(int use_waitpid)
 
 static void *test_pidfd_poll_leader_exit_thread(void *priv)
 {
-	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
+	ksft_print_msg("Child Thread: starting. pid %d tid %ld ; and sleeping\n",
 			getpid(), syscall(SYS_gettid));
 	sleep(CHILD_THREAD_MIN_WAIT);
-	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
+	ksft_print_msg("Child Thread: DONE. pid %d tid %ld\n", getpid(), syscall(SYS_gettid));
 	return NULL;
 }
 
@@ -492,7 +492,7 @@ static int child_poll_leader_exit_test(void *args)
 {
 	pthread_t t1, t2;
 
-	ksft_print_msg("Child: starting. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
+	ksft_print_msg("Child: starting. pid %d tid %ld\n", getpid(), syscall(SYS_gettid));
 	pthread_create(&t1, NULL, test_pidfd_poll_leader_exit_thread, NULL);
 	pthread_create(&t2, NULL, test_pidfd_poll_leader_exit_thread, NULL);
 
-- 
2.42.0



