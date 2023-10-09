Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF97BE04E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377243AbjJINii (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377292AbjJINia (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:38:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12EF107
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:38:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F529C433C8;
        Mon,  9 Oct 2023 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858706;
        bh=EgJ5HWX1m61vhwxKknitBJAij2SE8LDY+IOeYnlzGbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6vCRy3cz1/PWyjRD7zJpUsBklhDq9z7VoNAmVsdWVDMwaTL9Fp/MtfTx9VROMEP0
         ohV99DFIHyok1PXMM4zCkxYNfp+9Diw8JPO+zx8qtn7a3GgvIlOGow+0/9V+lHpjuC
         mnGI0Hki4wB3gX8QUGhZ8f4qYwM6+ag4CogC74NM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 057/226] locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
Date:   Mon,  9 Oct 2023 15:00:18 +0200
Message-ID: <20231009130128.278968140@linuxfoundation.org>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 41b43b6c6e30a832c790b010a06772e793bca193 ]

It was brought up by Tetsuo that the following sequence:

   write_seqlock_irqsave()
   printk_deferred_enter()

could lead to a deadlock if the lockdep annotation within
write_seqlock_irqsave() triggers.

The problem is that the sequence counter is incremented before the lockdep
annotation is performed. The lockdep splat would then attempt to invoke
printk() but the reader side, of the same seqcount, could have a
tty_port::lock acquired waiting for the sequence number to become even again.

The other lockdep annotations come before the actual locking because "we
want to see the locking error before it happens". There is no reason why
seqcount should be different here.

Do the lockdep annotation first then perform the locking operation (the
sequence increment).

Fixes: 1ca7d67cf5d5a ("seqcount: Add lockdep functionality to seqcount/seqlock structures")
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230920104627._DTHgPyA@linutronix.de

Closes: https://lore.kernel.org/20230621130641.-5iueY1I@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 008fa88ad58e7..0928a60b8f825 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -511,8 +511,8 @@ do {									\
 
 static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	do_raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+	do_raw_write_seqcount_begin(s);
 }
 
 /**
-- 
2.40.1



