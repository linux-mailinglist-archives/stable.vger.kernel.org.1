Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDD676122F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjGYK75 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjGYK7i (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72192136
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C8B06166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E393C433C8;
        Tue, 25 Jul 2023 10:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282605;
        bh=qQwSVXBDosH+ASN5sxRAD8udlYpbP+LkBtnoT2t09SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqZrwFu0Hmg+Y0RyORk5kMkr5DR0bHS6LQwPDcBPlXGTLMN1UMOzwYmvz65jDJKxo
         pkWKN8PIAYM16HVLhdaR3sf59FusbvBi/gxvDEPuealdiz3MiJeXFdLNQ5Xr75K8/L
         LtuzoJizDDHW+rQ44ggegh732+/LjmOl+29gVHYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang Ming <machel@vivo.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 188/227] net: ipv4: Use kfree_sensitive instead of kfree
Date:   Tue, 25 Jul 2023 12:45:55 +0200
Message-ID: <20230725104522.590435520@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index ba06ed42e4284..2be2d49225573 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -1132,7 +1132,7 @@ static int esp_init_authenc(struct xfrm_state *x,
 	err = crypto_aead_setkey(aead, key, keylen);
 
 free_key:
-	kfree(key);
+	kfree_sensitive(key);
 
 error:
 	return err;
-- 
2.39.2



