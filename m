Return-Path: <stable+bounces-95063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A095C9D7574
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324C4B3122D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93305204F72;
	Sun, 24 Nov 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnUTZDe/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B476204F67;
	Sun, 24 Nov 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455859; cv=none; b=HKNfoZiMovu3/l0JnsPzoBg7ECb7OcyBOmwNVPbYADvXDhsmwEw8+EU9oTSBUgkHa8TcXDLc4HKBGVIICuFHNMjaQCXXUgU2fcVZWCBhW1RaGErAIQPDe+J9o9j/V2m8IFoOMlrF55gWUsmsiQ9RrAoG30EJ3u4t5iRpXOzrRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455859; c=relaxed/simple;
	bh=ClsFsJLrNTgPAEbmBRcrd3cIWDFMmJTWP+glt2cjSUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4M9HwchmttQrinLXmF9RVgFC4a55yk/5xD5VnuEge0HhijMSzwTgxI6hLBgrRyUlKf+MHgcP2O/f4f+8vnv133wERGLqaxxp2z03F8Hyv2Nc2OIsTAZ9i0RKUikoVw9KMTLy0XVVLocVZ5Al/e/STeqvEFppVI//VZImXFhdb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnUTZDe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA03FC4CECC;
	Sun, 24 Nov 2024 13:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455859;
	bh=ClsFsJLrNTgPAEbmBRcrd3cIWDFMmJTWP+glt2cjSUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnUTZDe/phpZHrV45eaDeIv+ZycVxLV0lvJ/cIi13WUS1fh9Es9etkqufMERupShk
	 CJOqRq57/dji78du1zAjsl1l3Pwyusx5icbLUiMUqhEdMFeJU/+el9Aa0qrre1Ukwv
	 MdImMuNW2Wf2SjLDI4SB+dHH1WHDsVRWVxu34hgsb+5mrvT/An1N5LHKx3Nbq0qoui
	 xlQ89pWpPYHwQBuBy5Vqk7hWxKxPB29wmR3hnWRTEkL0Y44Rjoy3QGYMCire7PDWkd
	 RdxGf9ILzEQMrlrbw/nRFpHes1ze6JcFAXVH6PZOHzVtm4rfbz9Jy4hDK/7SbIx6pE
	 AFdwSGLcit3lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 60/87] net/tcp: Add missing lockdep annotations for TCP-AO hlist traversals
Date: Sun, 24 Nov 2024 08:38:38 -0500
Message-ID: <20241124134102.3344326-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Dmitry Safonov <0x7f454c46@gmail.com>

[ Upstream commit 6b2d11e2d8fc130df4708be0b6b53fd3e6b54cf6 ]

Under CONFIG_PROVE_RCU_LIST + CONFIG_RCU_EXPERT
hlist_for_each_entry_rcu() provides very helpful splats, which help
to find possible issues. I missed CONFIG_RCU_EXPERT=y in my testing
config the same as described in
a3e4bf7f9675 ("configs/debug: make sure PROVE_RCU_LIST=y takes effect").

The fix itself is trivial: add the very same lockdep annotations
as were used to dereference ao_info from the socket.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20241028152645.35a8be66@kernel.org/
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
Link: https://patch.msgid.link/20241030-tcp-ao-hlist-lockdep-annotate-v1-1-bf641a64d7c6@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp_ao.h |  3 ++-
 net/ipv4/tcp_ao.c    | 42 +++++++++++++++++++++++-------------------
 net/ipv4/tcp_ipv4.c  |  3 ++-
 net/ipv6/tcp_ipv6.c  |  4 ++--
 4 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 1d46460d0fefa..df655ce6987d3 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -183,7 +183,8 @@ int tcp_ao_hash_skb(unsigned short int family,
 		    const u8 *tkey, int hash_offset, u32 sne);
 int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
 		 sockptr_t optval, int optlen);
-struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
+struct tcp_ao_key *tcp_ao_established_key(const struct sock *sk,
+					  struct tcp_ao_info *ao,
 					  int sndid, int rcvid);
 int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 			     struct request_sock *req, struct sk_buff *skb,
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index db6516092daf5..bbb8d5f0eae7d 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -109,12 +109,13 @@ bool tcp_ao_ignore_icmp(const struct sock *sk, int family, int type, int code)
  * it's known that the keys in ao_info are matching peer's
  * family/address/VRF/etc.
  */
-struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
+struct tcp_ao_key *tcp_ao_established_key(const struct sock *sk,
+					  struct tcp_ao_info *ao,
 					  int sndid, int rcvid)
 {
 	struct tcp_ao_key *key;
 
-	hlist_for_each_entry_rcu(key, &ao->head, node) {
+	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk)) {
 		if ((sndid >= 0 && key->sndid != sndid) ||
 		    (rcvid >= 0 && key->rcvid != rcvid))
 			continue;
@@ -205,7 +206,7 @@ static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk, int l3index,
 	if (!ao)
 		return NULL;
 
-	hlist_for_each_entry_rcu(key, &ao->head, node) {
+	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk)) {
 		u8 prefixlen = min(prefix, key->prefixlen);
 
 		if (!tcp_ao_key_cmp(key, l3index, addr, prefixlen,
@@ -793,7 +794,7 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		if (!ao_info)
 			return -ENOENT;
 
-		*key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
+		*key = tcp_ao_established_key(sk, ao_info, aoh->rnext_keyid, -1);
 		if (!*key)
 			return -ENOENT;
 		*traffic_key = snd_other_key(*key);
@@ -979,7 +980,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		 */
 		key = READ_ONCE(info->rnext_key);
 		if (key->rcvid != aoh->keyid) {
-			key = tcp_ao_established_key(info, -1, aoh->keyid);
+			key = tcp_ao_established_key(sk, info, -1, aoh->keyid);
 			if (!key)
 				goto key_not_found;
 		}
@@ -1003,7 +1004,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 						   aoh->rnext_keyid,
 						   tcp_ao_hdr_maclen(aoh));
 			/* If the key is not found we do nothing. */
-			key = tcp_ao_established_key(info, aoh->rnext_keyid, -1);
+			key = tcp_ao_established_key(sk, info, aoh->rnext_keyid, -1);
 			if (key)
 				/* pairs with tcp_ao_del_cmd */
 				WRITE_ONCE(info->current_key, key);
@@ -1163,7 +1164,7 @@ void tcp_ao_established(struct sock *sk)
 	if (!ao)
 		return;
 
-	hlist_for_each_entry_rcu(key, &ao->head, node)
+	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk))
 		tcp_ao_cache_traffic_keys(sk, ao, key);
 }
 
@@ -1180,7 +1181,7 @@ void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
 	WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
 	ao->rcv_sne = 0;
 
-	hlist_for_each_entry_rcu(key, &ao->head, node)
+	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk))
 		tcp_ao_cache_traffic_keys(sk, ao, key);
 }
 
@@ -1256,14 +1257,14 @@ int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 	key_head = rcu_dereference(hlist_first_rcu(&new_ao->head));
 	first_key = hlist_entry_safe(key_head, struct tcp_ao_key, node);
 
-	key = tcp_ao_established_key(new_ao, tcp_rsk(req)->ao_keyid, -1);
+	key = tcp_ao_established_key(req_to_sk(req), new_ao, tcp_rsk(req)->ao_keyid, -1);
 	if (key)
 		new_ao->current_key = key;
 	else
 		new_ao->current_key = first_key;
 
 	/* set rnext_key */
-	key = tcp_ao_established_key(new_ao, -1, tcp_rsk(req)->ao_rcv_next);
+	key = tcp_ao_established_key(req_to_sk(req), new_ao, -1, tcp_rsk(req)->ao_rcv_next);
 	if (key)
 		new_ao->rnext_key = key;
 	else
