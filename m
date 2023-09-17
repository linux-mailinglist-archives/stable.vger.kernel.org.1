Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38447A3B1C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbjIQUNy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbjIQUN0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:13:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E7E1AB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:12:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C38DC433CC;
        Sun, 17 Sep 2023 20:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981564;
        bh=xBbZEOyj9VcpV/RCbkEdbLY+tg635D8puTW+lJY0jCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zuRfuQL676GroMIy+0Msybpxj/25xGw566G0FMGqzM9BUD7YdbhEmZyrtxh2R0Gd3
         faF3CX0XE2i1xEIdlGbBRcC4p9KIfrHZnZnW4rm3PWZ7j0sySUOIgZLJ/vX11LYRxD
         fuLanQmyGYF8UURlggSB9au3sLG19wuVQkRwl5O0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Nysal Jan K.A" <nysal@linux.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 072/511] selftests/futex: Order calls to futex_lock_pi
Date:   Sun, 17 Sep 2023 21:08:19 +0200
Message-ID: <20230917191115.618123281@linuxfoundation.org>
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

From: Nysal Jan K.A <nysal@linux.ibm.com>

[ Upstream commit fbf4dec702774286db409815ffb077711a96b824 ]

Observed occassional failures in the futex_wait_timeout test:

ok 1 futex_wait relative succeeds
ok 2 futex_wait_bitset realtime succeeds
ok 3 futex_wait_bitset monotonic succeeds
ok 4 futex_wait_requeue_pi realtime succeeds
ok 5 futex_wait_requeue_pi monotonic succeeds
not ok 6 futex_lock_pi realtime returned 0
......

The test expects the child thread to complete some steps before
the parent thread gets to run. There is an implicit expectation
of the order of invocation of futex_lock_pi between the child thread
and the parent thread. Make this order explicit. If the order is
not met, the futex_lock_pi call in the parent thread succeeds and
will not timeout.

Fixes: f4addd54b161 ("selftests: futex: Expand timeout test")
Signed-off-by: Nysal Jan K.A <nysal@linux.ibm.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/futex/functional/futex_wait_timeout.c        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index 1f8f6daaf1e70..86ac205ea8e18 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -23,6 +23,7 @@
 
 static long timeout_ns = 100000;	/* 100us default timeout */
 static futex_t futex_pi;
+static pthread_barrier_t barrier;
 
 void usage(char *prog)
 {
@@ -47,6 +48,8 @@ void *get_pi_lock(void *arg)
 	if (ret != 0)
 		error("futex_lock_pi failed\n", ret);
 
+	pthread_barrier_wait(&barrier);
+
 	/* Blocks forever */
 	ret = futex_wait(&lock, 0, NULL, 0);
 	error("futex_wait failed\n", ret);
@@ -123,6 +126,7 @@ int main(int argc, char *argv[])
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
 
+	pthread_barrier_init(&barrier, NULL, 2);
 	pthread_create(&thread, NULL, get_pi_lock, NULL);
 
 	/* initialize relative timeout */
@@ -156,6 +160,9 @@ int main(int argc, char *argv[])
 	res = futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, 0);
 	test_timeout(res, &ret, "futex_wait_requeue_pi monotonic", ETIMEDOUT);
 
+	/* Wait until the other thread calls futex_lock_pi() */
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_destroy(&barrier);
 	/*
 	 * FUTEX_LOCK_PI with CLOCK_REALTIME
 	 * Due to historical reasons, FUTEX_LOCK_PI supports only realtime
-- 
2.40.1



