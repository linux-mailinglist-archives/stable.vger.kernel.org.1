Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1970B78AB2D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjH1K2j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjH1K2T (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:28:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CF612D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A51F763BA4
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1E8C433C8;
        Mon, 28 Aug 2023 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218491;
        bh=fhdH+RShQxfQIQq/yI5q1Dt7+IqHwszLRKg6onLlvCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSxVzreBp4bq5iARJ/gJCH73FJty2WtOSExCkYYzUOB1Rt9IrtgfgVoxv4t7Z5ApA
         Ygv9UFsbcgYxr5gUH4obG5tAVL5muWg5l73ZCjUAX7vFMZQ+BmEf/ZRuazkYXi4poQ
         YkA1+Jz9vU7dfry84h99xtuwru6K123rwOLJd+AE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 106/129] net: remove bond_slave_has_mac_rcu()
Date:   Mon, 28 Aug 2023 12:13:20 +0200
Message-ID: <20230828101157.144088502@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 8b0fdcdc3a7d44aff907f0103f5ffb86b12bfe71 ]

No caller since v3.16.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e74216b8def3 ("bonding: fix macvlan over alb bond support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bonding.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index c458f084f7bb9..ab862e2e34520 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -674,20 +674,6 @@ static inline struct slave *bond_slave_has_mac(struct bonding *bond,
 	return NULL;
 }
 
-/* Caller must hold rcu_read_lock() for read */
-static inline struct slave *bond_slave_has_mac_rcu(struct bonding *bond,
-					       const u8 *mac)
-{
-	struct list_head *iter;
-	struct slave *tmp;
-
-	bond_for_each_slave_rcu(bond, tmp, iter)
-		if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
-			return tmp;
-
-	return NULL;
-}
-
 /* Caller must hold rcu_read_lock() for read */
 static inline bool bond_slave_has_mac_rx(struct bonding *bond, const u8 *mac)
 {
-- 
2.40.1



