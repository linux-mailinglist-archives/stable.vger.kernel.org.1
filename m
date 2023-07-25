Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50FA7614D0
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjGYLXM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjGYLW4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8AD19BB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E40A0616A5
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1042C433C9;
        Tue, 25 Jul 2023 11:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284168;
        bh=V5W0Bn0qay+Bh1r5BUFiMvXV5Mz85bTKyqUZQmYwe7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjQf4/MwCe3kLsQpQpPNWRaJs/4J4lz6hCZz8HJni+xB9Azev2HfP7X4ibJGfs2gu
         rFVe2rm2Xn9gMm6OKkqjb3dO9DGkl9jLPCFxfWBambVhRkNdX5c+tDc/cK2/4WMw4D
         IwHKsdQ/Wduek6kcYzZmmlytCfcVHBJpqMcOZZ7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengfeng Ye <dg573847474@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 260/509] sctp: fix potential deadlock on &net->sctp.addr_wq_lock
Date:   Tue, 25 Jul 2023 12:43:19 +0200
Message-ID: <20230725104605.655411899@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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
index 4a7f811abae4e..534364bb871a3 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -362,9 +362,9 @@ static void sctp_auto_asconf_init(struct sctp_sock *sp)
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



