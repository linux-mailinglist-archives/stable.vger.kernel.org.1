Return-Path: <stable+bounces-77135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645979858B9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF5EB236C7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705F91917EE;
	Wed, 25 Sep 2024 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtqcEDFZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFC1917D9;
	Wed, 25 Sep 2024 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264281; cv=none; b=V80S31iix93j3sfTQuNUOOI7ACCHpHAn/WUyMx7l0P8pZHue6X9oIDczqrn2LFhbBWmLD7U9yilX/ejOGqwwcgcyKdvj1ePfebgAARDoplSI7cUQC1ALim/LNaWtVsATIijmwiUGGJo0zfn/rLsEjURR5MdjZmAxsxtHBQ2fq2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264281; c=relaxed/simple;
	bh=+rE0xPZY7L4gDEyJvHiUKPrjEaBZiYLydbmWeXeOb4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQTBjaE4rmECN92m3T6/Q/3ifT+AZWDviW3CV1ZzK4YkhI6Y9GwYzz2h+wMpb1id4ej5D065hnJxTBSN1HAPy1WB24cWc/rKgHT4ydCNecYWcBcIRy9bjOyjWKlPigAs7hKYv2JLPbesFIFIuGtbQXhUYTOd0f+QIvOOcwz7GVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtqcEDFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92680C4CEC7;
	Wed, 25 Sep 2024 11:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264281;
	bh=+rE0xPZY7L4gDEyJvHiUKPrjEaBZiYLydbmWeXeOb4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TtqcEDFZaMmBOYBgRllrT3+D72PZVsHog/+SuSh6tN0VQvk3HeKTaBSPNFuyPGrJ9
	 6fFwYDR8KHnfAMEGMOqpsD22PcKx/uahabNaL3lUr9QapaCDnqALDju1oGqWZ1bO52
	 VDjQ/O2OwjpocjR5hvzHkrNIsPFMLq2rtO418NfbzcmKIuIC280RzcwgmaXsC9WXt1
	 +xKVkeHHHfYsU2SaOJdWUXH72saRUMMghreNIMgac/rf4jcZNxEfmPkjWQa1Zg6Nvj
	 pPm2h0nHEegkrz8TY3O+fXMiBINkOjWltiSsS4Huwxjy1/AGAVg/4UXbepsttpaEgp
	 yZHEHrsuARcBQ==
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
Subject: [PATCH AUTOSEL 6.11 037/244] l2tp: free sessions using rcu
Date: Wed, 25 Sep 2024 07:24:18 -0400
Message-ID: <20240925113641.1297102-37-sashal@kernel.org>
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

[ Upstream commit d17e89999574aca143dd4ede43e4382d32d98724 ]

l2tp sessions may be accessed under an rcu read lock. Have them freed
via rcu and remove the now unneeded synchronize_rcu when a session is
removed.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_core.c | 4 +---
 net/l2tp/l2tp_core.h | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index a9cbcbc9d016d..edff7afc06199 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -152,7 +152,7 @@ static void l2tp_session_free(struct l2tp_session *session)
 	trace_free_session(session);
 	if (session->tunnel)
 		l2tp_tunnel_dec_refcount(session->tunnel);
-	kfree(session);
+	kfree_rcu(session, rcu);
 }
 
 struct l2tp_tunnel *l2tp_sk_to_tunnel(struct sock *sk)
@@ -1298,8 +1298,6 @@ static void l2tp_session_unhash(struct l2tp_session *session)
 
 		spin_unlock_bh(&pn->l2tp_session_idr_lock);
 		spin_unlock_bh(&tunnel->list_lock);
-
-		synchronize_rcu();
 	}
 }
 
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 6c25c196cc222..d0e3460089d90 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -67,6 +67,7 @@ struct l2tp_session_coll_list {
 struct l2tp_session {
 	int			magic;		/* should be L2TP_SESSION_MAGIC */
 	long			dead;
+	struct rcu_head		rcu;
 
 	struct l2tp_tunnel	*tunnel;	/* back pointer to tunnel context */
 	u32			session_id;
-- 
2.43.0


