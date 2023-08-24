Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0705C787343
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbjHXPBf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242026AbjHXPBQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:01:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19991BCE
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C75464EC8
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DED0C433C7;
        Thu, 24 Aug 2023 15:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889272;
        bh=X3bHd4zWyZBs20HLeRPXCYoz+h2CRnkRwSVdGVqZeQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqJxjdp8Ed6m0dikkqot2CQu+HcnLCbKJkln8kl8+8JqX6qrF2nUTHU4z6ZiSZSyt
         sRPx4YRyf/5Uv9aiDnQ+1JeBIxsjugZRgZdIMHpBsdFN729hRrWJoi7A4TwLZW5TA8
         BVHmpZRAasI/OaEyQ3kdCbrAAXCtZSin2adn0RDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 076/135] net: xfrm: Fix xfrm_address_filter OOB read
Date:   Thu, 24 Aug 2023 16:50:19 +0200
Message-ID: <20230824145030.156635671@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit dfa73c17d55b921e1d4e154976de35317e43a93a ]

We found below OOB crash:

[   44.211730] ==================================================================
[   44.212045] BUG: KASAN: slab-out-of-bounds in memcmp+0x8b/0xb0
[   44.212045] Read of size 8 at addr ffff88800870f320 by task poc.xfrm/97
[   44.212045]
[   44.212045] CPU: 0 PID: 97 Comm: poc.xfrm Not tainted 6.4.0-rc7-00072-gdad9774deaf1-dirty #4
[   44.212045] Call Trace:
[   44.212045]  <TASK>
[   44.212045]  dump_stack_lvl+0x37/0x50
[   44.212045]  print_report+0xcc/0x620
[   44.212045]  ? __virt_addr_valid+0xf3/0x170
[   44.212045]  ? memcmp+0x8b/0xb0
[   44.212045]  kasan_report+0xb2/0xe0
[   44.212045]  ? memcmp+0x8b/0xb0
[   44.212045]  kasan_check_range+0x39/0x1c0
[   44.212045]  memcmp+0x8b/0xb0
[   44.212045]  xfrm_state_walk+0x21c/0x420
[   44.212045]  ? __pfx_dump_one_state+0x10/0x10
[   44.212045]  xfrm_dump_sa+0x1e2/0x290
[   44.212045]  ? __pfx_xfrm_dump_sa+0x10/0x10
[   44.212045]  ? __kernel_text_address+0xd/0x40
[   44.212045]  ? kasan_unpoison+0x27/0x60
[   44.212045]  ? mutex_lock+0x60/0xe0
[   44.212045]  ? __pfx_mutex_lock+0x10/0x10
[   44.212045]  ? kasan_save_stack+0x22/0x50
[   44.212045]  netlink_dump+0x322/0x6c0
[   44.212045]  ? __pfx_netlink_dump+0x10/0x10
[   44.212045]  ? mutex_unlock+0x7f/0xd0
[   44.212045]  ? __pfx_mutex_unlock+0x10/0x10
[   44.212045]  __netlink_dump_start+0x353/0x430
[   44.212045]  xfrm_user_rcv_msg+0x3a4/0x410
[   44.212045]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   44.212045]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
[   44.212045]  ? __pfx_xfrm_dump_sa+0x10/0x10
[   44.212045]  ? __pfx_xfrm_dump_sa_done+0x10/0x10
[   44.212045]  ? __stack_depot_save+0x382/0x4e0
[   44.212045]  ? filter_irq_stacks+0x1c/0x70
[   44.212045]  ? kasan_save_stack+0x32/0x50
[   44.212045]  ? kasan_save_stack+0x22/0x50
[   44.212045]  ? kasan_set_track+0x25/0x30
[   44.212045]  ? __kasan_slab_alloc+0x59/0x70
[   44.212045]  ? kmem_cache_alloc_node+0xf7/0x260
[   44.212045]  ? kmalloc_reserve+0xab/0x120
[   44.212045]  ? __alloc_skb+0xcf/0x210
[   44.212045]  ? netlink_sendmsg+0x509/0x700
[   44.212045]  ? sock_sendmsg+0xde/0xe0
[   44.212045]  ? __sys_sendto+0x18d/0x230
[   44.212045]  ? __x64_sys_sendto+0x71/0x90
[   44.212045]  ? do_syscall_64+0x3f/0x90
[   44.212045]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   44.212045]  ? netlink_sendmsg+0x509/0x700
[   44.212045]  ? sock_sendmsg+0xde/0xe0
[   44.212045]  ? __sys_sendto+0x18d/0x230
[   44.212045]  ? __x64_sys_sendto+0x71/0x90
[   44.212045]  ? do_syscall_64+0x3f/0x90
[   44.212045]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   44.212045]  ? kasan_save_stack+0x22/0x50
[   44.212045]  ? kasan_set_track+0x25/0x30
[   44.212045]  ? kasan_save_free_info+0x2e/0x50
[   44.212045]  ? __kasan_slab_free+0x10a/0x190
[   44.212045]  ? kmem_cache_free+0x9c/0x340
[   44.212045]  ? netlink_recvmsg+0x23c/0x660
[   44.212045]  ? sock_recvmsg+0xeb/0xf0
[   44.212045]  ? __sys_recvfrom+0x13c/0x1f0
[   44.212045]  ? __x64_sys_recvfrom+0x71/0x90
[   44.212045]  ? do_syscall_64+0x3f/0x90
[   44.212045]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   44.212045]  ? copyout+0x3e/0x50
[   44.212045]  netlink_rcv_skb+0xd6/0x210
[   44.212045]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
[   44.212045]  ? __pfx_netlink_rcv_skb+0x10/0x10
[   44.212045]  ? __pfx_sock_has_perm+0x10/0x10
[   44.212045]  ? mutex_lock+0x8d/0xe0
[   44.212045]  ? __pfx_mutex_lock+0x10/0x10
[   44.212045]  xfrm_netlink_rcv+0x44/0x50
[   44.212045]  netlink_unicast+0x36f/0x4c0
[   44.212045]  ? __pfx_netlink_unicast+0x10/0x10
[   44.212045]  ? netlink_recvmsg+0x500/0x660
[   44.212045]  netlink_sendmsg+0x3b7/0x700
[   44.212045]  ? __pfx_netlink_sendmsg+0x10/0x10
[   44.212045]  ? __pfx_netlink_sendmsg+0x10/0x10
[   44.212045]  sock_sendmsg+0xde/0xe0
[   44.212045]  __sys_sendto+0x18d/0x230
[   44.212045]  ? __pfx___sys_sendto+0x10/0x10
[   44.212045]  ? rcu_core+0x44a/0xe10
[   44.212045]  ? __rseq_handle_notify_resume+0x45b/0x740
[   44.212045]  ? _raw_spin_lock_irq+0x81/0xe0
[   44.212045]  ? __pfx___rseq_handle_notify_resume+0x10/0x10
[   44.212045]  ? __pfx_restore_fpregs_from_fpstate+0x10/0x10
[   44.212045]  ? __pfx_blkcg_maybe_throttle_current+0x10/0x10
[   44.212045]  ? __pfx_task_work_run+0x10/0x10
[   44.212045]  __x64_sys_sendto+0x71/0x90
[   44.212045]  do_syscall_64+0x3f/0x90
[   44.212045]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   44.212045] RIP: 0033:0x44b7da
[   44.212045] RSP: 002b:00007ffdc8838548 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   44.212045] RAX: ffffffffffffffda RBX: 00007ffdc8839978 RCX: 000000000044b7da
[   44.212045] RDX: 0000000000000038 RSI: 00007ffdc8838770 RDI: 0000000000000003
[   44.212045] RBP: 00007ffdc88385b0 R08: 00007ffdc883858c R09: 000000000000000c
[   44.212045] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[   44.212045] R13: 00007ffdc8839968 R14: 00000000004c37d0 R15: 0000000000000001
[   44.212045]  </TASK>
[   44.212045]
[   44.212045] Allocated by task 97:
[   44.212045]  kasan_save_stack+0x22/0x50
[   44.212045]  kasan_set_track+0x25/0x30
[   44.212045]  __kasan_kmalloc+0x7f/0x90
[   44.212045]  __kmalloc_node_track_caller+0x5b/0x140
[   44.212045]  kmemdup+0x21/0x50
[   44.212045]  xfrm_dump_sa+0x17d/0x290
[   44.212045]  netlink_dump+0x322/0x6c0
[   44.212045]  __netlink_dump_start+0x353/0x430
[   44.212045]  xfrm_user_rcv_msg+0x3a4/0x410
[   44.212045]  netlink_rcv_skb+0xd6/0x210
[   44.212045]  xfrm_netlink_rcv+0x44/0x50
[   44.212045]  netlink_unicast+0x36f/0x4c0
[   44.212045]  netlink_sendmsg+0x3b7/0x700
[   44.212045]  sock_sendmsg+0xde/0xe0
[   44.212045]  __sys_sendto+0x18d/0x230
[   44.212045]  __x64_sys_sendto+0x71/0x90
[   44.212045]  do_syscall_64+0x3f/0x90
[   44.212045]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   44.212045]
[   44.212045] The buggy address belongs to the object at ffff88800870f300
[   44.212045]  which belongs to the cache kmalloc-64 of size 64
[   44.212045] The buggy address is located 32 bytes inside of
[   44.212045]  allocated 36-byte region [ffff88800870f300, ffff88800870f324)
[   44.212045]
[   44.212045] The buggy address belongs to the physical page:
[   44.212045] page:00000000e4de16ee refcount:1 mapcount:0 mapping:000000000 ...
[   44.212045] flags: 0x100000000000200(slab|node=0|zone=1)
[   44.212045] page_type: 0xffffffff()
[   44.212045] raw: 0100000000000200 ffff888004c41640 dead000000000122 0000000000000000
[   44.212045] raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
[   44.212045] page dumped because: kasan: bad access detected
[   44.212045]
[   44.212045] Memory state around the buggy address:
[   44.212045]  ffff88800870f200: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   44.212045]  ffff88800870f280: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
[   44.212045] >ffff88800870f300: 00 00 00 00 04 fc fc fc fc fc fc fc fc fc fc fc
[   44.212045]                                ^
[   44.212045]  ffff88800870f380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   44.212045]  ffff88800870f400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   44.212045] ==================================================================

