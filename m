Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07747761384
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjGYLLQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjGYLKw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:10:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380E42719
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A80CE61683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2523C433CA;
        Tue, 25 Jul 2023 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283403;
        bh=MdAa3hZjHzDkND0KjfFCbPNT3eIQcCK+AhoFxxUa+X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXg97T4jorL4agvQZNYrdckGPyKxQE8AKLE1KpJDxzCSMkfDnCdAI0z0UOf3cCXDi
         PrHzK6QmV7BynL1hnlCv1iH8JHbDG6Q5VkTEnbNeaGBKqlbzkI4Ac7WOA7i98bBSZH
         TqiOByc5fSq8ijyxkG3yXmVEv4dxq2hp1/1A9Tvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang Ming <machel@vivo.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 56/78] net: ipv4: Use kfree_sensitive instead of kfree
Date:   Tue, 25 Jul 2023 12:46:47 +0200
Message-ID: <20230725104453.443463603@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
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

From: Wang Ming <machel@vivo.com>

[ Upstream commit daa751444fd9d4184270b1479d8af49aaf1a1ee6 ]

key might contain private part of the key, so better use
kfree_sensitive to free it.

Fixes: 38320c70d282 ("[IPSEC]: Use crypto_aead and authenc in ESP")
Signed-off-by: Wang Ming <machel@vivo.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/esp4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d747166bb291c..386e9875e5b80 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -1133,7 +1133,7 @@ static int esp_init_authenc(struct xfrm_state *x)
 	err = crypto_aead_setkey(aead, key, keylen);
 
 free_key:
-	kfree(key);
+	kfree_sensitive(key);
 
 error:
 	return err;
-- 
2.39.2



