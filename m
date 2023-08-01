Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8EF76AD33
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjHAJ1S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjHAJ0u (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:26:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B6635BD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45990614FE
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D1DC433C8;
        Tue,  1 Aug 2023 09:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881950;
        bh=6trlCTXDvEEdpebaUiJa+pdRHQ6IluKLrWb0CSgbe84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L5A95E/i+thOTIq7CFb82CtP25AKek+6x5DVw2EQwr2oFmPwlym1UcVpNgx+l7VDM
         3tbMX3E1WyBQXZhICVikT4mVqRJec9HhH3Rs/9BPccWyOUXMPNTHe9RbBJmIXN14bL
         gvpUmgV4tbqUNM7qsSdGxuytpx1bOUrkj1zUge/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 080/155] tipc: check return value of pskb_trim()
Date:   Tue,  1 Aug 2023 11:19:52 +0200
Message-ID: <20230801091913.004335608@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yuanjun Gong <ruc_gongyuanjun@163.com>

[ Upstream commit e46e06ffc6d667a89b979701288e2264f45e6a7b ]

goto free_skb if an unexpected result is returned by pskb_tirm()
in tipc_crypto_rcv_complete().

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
Reviewed-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Link: https://lore.kernel.org/r/20230725064810.5820-1-ruc_gongyuanjun@163.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 4243d2ab8adfb..32447e8d94ac9 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1971,7 +1971,8 @@ static void tipc_crypto_rcv_complete(struct net *net, struct tipc_aead *aead,
 
 	skb_reset_network_header(*skb);
 	skb_pull(*skb, tipc_ehdr_size(ehdr));
-	pskb_trim(*skb, (*skb)->len - aead->authsize);
+	if (pskb_trim(*skb, (*skb)->len - aead->authsize))
+		goto free_skb;
 
 	/* Validate TIPCv2 message */
 	if (unlikely(!tipc_msg_validate(skb))) {
-- 
2.39.2