By investigating the code, we find the root cause of this OOB is the lack
of checks in xfrm_dump_sa(). The buggy code allows a malicious user to pass
arbitrary value of filter->splen/dplen. Hence, with crafted xfrm states,
the attacker can achieve 8 bytes heap OOB read, which causes info leak.

  if (attrs[XFRMA_ADDRESS_FILTER]) {
    filter = kmemdup(nla_data(attrs[XFRMA_ADDRESS_FILTER]),
        sizeof(*filter), GFP_KERNEL);
    if (filter == NULL)
      return -ENOMEM;
    // NO MORE CHECKS HERE !!!
  }

This patch fixes the OOB by adding necessary boundary checks, just like
the code in pfkey_dump() function.

Fixes: d3623099d350 ("ipsec: add support of limited SA dump")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c6bf3898d1bf0..025401bfa3e1e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1062,6 +1062,15 @@ static int xfrm_dump_sa(struct sk_buff *skb, struct netlink_callback *cb)
 					 sizeof(*filter), GFP_KERNEL);
 			if (filter == NULL)
 				return -ENOMEM;
+
+			/* see addr_match(), (prefix length >> 5) << 2
+			 * will be used to compare xfrm_address_t
+			 */
+			if (filter->splen > (sizeof(xfrm_address_t) << 3) ||
+			    filter->dplen > (sizeof(xfrm_address_t) << 3)) {
+				kfree(filter);
+				return -EINVAL;
+			}
 		}
 
 		if (attrs[XFRMA_PROTO])
-- 
2.40.1



