Return-Path: <stable+bounces-261004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HdT/N/NDJWqNFQIAu9opvQ
	(envelope-from <stable+bounces-261004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:12:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B37264F65C
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:12:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=zR2QpNd0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261004-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261004-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74F7D3049294
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A412E1EFC;
	Sun,  7 Jun 2026 10:08:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E79B1E98E3;
	Sun,  7 Jun 2026 10:08:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826935; cv=none; b=YkH/JlKrSgBz0art3d9+vy0VMiwEh2hx+J7XbVOCUU7ENQMM0G/aNouHdkDQt2MH0r1YPHcww7Wn7Rr2W6sNT2qkGsi4MOYkz9BueI3FbP6TkczHKGsE89H3AT5BrasymNPf0WDrjyK+3diXXHmuzRuQRNTckUYl9gr168EMlg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826935; c=relaxed/simple;
	bh=Rs1yvi0p62zRfDwB63SYcVQuyeJWBiU6xGVSARRGkJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeSoyiHgo+FxCcV5a28UYg/9YFlMUluwIs6+u8upXHTQwdgs4Y6yaWWyV8RzMiqlywmh8X+r55HFUFycsW7S0QM1925gpEqi+UWjZNw/HsoSJbFmlerxhs34m0FxOeqcJe36RDWpxty0dircG5AGiREgllQAR95RKCLOA8vBcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zR2QpNd0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEE51F00893;
	Sun,  7 Jun 2026 10:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826934;
	bh=r1PgPzvhpf/0JF0LtcUIqFN4IPsVKz5CMtkfF1bDMCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zR2QpNd0ol+fckad6sTgakm/B/cmdu/Zz2t51nwcqO2VT7Bm8lq+VrrDQS10Pnpv1
	 vabVA7e6sJVKYl51HyxtX2RMozCOcwkBckO6YIqmrxQ9xftyP28m1qf0H3lny6joUP
	 jA4Rg2T39n9/D4KGSqyS23ln+mTnV78AR1jTFLL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matteo Perin <matteo.perin@canonical.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 024/315] net: netlink: dont set nsid on local notifications
Date: Sun,  7 Jun 2026 11:56:51 +0200
Message-ID: <20260607095728.380457890@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-261004-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,6wind.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,ovn.org:email,vger.kernel.org:from_smtp,canonical.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B37264F65C

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 0e6dfd01d9b419..1d1b3bd54a916b 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1484,10 +1484,14 @@ static void do_one_broadcast(struct sock *sk,
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




