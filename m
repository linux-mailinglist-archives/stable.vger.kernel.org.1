Return-Path: <stable+bounces-252725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELidCM4oDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-252725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:34:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D8459B059
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 566A8370F2FD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E923F1ACA;
	Wed, 20 May 2026 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VyH9Zjem"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6E3FB060;
	Wed, 20 May 2026 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301426; cv=none; b=Tf+2a42+igXSs0SlatfP3eCo6FZWB90B5gE+IJCIhDUPXNHQRVFxEjnQINBXVPenLPZkg/9kPhkpE1ba2WOuGoFkI3bRTPYq3x/fpmcKK2QYr+To3KNE4mjTU6+JQJMeiavZAfj7XvpQUFEx9rIHpdFlcY77Y68LPD1lFzC8xuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301426; c=relaxed/simple;
	bh=bsO7srdbtsFFI2b3eAWj08jpDSJGtUQojmsGzsFN1Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNkxu0MbjSxu1TSwfkAXlO10/lXdhZ5I4KfQMdX49FOZFOKC1im/P54xR9nLTce8FaOxiA2zDXbepaaTjXLEDP+0BiEaQGyiCTu2fccoTLpCpD4EyezGZOeS0vPz0/bBcfzJUuSrQzOznlfEUjnGnR0Afw0NHMSMMsepo3XZ1o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VyH9Zjem; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7B71F00898;
	Wed, 20 May 2026 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301425;
	bh=JLmuabpAWU5/0/LT8oBXQIcP9iuphJ1ryNTGrX78EQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VyH9ZjemEQkQ7FNxiGAhJglZGcLMe6Vp8sY2c+65Z6N1fUXlz3az9OC9W+aRfaQ0u
	 jDKDo2j9zVxjbtiilPB7OlR+W5BGuoPkWoofDBs6zmBtZeMrp6wishrmXzb7kxYoTH
	 ZTVM5J+/vqqlf6zNkZRtMoQIfYMxSsIK3FOaXmw0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 549/666] netpoll: extract IPv4 address retrieval into helper function
Date: Wed, 20 May 2026 18:22:40 +0200
Message-ID: <20260520162123.168615541@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252725-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 68D8459B059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 3699f992e8c22d3ce54d2c1a5774e2c49028f99c ]

Move the IPv4 address retrieval logic from netpoll_setup() into a
separate netpoll_take_ipv4() function to improve code organization
and readability. This change consolidates the IPv4-specific logic
and error handling into a dedicated function while maintaining
the same functionality.

No functional changes.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250618-netpoll_ip_ref-v1-2-c2ac00fe558f@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 3bc179bc7146 ("netpoll: fix IPv6 local-address corruption")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 48 ++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a9c38f75b00ec..b5305ff217a8b 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -721,13 +721,41 @@ static void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev,
 	}
 }
 
+/*
+ * Take the IPv4 from ndev and populate local_ip structure in netpoll
+ */
+static int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev)
+{
+	char buf[MAC_ADDR_STR_LEN + 1];
+	const struct in_ifaddr *ifa;
+	struct in_device *in_dev;
+
+	in_dev = __in_dev_get_rtnl(ndev);
+	if (!in_dev) {
+		np_err(np, "no IP address for %s, aborting\n",
+		       egress_dev(np, buf));
+		return -EDESTADDRREQ;
+	}
+
+	ifa = rtnl_dereference(in_dev->ifa_list);
+	if (!ifa) {
+		np_err(np, "no IP address for %s, aborting\n",
+		       egress_dev(np, buf));
+		return -EDESTADDRREQ;
+	}
+
+	np->local_ip.ip = ifa->ifa_local;
+	np_info(np, "local IP %pI4\n", &np->local_ip.ip);
+
+	return 0;
+}
+
 int netpoll_setup(struct netpoll *np)
 {
 	struct net *net = current->nsproxy->net_ns;
 	char buf[MAC_ADDR_STR_LEN + 1];
 	struct net_device *ndev = NULL;
 	bool ip_overwritten = false;
-	struct in_device *in_dev;
 	int err;
 
 	rtnl_lock();
@@ -767,24 +795,10 @@ int netpoll_setup(struct netpoll *np)
 
 	if (!np->local_ip.ip) {
 		if (!np->ipv6) {
-			const struct in_ifaddr *ifa;
-
-			in_dev = __in_dev_get_rtnl(ndev);
-			if (!in_dev)
-				goto put_noaddr;
-
-			ifa = rtnl_dereference(in_dev->ifa_list);
-			if (!ifa) {
-put_noaddr:
-				np_err(np, "no IP address for %s, aborting\n",
-				       egress_dev(np, buf));
-				err = -EDESTADDRREQ;
+			err = netpoll_take_ipv4(np, ndev);
+			if (err)
 				goto put;
-			}
-
-			np->local_ip.ip = ifa->ifa_local;
 			ip_overwritten = true;
-			np_info(np, "local IP %pI4\n", &np->local_ip.ip);
 		} else {
 #if IS_ENABLED(CONFIG_IPV6)
 			struct inet6_dev *idev;
-- 
2.53.0




