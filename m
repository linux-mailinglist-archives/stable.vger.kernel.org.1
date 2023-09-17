Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6347A3783
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbjIQTVe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbjIQTVH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:21:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F5383
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:21:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E29C433C7;
        Sun, 17 Sep 2023 19:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978461;
        bh=sR81dnaaaLWGrBIcKKj+EJ3wUQmsdG3TQj5KHUzTMmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCBHGMJWM+tuy7NLZLEqMOIyOcep75ci09C0HbFdAaVoCa54LHo9mVMeMOpK2zTQE
         rfquGYjuoT5VR9AzcUHkTj0X7Hm56WcCsPSPZm6bpdWeK6aUfQ6tifVFih5Aa/PJ7R
         Bhu0XvSwUpAv1CcBwzdRzPbkO5mClYQ3mM92AHZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 066/406] eventfd: Export eventfd_ctx_do_read()
Date:   Sun, 17 Sep 2023 21:08:40 +0200
Message-ID: <20230917191102.881791034@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

[ Upstream commit 28f1326710555bbe666f64452d08f2d7dd657cae ]

Where events are consumed in the kernel, for example by KVM's
irqfd_wakeup() and VFIO's virqfd_wakeup(), they currently lack a
mechanism to drain the eventfd's counter.

Since the wait queue is already locked while the wakeup functions are
invoked, all they really need to do is call eventfd_ctx_do_read().

Add a check for the lock, and export it for them.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <20201027135523.646811-2-dwmw2@infradead.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 758b49204781 ("eventfd: prevent underflow for eventfd semaphores")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventfd.c            | 5 ++++-
 include/linux/eventfd.h | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 4a14295cffe0d..b8d38b970ce7f 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -187,11 +187,14 @@ static __poll_t eventfd_poll(struct file *file, poll_table *wait)
 	return events;
 }
 
-static void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
 {
+	lockdep_assert_held(&ctx->wqh.lock);
+
 	*cnt = (ctx->flags & EFD_SEMAPHORE) ? 1 : ctx->count;
 	ctx->count -= *cnt;
 }
+EXPORT_SYMBOL_GPL(eventfd_ctx_do_read);
 
 /**
  * eventfd_ctx_remove_wait_queue - Read the current counter and removes wait queue.
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 6cd2a92daf205..c1bd4883e2faf 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -42,6 +42,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
 __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, unsigned mask);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
 
 DECLARE_PER_CPU(int, eventfd_wake_count);
 
@@ -89,6 +90,11 @@ static inline bool eventfd_signal_count(void)
 	return false;
 }
 
+static inline void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
+{
+
+}
+
 #endif
 
 #endif /* _LINUX_EVENTFD_H */
-- 
2.40.1



