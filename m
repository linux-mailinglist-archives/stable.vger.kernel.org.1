Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CF77578C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjHIKrU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjHIKrT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18EB10F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A2666310A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D46C433C8;
        Wed,  9 Aug 2023 10:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578038;
        bh=zaJgJaiC/DV0d0Kb2X5zHd0frlMWaY508HjzGR9/LvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5tqgDjIGDLtHebhs2iK0+d4j+uyjj2kcEoJvAZ3upNZNr+psPFmCsvcUC5hIiUyu
         PoTx2qbWWrn2h7s5UxpnWwJSDi6Jrx+8qZEwBX4gu0XwZNwMWse0v16Q12zAA2PDjB
         P7MrJNRk7TMadbMzCIP3cwXBInWIz14jFmrgI14E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yue Haibing <yuehaibing@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 083/165] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Date:   Wed,  9 Aug 2023 12:40:14 +0200
Message-ID: <20230809103645.514586416@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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

From: Yue Haibing <yuehaibing@huawei.com>

[ Upstream commit 30e0191b16e8a58e4620fa3e2839ddc7b9d4281c ]

skbuff: skb_under_panic: text:ffffffff88771f69 len:56 put:-4
 head:ffff88805f86a800 data:ffff887f5f86a850 tail:0x88 end:0x2c0 dev:pim6reg
 ------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:192!
 invalid opcode: 0000 [#1] PREEMPT SMP KASAN
 CPU: 2 PID: 22968 Comm: kworker/2:11 Not tainted 6.5.0-rc3-00044-g0a8db05b571a #236
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 Workqueue: ipv6_addrconf addrconf_dad_work
 RIP: 0010:skb_panic+0x152/0x1d0
 Call Trace:
  <TASK>
  skb_push+0xc4/0xe0
  ip6mr_cache_report+0xd69/0x19b0
  reg_vif_xmit+0x406/0x690
  dev_hard_start_xmit+0x17e/0x6e0
  __dev_queue_xmit+0x2d6a/0x3d20
  vlan_dev_hard_start_xmit+0x3ab/0x5c0
  dev_hard_start_xmit+0x17e/0x6e0
  __dev_queue_xmit+0x2d6a/0x3d20
  neigh_connected_output+0x3ed/0x570
  ip6_finish_output2+0x5b5/0x1950
  ip6_finish_output+0x693/0x11c0
  ip6_output+0x24b/0x880
  NF_HOOK.constprop.0+0xfd/0x530
  ndisc_send_skb+0x9db/0x1400
  ndisc_send_rs+0x12a/0x6c0
  addrconf_dad_completed+0x3c9/0xea0
  addrconf_dad_work+0x849/0x1420
  process_one_work+0xa22/0x16e0
  worker_thread+0x679/0x10c0
  ret_from_fork+0x28/0x60
  ret_from_fork_asm+0x11/0x20

When setup a vlan device on dev pim6reg, DAD ns packet may sent on reg_vif_xmit().
reg_vif_xmit()
    ip6mr_cache_report()
        skb_push(skb, -skb_network_offset(pkt));//skb_network_offset(pkt) is 4
And skb_push declared as:
	void *skb_push(struct sk_buff *skb, unsigned int len);
		skb->data -= len;
		//0xffff88805f86a84c - 0xfffffffc = 0xffff887f5f86a850
skb->data is set to 0xffff887f5f86a850, which is invalid mem addr, lead to skb_push() fails.

Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 51cf37abd142d..b4152b5d68ffb 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1073,7 +1073,7 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 		   And all this only to mangle msg->im6_msgtype and
 		   to set msg->im6_mbz to "mbz" :-)
 		 */
-		skb_push(skb, -skb_network_offset(pkt));
+		__skb_pull(skb, skb_network_offset(pkt));
 
 		skb_push(skb, sizeof(*msg));
 		skb_reset_transport_header(skb);
-- 
2.40.1



