Return-Path: <stable+bounces-225869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA4OIIZDuWkk+QEAu9opvQ
	(envelope-from <stable+bounces-225869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:05:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E632A97BF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E3DC3052B9D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47DB3AE1B2;
	Tue, 17 Mar 2026 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oTUIOQTM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C1FC0A
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748920; cv=none; b=VNVQHnhekJrwOeTggZG8cqTQGKKfE9v2YBY97QJIKgnvanfze9WvUB3nzESHYkBGurcZJkh8x89fV0l2Ao8hLuq1Vos+Nz1TRKCwzn76akbNp2NhZsmiYC8H6e0cSUG5Yk8VutwuDWn4OBb+B0zGYTPcf7sehYqMeVQNBlQuoOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748920; c=relaxed/simple;
	bh=HqFTRDaOnTPsjn3b1qx0cuUXinn4rfSVjzgvQ/fsXQ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eB2+fKO/GOpvdItgzLURG2MmBva7CEXDVfxkes/b5lbIgcs2V3P8UXJSxIGPJP5D1lNb4aJHqI5UY8E7yN51HAyMtiBSoRMJfQF2s8hrYxC9OhyfOwwFrmZccGkOYJ1SToc0U40G4SolMucbohy98w3UHVqZFIAlMi/Cj8dx6kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oTUIOQTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFF3C4CEF7;
	Tue, 17 Mar 2026 12:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773748920;
	bh=HqFTRDaOnTPsjn3b1qx0cuUXinn4rfSVjzgvQ/fsXQ8=;
	h=Subject:To:Cc:From:Date:From;
	b=oTUIOQTMneMeGCnBbi7XpcttVymo/Ca0BWTexSVjgk6ZTKw7M7J49Q2zrQm1CWHTL
	 IbKh/DMmpH0lTQtdeUQvjgXxd2+H4q6dralL1IWbXR3+tXvj0XuCSS3DW1QPYojHXn
	 oIAZU7xZ+n539QiH+jDNoUdIdPOKwBWdIDWIMZEM=
Subject: FAILED: patch "[PATCH] net/tcp-md5: Fix MAC comparison to be constant-time" failed to apply to 6.18-stable tree
To: ebiggers@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:01:56 +0100
Message-ID: <2026031756-likewise-lumpiness-6c88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225869-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 05E632A97BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 46d0d6f50dab706637f4c18a470aac20a21900d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031756-likewise-lumpiness-6c88@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46d0d6f50dab706637f4c18a470aac20a21900d3 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 2 Mar 2026 12:34:09 -0800
Subject: [PATCH] net/tcp-md5: Fix MAC comparison to be constant-time

To prevent timing attacks, MACs need to be compared in constant
time.  Use the appropriate helper function for this.

Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
Fixes: 658ddaaf6694 ("tcp: md5: RST: getting md5 key from listener")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Link: https://patch.msgid.link/20260302203409.13388-1-ebiggers@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 3ab6247be585..df922f9f5289 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -762,6 +762,7 @@ config TCP_AO
 config TCP_MD5SIG
 	bool "TCP: MD5 Signature Option support (RFC2385)"
 	select CRYPTO_LIB_MD5
+	select CRYPTO_LIB_UTILS
 	help
 	  RFC2385 specifies a method of giving MD5 protection to TCP sessions.
 	  Its main (only?) use is to protect BGP sessions between core routers
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8cdc26e8ad68..202a4e57a218 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -244,6 +244,7 @@
 #define pr_fmt(fmt) "TCP: " fmt
 
 #include <crypto/md5.h>
+#include <crypto/utils.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -4970,7 +4971,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 		tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
 	else
 		tp->af_specific->calc_md5_hash(newhash, key, NULL, skb);
-	if (memcmp(hash_location, newhash, 16) != 0) {
+	if (crypto_memneq(hash_location, newhash, 16)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
 		trace_tcp_hash_md5_mismatch(sk, skb);
 		return SKB_DROP_REASON_TCP_MD5FAILURE;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d53d39be291a..910c25cb24e1 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -88,6 +88,7 @@
 #include <linux/skbuff_ref.h>
 
 #include <crypto/md5.h>
+#include <crypto/utils.h>
 
 #include <trace/events/tcp.h>
 
@@ -839,7 +840,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 			goto out;
 
 		tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
-		if (memcmp(md5_hash_location, newhash, 16) != 0)
+		if (crypto_memneq(md5_hash_location, newhash, 16))
 			goto out;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e46a0efae012..5195a46b951e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -68,6 +68,7 @@
 #include <linux/seq_file.h>
 
 #include <crypto/md5.h>
+#include <crypto/utils.h>
 
 #include <trace/events/tcp.h>
 
@@ -1048,7 +1049,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 		key.type = TCP_KEY_MD5;
 
 		tcp_v6_md5_hash_skb(newhash, key.md5_key, NULL, skb);
-		if (memcmp(md5_hash_location, newhash, 16) != 0)
+		if (crypto_memneq(md5_hash_location, newhash, 16))
 			goto out;
 	}
 #endif


