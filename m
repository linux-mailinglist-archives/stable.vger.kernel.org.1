Return-Path: <stable+bounces-140020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0923AAA3E0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FB616E2EF
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE192F8DEA;
	Mon,  5 May 2025 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm85iy1I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391DC2F8DE0;
	Mon,  5 May 2025 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483928; cv=none; b=iuzA1f3685Qi827+0JO0GcfGszIPTTkgF3rxRXCyYn1u83kz0buzZIz0blKuDezs/7DOhtHuOtC6jRkSn3TkP2GIBAiQ49h+OVuh2zsINP5tkpmbGuVJtocyDqeF83Pf6H/R95+6kIHzaWaUVWBP6YBmsg0w0Iss96O8shPqHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483928; c=relaxed/simple;
	bh=R59kCnJjiCPA0MC84qR3zibb+XfB2hs5mE1ghbwXHkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HHJBaMa1UTf7DXzQ/mnazMpEk+D4HboJwb4z3ursHehALZdeht/oxeSb+bVW/I/yvYani9NplmklTH0SGpmFPYPgUWfEruLlmM2Lsa6x3iF3xz59Bhe5VGiUJpDtQBUMeL4a8H4jdFgflmyLXczsFNCEwPI3aHLwqohSmMQn3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm85iy1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741B5C4CEED;
	Mon,  5 May 2025 22:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483927;
	bh=R59kCnJjiCPA0MC84qR3zibb+XfB2hs5mE1ghbwXHkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bm85iy1IKKDBpS9AfmPLKbzFyZYa7ZZ9MWqSzw7HnNbGnXuo69v7dH0AtyR/ZKNAO
	 SXmI8zO5xnctfsL4P2GCSSB+fjYhXXJu9cmXY5U5fKvAeDs4sUC8P66boxjwBXcCCa
	 VOnG4hkqGEG3eSfqYAU6Z4RTlkHSRBw3kUxL0wlxIcxO4z20Y/QQuaEN2uu5R8EHOj
	 0dsAbeberhKuBBiB5XKYcz3Gk0viN2n5keIGS4IlzRbBBKSnEJK7+cNJxzwCUI1NWV
	 uyZW2ICi824koK5EolKCvwTrdl+IOrlaJ2ViGNqieRZLHWMyRicUVFr390cbE6c1GV
	 +zcTiMFRXXP+A==
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
Subject: [PATCH AUTOSEL 6.14 273/642] ipv4: fib: Move fib_valid_key_len() to rtm_to_fib_config().
Date: Mon,  5 May 2025 18:08:09 -0400
Message-Id: <20250505221419.2672473-273-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 272e42d813230..493c37ce232d3 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -837,19 +837,33 @@ static int rtm_to_fib_config(struct net *net, struct sk_buff *skb,
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
index d6411ac810961..59a6f0a9638f9 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1187,22 +1187,6 @@ static int fib_insert_alias(struct trie *t, struct key_vector *tp,
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
 
@@ -1223,9 +1207,6 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
 
 	key = ntohl(cfg->fc_dst);
 
-	if (!fib_valid_key_len(key, plen, extack))
-		return -EINVAL;
-
 	pr_debug("Insert table=%u %08x/%d\n", tb->tb_id, key, plen);
 
 	fi = fib_create_info(cfg, extack);
@@ -1717,9 +1698,6 @@ int fib_table_delete(struct net *net, struct fib_table *tb,
 
 	key = ntohl(cfg->fc_dst);
 
-	if (!fib_valid_key_len(key, plen, extack))
-		return -EINVAL;
-
 	l = fib_find_node(t, &tp, key);
 	if (!l)
 		return -ESRCH;
-- 
2.39.5


