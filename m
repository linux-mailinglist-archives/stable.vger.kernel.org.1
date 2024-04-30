Return-Path: <stable+bounces-42347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0849F8B728B
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0071C2303E
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852DB12D1FA;
	Tue, 30 Apr 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="REKGNyJP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9512CD90;
	Tue, 30 Apr 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475365; cv=none; b=d3RqEK5weUC26GeNHKzN3D0S1zLUk+AWkEmlGVD5nxrQOKde/c1ybn82wHxotfEaVv6F7dKM6oGE1pqmNH1HXcLXpxovsgoW+U658Fd7goqKio3QkGn0XGKyM+2trA2ziYRN2HXLiXjhlFN/oJnwLK1BQD+YJ7lnRPHdCFNFt4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475365; c=relaxed/simple;
	bh=961r8gkZMsdGWHPT8L2iYSCckXvDoBJZoQuEz3PEgIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llNZ/YVOaBcrPr/0cDAPzc9wdFrxwK7jJd3daJu429BGnhHcPSQAeEfUu2Ui066ApJE9fOcGKK6Aa10xC/MFlap7BOVxAiK2uYGoBBUJ+B1lJwmgDU6kBgJg4Gil7JGmwih0vpy9AsmSoQhvG9tdtjSrv1Kr+xK3Hx73wC09LA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=REKGNyJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE892C2BBFC;
	Tue, 30 Apr 2024 11:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475365;
	bh=961r8gkZMsdGWHPT8L2iYSCckXvDoBJZoQuEz3PEgIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REKGNyJPlX35puFWuli+66TaQCzXzYIDkI/K9eFz2JCs4t3X/Gur8Tt+zmcwpEf8V
	 1AkxJG0Ivhl6L3nPL8+LaXa1O2yXeIk6WDeOHjYJ2RL+tp6RRH0r+kW8tIxK0X+Etu
	 emtoaRYCqjzey2hqxAQRu7P4UzxxV7OdVIEO6v+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <v4bel@theori.io>,
	Eric Dumazet <edumazet@google.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 073/186] net: openvswitch: Fix Use-After-Free in ovs_ct_exit
Date: Tue, 30 Apr 2024 12:38:45 +0200
Message-ID: <20240430103100.158108462@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunwoo Kim <v4bel@theori.io>

[ Upstream commit 5ea7b72d4fac2fdbc0425cd8f2ea33abe95235b2 ]

Since kfree_rcu, which is called in the hlist_for_each_entry_rcu traversal
of ovs_ct_limit_exit, is not part of the RCU read critical section, it
is possible that the RCU grace period will pass during the traversal and
the key will be free.

To prevent this, it should be changed to hlist_for_each_entry_safe.

Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://lore.kernel.org/r/ZiYvzQN/Ry5oeFQW@v4bel-B760M-AORUS-ELITE-AX
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/conntrack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 74b63cdb59923..2928c142a2ddb 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1593,9 +1593,9 @@ static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
 		struct hlist_head *head = &info->limits[i];
 		struct ovs_ct_limit *ct_limit;
+		struct hlist_node *next;
 
-		hlist_for_each_entry_rcu(ct_limit, head, hlist_node,
-					 lockdep_ovsl_is_held())
+		hlist_for_each_entry_safe(ct_limit, next, head, hlist_node)
 			kfree_rcu(ct_limit, rcu);
 	}
 	kfree(info->limits);
-- 
2.43.0




