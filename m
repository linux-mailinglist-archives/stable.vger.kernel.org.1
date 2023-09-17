Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D1D7A3BBD
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbjIQUVy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbjIQUVd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:21:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB2C10A
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:21:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB67C433CB;
        Sun, 17 Sep 2023 20:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982085;
        bh=ooDOdC8PmgA4kwmfAvkTIrjiH3M9GDJeRd422wdJDyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zRTFS4awX0Jx64EP6/nah5UqHTKCnesYlvx2yXkDTBkE+ML7MkPGx4reLRMX/d2KK
         OFY99SRavsD9GsIc4tME3Rz4/NOUJQ/3h4bn0xJnrpa4q0ZeC3QilZOhA/XF1s/FV4
         BPslzM2O2itnyHmCWvSyAF/WTyg6URERjPSdLOQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 215/219] tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
Date:   Sun, 17 Sep 2023 21:15:42 +0200
Message-ID: <20230917191048.707271129@linuxfoundation.org>
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

[ Upstream commit c48ef9c4aed3632566b57ba66cec6ec78624d4cb ]

Since bhash2 was introduced, the example below does not work as expected.
These two bind() should conflict, but the 2nd bind() now succeeds.

  from socket import *

  s1 = socket(AF_INET6, SOCK_STREAM)
  s1.bind(('::ffff:127.0.0.1', 0))

  s2 = socket(AF_INET, SOCK_STREAM)
  s2.bind(('127.0.0.1', s1.getsockname()[1]))

During the 2nd bind() in inet_csk_get_port(), inet_bind2_bucket_find()
fails to find the 1st socket's tb2, so inet_bind2_bucket_create() allocates
a new tb2 for the 2nd socket.  Then, we call inet_csk_bind_conflict() that
checks conflicts in the new tb2 by inet_bhash2_conflict().  However, the
new tb2 does not include the 1st socket, thus the bind() finally succeeds.

In this case, inet_bind2_bucket_match() must check if AF_INET6 tb2 has
the conflicting v4-mapped-v6 address so that inet_bind2_bucket_find()
returns the 1st socket's tb2.

Note that if we bind two sockets to 127.0.0.1 and then ::FFFF:127.0.0.1,
the 2nd bind() fails properly for the same reason mentinoed in the previous
commit.

Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_hashtables.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index eb522c0374d59..d79de4b95186b 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -800,8 +800,13 @@ static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,
 		return false;
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb->family)
+	if (sk->sk_family != tb->family) {
+		if (sk->sk_family == AF_INET)
+			return ipv6_addr_v4mapped(&tb->v6_rcv_saddr) &&
+				tb->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
+
 		return false;
+	}
 
 	if (sk->sk_family == AF_INET6)
 		return ipv6_addr_equal(&tb->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
-- 
2.40.1



