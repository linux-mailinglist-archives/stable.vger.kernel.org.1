Return-Path: <stable+bounces-141697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4288CAAB5C9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E823A16C7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB94A3C4A;
	Tue,  6 May 2025 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV9zMkLD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2B2F818E;
	Mon,  5 May 2025 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487196; cv=none; b=gUnAwn/YetZ83tr0j4znpa1DjbdJeXB/FUJw6gz1RzwGyVOfR9tAR3fD/3J5Ms/RFRQPJppNt3HxZJCbsmWRE8Vz1lzKdfXjEbx9hHQQPEw3wGXgHN3DvudzESc1V35nYzSkCgFp+oeYtCTGOTeyzdR8MOaZqp8LiwQnk56wA5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487196; c=relaxed/simple;
	bh=KT+uXDczhG9CVFcFO/QUvgBQUbGLWTZv1Qclq7yxCGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z51/EZTzXr+/wdPPZHbEycw8oLooHKqFecE+KbOUXJ44kTErZrYKLYQlBOccJipwEmug/s7Munap1zxNQxpPlSsRWhXL0QBJBXhPJLRBoI3M6Vif1UYKmzXBQRCegmdw1Xg0gPggiowXfXgC6Rb1hewkHODZgk4s8A6olqLLbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV9zMkLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B93FC4CEEF;
	Mon,  5 May 2025 23:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487195;
	bh=KT+uXDczhG9CVFcFO/QUvgBQUbGLWTZv1Qclq7yxCGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZV9zMkLD44MdQ3/UoflK/8azkTDfhiJ55trbDUbHDI+Nr6SiR2b6Ztq9e1O9nZNYa
	 w4aYi+EiwoMfdr5QfEXyuiIYMKibnEtcJKEYlMwmqRXe/WsWYf77Riemq3OM2Jl7ws
	 T6Q2UJWL505xHNa5A0Mc4abbu+tA6Yw9jjQyLRmzXwjHT5ZuC/dqTfOCvpqwQ3Vyty
	 0lbGeF7I239WHZ8wL2BZOJDhGNWaWADMLTRgwbfhK8/TjIgaNCPdCQXKt5KKFjKR3k
	 i2AAU37jMlGGrREctXQsWYxVEotj1O5Ozh6+ucCoHl4P7usb6YZroQJ52UpYBg2sWu
	 ROTWJVwCP/A2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 051/114] ipv4: fib: Move fib_valid_key_len() to rtm_to_fib_config().
Date: Mon,  5 May 2025 19:17:14 -0400
Message-Id: <20250505231817.2697367-51-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 254ba7e6032d3fc738050d500b0c1d8197af90ca ]

fib_valid_key_len() is called in the beginning of fib_table_insert()
or fib_table_delete() to check if the prefix length is valid.

fib_table_insert() and fib_table_delete() are called from 3 paths

  - ip_rt_ioctl()
  - inet_rtm_newroute() / inet_rtm_delroute()
  - fib_magic()

In the first ioctl() path, rtentry_to_fib_config() checks the prefix
length with bad_mask().  Also, fib_magic() always passes the correct
prefix: 32 or ifa->ifa_prefixlen, which is already validated.

Let's move fib_valid_key_len() to the rtnetlink path, rtm_to_fib_config().

While at it, 2 direct returns in rtm_to_fib_config() are changed to
goto to match other places in the same function

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250228042328.96624-12-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fib_frontend.c | 18 ++++++++++++++++--
 net/ipv4/fib_trie.c     | 22 ----------------------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 5e2a003cd83c7..f902cd8cb852b 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -817,19 +817,33 @@ static int rtm_to_fib_config(struct net *net, struct sk_buff *skb,
 		}
 	}
 
+	if (cfg->fc_dst_len > 32) {
+		NL_SET_ERR_MSG(extack, "Invalid prefix length");
+		err = -EINVAL;
+		goto errout;
+	}
+
+	if (cfg->fc_dst_len < 32 && (ntohl(cfg->fc_dst) << cfg->fc_dst_len)) {
+		NL_SET_ERR_MSG(extack, "Invalid prefix for given prefix length");
+		err = -EINVAL;
+		goto errout;
+	}
+
 	if (cfg->fc_nh_id) {
 		if (cfg->fc_oif || cfg->fc_gw_family ||
 		    cfg->fc_encap || cfg->fc_mp) {
 			NL_SET_ERR_MSG(extack,
 				       "Nexthop specification and nexthop id are mutually exclusive");
-			return -EINVAL;
+			err = -EINVAL;
+			goto errout;
 		}
 	}
 
 	if (has_gw && has_via) {
 		NL_SET_ERR_MSG(extack,
 			       "Nexthop configuration can not contain both GATEWAY and VIA");
-		return -EINVAL;
+		err = -EINVAL;
+		goto errout;
 	}
 
 	if (!cfg->fc_table)
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 1bdcdc79d43f9..6c53381fa36f7 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1145,22 +1145,6 @@ static int fib_insert_alias(struct trie *t, struct key_vector *tp,
 	return 0;
 }
 
-static bool fib_valid_key_len(u32 key, u8 plen, struct netlink_ext_ack *extack)
-{
-	if (plen > KEYLENGTH) {
-		NL_SET_ERR_MSG(extack, "Invalid prefix length");
-		return false;
-	}
-
-	if ((plen < KEYLENGTH) && (key << plen)) {
-		NL_SET_ERR_MSG(extack,
-			       "Invalid prefix for given prefix length");
-		return false;
-	}
-
-	return true;
-}
-
 static void fib_remove_alias(struct trie *t, struct key_vector *tp,
 			     struct key_vector *l, struct fib_alias *old);
 
@@ -1181,9 +1165,6 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
 
 	key = ntohl(cfg->fc_dst);
 
-	if (!fib_valid_key_len(key, plen, extack))
-		return -EINVAL;
-
 	pr_debug("Insert table=%u %08x/%d\n", tb->tb_id, key, plen);
 
 	fi = fib_create_info(cfg, extack);
@@ -1671,9 +1652,6 @@ int fib_table_delete(struct net *net, struct fib_table *tb,
 
 	key = ntohl(cfg->fc_dst);
 
-	if (!fib_valid_key_len(key, plen, extack))
-		return -EINVAL;
-
 	l = fib_find_node(t, &tp, key);
 	if (!l)
 		return -ESRCH;
-- 
2.39.5


