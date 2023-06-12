Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9EE72C19A
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbjFLK65 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjFLKym (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A6935BE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F00A0612F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDE2C433D2;
        Mon, 12 Jun 2023 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566464;
        bh=bjUOiD2qmG/m8W/LQEsKmK1UxedBQf+dq/Qc/oaB+7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QH54el9tGToPuvj7ElfasYDa8t64rFn5IUb8uD7w7VE1VuciO2bzKfFO2qO1dQCpi
         KZx0CeTPOhcI/1vSNiuwuSg0mSlEOTSZmSj+MiMCQBXnghmTdzpEFwbGB85bIqjvu0
         9byK39VUVSPolvrul2bkVyMZdeNgwwsp/7BFQqpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 042/132] rfs: annotate lockless accesses to RFS sock flow table
Date:   Mon, 12 Jun 2023 12:26:16 +0200
Message-ID: <20230612101712.161856126@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5c3b74a92aa285a3df722bf6329ba7ccf70346d6 ]

Add READ_ONCE()/WRITE_ONCE() on accesses to the sock flow table.

This also prevents a (smart ?) compiler to remove the condition in:

if (table->ents[index] != newval)
        table->ents[index] = newval;

We need the condition to avoid dirtying a shared cache line.

Fixes: fec5e652e58f ("rfs: Receive Flow Steering")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h | 7 +++++--
 net/core/dev.c            | 6 ++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index eac51e22a52a8..74e05b82f1bf7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -757,8 +757,11 @@ static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
 		/* We only give a hint, preemption can change CPU under us */
 		val |= raw_smp_processor_id();
 
-		if (table->ents[index] != val)
-			table->ents[index] = val;
+		/* The following WRITE_ONCE() is paired with the READ_ONCE()
+		 * here, and another one in get_rps_cpu().
+		 */
+		if (READ_ONCE(table->ents[index]) != val)
+			WRITE_ONCE(table->ents[index], val);
 	}
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 93d430693ca0f..ee00d3cfcb564 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4483,8 +4483,10 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		u32 next_cpu;
 		u32 ident;
 
-		/* First check into global flow table if there is a match */
-		ident = sock_flow_table->ents[hash & sock_flow_table->mask];
+		/* First check into global flow table if there is a match.
+		 * This READ_ONCE() pairs with WRITE_ONCE() from rps_record_sock_flow().
+		 */
+		ident = READ_ONCE(sock_flow_table->ents[hash & sock_flow_table->mask]);
 		if ((ident ^ hash) & ~rps_cpu_mask)
 			goto try_rps;
 
-- 
2.39.2



