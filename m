Return-Path: <stable+bounces-250253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A8dGXLmDWqm4gUAu9opvQ
	(envelope-from <stable+bounces-250253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9A259289B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7DA730A3CD2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8FE3E1D1B;
	Wed, 20 May 2026 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nguIOOXj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287273E832A;
	Wed, 20 May 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294928; cv=none; b=rKRAZEc/x3k+Ym4CEY+eA8F3M+7su5rlr+9wnSqnBGgajHAAdVJq0KV3tRrUWPM5wlUOOPILEAj7sJ6oEtThBt5B22F5wb+6vYfa2SJFhwrlWNALQKIc8AAGyO9HMw2fqYJaLVFFGttJyHLp/Wf5fopBJEavuPuqGcPIiRS2GtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294928; c=relaxed/simple;
	bh=Sv5i1VbTS3ljxmyq1Xk5PsyVsIOtVbgYSopLuEel/Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpBkYzCCxVo7xLb6CPcmKfariJSbBaf31oNPZ/zpuStNk5XWpD13hmW2Hq4cnkRwjl8+sQJXU8bNgHgvDcquXmjHbKldqNLifLdDHXZ8cqgkvLq2cgk7rNjIlX25E8v3lXXWbnGXJxoltss9lDGVETC2G2c4Im1ZTf028miFAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nguIOOXj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A891F000E9;
	Wed, 20 May 2026 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294926;
	bh=avgr4cG0M9JN4GV1QGqxHRfb+0RmxQ+5qECbr1IxZKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nguIOOXjZbiksxGxXIlKX0bWkhwpsqujsCL+uQ+DzyHCuv3c+LSPfUXPuc5jxP6dz
	 b5ARbU+k+eDe8icw55GToO70Swy3oZDDqC2jTSyXhONMV95xd/CiSV0/q0//oTpQJG
	 didz4DcSqEhwxvO8sxPRl7rltBxVKYxr4PBWCBxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0226/1146] selftests/futex: Fix incorrect result reporting of futex_requeue test item
Date: Wed, 20 May 2026 18:07:56 +0200
Message-ID: <20260520162153.369504932@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250253-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,foxmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,foxmail.com:email]
X-Rspamd-Queue-Id: 0E9A259289B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuwen Chen <ywen.chen@foxmail.com>

[ Upstream commit d317e2ef9dcf673c9f37cda784284af7c6812757 ]

When using the TEST_HARNESS_MAIN macro definition to declare the main
function, it is required to use the EXPECT*() and ASSERT*() macros in
conjunction and not ksft_test_result_*(). Otherwise, even if a test item
fails, the test will still return a success result because
ksft_test_result_*() does not affect the test harness state.

Convert the code to use EXPECT/ASSERT() variants, which ensures that the
overall test result is fail if one of the EXPECT()s fails.

[ tglx: Massaged change log to explain _why_ ksft_test_result*() is the wrong
  	choice ]

Fixes: f341a20f6d7e ("selftests/futex: Refactor futex_requeue with kselftest_harness.h")
Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/tencent_51851B741CC4B5EC9C22AFF70BA82BB60805@qq.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../futex/functional/futex_requeue.c          | 49 +++----------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
index 35d4be23db5da..dcf0d5f2f3122 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -34,34 +34,18 @@ TEST(requeue_single)
 	volatile futex_t _f1 = 0;
 	volatile futex_t f2 = 0;
 	pthread_t waiter[10];
-	int res;
 
 	f1 = &_f1;
 
 	/*
 	 * Requeue a waiter from f1 to f2, and wake f2.
 	 */
-	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
-		ksft_exit_fail_msg("pthread_create failed\n");
+	ASSERT_EQ(0, pthread_create(&waiter[0], NULL, waiterfn, NULL));
 
 	usleep(WAKE_WAIT_US);
 
-	ksft_print_dbg_msg("Requeuing 1 futex from f1 to f2\n");
-	res = futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
-	if (res != 1)
-		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-
-	ksft_print_dbg_msg("Waking 1 futex at f2\n");
-	res = futex_wake(&f2, 1, 0);
-	if (res != 1) {
-		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-	} else {
-		ksft_test_result_pass("futex_requeue simple succeeds\n");
-	}
+	EXPECT_EQ(1, futex_cmp_requeue(f1, 0, &f2, 0, 1, 0));
+	EXPECT_EQ(1, futex_wake(&f2, 1, 0));
 }
 
 TEST(requeue_multiple)
@@ -69,7 +53,7 @@ TEST(requeue_multiple)
 	volatile futex_t _f1 = 0;
 	volatile futex_t f2 = 0;
 	pthread_t waiter[10];
-	int res, i;
+	int i;
 
 	f1 = &_f1;
 
@@ -77,30 +61,13 @@ TEST(requeue_multiple)
 	 * Create 10 waiters at f1. At futex_requeue, wake 3 and requeue 7.
 	 * At futex_wake, wake INT_MAX (should be exactly 7).
 	 */
-	for (i = 0; i < 10; i++) {
-		if (pthread_create(&waiter[i], NULL, waiterfn, NULL))
-			ksft_exit_fail_msg("pthread_create failed\n");
-	}
+	for (i = 0; i < 10; i++)
+		ASSERT_EQ(0, pthread_create(&waiter[i], NULL, waiterfn, NULL));
 
 	usleep(WAKE_WAIT_US);
 
-	ksft_print_dbg_msg("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
-	res = futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
-	if (res != 10) {
-		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-	}
-
-	ksft_print_dbg_msg("Waking INT_MAX futexes at f2\n");
-	res = futex_wake(&f2, INT_MAX, 0);
-	if (res != 7) {
-		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-	} else {
-		ksft_test_result_pass("futex_requeue many succeeds\n");
-	}
+	EXPECT_EQ(10, futex_cmp_requeue(f1, 0, &f2, 3, 7, 0));
+	EXPECT_EQ(7, futex_wake(&f2, INT_MAX, 0));
 }
 
 TEST_HARNESS_MAIN
-- 
2.53.0




