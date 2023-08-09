Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A03F775D5C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjHILgi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjHILgi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903DA1FD2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3041963537
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2BFC433C8;
        Wed,  9 Aug 2023 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580996;
        bh=wzF1K+u6aaEzLFict1PTn5PtZscftQQ8HPIFxJw/9FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPDfIUC+ZH9eYGBYEJ76LVQbjz2AFOOsp2RlTlFs36JPRdcOgA+R2tn3JfTz5sOXM
         AEax/SmfBYsKcA4VRJVFzNquTbp7eNF5ZJGQFbEOkKNHLh7632kcIrS192J4cCzJ9S
         Mkgoovo8yrIxhgfMiFaoaFi1v664Su7iPYJb9Psk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xin Long <lucien.xin@gmail.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 051/201] tipc: stop tipc crypto on failure in tipc_node_create
Date:   Wed,  9 Aug 2023 12:40:53 +0200
Message-ID: <20230809103645.557172319@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit de52e17326c3e9a719c9ead4adb03467b8fae0ef ]

If tipc_link_bc_create() fails inside tipc_node_create() for a newly
allocated tipc node then we should stop its tipc crypto and free the
resources allocated with a call to tipc_crypto_start().

As the node ref is initialized to one to that point, just put the ref on
tipc_link_bc_create() error case that would lead to tipc_node_free() be
eventually executed and properly clean the node and its crypto resources.

Found by Linux Verification Center (linuxtesting.org).

Fixes: cb8092d70a6f ("tipc: move bc link creation back to tipc_node_create")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Link: https://lore.kernel.org/r/20230725214628.25246-1-pchelkin@ispras.ru
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 38f61dccb8552..9e3cfeb82a23d 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -567,7 +567,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 				 n->capabilities, &n->bc_entry.inputq1,
 				 &n->bc_entry.namedq, snd_l, &n->bc_entry.link)) {
 		pr_warn("Broadcast rcv link creation failed, no memory\n");
-		kfree(n);
+		tipc_node_put(n);
 		n = NULL;
 		goto exit;
 	}
-- 
2.39.2



