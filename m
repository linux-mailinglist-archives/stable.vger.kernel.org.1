Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9867ECDA7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjKOThi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjKOThh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:37:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA8EA4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27D2C433C7;
        Wed, 15 Nov 2023 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077054;
        bh=R6vV9wPh4ioJOnmIIcjnyoLOLdLOAXvlQ6ZVJlUaA8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0M6nrNMohhPNzQck9pvVdmK36uf/WwyGch1AFzlfmqBdp1sEUYSp/TB1VbHUvAYy2
         7ZT4kiqKvcvnPTxL0F5sPI3UH9djaaEjtajBno9NFVfT5AifO8TBM9nMrIl6xh7C7m
         efGr/h0uKpz1ZS2MJadml9ZhzXyX5M38f5YkUATo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hsin-Wei Hung <hsinweih@uci.edu>,
        Hou Tao <houtao1@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 502/550] bpf: Check map->usercnt after timer->timer is assigned
Date:   Wed, 15 Nov 2023 14:18:06 -0500
Message-ID: <20231115191635.717679558@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit fd381ce60a2d79cc967506208085336d3d268ae0 ]

When there are concurrent uref release and bpf timer init operations,
the following sequence diagram is possible. It will break the guarantee
provided by bpf_timer: bpf_timer will still be alive after userspace
application releases or unpins the map. It also will lead to kmemleak
for old kernel version which doesn't release bpf_timer when map is
released.

bpf program X:

bpf_timer_init()
  lock timer->lock
    read timer->timer as NULL
    read map->usercnt != 0

                process Y:

                close(map_fd)
                  // put last uref
                  bpf_map_put_uref()
                    atomic_dec_and_test(map->usercnt)
                      array_map_free_timers()
                        bpf_timer_cancel_and_free()
                          // just return
                          read timer->timer is NULL

    t = bpf_map_kmalloc_node()
    timer->timer = t
  unlock timer->lock

Fix the problem by checking map->usercnt after timer->timer is assigned,
so when there are concurrent uref release and bpf timer init, either
bpf_timer_cancel_and_free() from uref release reads a no-NULL timer
or the newly-added atomic64_read() returns a zero usercnt.

Because atomic_dec_and_test(map->usercnt) and READ_ONCE(timer->timer)
in bpf_timer_cancel_and_free() are not protected by a lock, so add
a memory barrier to guarantee the order between map->usercnt and
timer->timer. Also use WRITE_ONCE(timer->timer, x) to match the lockless
read of timer->timer in bpf_timer_cancel_and_free().

Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Closes: https://lore.kernel.org/bpf/CABcoxUaT2k9hWsS1tNgXyoU3E-=PuOgMn737qK984fbFmfYixQ@mail.gmail.com
Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20231030063616.1653024-1-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/helpers.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3779300002327..add185dfa5c65 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1174,13 +1174,6 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 		ret = -EBUSY;
 		goto out;
 	}
-	if (!atomic64_read(&map->usercnt)) {
-		/* maps with timers must be either held by user space
-		 * or pinned in bpffs.
-		 */
-		ret = -EPERM;
-		goto out;
-	}
 	/* allocate hrtimer via map_kmalloc to use memcg accounting */
 	t = bpf_map_kmalloc_node(map, sizeof(*t), GFP_ATOMIC, map->numa_node);
 	if (!t) {
@@ -1193,7 +1186,21 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	rcu_assign_pointer(t->callback_fn, NULL);
 	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
 	t->timer.function = bpf_timer_cb;
-	timer->timer = t;
+	WRITE_ONCE(timer->timer, t);
+	/* Guarantee the order between timer->timer and map->usercnt. So
+	 * when there are concurrent uref release and bpf timer init, either
+	 * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
+	 * timer or atomic64_read() below returns a zero usercnt.
+	 */
+	smp_mb();
+	if (!atomic64_read(&map->usercnt)) {
+		/* maps with timers must be either held by user space
+		 * or pinned in bpffs.
+		 */
+		WRITE_ONCE(timer->timer, NULL);
+		kfree(t);
+		ret = -EPERM;
+	}
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	return ret;
@@ -1368,7 +1375,7 @@ void bpf_timer_cancel_and_free(void *val)
 	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
 	 * this timer, since it won't be initialized.
 	 */
-	timer->timer = NULL;
+	WRITE_ONCE(timer->timer, NULL);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	if (!t)
-- 
2.42.0



