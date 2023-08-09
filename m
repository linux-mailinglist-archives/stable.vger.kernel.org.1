Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDC5775C32
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjHILYt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjHILYs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569B61BFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1A256323F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F19C433C7;
        Wed,  9 Aug 2023 11:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580287;
        bh=lyCT77xzH4dwjhA0JcfnnwMroyD8RjAxphpKAlVC7ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs0Xa6be/5BiDPX9Agnw7ejjb1p09/6sYId4FoyvKaK9LPz5p16YgrvSVION0x/1e
         Wh73DuDdkDsKKxoWbH7jGJSnYiLMy7Fr6E+ymH0LjdpUS1/gQVarHFUXLQjrwt+dsA
         PGheVe2n/eBXb9rKNwbTEDqPHvkcd/57qbTcqFkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 294/323] net: add missing data-race annotations around sk->sk_peek_off
Date:   Wed,  9 Aug 2023 12:42:12 +0200
Message-ID: <20230809103711.515187860@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
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

[ Upstream commit 11695c6e966b0ec7ed1d16777d294cef865a5c91 ]

sk_getsockopt() runs locklessly, thus we need to annotate the read
of sk->sk_peek_off.

While we are at it, add corresponding annotations to sk_set_peek_off()
and unix_set_peek_off().

Fixes: b9bb53f3836f ("sock: convert sk_peek_offset functions to WRITE_ONCE")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c    | 4 ++--
 net/unix/af_unix.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 5b31f3446fc7a..f112862fe0682 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1319,7 +1319,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		if (!sock->ops->set_peek_off)
 			return -EOPNOTSUPP;
 
-		v.val = sk->sk_peek_off;
+		v.val = READ_ONCE(sk->sk_peek_off);
 		break;
 	case SO_NOFCS:
 		v.val = sock_flag(sk, SOCK_NOFCS);
@@ -2559,7 +2559,7 @@ EXPORT_SYMBOL(__sk_mem_reclaim);
 
 int sk_set_peek_off(struct sock *sk, int val)
 {
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sk_set_peek_off);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b0dcbb08e60db..8971341c4f8af 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -706,7 +706,7 @@ static int unix_set_peek_off(struct sock *sk, int val)
 	if (mutex_lock_interruptible(&u->iolock))
 		return -EINTR;
 
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	mutex_unlock(&u->iolock);
 
 	return 0;
-- 
2.40.1



