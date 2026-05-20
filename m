Return-Path: <stable+bounces-251995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB0WNtT4DWqq5AUAu9opvQ
	(envelope-from <stable+bounces-251995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:09:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A6C5956A1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEB0730B3E5A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EAA2F83A0;
	Wed, 20 May 2026 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AX9dpDDC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9253F20FA;
	Wed, 20 May 2026 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299470; cv=none; b=HwgxH6bZtXF8R9UiwcpjyztUZxRQw0jKkDk++V/QIkQfBHd2VrrelASvbMp6n7MTg8TlScNSP+t4eJ7fCK+LuS8wCsLOimGUoQgiZv4uy4bd1UDQJukLyvgwOyvDQg3u/Kfm21Xl6owOTTePfJpSE6eF+YDjNG8H4eLo2tBMJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299470; c=relaxed/simple;
	bh=97PEAqCIWTWZccvbZM79Jn16kf70bf+CjhoIxeazwQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crZqr8eJwukc92OAvCryhauZNG2pTot3ucyk8w3YTwoE9XmZ9gvb68Z+fVwt/FZdZjVC/+qssAXTVLcLOgg4tekvuox15wmzIudIeVlYLTTpogDniG7+FnbM2X+ZttYCJtL5ILQDjTs9v4Fs5fxYz4p3fqruOL5dz0OlbM+fBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AX9dpDDC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B851F000E9;
	Wed, 20 May 2026 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299468;
	bh=c7+1h4dAJP8baDFk1HI6ed2RSWDx+y3Ratyd3QYZnP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AX9dpDDCW4RBWYoj+3xxGs64+8xer4GyVAJStDbxpuuLNl/lF81sjsAqA3CdOYiRQ
	 3KzgeuGX9qZKPslMmHx+T9QccC/uUaaoGmh9zHiwf0veEcAzuFuwcApOsTxViU6k43
	 elHHctrAia6M4S+dlW161X4SQGYGBXkmosb4OruE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 783/957] neigh: let neigh_xmit take skb ownership
Date: Wed, 20 May 2026 18:21:06 +0200
Message-ID: <20260520162151.541794046@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251995-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,strlen.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 81A6C5956A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 4438113be604ee67a7bf4f81da6e1cca41332ce4 ]

neigh_xmit always releases the skb, except when no neighbour table is
found. But even the first added user of neigh_xmit (mpls) relied on
neigh_xmit to release the skb (or queue it for tx).

sashiko reported:
 If neigh_xmit() is called with an uninitialized neighbor table (for
 example, NEIGH_ND_TABLE when IPv6 is disabled), it returns -EAFNOSUPPORT
 and bypasses its internal out_kfree_skb error path.  Because the return
 value of neigh_xmit() is ignored here, does this leak the SKB?

Assume full ownership and remove the last code path that doesn't
xmit or free skb.

Fixes: 4fd3d7d9e868 ("neigh: Add helper function neigh_xmit")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260424145843.74055-1-fw@strlen.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6dab4d1c2263d..dabd368eaa4e7 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3182,8 +3182,10 @@ int neigh_xmit(int index, struct net_device *dev,
 
 		rcu_read_lock();
 		tbl = rcu_dereference(neigh_tables[index]);
-		if (!tbl)
-			goto out_unlock;
+		if (!tbl) {
+			rcu_read_unlock();
+			goto out_kfree_skb;
+		}
 		if (index == NEIGH_ARP_TABLE) {
 			u32 key = *((u32 *)addr);
 
@@ -3199,7 +3201,6 @@ int neigh_xmit(int index, struct net_device *dev,
 			goto out_kfree_skb;
 		}
 		err = READ_ONCE(neigh->output)(neigh, skb);
-out_unlock:
 		rcu_read_unlock();
 	}
 	else if (index == NEIGH_LINK_TABLE) {
@@ -3209,11 +3210,10 @@ int neigh_xmit(int index, struct net_device *dev,
 			goto out_kfree_skb;
 		err = dev_queue_xmit(skb);
 	}
-out:
 	return err;
 out_kfree_skb:
 	kfree_skb(skb);
-	goto out;
+	return err;
 }
 EXPORT_SYMBOL(neigh_xmit);
 
-- 
2.53.0




