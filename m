Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA217A38FB
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbjIQTn3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbjIQTnE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:43:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCC0103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:42:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8144C433C9;
        Sun, 17 Sep 2023 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979778;
        bh=X3sR6X595CJRfhGlAmmPylyQrWfbX3mWpNOo1swWc+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ba3J8AE9N5lsmivGnTJ9e+Al2FvlLuSWcoaMeoLlXuqk3aFImQXTz6rkVObTOzu4N
         Ia8jl8tM5I6lJ33iMKOQLNNb1FShCksWeJNpnRaibc6lkTBtSjPK6KoWBeogMWlExC
         E4QLMewstO7/DaUCoAROSw+ujyMLFb2yeD9xaiLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 393/406] net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list iterate in smcr_port_add
Date:   Sun, 17 Sep 2023 21:14:07 +0200
Message-ID: <20230917191111.642381695@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guangguan Wang <guangguan.wang@linux.alibaba.com>

[ Upstream commit f5146e3ef0a9eea405874b36178c19a4863b8989 ]

While doing smcr_port_add, there maybe linkgroup add into or delete
from smc_lgr_list.list at the same time, which may result kernel crash.
So, use smc_lgr_list.lock to protect smc_lgr_list.list iterate in
smcr_port_add.

The crash calltrace show below:
BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 0 PID: 559726 Comm: kworker/0:92 Kdump: loaded Tainted: G
Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 449e491 04/01/2014
Workqueue: events smc_ib_port_event_work [smc]
RIP: 0010:smcr_port_add+0xa6/0xf0 [smc]
RSP: 0000:ffffa5a2c8f67de0 EFLAGS: 00010297
RAX: 0000000000000001 RBX: ffff9935e0650000 RCX: 0000000000000000
RDX: 0000000000000010 RSI: ffff9935e0654290 RDI: ffff9935c8560000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff9934c0401918
R10: 0000000000000000 R11: ffffffffb4a5c278 R12: ffff99364029aae4
R13: ffff99364029aa00 R14: 00000000ffffffed R15: ffff99364029ab08
FS:  0000000000000000(0000) GS:ffff994380600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000f06a10003 CR4: 0000000002770ef0
PKRU: 55555554
Call Trace:
 smc_ib_port_event_work+0x18f/0x380 [smc]
 process_one_work+0x19b/0x340
 worker_thread+0x30/0x370
 ? process_one_work+0x340/0x340
 kthread+0x114/0x130
 ? __kthread_cancel_work+0x50/0x50
 ret_from_fork+0x1f/0x30

Fixes: 1f90a05d9ff9 ("net/smc: add smcr_port_add() and smcr_link_up() processing")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index e84241ff4ac4f..ab9ecdd1af0ac 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1101,6 +1101,7 @@ void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport)
 {
 	struct smc_link_group *lgr, *n;
 
+	spin_lock_bh(&smc_lgr_list.lock);
 	list_for_each_entry_safe(lgr, n, &smc_lgr_list.list, list) {
 		struct smc_link *link;
 
@@ -1115,6 +1116,7 @@ void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport)
 		if (link)
 			smc_llc_add_link_local(link);
 	}
+	spin_unlock_bh(&smc_lgr_list.lock);
 }
 
 /* link is down - switch connections to alternate link,
-- 
2.40.1



