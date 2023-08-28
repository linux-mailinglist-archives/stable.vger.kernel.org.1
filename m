Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D878AC5F
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjH1Kja (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjH1KjU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:39:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FBC93
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C6763FC3
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14038C433C9;
        Mon, 28 Aug 2023 10:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219157;
        bh=wCIN06NMehadfHkTvQmcFOlJ3+wXCnBxpCDuqCeSIYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMK0Xf66N+Z+GGEgJTqRvvDRyRDoi7ednMXBQwjTqWabs7pGI44e6StGQ4KoSnHd7
         /TjcO5kqIxg8egrIMyTH/TGD7R5bN9hCzJtbbonfTGQrRWHZRjJiaLaOI6SdP6vMJA
         ELAhsQGyg3vNJGjxP/jpQDH4KiE3YlbciB283Xbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Leon Romanovsky <leonro@nvidia.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 066/158] xfrm: add NULL check in xfrm_update_ae_params
Date:   Mon, 28 Aug 2023 12:12:43 +0200
Message-ID: <20230828101159.506527976@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 00374d9b6d9f932802b55181be9831aa948e5b7c ]

Normally, x->replay_esn and x->preplay_esn should be allocated at
xfrm_alloc_replay_state_esn(...) in xfrm_state_construct(...), hence the
xfrm_update_ae_params(...) is okay to update them. However, the current
implementation of xfrm_new_ae(...) allows a malicious user to directly
dereference a NULL pointer and crash the kernel like below.

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 8253067 P4D 8253067 PUD 8e0e067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 98 Comm: poc.npd Not tainted 6.4.0-rc7-00072-gdad9774deaf1 #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.o4
RIP: 0010:memcpy_orig+0xad/0x140
Code: e8 4c 89 5f e0 48 8d 7f e0 73 d2 83 c2 20 48 29 d6 48 29 d7 83 fa 10 72 34 4c 8b 06 4c 8b 4e 08 c
RSP: 0018:ffff888008f57658 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffff888008bd0000 RCX: ffffffff8238e571
RDX: 0000000000000018 RSI: ffff888007f64844 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888008f57818
R13: ffff888007f64aa4 R14: 0000000000000000 R15: 0000000000000000
FS:  00000000014013c0(0000) GS:ffff88806d600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000054d8000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? __die+0x1f/0x70
 ? page_fault_oops+0x1e8/0x500
 ? __pfx_is_prefetch.constprop.0+0x10/0x10
 ? __pfx_page_fault_oops+0x10/0x10
 ? _raw_spin_unlock_irqrestore+0x11/0x40
 ? fixup_exception+0x36/0x460
 ? _raw_spin_unlock_irqrestore+0x11/0x40
 ? exc_page_fault+0x5e/0xc0
 ? asm_exc_page_fault+0x26/0x30
 ? xfrm_update_ae_params+0xd1/0x260
 ? memcpy_orig+0xad/0x140
 ? __pfx__raw_spin_lock_bh+0x10/0x10
 xfrm_update_ae_params+0xe7/0x260
 xfrm_new_ae+0x298/0x4e0
 ? __pfx_xfrm_new_ae+0x10/0x10
 ? __pfx_xfrm_new_ae+0x10/0x10
 xfrm_user_rcv_msg+0x25a/0x410
 ? __pfx_xfrm_user_rcv_msg+0x10/0x10
 ? __alloc_skb+0xcf/0x210
 ? stack_trace_save+0x90/0xd0
 ? filter_irq_stacks+0x1c/0x70
 ? __stack_depot_save+0x39/0x4e0
 ? __kasan_slab_free+0x10a/0x190
 ? kmem_cache_free+0x9c/0x340
 ? netlink_recvmsg+0x23c/0x660
 ? sock_recvmsg+0xeb/0xf0
 ? __sys_recvfrom+0x13c/0x1f0
 ? __x64_sys_recvfrom+0x71/0x90
 ? do_syscall_64+0x3f/0x90
 ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
 ? copyout+0x3e/0x50
 netlink_rcv_skb+0xd6/0x210
 ? __pfx_xfrm_user_rcv_msg+0x10/0x10
 ? __pfx_netlink_rcv_skb+0x10/0x10
 ? __pfx_sock_has_perm+0x10/0x10
 ? mutex_lock+0x8d/0xe0
 ? __pfx_mutex_lock+0x10/0x10
 xfrm_netlink_rcv+0x44/0x50
 netlink_unicast+0x36f/0x4c0
 ? __pfx_netlink_unicast+0x10/0x10
 ? netlink_recvmsg+0x500/0x660
 netlink_sendmsg+0x3b7/0x700

This Null-ptr-deref bug is assigned CVE-2023-3772. And this commit
adds additional NULL check in xfrm_update_ae_params to fix the NPD.

Fixes: d8647b79c3b7 ("xfrm: Add user interface for esn and big anti-replay windows")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 68ac55842dedd..06aeefce88718 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -522,7 +522,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
 	struct nlattr *et = attrs[XFRMA_ETIMER_THRESH];
 	struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
 
-	if (re) {
+	if (re && x->replay_esn && x->preplay_esn) {
 		struct xfrm_replay_state_esn *replay_esn;
 		replay_esn = nla_data(re);
 		memcpy(x->replay_esn, replay_esn,
-- 
2.40.1



