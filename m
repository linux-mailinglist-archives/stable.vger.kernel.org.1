Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02897BE057
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377271AbjJINjb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377672AbjJINjZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:39:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAF899
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:39:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2388BC433C7;
        Mon,  9 Oct 2023 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858763;
        bh=d7B/3xUBqfTAVUUFk5GCp6jPGTLZpztEpMSbPdawa70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPkHgaQJZ6FJaBlTj+4bo56KAO4Fbnwh/8flmbg3w0H8n9UG0T7TdYSRLVPPCtKJ6
         Z2jeZoZ/TO4XJYt2p8oN/xIqbcLAFO2KFaxfbUPb6KMltz9Nsu57CwO42ukkEtCm7R
         YJtyJFAcdz5b5kwHx8YZRp82Q5AJrZRYSWM1xc9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 055/226] seqlock: Rename __seqprop() users
Date:   Mon,  9 Oct 2023 15:00:16 +0200
Message-ID: <20231009130128.228813727@linuxfoundation.org>
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

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit ab440b2c604b60fe90885270fcfeb5c3dd5d6fae ]

More consistent naming should make it easier to untangle the _Generic
token pasting maze called __seqprop().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201110115358.GE2594@hirez.programming.kicks-ass.net
Stable-dep-of: 41b43b6c6e30 ("locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/seqlock.h | 46 ++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index fb89b05066f43..66993e9ef90d9 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -307,10 +307,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 	__seqprop_case((s),	mutex,		prop),			\
 	__seqprop_case((s),	ww_mutex,	prop))
 
-#define __seqcount_ptr(s)		__seqprop(s, ptr)
-#define __seqcount_sequence(s)		__seqprop(s, sequence)
-#define __seqcount_lock_preemptible(s)	__seqprop(s, preemptible)
-#define __seqcount_assert_lock_held(s)	__seqprop(s, assert)
+#define seqprop_ptr(s)			__seqprop(s, ptr)
+#define seqprop_sequence(s)		__seqprop(s, sequence)
+#define seqprop_preemptible(s)		__seqprop(s, preemptible)
+#define seqprop_assert(s)		__seqprop(s, assert)
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
@@ -330,7 +330,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 ({									\
 	unsigned __seq;							\
 									\
-	while ((__seq = __seqcount_sequence(s)) & 1)			\
+	while ((__seq = seqprop_sequence(s)) & 1)			\
 		cpu_relax();						\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
@@ -359,7 +359,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define read_seqcount_begin(s)						\
 ({									\
-	seqcount_lockdep_reader_access(__seqcount_ptr(s));		\
+	seqcount_lockdep_reader_access(seqprop_ptr(s));			\
 	raw_read_seqcount_begin(s);					\
 })
 
@@ -376,7 +376,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount(s)						\
 ({									\
-	unsigned __seq = __seqcount_sequence(s);			\
+	unsigned __seq = seqprop_sequence(s);				\
 									\
 	smp_rmb();							\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
@@ -425,7 +425,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	__read_seqcount_t_retry(__seqcount_ptr(s), start)
+	__read_seqcount_t_retry(seqprop_ptr(s), start)
 
 static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
@@ -445,7 +445,7 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	read_seqcount_t_retry(__seqcount_ptr(s), start)
+	read_seqcount_t_retry(seqprop_ptr(s), start)
 
 static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
@@ -459,10 +459,10 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
+	raw_write_seqcount_t_begin(seqprop_ptr(s));			\
 } while (0)
 
 static inline void raw_write_seqcount_t_begin(seqcount_t *s)
@@ -478,9 +478,9 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
-	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
+	raw_write_seqcount_t_end(seqprop_ptr(s));			\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
@@ -501,12 +501,12 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
  */
 #define write_seqcount_begin_nested(s, subclass)			\
 do {									\
-	__seqcount_assert_lock_held(s);					\
+	seqprop_assert(s);						\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
+	write_seqcount_t_begin_nested(seqprop_ptr(s), subclass);	\
 } while (0)
 
 static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
@@ -528,12 +528,12 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
  */
 #define write_seqcount_begin(s)						\
 do {									\
-	__seqcount_assert_lock_held(s);					\
+	seqprop_assert(s);						\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin(__seqcount_ptr(s));			\
+	write_seqcount_t_begin(seqprop_ptr(s));				\
 } while (0)
 
 static inline void write_seqcount_t_begin(seqcount_t *s)
@@ -549,9 +549,9 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
  */
 #define write_seqcount_end(s)						\
 do {									\
-	write_seqcount_t_end(__seqcount_ptr(s));			\
+	write_seqcount_t_end(seqprop_ptr(s));				\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
@@ -603,7 +603,7 @@ static inline void write_seqcount_t_end(seqcount_t *s)
  *      }
  */
 #define raw_write_seqcount_barrier(s)					\
-	raw_write_seqcount_t_barrier(__seqcount_ptr(s))
+	raw_write_seqcount_t_barrier(seqprop_ptr(s))
 
 static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
 {
@@ -623,7 +623,7 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
  * will complete successfully and see data older than this.
  */
 #define write_seqcount_invalidate(s)					\
-	write_seqcount_t_invalidate(__seqcount_ptr(s))
+	write_seqcount_t_invalidate(seqprop_ptr(s))
 
 static inline void write_seqcount_t_invalidate(seqcount_t *s)
 {
-- 
2.40.1