@@ -1857,12 +1858,12 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 	 * if there's any.
 	 */
 	if (cmd.set_current) {
-		new_current = tcp_ao_established_key(ao_info, cmd.current_key, -1);
+		new_current = tcp_ao_established_key(sk, ao_info, cmd.current_key, -1);
 		if (!new_current)
 			return -ENOENT;
 	}
 	if (cmd.set_rnext) {
-		new_rnext = tcp_ao_established_key(ao_info, -1, cmd.rnext);
+		new_rnext = tcp_ao_established_key(sk, ao_info, -1, cmd.rnext);
 		if (!new_rnext)
 			return -ENOENT;
 	}
@@ -1902,7 +1903,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 	 * "It is presumed that an MKT affecting a particular
 	 * connection cannot be destroyed during an active connection"
 	 */
-	hlist_for_each_entry_rcu(key, &ao_info->head, node) {
+	hlist_for_each_entry_rcu(key, &ao_info->head, node,
+				 lockdep_sock_is_held(sk)) {
 		if (cmd.sndid != key->sndid ||
 		    cmd.rcvid != key->rcvid)
 			continue;
@@ -2000,14 +2002,14 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 	 * if there's any.
 	 */
 	if (cmd.set_current) {
-		new_current = tcp_ao_established_key(ao_info, cmd.current_key, -1);
+		new_current = tcp_ao_established_key(sk, ao_info, cmd.current_key, -1);
 		if (!new_current) {
 			err = -ENOENT;
 			goto out;
 		}
 	}
 	if (cmd.set_rnext) {
-		new_rnext = tcp_ao_established_key(ao_info, -1, cmd.rnext);
+		new_rnext = tcp_ao_established_key(sk, ao_info, -1, cmd.rnext);
 		if (!new_rnext) {
 			err = -ENOENT;
 			goto out;
@@ -2101,7 +2103,8 @@ int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen)
  * The layout of the fields in the user and kernel structures is expected to
  * be the same (including in the 32bit vs 64bit case).
  */
-static int tcp_ao_copy_mkts_to_user(struct tcp_ao_info *ao_info,
+static int tcp_ao_copy_mkts_to_user(const struct sock *sk,
+				    struct tcp_ao_info *ao_info,
 				    sockptr_t optval, sockptr_t optlen)
 {
 	struct tcp_ao_getsockopt opt_in, opt_out;
@@ -2229,7 +2232,8 @@ static int tcp_ao_copy_mkts_to_user(struct tcp_ao_info *ao_info,
 	/* May change in RX, while we're dumping, pre-fetch it */
 	current_key = READ_ONCE(ao_info->current_key);
 
-	hlist_for_each_entry_rcu(key, &ao_info->head, node) {
+	hlist_for_each_entry_rcu(key, &ao_info->head, node,
+				 lockdep_sock_is_held(sk)) {
 		if (opt_in.get_all)
 			goto match;
 
@@ -2309,7 +2313,7 @@ int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen)
 	if (!ao_info)
 		return -ENOENT;
 
-	return tcp_ao_copy_mkts_to_user(ao_info, optval, optlen);
+	return tcp_ao_copy_mkts_to_user(sk, ao_info, optval, optlen);
 }
 
 int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen)
@@ -2396,7 +2400,7 @@ int tcp_ao_set_repair(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	WRITE_ONCE(ao->snd_sne, cmd.snd_sne);
 	WRITE_ONCE(ao->rcv_sne, cmd.rcv_sne);
 
-	hlist_for_each_entry_rcu(key, &ao->head, node)
+	hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_held(sk))
 		tcp_ao_cache_traffic_keys(sk, ao, key);
 
 	return 0;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5087e12209a19..bd27495ea3b12 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1052,7 +1052,8 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			}
 
 			if (aoh)
-				key.ao_key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
+				key.ao_key = tcp_ao_established_key(sk, ao_info,
+								    aoh->rnext_keyid, -1);
 		}
 	}
 	if (key.ao_key) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 84cd46311da09..766b2d9e6d1ad 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1169,8 +1169,8 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
 				goto out;
 			if (aoh)
-				key.ao_key = tcp_ao_established_key(ao_info,
-						aoh->rnext_keyid, -1);
+				key.ao_key = tcp_ao_established_key(sk, ao_info,
+								    aoh->rnext_keyid, -1);
 		}
 	}
 	if (key.ao_key) {
-- 
2.43.0


