Return-Path: <stable+bounces-259095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO0aK0cwG2p5AAkAu9opvQ
	(envelope-from <stable+bounces-259095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:45:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 588336126B9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB41330598EE
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDA621B191;
	Sat, 30 May 2026 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="orVv4GhJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039072F3C3E;
	Sat, 30 May 2026 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166596; cv=none; b=JqL3RL1Go2USyY+t9ZSom1OQc668FbsWN6bDUjDHP8wKzNSIiP0PUmieLNOxru0gTDDG7fUqeKXJ2l33UpC2hYtkhVk9g/zrY11eSQbRFxSlC1aSYYMpQKf39qAbPEy74B/b+rVxq8kPLl+y1BtqjYZpDPQ7XHM9qOUPzIsHcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166596; c=relaxed/simple;
	bh=t9xZkmdH4uqLaol+OnXyrvKUPOgUxpxkWFHkP/ZAYK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxrIEdukpxAh4drd+mC0HxrQfl/TKMwUKdKX4z3FrsoMWHf6YSKYRgzk0XvMjRH9ieUIwahgE967Ydvb62Jx0g49z7bZjMkJHBxgbyOlQ4+sG0mgvi3Iq2abE1Ih5UCaJGJ2zpHE1NEEqHaUWER5QXJMP5J/8j+xfMQz7/XuZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=orVv4GhJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6E91F00893;
	Sat, 30 May 2026 18:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166594;
	bh=7ll23bGkzhFcev5dTea9jsdQwIy0mFH14R6Tl4b4VHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=orVv4GhJ3rnOPGeroagxMZ3h6mXbg9u4X55T1n9+NPOuccx0WAnqX3jfyD3lnWYs/
	 PidrQIEz7cwNK/jlIouXHT695tPbk0GdSYl0x1eN4lCsHZp6Lwx0d9L1yQhdTsv+QG
	 byDqmtC4Cyv6NbWZeCiz5/24NVvQ/1t2MxDa2vS8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 413/589] nexthop: Emit a notification when a nexthop group is modified
Date: Sat, 30 May 2026 18:04:54 +0200
Message-ID: <20260530160235.606342984@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,nvidia.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-259095-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 588336126B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit f17bc33d7412bcca58825273d9f4abf84a87c4cb ]

When a single nexthop is replaced, the configuration of all the groups
using the nexthop is effectively modified. In this case, emit a
notification in the nexthop notification chain for each modified group
so that listeners would not need to keep track of which nexthops are
member in which groups.

The notification can only be emitted after the new configuration (i.e.,
'struct nh_info') is pointed at by the old shell (i.e., 'struct
nexthop'). Before that the configuration of the nexthop groups is still
the same as before the replacement.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 29c95185ba32 ("nexthop: fix IPv6 route referencing IPv4 nexthop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/nexthop.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 75e1c8d3bd835..29f95987b68d5 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1014,7 +1014,9 @@ static int replace_nexthop_single(struct net *net, struct nexthop *old,
 				  struct nexthop *new,
 				  struct netlink_ext_ack *extack)
 {
+	u8 old_protocol, old_nh_flags;
 	struct nh_info *oldi, *newi;
+	struct nh_grp_entry *nhge;
 	int err;
 
 	if (new->is_group) {
@@ -1044,18 +1046,29 @@ static int replace_nexthop_single(struct net *net, struct nexthop *old,
 	newi->nh_parent = old;
 	oldi->nh_parent = new;
 
+	old_protocol = old->protocol;
+	old_nh_flags = old->nh_flags;
+
 	old->protocol = new->protocol;
 	old->nh_flags = new->nh_flags;
 
 	rcu_assign_pointer(old->nh_info, newi);
 	rcu_assign_pointer(new->nh_info, oldi);
 
+	/* Send a replace notification for all the groups using the nexthop. */
+	list_for_each_entry(nhge, &old->grp_list, nh_list) {
+		struct nexthop *nhp = nhge->nh_parent;
+
+		err = call_nexthop_notifiers(net, NEXTHOP_EVENT_REPLACE, nhp,
+					     extack);
+		if (err)
+			goto err_notify;
+	}
+
 	/* When replacing an IPv4 nexthop with an IPv6 nexthop, potentially
 	 * update IPv4 indication in all the groups using the nexthop.
 	 */
 	if (oldi->family == AF_INET && newi->family == AF_INET6) {
-		struct nh_grp_entry *nhge;
-
 		list_for_each_entry(nhge, &old->grp_list, nh_list) {
 			struct nexthop *nhp = nhge->nh_parent;
 			struct nh_group *nhg;
@@ -1066,6 +1079,21 @@ static int replace_nexthop_single(struct net *net, struct nexthop *old,
 	}
 
 	return 0;
+
+err_notify:
+	rcu_assign_pointer(new->nh_info, newi);
+	rcu_assign_pointer(old->nh_info, oldi);
+	old->nh_flags = old_nh_flags;
+	old->protocol = old_protocol;
+	oldi->nh_parent = old;
+	newi->nh_parent = new;
+	list_for_each_entry_continue_reverse(nhge, &old->grp_list, nh_list) {
+		struct nexthop *nhp = nhge->nh_parent;
+
+		call_nexthop_notifiers(net, NEXTHOP_EVENT_REPLACE, nhp, extack);
+	}
+	call_nexthop_notifiers(net, NEXTHOP_EVENT_REPLACE, old, extack);
+	return err;
 }
 
 static void __nexthop_replace_notify(struct net *net, struct nexthop *nh,
-- 
2.53.0




