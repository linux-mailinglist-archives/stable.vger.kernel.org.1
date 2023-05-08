Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168AC6FAE0F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjEHLkj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbjEHLkS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:40:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F0B3FCD0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A6D1634D0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583CCC433EF;
        Mon,  8 May 2023 11:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546015;
        bh=Q4hhfPp9/kHefkrurnp71vJhxL/wq4aRG0tApmDqY2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8bN9VQMTFFcZsP0s7UmFjK7YdrJ/kwZZc3pRu228/D1l4rt6In88a6yB4TEsld/0
         qvyw5xfnS/cq5lXxFT78BmAGMuxP876fXq/nzNJlO2wzJmqaUnof5fX33aPH0+2DvA
         uonj2MUWaieXq/hhkDAJkKsk8D4UpN8o+5tjD9ac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hsin-Wei Hung <hsinweih@uci.edu>,
        Xin Liu <liuxin350@huawei.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 190/371] bpf, sockmap: fix deadlocks in the sockhash and sockmap
Date:   Mon,  8 May 2023 11:46:31 +0200
Message-Id: <20230508094819.663169070@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xin Liu <liuxin350@huawei.com>

[ Upstream commit ed17aa92dc56b6d8883e4b7a8f1c6fbf5ed6cd29 ]

When huang uses sched_switch tracepoint, the tracepoint
does only one thing in the mounted ebpf program, which
deletes the fixed elements in sockhash ([0])

It seems that elements in sockhash are rarely actively
deleted by users or ebpf program. Therefore, we do not
pay much attention to their deletion. Compared with hash
maps, sockhash only provides spin_lock_bh protection.
This causes it to appear to have self-locking behavior
in the interrupt context.

  [0]:https://lore.kernel.org/all/CABcoxUayum5oOqFMMqAeWuS8+EzojquSOSyDA3J_2omY=2EeAg@mail.gmail.com/

Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Xin Liu <liuxin350@huawei.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20230406122622.109978-1-liuxin350@huawei.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock_map.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 86b4e8909ad1e..36afe39dd2df9 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -414,8 +414,9 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 {
 	struct sock *sk;
 	int err = 0;
+	unsigned long flags;
 
-	raw_spin_lock_bh(&stab->lock);
+	raw_spin_lock_irqsave(&stab->lock, flags);
 	sk = *psk;
 	if (!sk_test || sk_test == sk)
 		sk = xchg(psk, NULL);
@@ -425,7 +426,7 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 	else
 		err = -EINVAL;
 
-	raw_spin_unlock_bh(&stab->lock);
+	raw_spin_unlock_irqrestore(&stab->lock, flags);
 	return err;
 }
 
@@ -930,11 +931,12 @@ static int sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
+	unsigned long flags;
 
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	raw_spin_lock_bh(&bucket->lock);
+	raw_spin_lock_irqsave(&bucket->lock, flags);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -942,7 +944,7 @@ static int sock_hash_delete_elem(struct bpf_map *map, void *key)
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	raw_spin_unlock_bh(&bucket->lock);
+	raw_spin_unlock_irqrestore(&bucket->lock, flags);
 	return ret;
 }
 
-- 
2.39.2



