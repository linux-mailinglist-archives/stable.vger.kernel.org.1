Return-Path: <stable+bounces-256018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cABCB6uoGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:42:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B69AA5F95D0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB54D30E713F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59236313550;
	Thu, 28 May 2026 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V9yM6iaj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F300033439A;
	Thu, 28 May 2026 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000525; cv=none; b=jUYc+jd0wwN0fSupESb5077JOqBQB2TUeFZTbLFeIsCT99hL0mRKUa4mOtEN+umGWv8N1Yfhh5jQs+IT+QviruCOniMGemsVgnUCV7ecV7pBIyvqBVjdTQmE3GmsFfIZAFnqdPZlmrca8unmuFCDTVpcLgGR2/yWBLoaBoAMgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000525; c=relaxed/simple;
	bh=J0/tVuFlgoo8L2e5MxgrQYirpb8EUXklI4g3jW0z8HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agitos/REv6eWhGeclMAKU43VoUi8cucAhjvP652qfU74vgiqhHeLJbEw/KDBYgDcNPd+BJVjpxXRLzwsdcCsiS//uJXuoSYwP8oKqmsoVvbf2IcRBw76eXyszZwCoPNRfhO7yKIDirnDljmblRiI9mqgTidG9ZQ2g4N7aKdhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V9yM6iaj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D251F000E9;
	Thu, 28 May 2026 20:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000523;
	bh=vkUY86RQuUwB5STxF+xcSrGfXx9MFOWrx34wHj/QM+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V9yM6iajwvVh7ZVfpBQlDsji+WjWfBUVOq1YN3LjkvJxZmO99uyBQ6XWlaIhuPpHK
	 FeZsfQfhlMiZsw9TOK/b113EZhFjTERCmV4EWm2a2sgDYLb/imFg/lLUFze6NNI62U
	 VrPo+26ExPUemvXTSM5U14Lfjz9zQT5UxWxCPru0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Nan Li <tonanli66@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 6.12 075/272] netfilter: ipset: stop hash:* range iteration at end
Date: Thu, 28 May 2026 21:47:29 +0200
Message-ID: <20260528194631.475336711@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,netfilter.org];
	TAGGED_FROM(0.00)[bounces-256018-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lzu.edu.cn:email,netfilter.org:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B69AA5F95D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nan Li <tonanli66@gmail.com>

commit 0d3a282ab5f165fc207ff49ea5b6ad8f54616bd6 upstream.

The following hash set variants:

hash:ip,mark
hash:ip,port
hash:ip,port,ip
hash:ip,port,net

iterate IPv4 ranges with a 32-bit iterator.

The iterator must stop once the last address in the requested range has
been processed. Advancing it once more can move the traversal state past
the end of the request, so a later retry may continue from an unintended
position.

Handle the iterator increment explicitly at the end of the loop and stop
once the upper bound has been processed. This keeps the existing retry
behaviour intact for valid ranges while preventing traversal from
continuing past the original boundary.

Fixes: 48596a8ddc46 ("netfilter: ipset: Fix adding an IPv4 range containing more than 2^31 addresses")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/ipset/ip_set_hash_ipmark.c    |    6 +++++-
 net/netfilter/ipset/ip_set_hash_ipport.c    |    5 ++++-
 net/netfilter/ipset/ip_set_hash_ipportip.c  |    5 ++++-
 net/netfilter/ipset/ip_set_hash_ipportnet.c |    5 ++++-
 4 files changed, 17 insertions(+), 4 deletions(-)

--- a/net/netfilter/ipset/ip_set_hash_ipmark.c
+++ b/net/netfilter/ipset/ip_set_hash_ipmark.c
@@ -150,7 +150,7 @@ hash_ipmark4_uadt(struct ip_set *set, st
 
 	if (retried)
 		ip = ntohl(h->next.ip);
-	for (; ip <= ip_to; ip++, i++) {
+	for (; ip <= ip_to; i++) {
 		e.ip = htonl(ip);
 		if (i > IPSET_MAX_RANGE) {
 			hash_ipmark4_data_next(&h->next, &e);
@@ -162,6 +162,10 @@ hash_ipmark4_uadt(struct ip_set *set, st
 			return ret;
 
 		ret = 0;
+
+		if (ip == ip_to)
+			break;
+		ip++;
 	}
 	return ret;
 }
--- a/net/netfilter/ipset/ip_set_hash_ipport.c
+++ b/net/netfilter/ipset/ip_set_hash_ipport.c
@@ -186,7 +186,7 @@ hash_ipport4_uadt(struct ip_set *set, st
 
 	if (retried)
 		ip = ntohl(h->next.ip);
-	for (; ip <= ip_to; ip++) {
+	for (; ip <= ip_to;) {
 		p = retried && ip == ntohl(h->next.ip) ? ntohs(h->next.port)
 						       : port;
 		for (; p <= port_to; p++, i++) {
@@ -203,6 +203,9 @@ hash_ipport4_uadt(struct ip_set *set, st
 
 			ret = 0;
 		}
+		if (ip == ip_to)
+			break;
+		ip++;
 	}
 	return ret;
 }
--- a/net/netfilter/ipset/ip_set_hash_ipportip.c
+++ b/net/netfilter/ipset/ip_set_hash_ipportip.c
@@ -182,7 +182,7 @@ hash_ipportip4_uadt(struct ip_set *set,
 
 	if (retried)
 		ip = ntohl(h->next.ip);
-	for (; ip <= ip_to; ip++) {
+	for (; ip <= ip_to;) {
 		p = retried && ip == ntohl(h->next.ip) ? ntohs(h->next.port)
 						       : port;
 		for (; p <= port_to; p++, i++) {
@@ -199,6 +199,9 @@ hash_ipportip4_uadt(struct ip_set *set,
 
 			ret = 0;
 		}
+		if (ip == ip_to)
+			break;
+		ip++;
 	}
 	return ret;
 }
--- a/net/netfilter/ipset/ip_set_hash_ipportnet.c
+++ b/net/netfilter/ipset/ip_set_hash_ipportnet.c
@@ -274,7 +274,7 @@ hash_ipportnet4_uadt(struct ip_set *set,
 		p = port;
 		ip2 = ip2_from;
 	}
-	for (; ip <= ip_to; ip++) {
+	for (; ip <= ip_to;) {
 		e.ip = htonl(ip);
 		for (; p <= port_to; p++) {
 			e.port = htons(p);
@@ -298,6 +298,9 @@ hash_ipportnet4_uadt(struct ip_set *set,
 			ip2 = ip2_from;
 		}
 		p = port;
+		if (ip == ip_to)
+			break;
+		ip++;
 	}
 	return ret;
 }



