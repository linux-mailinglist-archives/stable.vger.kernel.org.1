Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F989775774
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjHIKqN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjHIKqM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A274C1BFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4077863120
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2A6C433C7;
        Wed,  9 Aug 2023 10:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577970;
        bh=/OL+7b9O51R6gLno+CJqBnpZY6cmS+YLOb6oAzKVM6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOAknKoHxqAVaGw27fUgXNGssr7rh5Fq0KOAP/ODLA4kSc4O+22OgCngyTwma5Ixb
         lgnHXVDCq0FC8vvvPy+umMQewleeS+8QrRyTcekLPUbJs6tSuFVk0JRu9VbCdz3/nj
         DJls2aei8Y2+ynKSVuVUuecznniXFe6Avd39eJfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 059/165] net: add missing data-race annotation for sk_ll_usec
Date:   Wed,  9 Aug 2023 12:39:50 +0200
Message-ID: <20230809103644.748199443@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e5f0d2dd3c2faa671711dac6d3ff3cef307bcfe3 ]

In a prior commit I forgot that sk_getsockopt() reads
sk->sk_ll_usec without holding a lock.

Fixes: 0dbffbb5335a ("net: annotate data race around sk_ll_usec")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index f9fc2a0130a9f..c0c495e0a474e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1848,7 +1848,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	case SO_BUSY_POLL:
-		v.val = sk->sk_ll_usec;
+		v.val = READ_ONCE(sk->sk_ll_usec);
 		break;
 	case SO_PREFER_BUSY_POLL:
 		v.val = READ_ONCE(sk->sk_prefer_busy_poll);
-- 
2.40.1



