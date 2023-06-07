Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45842726D1D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjFGUjR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjFGUjH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:39:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9167B2706
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8277C645CF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E9BC433EF;
        Wed,  7 Jun 2023 20:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170317;
        bh=aw+Afq7dAv+ZX3UiHFSFBZ/fmG/w4QqvKQburD5VRts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJrh/FVLe2uMEE/tKoRE8XuDLqhnn84dXZjLBl21CJ93nBtQfn2w+mVWRSgX8oBvR
         mY4BReRWFu1qMA0Et0+8h5R0wgFF3lvwTkD+y1r2tp2otr4zmD2GQXwZquhT6LGoG4
         8ISSgEH6Y/9E4eW+7TcIM9zS/IxV/Auy5QePYo9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengchao Shao <shaozhengchao@huawei.com>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 039/225] net: sched: fix NULL pointer dereference in mq_attach
Date:   Wed,  7 Jun 2023 22:13:52 +0200
Message-ID: <20230607200915.627019916@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit 36eec020fab668719b541f34d97f44e232ffa165 ]

When use the following command to test:
1)ip link add bond0 type bond
2)ip link set bond0 up
3)tc qdisc add dev bond0 root handle ffff: mq
4)tc qdisc replace dev bond0 parent ffff:fff1 handle ffff: mq

The kernel reports NULL pointer dereference issue. The stack information
is as follows:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Internal error: Oops: 0000000096000006 [#1] SMP
Modules linked in:
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mq_attach+0x44/0xa0
lr : qdisc_graft+0x20c/0x5cc
sp : ffff80000e2236a0
x29: ffff80000e2236a0 x28: ffff0000c0e59d80 x27: ffff0000c0be19c0
x26: ffff0000cae3e800 x25: 0000000000000010 x24: 00000000fffffff1
x23: 0000000000000000 x22: ffff0000cae3e800 x21: ffff0000c9df4000
x20: ffff0000c9df4000 x19: 0000000000000000 x18: ffff80000a934000
x17: ffff8000f5b56000 x16: ffff80000bb08000 x15: 0000000000000000
x14: 0000000000000000 x13: 6b6b6b6b6b6b6b6b x12: 6b6b6b6b00000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c0be0730 x7 : bbbbbbbbbbbbbbbb x6 : 0000000000000008
x5 : ffff0000cae3e864 x4 : 0000000000000000 x3 : 0000000000000001
x2 : 0000000000000001 x1 : ffff8000090bc23c x0 : 0000000000000000
Call trace:
mq_attach+0x44/0xa0
qdisc_graft+0x20c/0x5cc
tc_modify_qdisc+0x1c4/0x664
rtnetlink_rcv_msg+0x354/0x440
netlink_rcv_skb+0x64/0x144
rtnetlink_rcv+0x28/0x34
netlink_unicast+0x1e8/0x2a4
netlink_sendmsg+0x308/0x4a0
sock_sendmsg+0x64/0xac
____sys_sendmsg+0x29c/0x358
___sys_sendmsg+0x90/0xd0
__sys_sendmsg+0x7c/0xd0
__arm64_sys_sendmsg+0x2c/0x38
invoke_syscall+0x54/0x114
el0_svc_common.constprop.1+0x90/0x174
do_el0_svc+0x3c/0xb0
el0_svc+0x24/0xec
el0t_64_sync_handler+0x90/0xb4
el0t_64_sync+0x174/0x178

This is because when mq is added for the first time, qdiscs in mq is set
to NULL in mq_attach(). Therefore, when replacing mq after adding mq, we
need to initialize qdiscs in the mq before continuing to graft. Otherwise,
it will couse NULL pointer dereference issue in mq_attach(). And the same
issue will occur in the attach functions of mqprio, taprio and htb.
ffff:fff1 means that the repalce qdisc is ingress. Ingress does not allow
any qdisc to be attached. Therefore, ffff:fff1 is incorrectly used, and
the command should be dropped.

Fixes: 6ec1c69a8f64 ("net_sched: add classful multiqueue dummy scheduler")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Tested-by: Peilin Ye <peilin.ye@bytedance.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/20230527093747.3583502-1-shaozhengchao@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 95f38595b0f7f..f6a7b876d5954 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1601,6 +1601,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Qdisc parent/child loop detected");
 					return -ELOOP;
 				}
+				if (clid == TC_H_INGRESS) {
+					NL_SET_ERR_MSG(extack, "Ingress cannot graft directly");
+					return -EINVAL;
+				}
 				qdisc_refcount_inc(q);
 				goto graft;
 			} else {
-- 
2.39.2



