Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C07A7D2F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjITMHa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjITMHO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:07:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74440C6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:07:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C25C433CA;
        Wed, 20 Sep 2023 12:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211628;
        bh=Em5IwOWjzHhzHlXzfeNOmEHEJvEVC5V/3xF8vbVWFJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSEwWLUT4WD+FdF9IO3tVAbbEQNuMkSjK3u1hqo6p5i/msgFQi9Kn77vItuGy0DJ8
         aykg36Z87JiyUyDwMrANDIxzmU8K5g/+RFIyJWVBCCDJE8sQMe7MreNc9izTKEjk24
         E97/N8dW1Mi3rqr1bqqi65KdKWz5pSZZY64MkrTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 137/186] af_unix: Fix data race around sk->sk_err.
Date:   Wed, 20 Sep 2023 13:30:40 +0200
Message-ID: <20230920112841.945456012@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit b192812905e4b134f7b7994b079eb647e9d2d37e ]

As with sk->sk_shutdown shown in the previous patch, sk->sk_err can be
read locklessly by unix_dgram_sendmsg().

Let's use READ_ONCE() for sk_err as well.

Note that the writer side is marked by commit cc04410af7de ("af_unix:
annotate lockless accesses to sk->sk_err").

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 846d4cec79903..5b9f51a27dc0d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2067,7 +2067,7 @@ static long sock_wait_for_wmem(struct sock *sk, long timeo)
 			break;
 		if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 			break;
-		if (sk->sk_err)
+		if (READ_ONCE(sk->sk_err))
 			break;
 		timeo = schedule_timeout(timeo);
 	}
-- 
2.40.1



