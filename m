Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B17553FA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjGPUZL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjGPUZK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:25:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DB1BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:25:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33DAB60EBB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D53CC433C7;
        Sun, 16 Jul 2023 20:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539108;
        bh=ae0FNF8BgrzFP3Moios+vQ25h06mx2/p8mhO9UerDDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxoj2XnFA66fwYp++br8ml7HTfnptBWAkNNFy/BCwx82i3t6xYYxAKH2bAkbML/zH
         u6CTw/axZhh93Kt+nv9ih5/+YJVFDs7xflUEm035BfLK8TdskbRx6GeIvBlXR3yoxa
         ZqV0ZMPQqw+D+WvJpFsuUNqFMYc81YmVfzkRo2Zo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengfeng Ye <dg573847474@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 661/800] sctp: fix potential deadlock on &net->sctp.addr_wq_lock
Date:   Sun, 16 Jul 2023 21:48:34 +0200
Message-ID: <20230716195004.465895516@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chengfeng Ye <dg573847474@gmail.com>

[ Upstream commit 6feb37b3b06e9049e20dcf7e23998f92c9c5be9a ]

As &net->sctp.addr_wq_lock is also acquired by the timer
sctp_addr_wq_timeout_handler() in protocal.c, the same lock acquisition
at sctp_auto_asconf_init() seems should disable irq since it is called
from sctp_accept() under process context.

Possible deadlock scenario:
sctp_accept()
    -> sctp_sock_migrate()
    -> sctp_auto_asconf_init()
    -> spin_lock(&net->sctp.addr_wq_lock)
        <timer interrupt>
        -> sctp_addr_wq_timeout_handler()
        -> spin_lock_bh(&net->sctp.addr_wq_lock); (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_bh().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Fixes: 34e5b0118685 ("sctp: delay auto_asconf init until binding the first addr")
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://lore.kernel.org/r/20230627120340.19432-1-dg573847474@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index a68e1d541b128..ee15eff6364ee 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -364,9 +364,9 @@ static void sctp_auto_asconf_init(struct sctp_sock *sp)
 	struct net *net = sock_net(&sp->inet.sk);
 
 	if (net->sctp.default_auto_asconf) {
-		spin_lock(&net->sctp.addr_wq_lock);
+		spin_lock_bh(&net->sctp.addr_wq_lock);
 		list_add_tail(&sp->auto_asconf_list, &net->sctp.auto_asconf_splist);
-		spin_unlock(&net->sctp.addr_wq_lock);
+		spin_unlock_bh(&net->sctp.addr_wq_lock);
 		sp->do_auto_asconf = 1;
 	}
 }
-- 
2.39.2



