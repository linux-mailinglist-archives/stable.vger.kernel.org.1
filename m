Return-Path: <stable+bounces-224565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNlVJER8sGnLjgIAu9opvQ
	(envelope-from <stable+bounces-224565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:17:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F5257736
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E528E3009F13
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65523E92B0;
	Tue, 10 Mar 2026 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGVa6B7A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988DC35AC07;
	Tue, 10 Mar 2026 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173817; cv=none; b=q10k5tytaTMUzTMN7SrmgsNmN04qRp1KZS/DEmuLVFZK88L0LN6bZGU7cujbzJiWYrzUVzzjo0CVPZ5OMWTiHnvsVNZz4PzpvxZ8k6Hiw4TzENUKwDvg+N5NTtMsyV7LrfIPl0YEWCSBTCUbC6kKuN/p9EMfWLXE8iNCj0TL2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173817; c=relaxed/simple;
	bh=QDryLm0A/VDqj2W8rU8HNn+1Jbr6z68AoLsKNRh1KZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDE5V2rmP5HpiuiRpWVyOyP23VsohnjM5jO0vV/FPrFFll8GVzf4mViiaQfbEPYba04W6EF7ekuW+7Waj5xaBjOSTUz6rNjQtSZmGtqWNWTvgrKWdhlUYdDojkqRQIsIZrdUXb4A22BA/j+K2egOkqHyUZBjWhVcpkbZrDz1A5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGVa6B7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E352BC19423;
	Tue, 10 Mar 2026 20:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773173817;
	bh=QDryLm0A/VDqj2W8rU8HNn+1Jbr6z68AoLsKNRh1KZs=;
	h=From:To:Cc:Subject:Date:From;
	b=tGVa6B7A30oDqLz9nsTVM/GeUKg9kquDNNq/KCejKiXiR8IZEgEGalU3D4TKWCLmG
	 sgPHf++RHUneH0QBqhl6vl8gYMUcAxW/j29ZXbuFqr0e86iaPtRKOnePeVsO3nhEQe
	 6pHjDpTAXNacyyI1bxCRYlyXdjKtofrwWN7FXhK1ObxuyJmP184KXT9Fakcrup9hiH
	 lm0OcuBrQ2/ERaOLDaFICB1SuShDCZuFpWgf5HghHNkXeoORoZ62wjR2f+2qojRc1m
	 j9VluRA8Js1/Qo2Qmuw2ox0tEmia4uJMnKcmO6/OzY8qT7RO5ag51MrBwp4waRuco4
	 baDPZpyxHfXlg==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18] net/tcp-md5: Fix MAC comparison to be constant-time
Date: Tue, 10 Mar 2026 13:16:36 -0700
Message-ID: <20260310201636.119877-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C0F5257736
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224565-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

commit 46d0d6f50dab706637f4c18a470aac20a21900d3 upstream.

To prevent timing attacks, MACs need to be compared in constant
time.  Use the appropriate helper function for this.

Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
Fixes: 658ddaaf6694 ("tcp: md5: RST: getting md5 key from listener")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Link: https://patch.msgid.link/20260302203409.13388-1-ebiggers@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv4/tcp.c      | 3 ++-
 net/ipv4/tcp_ipv4.c | 3 ++-
 net/ipv6/tcp_ipv6.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e35825656e6ea..8466e77ba4b86 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -242,10 +242,11 @@
  */
 
 #define pr_fmt(fmt) "TCP: " fmt
 
 #include <crypto/hash.h>
+#include <crypto/utils.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/poll.h>
@@ -4897,11 +4898,11 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 	if (family == AF_INET)
 		genhash = tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
 	else
 		genhash = tp->af_specific->calc_md5_hash(newhash, key,
 							 NULL, skb);
-	if (genhash || memcmp(hash_location, newhash, 16) != 0) {
+	if (genhash || crypto_memneq(hash_location, newhash, 16)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
 		trace_tcp_hash_md5_mismatch(sk, skb);
 		return SKB_DROP_REASON_TCP_MD5FAILURE;
 	}
 	return SKB_NOT_DROPPED_YET;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0fbf13dcf3c2b..80c81324c8c6d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -85,10 +85,11 @@
 #include <linux/inetdevice.h>
 #include <linux/btf_ids.h>
 #include <linux/skbuff_ref.h>
 
 #include <crypto/hash.h>
+#include <crypto/utils.h>
 #include <linux/scatterlist.h>
 
 #include <trace/events/tcp.h>
 
 #ifdef CONFIG_TCP_MD5SIG
@@ -840,11 +841,11 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 		if (!key)
 			goto out;
 
 
 		genhash = tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
-		if (genhash || memcmp(md5_hash_location, newhash, 16) != 0)
+		if (genhash || crypto_memneq(md5_hash_location, newhash, 16))
 			goto out;
 
 	}
 
 	if (key) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 5faa46f4cf9a2..ac0de2c126096 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -66,10 +66,11 @@
 
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
 #include <crypto/hash.h>
+#include <crypto/utils.h>
 #include <linux/scatterlist.h>
 
 #include <trace/events/tcp.h>
 
 static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
@@ -1090,11 +1091,11 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 		if (!key.md5_key)
 			goto out;
 		key.type = TCP_KEY_MD5;
 
 		genhash = tcp_v6_md5_hash_skb(newhash, key.md5_key, NULL, skb);
-		if (genhash || memcmp(md5_hash_location, newhash, 16) != 0)
+		if (genhash || crypto_memneq(md5_hash_location, newhash, 16))
 			goto out;
 	}
 #endif
 
 	if (th->ack)

base-commit: 6258e292d7463f96d0f06dff2a39093a54c9d16f
-- 
2.53.0


