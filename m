Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA37E78ACD6
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjH1Kmm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjH1KmP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0827ACC0
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F1AC64113
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C96FC433C7;
        Mon, 28 Aug 2023 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219329;
        bh=SjgJlWmomEEk+Y5k9uzooq4F1dY4k75q/ZTNiWEK5LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkARaXiUIljM+b9nhP1mfT1gDFTEgjEdjLMS3T4IciHGPr+prBbNGM4GE4ByQXVqb
         KH9uQK7dySpFzh5uuaxnNQa2MxlmCiDTNR52EFMKHW1SP4c9X2yCf9sq+6iFrurJsb
         QVBWFspqZkvJCwjurQZpxHZP+l2hPyBcpjaprmd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 128/158] net: remove bond_slave_has_mac_rcu()
Date:   Mon, 28 Aug 2023 12:13:45 +0200
Message-ID: <20230828101201.732341197@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index a3698f0fb2a6d..4e1e589aae057 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -685,20 +685,6 @@ static inline struct slave *bond_slave_has_mac(struct bonding *bond,
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



