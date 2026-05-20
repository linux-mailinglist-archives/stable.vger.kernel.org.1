Return-Path: <stable+bounces-252286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJHYBUL5DWqR5AUAu9opvQ
	(envelope-from <stable+bounces-252286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:11:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E05957DD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66DD030C26F6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36563FB7EE;
	Wed, 20 May 2026 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rJf46wA9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620563F9F2A;
	Wed, 20 May 2026 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300278; cv=none; b=sw+LSZjL61NLwDLwN6hMhMC7F0v4z3khRaS7oks2ffvTzDRaiACQ6FvOckCY1B5LNfmpApZWVY+nylrBK04dcT7mu+bJqY0bZrZusGTHQRUV4gyc1nf8vu++HJNopmexBLr1zqXVtQmPXsl/Z2GdYG42BHqBxW9GWiCr9uJmJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300278; c=relaxed/simple;
	bh=qYLMSYmaGwogOjzt7NjZAFUHUZutLZpMmWFMbCdNYLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VizbyTF5lY5k7Of758FjfSgq1Xo8O1fl8PiHaoFHz1hOqYfkio78vt0+u4Y7wcqumIQPXE1Qe8f2+6HfrhgRiUAAOox0rYAaDcRWFw9dXyivSMyEimqMoG62RCSZVYznK3RthVQ8jLWe+IZp0M9Yo039pzPau7N2TLbU64vMfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rJf46wA9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D1F1F00893;
	Wed, 20 May 2026 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300277;
	bh=qz2KiXm6QaxVrE/g4lBw/e765ohW8Moq1VLC6WiZtTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rJf46wA9eUgt+B0A/cZnrjaVHSZmCq3sqCuHdd4IfRXC3I1xZY1jKpjcLB/TTAR3v
	 20MMkniFWdKwe0u3I8GG0ptsr5ZyhRm13cHNP6Am4XH4V9QPlfamBlhZA6mxs7jIWn
	 phhh+d78Qocu1qpgJFfYd9099Qi+2KeXKMMorZt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 113/666] ipv6: udp: fix typos in comments
Date: Wed, 20 May 2026 18:15:24 +0200
Message-ID: <20260520162113.670322432@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252286-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 883E05957DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit ac36dea3bc85c2cde87e490736708032328dfbdc ]

Correct typos in ipv6/udp.c comments:
"execeeds" -> "exceeds"
"tacking care" -> "taking care"
"measureable" -> "measurable"

No functional changes.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250909122611.3711859-1-alok.a.tiwari@oracle.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: b80a95ccf160 ("udp: Force compute_score to always inline")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/udp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 9b93df668025d..bfda1f318b779 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -248,7 +248,7 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
 
 			/* compute_score is too long of a function to be
 			 * inlined, and calling it again here yields
-			 * measureable overhead for some
+			 * measurable overhead for some
 			 * workloads. Work around it by jumping
 			 * backwards to rescore 'result'.
 			 */
@@ -364,7 +364,7 @@ struct sock *udp6_lib_lookup(const struct net *net, const struct in6_addr *saddr
 EXPORT_SYMBOL_GPL(udp6_lib_lookup);
 #endif
 
-/* do not use the scratch area len for jumbogram: their length execeeds the
+/* do not use the scratch area len for jumbogram: their length exceeds the
  * scratch area space; note that the IP6CB flags is still in the first
  * cacheline, so checking for jumbograms is cheap
  */
@@ -964,7 +964,7 @@ static void udp6_sk_rx_dst_set(struct sock *sk, struct dst_entry *dst)
 		sk->sk_rx_dst_cookie = rt6_get_cookie(dst_rt6_info(dst));
 }
 
-/* wrapper for udp_queue_rcv_skb tacking care of csum conversion and
+/* wrapper for udp_queue_rcv_skb taking care of csum conversion and
  * return code conversion for ip layer consumption
  */
 static int udp6_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
-- 
2.53.0




