Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA887BE023
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377235AbjJINhz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377204AbjJINhx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:37:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD9E99
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:37:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500A4C433C7;
        Mon,  9 Oct 2023 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858671;
        bh=QSPCAUUw5md9GL2X0eMPxbr276C3zUIZTR00Pf+K51o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vF1jsoQ26MmGspe3SmjNp+vJFj8vxGRam5YMV+On1mjw9s4p47Wgx/oXMEsrr6vxn
         pLuh80QKuTEcj6Hz1ODf6O/I2ppmv9Pv5OuFvh9EMsHI/mb8Md/3Z7Agh4rGMf95DN
         EmngQ+BbPR0ZCAXgv5R6ZgED5wluBpyJcjrbHgGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 056/226] seqlock: Prefix internal seqcount_t-only macros with a "do_"
Date:   Mon,  9 Oct 2023 15:00:17 +0200
Message-ID: <20231009130128.253941942@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ahmed S. Darwish <a.darwish@linutronix.de>

[ Upstream commit 66bcfcdf89d00f2409f4b5da0f8c20c08318dc72 ]

When the seqcount_LOCKNAME_t group of data types were introduced, two
classes of seqlock.h sequence counter macros were added:

  - An external public API which can either take a plain seqcount_t or
    any of the seqcount_LOCKNAME_t variants.

  - An internal API which takes only a plain seqcount_t.

To distinguish between the two groups, the "*_seqcount_t_*" pattern was
used for the latter. This confused a number of mm/ call-site developers,
and Linus also commented that it was not a standard practice for marking
seqlock.h internal APIs.

Distinguish the latter group of macros by prefixing a "do_".

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com
Stable-dep-of: 41b43b6c6e30 ("locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/seqlock.h | 66 ++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 66993e9ef90d9..008fa88ad58e7 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -425,9 +425,9 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	__read_seqcount_t_retry(seqprop_ptr(s), start)
+	do___read_seqcount_retry(seqprop_ptr(s), start)
 
-static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
+static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	kcsan_atomic_next(0);
 	return unlikely(READ_ONCE(s->sequence) != start);
@@ -445,12 +445,12 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	read_seqcount_t_retry(seqprop_ptr(s), start)
+	do_read_seqcount_retry(seqprop_ptr(s), start)
 
-static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
+static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	smp_rmb();
-	return __read_seqcount_t_retry(s, start);
+	return do___read_seqcount_retry(s, start);
 }
 
 /**
@@ -462,10 +462,10 @@ do {									\
 	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	raw_write_seqcount_t_begin(seqprop_ptr(s));			\
+	do_raw_write_seqcount_begin(seqprop_ptr(s));			\
 } while (0)
 
-static inline void raw_write_seqcount_t_begin(seqcount_t *s)
+static inline void do_raw_write_seqcount_begin(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -478,13 +478,13 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
-	raw_write_seqcount_t_end(seqprop_ptr(s));			\
+	do_raw_write_seqcount_end(seqprop_ptr(s));			\
 									\
 	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
-static inline void raw_write_seqcount_t_end(seqcount_t *s)
+static inline void do_raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
@@ -506,12 +506,12 @@ do {									\
 	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin_nested(seqprop_ptr(s), subclass);	\
+	do_write_seqcount_begin_nested(seqprop_ptr(s), subclass);	\
 } while (0)
 
-static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
+static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	raw_write_seqcount_t_begin(s);
+	do_raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
@@ -533,12 +533,12 @@ do {									\
 	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin(seqprop_ptr(s));				\
+	do_write_seqcount_begin(seqprop_ptr(s));			\
 } while (0)
 
-static inline void write_seqcount_t_begin(seqcount_t *s)
+static inline void do_write_seqcount_begin(seqcount_t *s)
 {
-	write_seqcount_t_begin_nested(s, 0);
+	do_write_seqcount_begin_nested(s, 0);
 }
 
 /**
@@ -549,16 +549,16 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
  */
 #define write_seqcount_end(s)						\
 do {									\
-	write_seqcount_t_end(seqprop_ptr(s));				\
+	do_write_seqcount_end(seqprop_ptr(s));				\
 									\
 	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
-static inline void write_seqcount_t_end(seqcount_t *s)
+static inline void do_write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
-	raw_write_seqcount_t_end(s);
+	do_raw_write_seqcount_end(s);
 }
 
 /**
@@ -603,9 +603,9 @@ static inline void write_seqcount_t_end(seqcount_t *s)
  *      }
  */
 #define raw_write_seqcount_barrier(s)					\
-	raw_write_seqcount_t_barrier(seqprop_ptr(s))
+	do_raw_write_seqcount_barrier(seqprop_ptr(s))
 
-static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
+static inline void do_raw_write_seqcount_barrier(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -623,9 +623,9 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
  * will complete successfully and see data older than this.
  */
 #define write_seqcount_invalidate(s)					\
-	write_seqcount_t_invalidate(seqprop_ptr(s))
+	do_write_seqcount_invalidate(seqprop_ptr(s))
 
-static inline void write_seqcount_t_invalidate(seqcount_t *s)
+static inline void do_write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
 	kcsan_nestable_atomic_begin();
@@ -862,9 +862,9 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use write_seqcount_*t*_begin()
- * instead of the generic write_seqcount_begin(). This way, no redundant
- * lockdep_assert_held() checks are added.
+ * For all seqlock_t write side functions, use the the internal
+ * do_write_seqcount_begin() instead of generic write_seqcount_begin().
+ * This way, no redundant lockdep_assert_held() checks are added.
  */
 
 /**
@@ -883,7 +883,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -895,7 +895,7 @@ static inline void write_seqlock(seqlock_t *sl)
  */
 static inline void write_sequnlock(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock(&sl->lock);
 }
 
@@ -909,7 +909,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -922,7 +922,7 @@ static inline void write_seqlock_bh(seqlock_t *sl)
  */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
@@ -936,7 +936,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -948,7 +948,7 @@ static inline void write_seqlock_irq(seqlock_t *sl)
  */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -957,7 +957,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 	return flags;
 }
 
@@ -986,7 +986,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
-- 
2.40.1



