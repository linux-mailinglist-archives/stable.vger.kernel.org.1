Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC217352D9
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjFSKip (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjFSKin (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:38:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2974CC
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FEF960B67
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FCFC433C0;
        Mon, 19 Jun 2023 10:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171121;
        bh=NEa/W8pZ1NLjnYDn0S+kesJjh3wqAdNaACusIIVuuzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0cdNUfeWO/n60WeFddZPciLszsORbRYDRifeStVKpjDKKeIeh4yZEcnLUck+g+U/
         cbA8E0OTLlR0rgwnGAbcy4x/UEA5bPkLW7eRRXL8RidA3J2MWCGBHe2cKhsPH3/7sM
         wVyl6qR4ptKcM1HhTpoa5BZwDuzJ8obFJ/Qqq1Fw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+04afcb3d2c840447559a@syzkaller.appspotmail.com,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 130/187] net/sched: taprio: fix slab-out-of-bounds Read in taprio_dequeue_from_txq
Date:   Mon, 19 Jun 2023 12:29:08 +0200
Message-ID: <20230619102203.889638125@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit be3618d9651002cd5ff190dbfc6cf78f03e34e27 ]

As shown in [1], out-of-bounds access occurs in two cases:
1)when the qdisc of the taprio type is used to replace the previously
configured taprio, count and offset in tc_to_txq can be set to 0. In this
case, the value of *txq in taprio_next_tc_txq() will increases
continuously. When the number of accessed queues exceeds the number of
queues on the device, out-of-bounds access occurs.
2)When packets are dequeued, taprio can be deleted. In this case, the tc
rule of dev is cleared. The count and offset values are also set to 0. In
this case, out-of-bounds access is also caused.

Now the restriction on the queue number is added.

[1] https://groups.google.com/g/syzkaller-bugs/c/_lYOKgkBVMg
Fixes: 2f530df76c8c ("net/sched: taprio: give higher priority to higher TCs in software dequeue mode")
Reported-by: syzbot+04afcb3d2c840447559a@syzkaller.appspotmail.com
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Tested-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_taprio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a6cf56a969421..7190482b52e05 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -795,6 +795,9 @@ static struct sk_buff *taprio_dequeue_tc_priority(struct Qdisc *sch,
 
 			taprio_next_tc_txq(dev, tc, &q->cur_txq[tc]);
 
+			if (q->cur_txq[tc] >= dev->num_tx_queues)
+				q->cur_txq[tc] = first_txq;
+
 			if (skb)
 				return skb;
 		} while (q->cur_txq[tc] != first_txq);
-- 
2.39.2



