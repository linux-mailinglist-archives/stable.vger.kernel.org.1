Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E320A7B8AAD
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjJDShp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjJDShp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:37:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F0A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:37:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11354C433C7;
        Wed,  4 Oct 2023 18:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444661;
        bh=lWwWEAilsB78iis0cKeanWgnwg7kLnd9V1E7t53EZX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w3sMhW/2MgHD0NegJDnszuxIN4KymdF941lPbArWz7W/Js55S77+HB3YGFsbaaIUn
         5JjdBKz5kA3bN8IhBjfqUjbZ+kztaQxJISXczwg8ZykqI1AX1Sb7Q9qVUX4acHuAhK
         QbRSARAzvszYfpNRA8xdcb6fzMNZ2+m5nrWad+xs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.5 302/321] tracing/user_events: Align set_bit() address for all archs
Date:   Wed,  4 Oct 2023 19:57:27 +0200
Message-ID: <20231004175243.279188840@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Beau Belgrave <beaub@linux.microsoft.com>

commit 2de9ee94054263940122aee8720e902b30c27930 upstream.

All architectures should use a long aligned address passed to set_bit().
User processes can pass either a 32-bit or 64-bit sized value to be
updated when tracing is enabled when on a 64-bit kernel. Both cases are
ensured to be naturally aligned, however, that is not enough. The
address must be long aligned without affecting checks on the value
within the user process which require different adjustments for the bit
for little and big endian CPUs.

Add a compat flag to user_event_enabler that indicates when a 32-bit
value is being used on a 64-bit kernel. Long align addresses and correct
the bit to be used by set_bit() to account for this alignment. Ensure
compat flags are copied during forks and used during deletion clears.

Link: https://lore.kernel.org/linux-trace-kernel/20230925230829.341-2-beaub@linux.microsoft.com
Link: https://lore.kernel.org/linux-trace-kernel/20230914131102.179100-1-cleger@rivosinc.com/

Cc: stable@vger.kernel.org
Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Reported-by: Clément Léger <cleger@rivosinc.com>
Suggested-by: Clément Léger <cleger@rivosinc.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_user.c |   58 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 7 deletions(-)

--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -127,8 +127,13 @@ struct user_event_enabler {
 /* Bit 7 is for freeing status of enablement */
 #define ENABLE_VAL_FREEING_BIT 7
 
-/* Only duplicate the bit value */
-#define ENABLE_VAL_DUP_MASK ENABLE_VAL_BIT_MASK
+/* Bit 8 is for marking 32-bit on 64-bit */
+#define ENABLE_VAL_32_ON_64_BIT 8
+
+#define ENABLE_VAL_COMPAT_MASK (1 << ENABLE_VAL_32_ON_64_BIT)
+
+/* Only duplicate the bit and compat values */
+#define ENABLE_VAL_DUP_MASK (ENABLE_VAL_BIT_MASK | ENABLE_VAL_COMPAT_MASK)
 
 #define ENABLE_BITOPS(e) (&(e)->values)
 
@@ -174,6 +179,30 @@ struct user_event_validator {
 	int			flags;
 };
 
+static inline void align_addr_bit(unsigned long *addr, int *bit,
+				  unsigned long *flags)
+{
+	if (IS_ALIGNED(*addr, sizeof(long))) {
+#ifdef __BIG_ENDIAN
+		/* 32 bit on BE 64 bit requires a 32 bit offset when aligned. */
+		if (test_bit(ENABLE_VAL_32_ON_64_BIT, flags))
+			*bit += 32;
+#endif
+		return;
+	}
+
+	*addr = ALIGN_DOWN(*addr, sizeof(long));
+
+	/*
+	 * We only support 32 and 64 bit values. The only time we need
+	 * to align is a 32 bit value on a 64 bit kernel, which on LE
+	 * is always 32 bits, and on BE requires no change when unaligned.
+	 */
+#ifdef __LITTLE_ENDIAN
+	*bit += 32;
+#endif
+}
+
 typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
 				   void *tpdata, bool *faulted);
 
@@ -482,6 +511,7 @@ static int user_event_enabler_write(stru
 	unsigned long *ptr;
 	struct page *page;
 	void *kaddr;
+	int bit = ENABLE_BIT(enabler);
 	int ret;
 
 	lockdep_assert_held(&event_mutex);
@@ -497,6 +527,8 @@ static int user_event_enabler_write(stru
 		     test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))))
 		return -EBUSY;
 
+	align_addr_bit(&uaddr, &bit, ENABLE_BITOPS(enabler));
+
 	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
 				    &page, NULL);
 
@@ -515,9 +547,9 @@ static int user_event_enabler_write(stru
 
 	/* Update bit atomically, user tracers must be atomic as well */
 	if (enabler->event && enabler->event->status)
-		set_bit(ENABLE_BIT(enabler), ptr);
+		set_bit(bit, ptr);
 	else
-		clear_bit(ENABLE_BIT(enabler), ptr);
+		clear_bit(bit, ptr);
 
 	kunmap_local(kaddr);
 	unpin_user_pages_dirty_lock(&page, 1, true);
@@ -849,6 +881,12 @@ static struct user_event_enabler
 	enabler->event = user;
 	enabler->addr = uaddr;
 	enabler->values = reg->enable_bit;
+
+#if BITS_PER_LONG >= 64
+	if (reg->enable_size == 4)
+		set_bit(ENABLE_VAL_32_ON_64_BIT, ENABLE_BITOPS(enabler));
+#endif
+
 retry:
 	/* Prevents state changes from racing with new enablers */
 	mutex_lock(&event_mutex);
@@ -2376,7 +2414,8 @@ static long user_unreg_get(struct user_u
 }
 
 static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
-				   unsigned long uaddr, unsigned char bit)
+				   unsigned long uaddr, unsigned char bit,
+				   unsigned long flags)
 {
 	struct user_event_enabler enabler;
 	int result;
@@ -2384,7 +2423,7 @@ static int user_event_mm_clear_bit(struc
 
 	memset(&enabler, 0, sizeof(enabler));
 	enabler.addr = uaddr;
-	enabler.values = bit;
+	enabler.values = bit | flags;
 retry:
 	/* Prevents state changes from racing with new enablers */
 	mutex_lock(&event_mutex);
@@ -2414,6 +2453,7 @@ static long user_events_ioctl_unreg(unsi
 	struct user_event_mm *mm = current->user_event_mm;
 	struct user_event_enabler *enabler, *next;
 	struct user_unreg reg;
+	unsigned long flags;
 	long ret;
 
 	ret = user_unreg_get(ureg, &reg);
@@ -2424,6 +2464,7 @@ static long user_events_ioctl_unreg(unsi
 	if (!mm)
 		return -ENOENT;
 
+	flags = 0;
 	ret = -ENOENT;
 
 	/*
@@ -2440,6 +2481,9 @@ static long user_events_ioctl_unreg(unsi
 		    ENABLE_BIT(enabler) == reg.disable_bit) {
 			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
 
+			/* We must keep compat flags for the clear */
+			flags |= enabler->values & ENABLE_VAL_COMPAT_MASK;
+
 			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
 				user_event_enabler_destroy(enabler, true);
 
@@ -2453,7 +2497,7 @@ static long user_events_ioctl_unreg(unsi
 	/* Ensure bit is now cleared for user, regardless of event status */
 	if (!ret)
 		ret = user_event_mm_clear_bit(mm, reg.disable_addr,
-					      reg.disable_bit);
+					      reg.disable_bit, flags);
 
 	return ret;
 }


