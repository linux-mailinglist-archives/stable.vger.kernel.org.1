Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF637A7ADF
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjITLrB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjITLrA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:47:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D112B0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:46:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E08C433C7;
        Wed, 20 Sep 2023 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210415;
        bh=LUDbKRO6KVrgAnj9CITYnDoTGSm84GfwjbrFyPxL1CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGQC0XlkGY++gbR0/Icu3BkPu1foXeo8aNd+07WpoLaebVJ4rZ/6rwBa+hpNrNoje
         ///SvyU1cH+a65NX6VMjLhLiWtc6/GgP0gKpShHG/xzA6d2l2k91BesSpC62O8ai3c
         /EIrZYtrC1CFNYb7Z2JKiN93CUEchcpCIIeqx2xY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 035/211] net: Use sockaddr_storage for getsockopt(SO_PEERNAME).
Date:   Wed, 20 Sep 2023 13:27:59 +0200
Message-ID: <20230920112846.880744667@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 8936bf53a091ad6a34b480c22002f1cb2422ab38 ]

Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") started
applying strict rules to standard string functions.

It does not work well with conventional socket code around each protocol-
specific sockaddr_XXX struct, which is cast from sockaddr_storage and has
a bigger size than fortified functions expect.  See these commits:

 commit 06d4c8a80836 ("af_unix: Fix fortify_panic() in unix_bind_bsd().")
 commit ecb4534b6a1c ("af_unix: Terminate sun_path when bind()ing pathname socket.")
 commit a0ade8404c3b ("af_packet: Fix warning of fortified memcpy() in packet_getname().")

We must cast the protocol-specific address back to sockaddr_storage
to call such functions.

However, in the case of getsockaddr(SO_PEERNAME), the rationale is a bit
unclear as the buffer is defined by char[128] which is the same size as
sockaddr_storage.

Let's use sockaddr_storage explicitly.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 29c6cb030818b..eef27812013a4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1824,14 +1824,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_PEERNAME:
 	{
-		char address[128];
+		struct sockaddr_storage address;
 
-		lv = sock->ops->getname(sock, (struct sockaddr *)address, 2);
+		lv = sock->ops->getname(sock, (struct sockaddr *)&address, 2);
 		if (lv < 0)
 			return -ENOTCONN;
 		if (lv < len)
 			return -EINVAL;
-		if (copy_to_sockptr(optval, address, len))
+		if (copy_to_sockptr(optval, &address, len))
 			return -EFAULT;
 		goto lenout;
 	}
-- 
2.40.1



