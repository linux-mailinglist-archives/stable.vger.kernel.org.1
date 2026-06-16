Return-Path: <stable+bounces-265841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ovnFA6RMWqZmwUAu9opvQ
	(envelope-from <stable+bounces-265841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:08:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D5693D37
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:08:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=xWrvoVjJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265841-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265841-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D65931578B1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B43D47CE;
	Tue, 16 Jun 2026 18:08:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBF3D45CB;
	Tue, 16 Jun 2026 18:08:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633290; cv=none; b=QunWlYfELVVDVa7Wa6+Dr1/QlcfL86q+mYuVhO7EgYg9/FHObveV3/fBY02OAnGcH36lSdHw2JcLWwsP56Il/55JoBHdHH/PmAnpK6wYIRrSPMal5ofTqkr/bsc2ALwPcZnnU+hWBzlq4ON7iG6qxRay9JwveqWumTFaDClPPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633290; c=relaxed/simple;
	bh=fl1/0fg7zxQyaUDinEd8eu5WyJ1uOB/9E734HOSayhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrGqmJtuJ3U2hlNKhCZNKx2qvI+6v2s+5tpCLjPacnh4ztDKjoJjnh18LZuOcJAOqiehugVDqEr+LiJ6jE/hj5PRk8htyJmH/JkR2NvLo/Pm/bXft35WTxi30HSFlrtvEA59QMpdAZP3ZE2+DwBjQKD+418EeudVaZET/+sAjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xWrvoVjJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E351F000E9;
	Tue, 16 Jun 2026 18:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633289;
	bh=jOOUKeFIcp7orxhlrA3zBjGz4Yx43Bd1aL2UE5ijGB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xWrvoVjJMII1cBU2g9qeEvUzCnra0BmqbQMdGQhk5QvefLqh1qrfBQFO4gIh5TBNV
	 yQ4fb70bDy9+dJ0JfVc0lCxsFGoN6vX5qVj21y6wblO3SVxbW+6wNfe7yW8zRLKhPw
	 QMw9QY8Nx7qcOajL+pvLOPOXAz/Yq2UNZPe/dheM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matteo Perin <matteo.perin@canonical.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 017/411] net: netlink: dont set nsid on local notifications
Date: Tue, 16 Jun 2026 20:24:15 +0530
Message-ID: <20260616145101.305036032@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265841-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:matteo.perin@canonical.com,m:i.maximets@ovn.org,m:nicolas.dichtel@6wind.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,6wind.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ovn.org:email,canonical.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A82D5693D37

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 88b126b39f9757e9debc322d4679239e9af089c7 ]

In most cases, notifications on sockets with NETLINK_LISTEN_ALL_NSID
do not contain NSID in their ancillary data in case the event is local
to the listener.

However, when a self-referential NSID is allocated for a namespace,
every local notification starts sending this ID to the user space.

This is problematic, because the listener cannot tell if those
notifications are local or not anymore without making extra requests
to figure out if the provided NSID is local or not.  The listener
can also not figure out the local NSID beforehand as it can be
allocated at any point in time by other processes, changing the
structure of the future notifications for everyone.

The value is practically not useful, since it's the namespace's own
ID that the application has to obtain from other sources in order to
figure out if it's the same or not.  So, for the application it's
just an extra busy work with no benefits.  Moreover, applications
that do not know about this quirk may be mishandling notifications
with NSID set as notifications from remote namespaces.  This is the
case for ovs-vswitchd and the iproute2's 'ip monitor' that stops
printing 'current' and starts printing the nsid number mid-session.

Lack of clear documentation for this behavior is also not helping.

A search though open-source projects doesn't reveal any projects
that use NETNSA_NSID_NOT_ASSIGNED and rely on metadata to contain
self-referential NSIDs (expected, since the value is not useful).
Quite the opposite, as already mentioned, there are few applications
that rely on NSID to not be present in local events.

Since the value is not useful and actively harmful in some cases,
let's not report it for local events, making the notifications more
consistent.

Also adding some blank lines for readability.

Fixes: 59324cf35aba ("netlink: allow to listen "all" netns")
Reported-by: Matteo Perin <matteo.perin@canonical.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Link: https://patch.msgid.link/20260520172317.175168-3-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/af_netlink.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 12e765fcbd747d..731c53178eb559 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1482,10 +1482,14 @@ static void do_one_broadcast(struct sock *sk,
 		p->skb2 = NULL;
 		goto out;
 	}
+
 	NETLINK_CB(p->skb2).nsid_is_set = false;
-	NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
-	if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
-		NETLINK_CB(p->skb2).nsid_is_set = true;
+	if (!net_eq(sock_net(sk), p->net)) {
+		NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
+		if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
+			NETLINK_CB(p->skb2).nsid_is_set = true;
+	}
+
 	val = netlink_broadcast_deliver(sk, p->skb2);
 	if (val < 0) {
 		netlink_overrun(sk);
-- 
2.53.0




