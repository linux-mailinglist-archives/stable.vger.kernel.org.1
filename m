Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFBD7758DB
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjHIKzt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjHIKze (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3524212
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 395DC63126
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A4EC433C8;
        Wed,  9 Aug 2023 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578474;
        bh=1OZHGzEbOBC4KhqkNqRUSsaIM1HY3hDtUm1LMFcfuVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oj1Qz+nVibkS//OlUbTTa1+gig2VXp7Kf/gElkXQRmrHGBhWq8vJHK0X2F6MA8qKd
         Y/jiRC+tSN9GHVgjxqVKgoI/L74embWpIQ0O7TDMcBiJOcn9BChw3HGJsd0l+yME38
         NBB9WGhGJQ/56Nbmn9nr/diM4OfSZ6KXPAn8rfRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 043/127] net: add missing data-race annotation for sk_ll_usec
Date:   Wed,  9 Aug 2023 12:40:30 +0200
Message-ID: <20230809103638.101778157@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
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
index 61bbe6263f98e..ff52d51dfe2c5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1845,7 +1845,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	case SO_BUSY_POLL:
-		v.val = sk->sk_ll_usec;
+		v.val = READ_ONCE(sk->sk_ll_usec);
 		break;
 	case SO_PREFER_BUSY_POLL:
 		v.val = READ_ONCE(sk->sk_prefer_busy_poll);
-- 
2.40.1



