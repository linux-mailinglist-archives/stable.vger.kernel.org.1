Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A307759B4
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjHILCu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjHILCu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:02:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2DB1FFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 106556314B
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD1DC433C7;
        Wed,  9 Aug 2023 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578967;
        bh=kazbutTX3I4eqrXo35qk2dXUfIJly2LZnmbKYE2KS8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nznO9Vi13icesf/7CtCTvH2C5dzXYBfVR70XGFVcVvfvxfZwgunWFnvkN0CWZnm+N
         RmGatIJSyabdt9Kg4jVrAZ7zQ8qAhZ+fYNJgDt5pI0nxkGuA/KXkVXvDN/t9pH6CM5
         wWKERr/vRjBCOYchyOv9YD+78HCU8xEVYb2yyGbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com,
        Eric Dumazet <edumazet@google.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 028/204] netlink: fix potential deadlock in netlink_set_err()
Date:   Wed,  9 Aug 2023 12:39:26 +0200
Message-ID: <20230809103643.520804996@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8d61f926d42045961e6b65191c09e3678d86a9cf ]

syzbot reported a possible deadlock in netlink_set_err() [1]

A similar issue was fixed in commit 1d482e666b8e ("netlink: disable IRQs
for netlink_lock_table()") in netlink_lock_table()

This patch adds IRQ safety to netlink_set_err() and __netlink_diag_dump()
which were not covered by cited commit.

[1]

WARNING: possible irq lock inversion dependency detected
6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted

syz-executor.2/23011 just changed the state of lock:
ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+0x2e/0x3a0 net/netlink/af_netlink.c:1612
but this lock was taken by another, SOFTIRQ-safe lock in the past:
 (&local->queue_stop_reason_lock){..-.}-{2:2}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(nl_table_lock);
                               local_irq_disable();
                               lock(&local->queue_stop_reason_lock);
                               lock(nl_table_lock);
  <Interrupt>
    lock(&local->queue_stop_reason_lock);

 *** DEADLOCK ***

Fixes: 1d482e666b8e ("netlink: disable IRQs for netlink_lock_table()")
Reported-by: syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=a7d200a347f912723e5c
Link: https://lore.kernel.org/netdev/000000000000e38d1605fea5747e@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/20230621154337.1668594-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/af_netlink.c | 5 +++--
 net/netlink/diag.c       | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4b40edb51b9e5..6aa9849715775 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1574,6 +1574,7 @@ static int do_one_set_err(struct sock *sk, struct netlink_set_err_data *p)
 int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
 {
 	struct netlink_set_err_data info;
+	unsigned long flags;
 	struct sock *sk;
 	int ret = 0;
 
@@ -1583,12 +1584,12 @@ int netlink_set_err(struct sock *ssk, u32 portid, u32 group, int code)
 	/* sk->sk_err wants a positive error value */
 	info.code = -code;
 
-	read_lock(&nl_table_lock);
+	read_lock_irqsave(&nl_table_lock, flags);
 
 	sk_for_each_bound(sk, &nl_table[ssk->sk_protocol].mc_list)
 		ret += do_one_set_err(sk, &info);
 
-	read_unlock(&nl_table_lock);
+	read_unlock_irqrestore(&nl_table_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(netlink_set_err);
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index 8faa20b4d4573..8c96757d9dc2b 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -93,6 +93,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	struct net *net = sock_net(skb->sk);
 	struct netlink_diag_req *req;
 	struct netlink_sock *nlsk;
+	unsigned long flags;
 	struct sock *sk;
 	int num = 2;
 	int ret = 0;
@@ -155,7 +156,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	num++;
 
 mc_list:
-	read_lock(&nl_table_lock);
+	read_lock_irqsave(&nl_table_lock, flags);
 	sk_for_each_bound(sk, &tbl->mc_list) {
 		if (sk_hashed(sk))
 			continue;
@@ -176,7 +177,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		}
 		num++;
 	}
-	read_unlock(&nl_table_lock);
+	read_unlock_irqrestore(&nl_table_lock, flags);
 
 done:
 	cb->args[0] = num;
-- 
2.39.2



