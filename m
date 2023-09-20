Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20AA7A7B4B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjITLu7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjITLu7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:50:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7753ECE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:50:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEB5C433CA;
        Wed, 20 Sep 2023 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210652;
        bh=fynoGi+yC/8/EvXwM4C73jpsbYDbZslyGIcSbDJHpO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Asm/bIm2XOOO6bQ9qA5HVmsDU1+zYyMKNzwdI4KvMf1u7gxhfIAxBOKHOKTTfTTZd
         iCIFXfZe0o6yOC2P61FVUZZzE8VjwewIU6QtPYLyipy9yN1p6863nn2EXtpR2nU+NP
         xfpaD8cPuv4KnTyGmqG3AQYYa8JjdZ2CPCwxHhxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 128/211] printk: Reduce console_unblank() usage in unsafe scenarios
Date:   Wed, 20 Sep 2023 13:29:32 +0200
Message-ID: <20230920112849.781543688@linuxfoundation.org>
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

[ Upstream commit 7b23a66db55ed0a55b020e913f0d6f6d52a1ad2c ]

A semaphore is not NMI-safe, even when using down_trylock(). Both
down_trylock() and up() are using internal spinlocks and up()
might even call wake_up_process().

In the panic() code path it gets even worse because the internal
spinlocks of the semaphore may have been taken by a CPU that has
been stopped.

To reduce the risk of deadlocks caused by the console semaphore in
the panic path, make the following changes:

- First check if any consoles have implemented the unblank()
  callback. If not, then there is no reason to take the console
  semaphore anyway. (This check is also useful for the non-panic
  path since the locking/unlocking of the console lock can be
  quite expensive due to console printing.)

- If the panic path is in NMI context, bail out without attempting
  to take the console semaphore or calling any unblank() callbacks.
  Bailing out is acceptable because console_unblank() would already
  bail out if the console semaphore is contended. The alternative of
  ignoring the console semaphore and calling the unblank() callbacks
  anyway is a bad idea because these callbacks are also not NMI-safe.

If consoles with unblank() callbacks exist and console_unblank() is
called from a non-NMI panic context, it will still attempt a
down_trylock(). This could still result in a deadlock if one of the
stopped CPUs is holding the semaphore internal spinlock. But this
is a risk that the kernel has been (and continues to be) willing
to take.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20230717194607.145135-3-john.ogness@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 357a4d18f6387..7d3f30eb35862 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3045,9 +3045,27 @@ EXPORT_SYMBOL(console_conditional_schedule);
 
 void console_unblank(void)
 {
+	bool found_unblank = false;
 	struct console *c;
 	int cookie;
 
+	/*
+	 * First check if there are any consoles implementing the unblank()
+	 * callback. If not, there is no reason to continue and take the
+	 * console lock, which in particular can be dangerous if
+	 * @oops_in_progress is set.
+	 */
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
+		if ((console_srcu_read_flags(c) & CON_ENABLED) && c->unblank) {
+			found_unblank = true;
+			break;
+		}
+	}
+	console_srcu_read_unlock(cookie);
+	if (!found_unblank)
+		return;
+
 	/*
 	 * Stop console printing because the unblank() callback may
 	 * assume the console is not within its write() callback.
@@ -3056,6 +3074,16 @@ void console_unblank(void)
 	 * In that case, attempt a trylock as best-effort.
 	 */
 	if (oops_in_progress) {
+		/* Semaphores are not NMI-safe. */
+		if (in_nmi())
+			return;
+
+		/*
+		 * Attempting to trylock the console lock can deadlock
+		 * if another CPU was stopped while modifying the
+		 * semaphore. "Hope and pray" that this is not the
+		 * current situation.
+		 */
 		if (down_trylock_console_sem() != 0)
 			return;
 	} else
-- 
2.40.1



