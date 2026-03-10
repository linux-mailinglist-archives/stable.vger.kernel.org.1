Return-Path: <stable+bounces-224568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD/nBIR8sGnLjgIAu9opvQ
	(envelope-from <stable+bounces-224568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:18:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C62362577D7
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3500306C46D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AEB3EAC6B;
	Tue, 10 Mar 2026 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIGLZOqg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB53E9582;
	Tue, 10 Mar 2026 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173826; cv=none; b=FHOCiJA7iy97ZAJoFIPBe4upjAIJPmpMs70g4pXPGh7ex5wmPNjEWoR8OPei15+0rS+RTvRISKvzfWhZrDVgJk82UARdZhQnSnWjo5Vg4Hg2gUs1gSq8i7mnB7a6jiltAuzl7otf3w3WYpG4viJWQcIFONyj1GTpDqeG6zI8Jyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173826; c=relaxed/simple;
	bh=+JQGiOKn5ieQ6tSRJpF4SW4UAmEbQiZOI+rw+3VT6m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJx4qMoyZsEGa9+v80nswv33TISCtX78M2o9v+N9uXAvXhdO90y2I3poVwJJ1JE2+OE9HSseUuakHtkQb+pZFpvVaZUOoA4hBTsf7/HUdXk5lI/xiTWHofHRjYn046TqWF+4jn+VR50dW+y1ldrRe79yBQTG1PFe8uQdzgnw3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIGLZOqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25ABC19423;
	Tue, 10 Mar 2026 20:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773173826;
	bh=+JQGiOKn5ieQ6tSRJpF4SW4UAmEbQiZOI+rw+3VT6m0=;
	h=From:To:Cc:Subject:Date:From;
	b=bIGLZOqgnzoEQ6YDZRVpGdZxNwk/9NUoRc6gRFxjnffNq4LXepYe0Dm34fVNRmR+N
	 DIj22lX4dlXaoB/0ugGyL4StM1vr0vAgunM1aH2q+iMCNbhaK2aPK8S2uj67hwGQJa
	 EluSaWlPGlFI7eWN+qg5avSz5nYbGKFyHHnUS7A+hEgg5tvPQjM7hsh69zOtmOLuLe
	 wM+V6lFjpr/wxm7yhzjHWFe5qLbRA8GVmcGi3DF68yA0cRQP1Koda+5mvz2rDu2lkl
	 coZewgS1lp2l+oaWUOGCG8OV6mY+0ZDwrc0l1Y0XhUBC1MNPJuJrzGMtYrRHSR88oV
	 Xn9hjiXbfdJ/g==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1] net/tcp-md5: Fix MAC comparison to be constant-time
Date: Tue, 10 Mar 2026 13:17:04 -0700
Message-ID: <20260310201704.120040-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C62362577D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224568-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
index 6bef8514e29ad..fd81976d4beb7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -241,10 +241,11 @@
  *	TCP_CLOSE		socket is finished
  */
 
 #define pr_fmt(fmt) "TCP: " fmt
 
+#include <crypto/algapi.h>
 #include <crypto/hash.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
@@ -4678,11 +4679,11 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 	else
 		genhash = tp->af_specific->calc_md5_hash(newhash,
 							 hash_expected,
 							 NULL, skb);
 
-	if (genhash || memcmp(hash_location, newhash, 16) != 0) {
+	if (genhash || crypto_memneq(hash_location, newhash, 16)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
 		if (family == AF_INET) {
 			net_info_ratelimited("MD5 Hash failed for (%pI4, %d)->(%pI4, %d)%s L3 index %d\n",
 					saddr, ntohs(th->source),
 					daddr, ntohs(th->dest),
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7647f1ec0584e..00348cb9a211b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -76,10 +76,11 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/inetdevice.h>
 #include <linux/btf_ids.h>
 
+#include <crypto/algapi.h>
 #include <crypto/hash.h>
 #include <linux/scatterlist.h>
 
 #include <trace/events/tcp.h>
 
@@ -774,11 +775,11 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 		if (!key)
 			goto out;
 
 
 		genhash = tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
-		if (genhash || memcmp(hash_location, newhash, 16) != 0)
+		if (genhash || crypto_memneq(hash_location, newhash, 16))
 			goto out;
 
 	}
 
 	if (key) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 0ccaa78f6ff3d..a1e31fe596708 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -61,10 +61,11 @@
 #include <net/busy_poll.h>
 
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
+#include <crypto/algapi.h>
 #include <crypto/hash.h>
 #include <linux/scatterlist.h>
 
 #include <trace/events/tcp.h>
 
@@ -1040,11 +1041,11 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		key = tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr, l3index);
 		if (!key)
 			goto out;
 
 		genhash = tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
-		if (genhash || memcmp(hash_location, newhash, 16) != 0)
+		if (genhash || crypto_memneq(hash_location, newhash, 16))
 			goto out;
 	}
 #endif
 
 	if (th->ack)

base-commit: f2ddafa93a259310ca47507153b7811ec54ab7fd
-- 
2.53.0


