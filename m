Return-Path: <stable+bounces-246709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJE4H+XSA2ol/AEAu9opvQ
	(envelope-from <stable+bounces-246709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:24:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B98B52BDA1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 099D6301FDF4
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F23655CC;
	Wed, 13 May 2026 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="lkWyOEIW"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB736C9C2;
	Wed, 13 May 2026 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635477; cv=none; b=PqnXgNleQZU9razuDIjokvtftpGSfMPMPoNgbVd2/xvXpXZZQBBlvCdYkDRNVrB3+yCQArwPflg0w9MN58EbAz0V6ciqaJAZimAv6qSgxTPWRoQ66cMKz4/cQJDmsbswixfXnk0NUJGIBuBnjb0LFY8aakVPpfjm8fQ+r2kGvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635477; c=relaxed/simple;
	bh=MqNAlJJ/N5u/PqjyfWIdlRPLQA60IghZxqQ6X+wHNBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gRTXW2va9sU6wUxaP8J2p+pmxEVw36HHN/otfLo0DFbQhueIAhKGQXnSSGjdquH6AlXkLhNfmApeTdFAT92ei/LAyHMFbGF5aTYEjvubHNSYl/RGUtTlD7jN9qciggHW2ACAhVWcE5SCPZU7lKub7KEBQjr2zN2qFh7R1FU3THM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=lkWyOEIW; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=lkWyOEIWH4sZqsJbfl/qQwy+dcPOK612/2IIAEd3WvrE27NRk6Dp+Er/w2L+pXMPnLvXvE+2hCoTt
	 DSB7dp4PXD+Idpk5kQ/qib3jTdv53qing+PGhyyoea7ie0xi6j43YaD2aCDSKwPcwJWepyaojJboQd
	 4XdeDW4ZYMcB3P5g=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-05-12083 (RichMail) with SMTP id 2f336a03d2c28d3-08975;
	Wed, 13 May 2026 09:24:19 +0800 (CST)
X-RM-TRANSID:2f336a03d2c28d3-08975
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	ebiggers@kernel.org
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	kuba@kernel.org,
	shawn.lu@ericsson.com,
	netdev@vger.kernel.org
Subject: [PATCH 5.15.y] net/tcp-md5: Fix MAC comparison to be constant-time
Date: Wed, 13 May 2026 09:24:18 +0800
Message-Id: <20260513012418.3110859-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B98B52BDA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246709-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	NEURAL_SPAM(0.00)[0.633];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,139.com:email,139.com:mid,msgid.link:url]
X-Rspamd-Action: no action

From: Eric Biggers <ebiggers@kernel.org>

commit 46d0d6f50dab706637f4c18a470aac20a21900d3 upstream.

To prevent timing attacks, MACs need to be compared in constant
time.  Use the appropriate helper function for this.

Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
Fixes: 658ddaaf6694 ("tcp: md5: RST: getting md5 key from listener")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Link: https://patch.msgid.link/20260302203409.13388-1-ebiggers@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 net/ipv4/tcp_ipv4.c | 5 +++--
 net/ipv6/tcp_ipv6.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 43415de60d7f..7e4a9090abd7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -78,6 +78,7 @@
 #include <linux/inetdevice.h>
 #include <linux/btf_ids.h>
 
+#include <crypto/algapi.h>
 #include <crypto/hash.h>
 #include <linux/scatterlist.h>
 
@@ -763,7 +764,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 
 		genhash = tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
-		if (genhash || memcmp(hash_location, newhash, 16) != 0)
+		if (genhash || crypto_memneq(hash_location, newhash, 16))
 			goto out;
 
 	}
@@ -1467,7 +1468,7 @@ static bool tcp_v4_inbound_md5_hash(const struct sock *sk,
 				      hash_expected,
 				      NULL, skb);
 
-	if (genhash || memcmp(hash_location, newhash, 16) != 0) {
+	if (genhash || crypto_memneq(hash_location, newhash, 16)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
 		net_info_ratelimited("MD5 Hash failed for (%pI4, %d)->(%pI4, %d)%s L3 index %d\n",
 				     &iph->saddr, ntohs(th->source),
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e1ca8b73ec08..e972bbb75418 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -63,6 +63,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
+#include <crypto/algapi.h>
 #include <crypto/hash.h>
 #include <linux/scatterlist.h>
 
@@ -810,7 +811,7 @@ static bool tcp_v6_inbound_md5_hash(const struct sock *sk,
 				      hash_expected,
 				      NULL, skb);
 
-	if (genhash || memcmp(hash_location, newhash, 16) != 0) {
+	if (genhash || crypto_memneq(hash_location, newhash, 16)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
 		net_info_ratelimited("MD5 Hash %s for [%pI6c]:%u->[%pI6c]:%u L3 index %d\n",
 				     genhash ? "failed" : "mismatch",
@@ -1088,7 +1089,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 			goto out;
 
 		genhash = tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
-		if (genhash || memcmp(hash_location, newhash, 16) != 0)
+		if (genhash || crypto_memneq(hash_location, newhash, 16))
 			goto out;
 	}
 #endif
-- 
2.34.1



