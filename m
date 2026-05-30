Return-Path: <stable+bounces-259159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K0wO2oyG2qqAAkAu9opvQ
	(envelope-from <stable+bounces-259159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:54:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C997612C72
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB35302E91C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8E41D63E4;
	Sat, 30 May 2026 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pz3zj/xQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72421E098;
	Sat, 30 May 2026 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166809; cv=none; b=ks7rl/x5lZpSsSSiXSDWfJyJ2iRqbRmbTFpS4pMhT7f5cmpNlevTwA6Jy+X2Kk/aSmjPdKBXNWqTAQ0SShkOWoX00nRWeTpNj3Z057DWJLFDz1dZneU381barUMgz2IhBkT0Oeeqf8wkpVhz+dH4qKPGcxS42VJOcZnzUe6xqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166809; c=relaxed/simple;
	bh=AC2DZUhWbolS6CerdNKCWQf++Lcarejz2hkFMsuOQqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHfS/y2VzoGENrv9gVJpCL4TphsW9bdZ9/sDX9otRWq5veftCybwERX93XZVIGTw/3ueiIiCJbBUwuBIqO+GbfkHKQc/RJt3oGAev+YZRvVIQwVUvC8Ie1PWbea/y/A7y8j/8FC7hIQwDFa4v2Ionz+oxo2ANtnV7leZ3+6iPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pz3zj/xQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF971F00893;
	Sat, 30 May 2026 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166803;
	bh=R6vJleZmbiriE45vDv6ga1suhlkR13QJGLQnYEUer9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pz3zj/xQDmt3AdkQtOoiw1ch4vR+eKQSjgJBP2Pxb6wyZZx5ksmCM1xMXKZnTyCTe
	 6kQznSohmHmYpAoRxKcdqHh1Z6+0gPyDQPICcJoQz+jR5p7DCzWEwSnFOQrxRlNbLo
	 FnqqBESzGogB44XRUXSS3oJTJ713+4iwaPnbtAlg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Kito Xu (veritas501)" <hxzene@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 439/589] netfilter: nfnetlink_osf: fix potential NULL dereference in ttl check
Date: Sat, 30 May 2026 18:05:20 +0200
Message-ID: <20260530160236.247859987@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de,netfilter.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-259159-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,netfilter.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8C997612C72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernando Fernandez Mancera <fmancera@suse.de>

[ Upstream commit 711987ba281fd806322a7cd244e98e2a81903114 ]

The nf_osf_ttl() function accessed skb->dev to perform a local interface
address lookup without verifying that the device pointer was valid.

Additionally, the implementation utilized an in_dev_for_each_ifa_rcu
loop to match the packet source address against local interface
addresses. It assumed that packets from the same subnet should not see a
decrement on the initial TTL. A packet might appear it is from the same
subnet but it actually isn't especially in modern environments with
containers and virtual switching.

Remove the device dereference and interface loop. Replace the logic with
a switch statement that evaluates the TTL according to the ttl_check.

Fixes: 11eeef41d5f6 ("netfilter: passive OS fingerprint xtables match")
Reported-by: Kito Xu (veritas501) <hxzene@gmail.com>
Closes: https://lore.kernel.org/netfilter-devel/20260414074556.2512750-1-hxzene@gmail.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_osf.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 22d5d72d8250b..eee87713420dc 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -31,26 +31,18 @@ EXPORT_SYMBOL_GPL(nf_osf_fingers);
 static inline int nf_osf_ttl(const struct sk_buff *skb,
 			     int ttl_check, unsigned char f_ttl)
 {
-	struct in_device *in_dev = __in_dev_get_rcu(skb->dev);
 	const struct iphdr *ip = ip_hdr(skb);
-	const struct in_ifaddr *ifa;
-	int ret = 0;
 
-	if (ttl_check == NF_OSF_TTL_TRUE)
+	switch (ttl_check) {
+	case NF_OSF_TTL_TRUE:
 		return ip->ttl == f_ttl;
-	if (ttl_check == NF_OSF_TTL_NOCHECK)
-		return 1;
-	else if (ip->ttl <= f_ttl)
+		break;
+	case NF_OSF_TTL_NOCHECK:
 		return 1;
-
-	in_dev_for_each_ifa_rcu(ifa, in_dev) {
-		if (inet_ifa_match(ip->saddr, ifa)) {
-			ret = (ip->ttl == f_ttl);
-			break;
-		}
+	case NF_OSF_TTL_LESS:
+	default:
+		return ip->ttl <= f_ttl;
 	}
-
-	return ret;
 }
 
 struct nf_osf_hdr_ctx {
-- 
2.53.0




