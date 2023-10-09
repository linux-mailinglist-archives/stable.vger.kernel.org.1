Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219B17BDD49
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376720AbjJINJR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376736AbjJINJQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:09:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270B29C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:09:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640EFC433C7;
        Mon,  9 Oct 2023 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856954;
        bh=gAUUqs8eq1p9oqZ84DThV8QCBN47hITvImacIWxLi+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCPY47CWiQZE3LII76swcxYmsWksrCygDGU3S0imjMnS5RADMaNnQ7JIQjA27mcCw
         QQ1JflbrNB4f6KHmy2Xi+PxROIg+Wyg5Dg8gx8FpEMDg5N3LEa5I33DwDZ0ASZIsL0
         5y62lBV1N3pGjCGOW4c3SUu+3zzvFxLHpYuddz4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        syzbot+efc45d4e7ba6ab4ef1eb@syzkaller.appspotmail.com
Subject: [PATCH 6.5 047/163] io_uring: ensure io_lockdep_assert_cq_locked() handles disabled rings
Date:   Mon,  9 Oct 2023 15:00:11 +0200
Message-ID: <20231009130125.330701963@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 1658633c04653578429ff5dfc62fdc159203a8f2 upstream.

io_lockdep_assert_cq_locked() checks that locking is correctly done when
a CQE is posted. If the ring is setup in a disabled state with
IORING_SETUP_R_DISABLED, then ctx->submitter_task isn't assigned until
the ring is later enabled. We generally don't post CQEs in this state,
as no SQEs can be submitted. However it is possible to generate a CQE
if tagged resources are being updated. If this happens and PROVE_LOCKING
is enabled, then the locking check helper will dereference
ctx->submitter_task, which hasn't been set yet.

Fixup io_lockdep_assert_cq_locked() to handle this case correctly. While
at it, convert it to a static inline as well, so that generated line
offsets will actually reflect which condition failed, rather than just
the line offset for io_lockdep_assert_cq_locked() itself.

Reported-and-tested-by: syzbot+efc45d4e7ba6ab4ef1eb@syzkaller.appspotmail.com
Fixes: f26cc9593581 ("io_uring: lockdep annotate CQ locking")
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.h |   41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -87,20 +87,33 @@ bool __io_alloc_req_refill(struct io_rin
 bool io_match_task_safe(struct io_kiocb *head, struct task_struct *task,
 			bool cancel_all);
 
-#define io_lockdep_assert_cq_locked(ctx)				\
-	do {								\
-		lockdep_assert(in_task());				\
-									\
-		if (ctx->flags & IORING_SETUP_IOPOLL) {			\
-			lockdep_assert_held(&ctx->uring_lock);		\
-		} else if (!ctx->task_complete) {			\
-			lockdep_assert_held(&ctx->completion_lock);	\
-		} else if (ctx->submitter_task->flags & PF_EXITING) {	\
-			lockdep_assert(current_work());			\
-		} else {						\
-			lockdep_assert(current == ctx->submitter_task);	\
-		}							\
-	} while (0)
+#if defined(CONFIG_PROVE_LOCKING)
+static inline void io_lockdep_assert_cq_locked(struct io_ring_ctx *ctx)
+{
+	lockdep_assert(in_task());
+
+	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		lockdep_assert_held(&ctx->uring_lock);
+	} else if (!ctx->task_complete) {
+		lockdep_assert_held(&ctx->completion_lock);
+	} else if (ctx->submitter_task) {
+		/*
+		 * ->submitter_task may be NULL and we can still post a CQE,
+		 * if the ring has been setup with IORING_SETUP_R_DISABLED.
+		 * Not from an SQE, as those cannot be submitted, but via
+		 * updating tagged resources.
+		 */
+		if (ctx->submitter_task->flags & PF_EXITING)
+			lockdep_assert(current_work());
+		else
+			lockdep_assert(current == ctx->submitter_task);
+	}
+}
+#else
+static inline void io_lockdep_assert_cq_locked(struct io_ring_ctx *ctx)
+{
+}
+#endif
 
 static inline void io_req_task_work_add(struct io_kiocb *req)
 {


