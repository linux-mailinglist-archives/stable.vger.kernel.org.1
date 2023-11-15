Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5418E7ED4B0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbjKOU6w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344648AbjKOU5p (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02A219B5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC03C4E76E;
        Wed, 15 Nov 2023 20:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081539;
        bh=+7QSg+4P8Upbj2vnLU9lztI2d8DN5IUt/by3rEyR6Yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mA21Wgk8CiES6QRspz6V7Jd5IGihS5a1zCp1l0DMBzJjRcR0X5yy4Xwm2iDxPssfa
         zY059T4wobQrJBDufSDbgrDzRMUXxi2ml9iQ2mrdqmmbTbM0t1SRQyY/U257w48hnA
         l0lZOlkxLadmeIlm3BLkYDU8pGP1Irojo83tv/Rs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hsin-Wei Hung <hsinweih@uci.edu>,
        Hou Tao <houtao1@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 215/244] bpf: Check map->usercnt after timer->timer is assigned
Date:   Wed, 15 Nov 2023 15:36:47 -0500
Message-ID: <20231115203601.249826866@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index a711ffe238932..11e406ad16ae3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1118,13 +1118,6 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
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
@@ -1137,7 +1130,21 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
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
@@ -1305,7 +1312,7 @@ void bpf_timer_cancel_and_free(void *val)
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



