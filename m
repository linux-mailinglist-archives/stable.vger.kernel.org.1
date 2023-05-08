Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253376FABA6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjEHLPx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjEHLPv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8884037008
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC9D062BEB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2266C433D2;
        Mon,  8 May 2023 11:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544548;
        bh=sSBWeJwLWcLTi38iTnA8Z4DlUtp4Xh/JlC6gz+NGJWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1QIfXpBOJOfV8SmU7/Ek+wpu1bCVjXF5+TS6O9CUicSkXKqRfIRvZb1DfWC2rpsGP
         40w+doqbkuKZu0mIuVZwHwx7TMQLWR0NBRJjxOm2VvgNMXTkM+eVnr0Tq0RJoNqqif
         hzVAg7f26wFtQIx7C9dfIod7Cq1075IaXKddve0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+49f6cef45247ff249498@syzkaller.appspotmail.com,
        Hsin-Wei Hung <hsinweih@uci.edu>,
        Xin Liu <liuxin350@huawei.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 415/694] bpf, sockmap: Revert buggy deadlock fix in the sockhash and sockmap
Date:   Mon,  8 May 2023 11:44:10 +0200
Message-Id: <20230508094446.744975054@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 8c5c2a4898e3d6bad86e29d471e023c8a19ba799 ]

syzbot reported a splat and bisected it to recent commit ed17aa92dc56 ("bpf,
sockmap: fix deadlocks in the sockhash and sockmap"):

  [...]
  WARNING: CPU: 1 PID: 9280 at kernel/softirq.c:376 __local_bh_enable_ip+0xbe/0x130 kernel/softirq.c:376
  Modules linked in:
  CPU: 1 PID: 9280 Comm: syz-executor.1 Not tainted 6.2.0-syzkaller-13249-gd319f344561d #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
  RIP: 0010:__local_bh_enable_ip+0xbe/0x130 kernel/softirq.c:376
  [...]
  Call Trace:
  <TASK>
  spin_unlock_bh include/linux/spinlock.h:395 [inline]
  sock_map_del_link+0x2ea/0x510 net/core/sock_map.c:165
  sock_map_unref+0xb0/0x1d0 net/core/sock_map.c:184
  sock_hash_delete_elem+0x1ec/0x2a0 net/core/sock_map.c:945
  map_delete_elem kernel/bpf/syscall.c:1536 [inline]
  __sys_bpf+0x2edc/0x53e0 kernel/bpf/syscall.c:5053
  __do_sys_bpf kernel/bpf/syscall.c:5166 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5164 [inline]
  __x64_sys_bpf+0x79/0xc0 kernel/bpf/syscall.c:5164
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
  RIP: 0033:0x7fe8f7c8c169
  </TASK>
  [...]

Revert for now until we have a proper solution.

Fixes: ed17aa92dc56 ("bpf, sockmap: fix deadlocks in the sockhash and sockmap")
Reported-by: syzbot+49f6cef45247ff249498@syzkaller.appspotmail.com
Cc: Hsin-Wei Hung <hsinweih@uci.edu>
Cc: Xin Liu <liuxin350@huawei.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/000000000000f1db9605f939720e@google.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock_map.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index dd5d7b1fa3580..a055139f410e2 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -414,9 +414,8 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 {
 	struct sock *sk;
 	int err = 0;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&stab->lock, flags);
+	raw_spin_lock_bh(&stab->lock);
 	sk = *psk;
 	if (!sk_test || sk_test == sk)
 		sk = xchg(psk, NULL);
@@ -426,7 +425,7 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 	else
 		err = -EINVAL;
 
-	raw_spin_unlock_irqrestore(&stab->lock, flags);
+	raw_spin_unlock_bh(&stab->lock);
 	return err;
 }
 
@@ -924,12 +923,11 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
-	unsigned long flags;
 
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	raw_spin_lock_irqsave(&bucket->lock, flags);
+	raw_spin_lock_bh(&bucket->lock);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -937,7 +935,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	raw_spin_unlock_irqrestore(&bucket->lock, flags);
+	raw_spin_unlock_bh(&bucket->lock);
 	return ret;
 }
 
-- 
2.39.2



