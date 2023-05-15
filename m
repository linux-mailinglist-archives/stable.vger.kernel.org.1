Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEBB703442
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbjEOQqj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242986AbjEOQqf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:46:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDAB4EFE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 135E3628F7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A121C433EF;
        Mon, 15 May 2023 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169187;
        bh=uQtyOy6TNsbELjjqbnDxZNPI4ULgQu9ZfLQXiBaHeQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4wqRYYlkJlIhzcovXD56kJ8d0E0u8s5KXnbSDFu2E0HNJ5+7fEG4VT+aeuelQdsK
         Plxt5NoxzqNbXrL0TRQpHl8oMxcifPftekR5H7Ae+qRlGsz9ZtUKkud2B8HSvYcA05
         fj2k5ePMQDp+S+UcKT2EsSHXRfxXrD/buDzycvh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jamal Hadi Salim <jhs@mojatatu.com>,
        Victor Nogueira <victor@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 153/191] net/sched: act_mirred: Add carrier check
Date:   Mon, 15 May 2023 18:26:30 +0200
Message-Id: <20230515161712.969118391@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Victor Nogueira <victor@mojatatu.com>

[ Upstream commit 526f28bd0fbdc699cda31426928802650c1528e5 ]

There are cases where the device is adminstratively UP, but operationally
down. For example, we have a physical device (Nvidia ConnectX-6 Dx, 25Gbps)
who's cable was pulled out, here is its ip link output:

5: ens2f1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether b8:ce:f6:4b:68:35 brd ff:ff:ff:ff:ff:ff
    altname enp179s0f1np1

As you can see, it's administratively UP but operationally down.
In this case, sending a packet to this port caused a nasty kernel hang (so
nasty that we were unable to capture it). Aborting a transmit based on
operational status (in addition to administrative status) fixes the issue.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
v1->v2: Add fixes tag
v2->v3: Remove blank line between tags + add change log, suggested by Leon
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_mirred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index a30c17a282819..9aad86e4a0fb9 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -220,7 +220,7 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 		goto out;
 	}
 
-	if (unlikely(!(dev->flags & IFF_UP))) {
+	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
 		goto out;
-- 
2.39.2



