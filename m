Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23DA70C9A2
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjEVTua (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjEVTuI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:50:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEA3B5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CDB862AE7
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F508C433EF;
        Mon, 22 May 2023 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785006;
        bh=+xY9tYciHcJYoC84cna2hrybmQOq6ZlbigeiAIDbtpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGEGMxqbFyj7vFYAAI4378gSMcNv6Ewzj67dr+6svfNHrYIUvY4X9iqKf7P6hZg+a
         SyDlOxTJ2KGGF/hVF6/ABJfXV2Y4WkF8C6FkIdwhsr8oPX/UYecJtz27NuTJ5qMJ50
         15kh3RLKrFHzqoZokoScjMeZbNaMwfiKm1+kSKjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 277/364] devlink: Fix crash with CONFIG_NET_NS=n
Date:   Mon, 22 May 2023 20:09:42 +0100
Message-Id: <20230522190419.648065993@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit d6352dae0903fe8beae4c007dc320e9e9f1fed45 ]

'__net_initdata' becomes a no-op with CONFIG_NET_NS=y, but when this
option is disabled it becomes '__initdata', which means the data can be
freed after the initialization phase. This annotation is obviously
incorrect for the devlink net device notifier block which is still
registered after the initialization phase [1].

Fix this crash by removing the '__net_initdata' annotation.

[1]
general protection fault, probably for non-canonical address 0xcccccccccccccccc: 0000 [#1] PREEMPT SMP
CPU: 3 PID: 117 Comm: (udev-worker) Not tainted 6.4.0-rc1-custom-gdf0acdc59b09 #64
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
RIP: 0010:notifier_call_chain+0x58/0xc0
[...]
Call Trace:
 <TASK>
 dev_set_mac_address+0x85/0x120
 dev_set_mac_address_user+0x30/0x50
 do_setlink+0x219/0x1270
 rtnl_setlink+0xf7/0x1a0
 rtnetlink_rcv_msg+0x142/0x390
 netlink_rcv_skb+0x58/0x100
 netlink_unicast+0x188/0x270
 netlink_sendmsg+0x214/0x470
 __sys_sendto+0x12f/0x1a0
 __x64_sys_sendto+0x24/0x30
 do_syscall_64+0x38/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: e93c9378e33f ("devlink: change per-devlink netdev notifier to static one")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/netdev/600ddf9e-589a-2aa0-7b69-a438f833ca10@samsung.com/
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230515162925.1144416-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 0e58eee44bdb2..c23ebabadc526 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -294,7 +294,7 @@ static struct pernet_operations devlink_pernet_ops __net_initdata = {
 	.pre_exit = devlink_pernet_pre_exit,
 };
 
-static struct notifier_block devlink_port_netdevice_nb __net_initdata = {
+static struct notifier_block devlink_port_netdevice_nb = {
 	.notifier_call = devlink_port_netdevice_event,
 };
 
-- 
2.39.2



