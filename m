Return-Path: <stable+bounces-77136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8967A9858C2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8901C20FCB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F19B191F86;
	Wed, 25 Sep 2024 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtxJTuY1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB4191F80;
	Wed, 25 Sep 2024 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264284; cv=none; b=HIo5lhTBS1vhWnD4fJArRAdMJe/BgnZFdrtS8W52Exp6LpTR3d22LyAeKtGfJdIaHOYRNIT4Zw7e0IsFEn3TP+pYjFKy5Rowuivp4aBYWaX+ecbb607fe/2nfVd307l/cDuUhCgGc89egrjANasORcQ6DfVN/AG2il41vqeyhrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264284; c=relaxed/simple;
	bh=y12zO8TDcNx/hFrD6UoE77jTeDKPPhtLoiWZkoHKFBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0TmhSAiUMzDVyH0xEq+MtOq1MrlPf+Vb8SZh8Qs51RqMFCIEYtYV+F1ocIp7Rznpl7ZLAmn3g7wef/j+3Wx1TFkq4iUSEQibXnT8HygyUQIehedGVU8ycUBzEuGtuzXHR4R/jkUWsFcqRARQQ0Xp4tmNG/wJgAkw1aETMYGd8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtxJTuY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E93C4CEC7;
	Wed, 25 Sep 2024 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264284;
	bh=y12zO8TDcNx/hFrD6UoE77jTeDKPPhtLoiWZkoHKFBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtxJTuY1AGrzYFTqzmhcOBFOmQapP73xRXXd3KDpW6B8VRQJuqIbbol0Z2WQYnaUg
	 Y5p+Sl0eAgTX+k2J+DzeyN5uFY3MjF7iIWGvnAzlaEC8sBJJbSpc9rVaY2dhXJ3MVa
	 QJBSIsPUezF2+NfXNq5tZvFvintlsC+JBbssCpX3SDKzEcXvKfFTx5S/aaa6n5iNnS
	 o5/ehqv5Z8Dmo5ZzacOJzjXOOL3IJrM0JtOqcCQdRZoL9ACdwDHdvWjyOsYcF8FED1
	 lChl6Zctrw/fPI3WHJkCOkfGYN9ce4mARDeSZEd1RXbCAnyj3WrGcC9rnSq6ZYlo4i
	 MqRauhzFapTDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	samuel.thibault@ens-lyon.org,
	thorsten.blum@toblux.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 038/244] l2tp: use rcu list add/del when updating lists
Date: Wed, 25 Sep 2024 07:24:19 -0400
Message-ID: <20240925113641.1297102-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: James Chapman <jchapman@katalix.com>

[ Upstream commit 89b768ec2dfefaeba5212de14fc71368e12d06ba ]

l2tp_v3_session_htable and tunnel->session_list are read by lockless
getters using RCU. Use rcu list variants when adding or removing list
items.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index edff7afc06199..ee8133f77b64c 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -394,12 +394,12 @@ static int l2tp_session_collision_add(struct l2tp_net *pn,
 
 	/* If existing session isn't already in the session hlist, add it. */
 	if (!hash_hashed(&session2->hlist))
-		hash_add(pn->l2tp_v3_session_htable, &session2->hlist,
-			 session2->hlist_key);
+		hash_add_rcu(pn->l2tp_v3_session_htable, &session2->hlist,
+			     session2->hlist_key);
 
 	/* Add new session to the hlist and collision list */
-	hash_add(pn->l2tp_v3_session_htable, &session1->hlist,
-		 session1->hlist_key);
+	hash_add_rcu(pn->l2tp_v3_session_htable, &session1->hlist,
+		     session1->hlist_key);
 	refcount_inc(&clist->ref_count);
 	l2tp_session_coll_list_add(clist, session1);
 
@@ -415,7 +415,7 @@ static void l2tp_session_collision_del(struct l2tp_net *pn,
 
 	lockdep_assert_held(&pn->l2tp_session_idr_lock);
 
-	hash_del(&session->hlist);
+	hash_del_rcu(&session->hlist);
 
 	if (clist) {
 		/* Remove session from its collision list. If there
@@ -490,7 +490,7 @@ int l2tp_session_register(struct l2tp_session *session,
 
 	l2tp_tunnel_inc_refcount(tunnel);
 	WRITE_ONCE(session->tunnel, tunnel);
-	list_add(&session->list, &tunnel->session_list);
+	list_add_rcu(&session->list, &tunnel->session_list);
 
 	if (tunnel->version == L2TP_HDR_VER_3) {
 		if (!other_session)
-- 
2.43.0


