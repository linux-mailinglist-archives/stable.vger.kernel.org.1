Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4A97ED442
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbjKOU5c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjKOU5Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6105F1A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540F0C433CC;
        Wed, 15 Nov 2023 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081229;
        bh=1C0x11Vkyzd5ZdjiPA/Nno1cNE5XSnHdIe61a+zls+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmtZT4GX2Xrs08+ioVBGAiNXZWOM/vhS7Jj6IqILgqCKYIjwK7YxBK6caQJ/yPGSp
         wpuHwlq8V3X1/mleOfYW6ZXuCTQY3h4oGwNvj/rZnviFH5Kg+xJmnpU2KF90Laz+Lf
         qsrmOQBPZUC2YDqXT1sDaGBW1SC+thWxbOFkjF1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Neal Cardwell <ncardwell@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 029/244] tcp_metrics: add missing barriers on delete
Date:   Wed, 15 Nov 2023 15:33:41 -0500
Message-ID: <20231115203550.120848358@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cbc3a153222805d65f821e10f4f78b6afce06f86 ]

When removing an item from RCU protected list, we must prevent
store-tearing, using rcu_assign_pointer() or WRITE_ONCE().

Fixes: 04f721c671656 ("tcp_metrics: Rewrite tcp_metrics_flush_all")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_metrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 5df97aaac252e..0275bf7570b4c 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -908,7 +908,7 @@ static void tcp_metrics_flush_all(struct net *net)
 			match = net ? net_eq(tm_net(tm), net) :
 				!refcount_read(&tm_net(tm)->ns.count);
 			if (match) {
-				*pp = tm->tcpm_next;
+				rcu_assign_pointer(*pp, tm->tcpm_next);
 				kfree_rcu(tm, rcu_head);
 			} else {
 				pp = &tm->tcpm_next;
@@ -949,7 +949,7 @@ static int tcp_metrics_nl_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		if (addr_same(&tm->tcpm_daddr, &daddr) &&
 		    (!src || addr_same(&tm->tcpm_saddr, &saddr)) &&
 		    net_eq(tm_net(tm), net)) {
-			*pp = tm->tcpm_next;
+			rcu_assign_pointer(*pp, tm->tcpm_next);
 			kfree_rcu(tm, rcu_head);
 			found = true;
 		} else {
-- 
2.42.0



