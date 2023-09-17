Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5E37A3BBC
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbjIQUVx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbjIQUVY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:21:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044CE10A
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:21:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D31C433C8;
        Sun, 17 Sep 2023 20:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982078;
        bh=YhvnIGHBHbDHRaCiztgqk5g+bS6pMUpGLHKRKiYmATk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBzU+hpoBPJsRi8MnNTzLY+p4pj8tQgx4CaQXUYjW+X4raEq24uwAFhUJaGDRMhH2
         ctIOx9mxd5jw0scrwBdWIZ7GYb1ogifDehl9qLLIZhRvFg7R3nX0wbGXw3rPPKYE2R
         czFNQSZFSXn05hRr4fpxXX4bku9OSz098Y3lk2hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrei Vagin <avagin@google.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 214/219] tcp: Fix bind() regression for v4-mapped-v6 wildcard address.
Date:   Sun, 17 Sep 2023 21:15:41 +0200
Message-ID: <20230917191048.673445649@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit aa99e5f87bd54db55dd37cb130bd5eb55933027f ]

Andrei Vagin reported bind() regression with strace logs.

If we bind() a TCPv6 socket to ::FFFF:0.0.0.0 and then bind() a TCPv4
socket to 127.0.0.1, the 2nd bind() should fail but now succeeds.

  from socket import *

  s1 = socket(AF_INET6, SOCK_STREAM)
  s1.bind(('::ffff:0.0.0.0', 0))

  s2 = socket(AF_INET, SOCK_STREAM)
  s2.bind(('127.0.0.1', s1.getsockname()[1]))

During the 2nd bind(), if tb->family is AF_INET6 and sk->sk_family is
AF_INET in inet_bind2_bucket_match_addr_any(), we still need to check
if tb has the v4-mapped-v6 wildcard address.

The example above does not work after commit 5456262d2baa ("net: Fix
incorrect address comparison when searching for a bind2 bucket"), but
the blamed change is not the commit.

Before the commit, the leading zeros of ::FFFF:0.0.0.0 were treated
as 0.0.0.0, and the sequence above worked by chance.  Technically, this
case has been broken since bhash2 was introduced.

Note that if we bind() two sockets to 127.0.0.1 and then ::FFFF:0.0.0.0,
the 2nd bind() fails properly because we fall back to using bhash to
detect conflicts for the v4-mapped-v6 address.

Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
Reported-by: Andrei Vagin <avagin@google.com>
Closes: https://lore.kernel.org/netdev/ZPuYBOFC8zsK6r9T@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ipv6.h         | 5 +++++
 net/ipv4/inet_hashtables.c | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 8ced112167599..517bdae78614b 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -750,6 +750,11 @@ static inline bool ipv6_addr_v4mapped(const struct in6_addr *a)
 					cpu_to_be32(0x0000ffff))) == 0UL;
 }
 
+static inline bool ipv6_addr_v4mapped_any(const struct in6_addr *a)
+{
+	return ipv6_addr_v4mapped(a) && ipv4_is_zeronet(a->s6_addr32[3]);
+}
+
 static inline bool ipv6_addr_v4mapped_loopback(const struct in6_addr *a)
 {
 	return ipv6_addr_v4mapped(a) && ipv4_is_loopback(a->s6_addr32[3]);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 71d77b3b6536f..eb522c0374d59 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -819,7 +819,8 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family != tb->family) {
 		if (sk->sk_family == AF_INET)
-			return ipv6_addr_any(&tb->v6_rcv_saddr);
+			return ipv6_addr_any(&tb->v6_rcv_saddr) ||
+				ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr);
 
 		return false;
 	}
-- 
2.40.1



