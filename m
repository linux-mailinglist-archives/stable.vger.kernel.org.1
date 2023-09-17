Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA8A7A39C8
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbjIQTyL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240182AbjIQTyG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:54:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75FCEE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:54:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C67C433C9;
        Sun, 17 Sep 2023 19:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980440;
        bh=xBOZL6tbBn3rSWi/6q9N6co5cPhiZdSLJgkYsfpoYto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PC9WMlE3OvXDs6fJFTubaQtsoLeUspD5OySHQageW4V4wCXjx8w6Fd/yqLowuRzsV
         me95pETD0BBicmJVOyvgqeO8z/Jk1KAxUgzAoKPCiNuqfAdTXFLQ+9LWnCS0dBmpJj
         zyvJjl+HP1IujMObXqHaa0pAukdFDqymUTYMu5Dc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 165/285] netfilter: nf_tables: Unbreak audit log reset
Date:   Sun, 17 Sep 2023 21:12:45 +0200
Message-ID: <20230917191057.366019679@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 9b5ba5c9c5109bf89dc64a3f4734bd125d1ce52e ]

Deliver audit log from __nf_tables_dump_rules(), table dereference at
the end of the table list loop might point to the list head, leading to
this crash.

[ 4137.407349] BUG: unable to handle page fault for address: 00000000001f3c50
[ 4137.407357] #PF: supervisor read access in kernel mode
[ 4137.407359] #PF: error_code(0x0000) - not-present page
[ 4137.407360] PGD 0 P4D 0
[ 4137.407363] Oops: 0000 [#1] PREEMPT SMP PTI
[ 4137.407365] CPU: 4 PID: 500177 Comm: nft Not tainted 6.5.0+ #277
[ 4137.407369] RIP: 0010:string+0x49/0xd0
[ 4137.407374] Code: ff 77 36 45 89 d1 31 f6 49 01 f9 66 45 85 d2 75 19 eb 1e 49 39 f8 76 02 88 07 48 83 c7 01 83 c6 01 48 83 c2 01 4c 39 cf 74 07 <0f> b6 02 84 c0 75 e2 4c 89 c2 e9 58 e5 ff ff 48 c7 c0 0e b2 ff 81
[ 4137.407377] RSP: 0018:ffff8881179737f0 EFLAGS: 00010286
[ 4137.407379] RAX: 00000000001f2c50 RBX: ffff888117973848 RCX: ffff0a00ffffff04
[ 4137.407380] RDX: 00000000001f3c50 RSI: 0000000000000000 RDI: 0000000000000000
[ 4137.407381] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000ffffffff
[ 4137.407383] R10: ffffffffffffffff R11: ffff88813584d200 R12: 0000000000000000
[ 4137.407384] R13: ffffffffa15cf709 R14: 0000000000000000 R15: ffffffffa15cf709
[ 4137.407385] FS:  00007fcfc18bb580(0000) GS:ffff88840e700000(0000) knlGS:0000000000000000
[ 4137.407387] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4137.407388] CR2: 00000000001f3c50 CR3: 00000001055b2001 CR4: 00000000001706e0
[ 4137.407390] Call Trace:
[ 4137.407392]  <TASK>
[ 4137.407393]  ? __die+0x1b/0x60
[ 4137.407397]  ? page_fault_oops+0x6b/0xa0
[ 4137.407399]  ? exc_page_fault+0x60/0x120
[ 4137.407403]  ? asm_exc_page_fault+0x22/0x30
[ 4137.407408]  ? string+0x49/0xd0
[ 4137.407410]  vsnprintf+0x257/0x4f0
[ 4137.407414]  kvasprintf+0x3e/0xb0
[ 4137.407417]  kasprintf+0x3e/0x50
[ 4137.407419]  nf_tables_dump_rules+0x1c0/0x360 [nf_tables]
[ 4137.407439]  ? __alloc_skb+0xc3/0x170
[ 4137.407442]  netlink_dump+0x170/0x330
[ 4137.407447]  __netlink_dump_start+0x227/0x300
[ 4137.407449]  nf_tables_getrule+0x205/0x390 [nf_tables]

Deliver audit log only once at the end of the rule dump+reset for
consistency with the set dump+reset.

Ensure audit reset access to table under rcu read side lock. The table
list iteration holds rcu read lock side, but recent audit code
dereferences table object out of the rcu read lock side.

Fixes: ea078ae9108e ("netfilter: nf_tables: Audit log rule reset")
Fixes: 7e9be1124dbe ("netfilter: nf_tables: Audit log setelem reset")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Acked-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index cc70482b94907..a72934f00804e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3480,6 +3480,10 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 cont_skip:
 		(*idx)++;
 	}
+
+	if (reset && *idx)
+		audit_log_rule_reset(table, cb->seq, *idx);
+
 	return 0;
 }
 
@@ -3540,9 +3544,6 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 done:
 	rcu_read_unlock();
 
-	if (reset && idx > cb->args[0])
-		audit_log_rule_reset(table, cb->seq, idx - cb->args[0]);
-
 	cb->args[0] = idx;
 	return skb->len;
 }
@@ -5757,8 +5758,6 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!args.iter.err && args.iter.count == cb->args[0])
 		args.iter.err = nft_set_catchall_dump(net, skb, set,
 						      reset, cb->seq);
-	rcu_read_unlock();
-
 	nla_nest_end(skb, nest);
 	nlmsg_end(skb, nlh);
 
@@ -5766,6 +5765,8 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 		audit_log_nft_set_reset(table, cb->seq,
 					args.iter.count - args.iter.skip);
 
+	rcu_read_unlock();
+
 	if (args.iter.err && args.iter.err != -EMSGSIZE)
 		return args.iter.err;
 	if (args.iter.count == cb->args[0])
-- 
2.40.1



