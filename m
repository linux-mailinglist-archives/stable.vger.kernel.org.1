Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEDE7BE017
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377245AbjJINhZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377246AbjJINhW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:37:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FBEB6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:37:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F99FC433C8;
        Mon,  9 Oct 2023 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858639;
        bh=9Dplpl+tuyQAbP76THrL2+PxCxLgTe78//imrovYEXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwBuWep6u+mBLJrS2D1+5s8007ro46+6OOFFOFqiNNX/KdrB3vWibG5no/PA80v0S
         9VX9JQBitjMyAd+M/p6tJfsg46y4smDuywGsV8QfQzF1XRyBSnaxReU5H51Abh8vhs
         N4P0FjC1glGANAv7SgoThutiPj2W5unjpingwPRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kyle Zeng <zengyhkyle@gmail.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 053/226] netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP
Date:   Mon,  9 Oct 2023 15:00:14 +0200
Message-ID: <20231009130128.177725189@linuxfoundation.org>
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

From: Jozsef Kadlecsik <kadlec@netfilter.org>

[ Upstream commit 7433b6d2afd512d04398c73aa984d1e285be125b ]

Kyle Zeng reported that there is a race between IPSET_CMD_ADD and IPSET_CMD_SWAP
in netfilter/ip_set, which can lead to the invocation of `__ip_set_put` on a
wrong `set`, triggering the `BUG_ON(set->ref == 0);` check in it.

The race is caused by using the wrong reference counter, i.e. the ref counter instead
of ref_netlink.

Fixes: 24e227896bbf ("netfilter: ipset: Add schedule point in call_ad().")
Reported-by: Kyle Zeng <zengyhkyle@gmail.com>
Closes: https://lore.kernel.org/netfilter-devel/ZPZqetxOmH+w%2Fmyc@westworld/#r
Tested-by: Kyle Zeng <zengyhkyle@gmail.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 55ac0cc12657c..26613e3731d02 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -682,6 +682,14 @@ __ip_set_put(struct ip_set *set)
 /* set->ref can be swapped out by ip_set_swap, netlink events (like dump) need
  * a separate reference counter
  */
+static void
+__ip_set_get_netlink(struct ip_set *set)
+{
+	write_lock_bh(&ip_set_ref_lock);
+	set->ref_netlink++;
+	write_unlock_bh(&ip_set_ref_lock);
+}
+
 static void
 __ip_set_put_netlink(struct ip_set *set)
 {
@@ -1705,11 +1713,11 @@ call_ad(struct sock *ctnl, struct sk_buff *skb, struct ip_set *set,
 
 	do {
 		if (retried) {
-			__ip_set_get(set);
+			__ip_set_get_netlink(set);
 			nfnl_unlock(NFNL_SUBSYS_IPSET);
 			cond_resched();
 			nfnl_lock(NFNL_SUBSYS_IPSET);
-			__ip_set_put(set);
+			__ip_set_put_netlink(set);
 		}
 
 		ip_set_lock(set);
-- 
2.40.1



