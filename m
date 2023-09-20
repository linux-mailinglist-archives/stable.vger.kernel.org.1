Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67C97A7B4F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjITLvE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjITLvE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:51:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04B3CA
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:50:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A101C433C7;
        Wed, 20 Sep 2023 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210657;
        bh=gOxpGLnG32PWxUlCxpi2LUFMKCB/Hwr/eFA2xLhC5Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xScsexcayIx+y9mI5xmKoenTB3QxHQ3PxEJCKnwtJlVmU1sH3Tk2FFn7igQYC1gQ9
         948+bwHNatFJKbBiB0pXw48Gk6ugnTZMkplHzh1r+bohaLdH8IjM0CdQIGKTIGSC7p
         fwfpFkZSj0J5gOBruXuCCy7NP25OYOiJu9QMZFeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 130/211] printk: Do not take console lock for console_flush_on_panic()
Date:   Wed, 20 Sep 2023 13:29:34 +0200
Message-ID: <20230920112849.844643021@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit eacb04ff3c5b8662a65f380ae450250698448cff ]

Currently console_flush_on_panic() will attempt to acquire the
console lock when flushing the buffer on panic. If it fails to
acquire the lock, it continues anyway because this is the last
chance to get any pending records printed.

The reason why the console lock was attempted at all was to
prevent any other CPUs from acquiring the console lock for
printing while the panic CPU was printing. But as of the
previous commit, non-panic CPUs will no longer attempt to
acquire the console lock in a panic situation. Therefore it is
no longer strictly necessary for a panic CPU to acquire the
console lock.

Avoiding taking the console lock when flushing in panic has
the additional benefit of avoiding possible deadlocks due to
semaphore usage in NMI context (semaphores are not NMI-safe)
and avoiding possible deadlocks if another CPU accesses the
semaphore and is stopped while holding one of the semaphore's
internal spinlocks.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20230717194607.145135-5-john.ogness@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 591c11888200d..88770561c4350 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3120,14 +3120,24 @@ void console_unblank(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	bool handover;
+	u64 next_seq;
+
 	/*
-	 * If someone else is holding the console lock, trylock will fail
-	 * and may_schedule may be set.  Ignore and proceed to unlock so
-	 * that messages are flushed out.  As this can be called from any
-	 * context and we don't want to get preempted while flushing,
-	 * ensure may_schedule is cleared.
+	 * Ignore the console lock and flush out the messages. Attempting a
+	 * trylock would not be useful because:
+	 *
+	 *   - if it is contended, it must be ignored anyway
+	 *   - console_lock() and console_trylock() block and fail
+	 *     respectively in panic for non-panic CPUs
+	 *   - semaphores are not NMI-safe
+	 */
+
+	/*
+	 * If another context is holding the console lock,
+	 * @console_may_schedule might be set. Clear it so that
+	 * this context does not call cond_resched() while flushing.
 	 */
-	console_trylock();
 	console_may_schedule = 0;
 
 	if (mode == CONSOLE_REPLAY_ALL) {
@@ -3140,15 +3150,15 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
 			/*
-			 * If the above console_trylock() failed, this is an
-			 * unsynchronized assignment. But in that case, the
+			 * This is an unsynchronized assignment, but the
 			 * kernel is in "hope and pray" mode anyway.
 			 */
 			c->seq = seq;
 		}
 		console_srcu_read_unlock(cookie);
 	}
-	console_unlock();
+
+	console_flush_all(false, &next_seq, &handover);
 }
 
 /*
-- 
2.40.1



