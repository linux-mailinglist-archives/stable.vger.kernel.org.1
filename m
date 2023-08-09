Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F72775CCC
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjHILbD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjHILbD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:31:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F5ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:31:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E9CD63332
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B402C433C8;
        Wed,  9 Aug 2023 11:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580661;
        bh=gb3tivW3/BPDTH+L1SQc01dCru93Dbv7hw9LxSXOydI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzHiH7HK7pEawdmbA1HlsDNU9Q/mrnQIMaCLUlQ1f/zjGA1qtF6fllOHWVuc0okRQ
         8O4qkAdCVzCdF43vjlWWaB+vN1rfQkBeowOEP+O0fyZePcJeT8z4QRpFkMYG8YtVZu
         cvCvUtQmoK5onF3HiZfsNNv5W72PaboQ/iqhFT3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 104/154] net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
Date:   Wed,  9 Aug 2023 12:42:15 +0200
Message-ID: <20230809103640.409322518@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b4b553253091cafe9ec38994acf42795e073bef5 ]

In a prior commit, I forgot to change sk_getsockopt()
when reading sk->sk_rcvbuf locklessly.

Fixes: ebb3b78db7bf ("tcp: annotate sk->sk_rcvbuf lockless reads")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index e6d26cfba32d5..6d695da921094 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1262,7 +1262,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_RCVBUF:
-		v.val = sk->sk_rcvbuf;
+		v.val = READ_ONCE(sk->sk_rcvbuf);
 		break;
 
 	case SO_REUSEADDR:
-- 
2.40.1



