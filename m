Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B8E7BE018
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377205AbjJINh0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377247AbjJINhZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:37:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDF3C5
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:37:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B766C433C7;
        Mon,  9 Oct 2023 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858642;
        bh=UIEaVgMhHs5QHFmjWg3+w0uuDW93SlL4MR0IVr1o7xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeyPaqIskpjoxn0bLRTnrcHIy6heB6zE+9rHjcNv9qabNMS5j0FkUP5iayp4MhyBa
         YP0lZ8jLqRtiGlYmFJ8o5LWcziHccalgbrXpgckBxDQ93vy4sJDUl9kmj8nYwKHonF
         DDeqcI/aXh9nbQhOnRud/yyT/xpq6bIdVcZHNVW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 054/226] seqlock: avoid -Wshadow warnings
Date:   Mon,  9 Oct 2023 15:00:15 +0200
Message-ID: <20231009130128.203362509@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a07c45312f06e288417049208c344ad76074627d ]

When building with W=2, there is a flood of warnings about the seqlock
macros shadowing local variables:

  19806 linux/seqlock.h:331:11: warning: declaration of 'seq' shadows a previous local [-Wshadow]
     48 linux/seqlock.h:348:11: warning: declaration of 'seq' shadows a previous local [-Wshadow]
      8 linux/seqlock.h:379:11: warning: declaration of 'seq' shadows a previous local [-Wshadow]

Prefix the local variables to make the warning useful elsewhere again.

Fixes: 52ac39e5db51 ("seqlock: seqcount_t: Implement all read APIs as statement expressions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201026165044.3722931-1-arnd@kernel.org
Stable-dep-of: 41b43b6c6e30 ("locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/seqlock.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 1ac20d75b0618..fb89b05066f43 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -328,13 +328,13 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define __read_seqcount_begin(s)					\
 ({									\
-	unsigned seq;							\
+	unsigned __seq;							\
 									\
-	while ((seq = __seqcount_sequence(s)) & 1)			\
+	while ((__seq = __seqcount_sequence(s)) & 1)			\
 		cpu_relax();						\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	seq;								\
+	__seq;								\
 })
 
 /**
@@ -345,10 +345,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount_begin(s)					\
 ({									\
-	unsigned seq = __read_seqcount_begin(s);			\
+	unsigned _seq = __read_seqcount_begin(s);			\
 									\
 	smp_rmb();							\
-	seq;								\
+	_seq;								\
 })
 
 /**
@@ -376,11 +376,11 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount(s)						\
 ({									\
-	unsigned seq = __seqcount_sequence(s);				\
+	unsigned __seq = __seqcount_sequence(s);			\
 									\
 	smp_rmb();							\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	seq;								\
+	__seq;								\
 })
 
 /**
-- 
2.40.1



