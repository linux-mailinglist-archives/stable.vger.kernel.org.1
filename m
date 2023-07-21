Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830C575D409
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjGUTRI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjGUTRG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB861FD7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:17:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B62961D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A050C433C9;
        Fri, 21 Jul 2023 19:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967023;
        bh=bWifgF7O/ICfufidwxmhTYDKZPONgX2pN/42hIZIQBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ld8wxUZeLCNPOg50zOHyh2TbRap/hzRAqNgdSi6/pJ/9BGGc5G5BSEsTrbINpIysD
         N5QufgObWPh3BEp6BJqprj7ceNFgMOiz/LGlCsWtiDVmvE/C5GL4iqOjsa1wyTBWVW
         h/q/S3o46Em7/hz4rzSGV5dnw5WpUc3XzdWp1TP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Airlie <airlied@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.1 005/223] workqueue: clean up WORK_* constant types, clarify masking
Date:   Fri, 21 Jul 2023 18:04:18 +0200
Message-ID: <20230721160521.102513119@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit afa4bb778e48d79e4a642ed41e3b4e0de7489a6c upstream.

Dave Airlie reports that gcc-13.1.1 has started complaining about some
of the workqueue code in 32-bit arm builds:

  kernel/workqueue.c: In function ‘get_work_pwq’:
  kernel/workqueue.c:713:24: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
    713 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
        |                        ^
  [ ... a couple of other cases ... ]

and while it's not immediately clear exactly why gcc started complaining
about it now, I suspect it's some C23-induced enum type handlign fixup in
gcc-13 is the cause.

Whatever the reason for starting to complain, the code and data types
are indeed disgusting enough that the complaint is warranted.

The wq code ends up creating various "helper constants" (like that
WORK_STRUCT_WQ_DATA_MASK) using an enum type, which is all kinds of
confused.  The mask needs to be 'unsigned long', not some unspecified
enum type.

To make matters worse, the actual "mask and cast to a pointer" is
repeated a couple of times, and the cast isn't even always done to the
right pointer, but - as the error case above - to a 'void *' with then
the compiler finishing the job.

That's now how we roll in the kernel.

So create the masks using the proper types rather than some ambiguous
enumeration, and use a nice helper that actually does the type
conversion in one well-defined place.

Incidentally, this magically makes clang generate better code.  That,
admittedly, is really just a sign of clang having been seriously
confused before, and cleaning up the typing unconfuses the compiler too.

Reported-by: Dave Airlie <airlied@gmail.com>
Link: https://lore.kernel.org/lkml/CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com/
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/workqueue.h |   15 ++++++++-------
 kernel/workqueue.c        |   13 ++++++++-----
 2 files changed, 16 insertions(+), 12 deletions(-)

--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -68,7 +68,6 @@ enum {
 	WORK_OFFQ_FLAG_BASE	= WORK_STRUCT_COLOR_SHIFT,
 
 	__WORK_OFFQ_CANCELING	= WORK_OFFQ_FLAG_BASE,
-	WORK_OFFQ_CANCELING	= (1 << __WORK_OFFQ_CANCELING),
 
 	/*
 	 * When a work item is off queue, its high bits point to the last
@@ -79,12 +78,6 @@ enum {
 	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_FLAG_BASE + WORK_OFFQ_FLAG_BITS,
 	WORK_OFFQ_LEFT		= BITS_PER_LONG - WORK_OFFQ_POOL_SHIFT,
 	WORK_OFFQ_POOL_BITS	= WORK_OFFQ_LEFT <= 31 ? WORK_OFFQ_LEFT : 31,
-	WORK_OFFQ_POOL_NONE	= (1LU << WORK_OFFQ_POOL_BITS) - 1,
-
-	/* convenience constants */
-	WORK_STRUCT_FLAG_MASK	= (1UL << WORK_STRUCT_FLAG_BITS) - 1,
-	WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
-	WORK_STRUCT_NO_POOL	= (unsigned long)WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT,
 
 	/* bit mask for work_busy() return values */
 	WORK_BUSY_PENDING	= 1 << 0,
@@ -94,6 +87,14 @@ enum {
 	WORKER_DESC_LEN		= 24,
 };
 
+/* Convenience constants - of type 'unsigned long', not 'enum'! */
+#define WORK_OFFQ_CANCELING	(1ul << __WORK_OFFQ_CANCELING)
+#define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
+#define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
+
+#define WORK_STRUCT_FLAG_MASK    ((1ul << WORK_STRUCT_FLAG_BITS) - 1)
+#define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
+
 struct work_struct {
 	atomic_long_t data;
 	struct list_head entry;
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -698,12 +698,17 @@ static void clear_work_data(struct work_
 	set_work_data(work, WORK_STRUCT_NO_POOL, 0);
 }
 
+static inline struct pool_workqueue *work_struct_pwq(unsigned long data)
+{
+	return (struct pool_workqueue *)(data & WORK_STRUCT_WQ_DATA_MASK);
+}
+
 static struct pool_workqueue *get_work_pwq(struct work_struct *work)
 {
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
+		return work_struct_pwq(data);
 	else
 		return NULL;
 }
@@ -731,8 +736,7 @@ static struct worker_pool *get_work_pool
 	assert_rcu_or_pool_mutex();
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool;
+		return work_struct_pwq(data)->pool;
 
 	pool_id = data >> WORK_OFFQ_POOL_SHIFT;
 	if (pool_id == WORK_OFFQ_POOL_NONE)
@@ -753,8 +757,7 @@ static int get_work_pool_id(struct work_
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
+		return work_struct_pwq(data)->pool->id;
 
 	return data >> WORK_OFFQ_POOL_SHIFT;
 }


