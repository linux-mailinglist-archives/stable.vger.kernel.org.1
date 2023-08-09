Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD777595D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjHIK7v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjHIK7v (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:59:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F491FFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:59:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7EC863130
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04759C433C9;
        Wed,  9 Aug 2023 10:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578789;
        bh=uABZAp7WCzbTJt+0ts5NNTFbJVnOFl0TsAjn0kXLvhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1VYjzXOCrJ6T8fQ+jS4W+vj+Phh7AKQXC1Av8yeFAHNI5XHy7QR39Sy+lRos1iQv
         ofcofCKvDiB19Yey4FOYhNorP3wP6AZ25TE3dtXozgmi9yS4Zg2qaeKpWoDRPyjV2l
         z/vpZ2FaiY46ALGCLA88wP0DArvlcyhzfveJd9q8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 29/92] net: add missing data-race annotations around sk->sk_peek_off
Date:   Wed,  9 Aug 2023 12:41:05 +0200
Message-ID: <20230809103634.634805395@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
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
index 59abfb2c92266..0cca1ccf14990 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1643,7 +1643,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		if (!sock->ops->set_peek_off)
 			return -EOPNOTSUPP;
 
-		v.val = sk->sk_peek_off;
+		v.val = READ_ONCE(sk->sk_peek_off);
 		break;
 	case SO_NOFCS:
 		v.val = sock_flag(sk, SOCK_NOFCS);
@@ -2901,7 +2901,7 @@ EXPORT_SYMBOL(__sk_mem_reclaim);
 
 int sk_set_peek_off(struct sock *sk, int val)
 {
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sk_set_peek_off);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d326540e4938c..7a076d5017d1c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -717,7 +717,7 @@ static int unix_set_peek_off(struct sock *sk, int val)
 	if (mutex_lock_interruptible(&u->iolock))
 		return -EINTR;
 
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	mutex_unlock(&u->iolock);
 
 	return 0;
-- 
2.40.1



