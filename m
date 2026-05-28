Return-Path: <stable+bounces-255771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNn3Eu2nGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:39:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9945F93A4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E50CD33A9341
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC3622652D;
	Thu, 28 May 2026 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2bzRjXo+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430AE1EA65;
	Thu, 28 May 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999837; cv=none; b=FyzhbeAZdx33YWjryIv8q13as4Mm4U49maKKaPI3wcZZD1OPl8xbdC8ZfOWskC04aRPQRDNxkk1I/bRkJuFUwuyG+rGNX/9PFZhXSZPZK/mR7qYWU+toBsutsvk32hCOL2zXTyMgooCLwp0jNcVGsqRpG8/4tbi6XsZz1FHaJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999837; c=relaxed/simple;
	bh=QhK6moksvlDQ1KRieidy3Z3NAogC7OIG/OgNHuaKhsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmOWgFPvf0K76IhVF+c9puoYewPsRkxY4tt8qS0LZmkpKmxSev7QonDfSv8nai2jK5+momZ7RjpOiPVwjv00XqCNXBtGGd/I7pmJp6p/o6qBVYIdrYe+0XBZ9Qe2SppixIUCRO4G0QnomRu5huXNY3NbPITqX6ST9rmCyZl78UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2bzRjXo+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C061F000E9;
	Thu, 28 May 2026 20:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999836;
	bh=RXgfGRj//gmR5vPPnqMpbxHEw5czYJMxBDXsJlfRNlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2bzRjXo+phu/gtjZJ8wQS/6pct2bd59MbgyZZ5eVgqJdfsjTjYr0cs27ddv6ujmn1
	 4gXBszz2rmNAIji6lj2Hpbw7H9wC3jm9zPgs+VrrcyBAz5HS27rob8qHVsceLp0/PR
	 chs0dy0rXqZuF0xJXBRsaaowYo+F8NDhZ97CjT7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mohsin Bashir <hmohsin@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 209/377] net: shaper: Reject reparenting of existing nodes
Date: Thu, 28 May 2026 21:47:27 +0200
Message-ID: <20260528194644.454305586@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255771-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,meta.com:email]
X-Rspamd-Queue-Id: CB9945F93A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohsin Bashir <hmohsin@meta.com>

[ Upstream commit a77d5a069d959dc45f5f472d48cba37d8cba0f1c ]

When an existing node-scope shaper is moved to a different parent
via the group operation, the framework fails to update the leaves
count on both the old and new parent shapers. Only newly created
nodes (handle.id == NET_SHAPER_ID_UNSPEC) trigger the parent
leaves increment at line 1039.

This causes the parent's leaves counter to diverge from the
actual number of children in the xarray. When the node is later
deleted, pre_del_node() allocates an array sized by the stale
leaves count, but the xarray iteration finds more children than
expected, hitting the WARN_ON_ONCE guard and returning -EINVAL.

Rather than adding reparenting support with complex leaves count
bookkeeping, reject group calls that attempt to change an existing
node's parent. Updates to an existing node's rate or leaves under
the same parent remain permitted. We expect that for any modification
of the topology user should always create new groups and let the
kernel garbage collect the leaf-less nodes.

Fixes: 5d5d4700e75d ("net-shapers: implement NL group operation")
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
Link: https://patch.msgid.link/20260506233745.111895-1-mohsin.bashr@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/shaper/shaper.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index be9999ab62e39..e41a82241230d 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -964,15 +964,22 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 	int i, ret;
 
 	if (node->handle.scope == NET_SHAPER_SCOPE_NODE) {
+		struct net_shaper *cur = NULL;
+
 		new_node = node->handle.id == NET_SHAPER_ID_UNSPEC;
 
-		if (!new_node && !net_shaper_lookup(binding, &node->handle)) {
-			/* The related attribute is not available when
-			 * reaching here from the delete() op.
-			 */
-			NL_SET_ERR_MSG_FMT(extack, "Node shaper %d:%d does not exists",
-					   node->handle.scope, node->handle.id);
-			return -ENOENT;
+		if (!new_node) {
+			cur = net_shaper_lookup(binding, &node->handle);
+			if (!cur) {
+				/* The related attribute is not available
+				 * when reaching here from the delete() op.
+				 */
+				NL_SET_ERR_MSG_FMT(extack,
+						   "Node shaper %d:%d does not exist",
+						   node->handle.scope,
+						   node->handle.id);
+				return -ENOENT;
+			}
 		}
 
 		/* When unspecified, the node parent scope is inherited from
@@ -986,6 +993,15 @@ static int __net_shaper_group(struct net_shaper_binding *binding,
 				return ret;
 		}
 
+		if (cur && net_shaper_handle_cmp(&cur->parent,
+						 &node->parent)) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Cannot reparent node shaper %d:%d",
+					   node->handle.scope,
+					   node->handle.id);
+			return -EOPNOTSUPP;
+		}
+
 	} else {
 		net_shaper_default_parent(&node->handle, &node->parent);
 	}
-- 
2.53.0




