Return-Path: <stable+bounces-123870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE6CA5C7F9
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38023BD17D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A3725B691;
	Tue, 11 Mar 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jvLV/qMf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241E25E83F;
	Tue, 11 Mar 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707199; cv=none; b=pAovl/OrEGTomaGi38FRonoiQBcaZ0qklD40VSgS0JijkWwjrJ9GVrdOc6CISF6S1zSiWgpahvIATd/R4oucTwDkhxG0VRQcxbhuNLXq8E+GMr5VFCBapadoHcHSC0joHxUiKBdbB+01d6GExjlT+QSAnHAN3vh1/XR9sXSFE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707199; c=relaxed/simple;
	bh=MCqwH3mV4tj+FfJtnhU86SiwE0li2LEuzK+uGsmH31c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJVJrAZ72+ot2M+onT4606oDu6/xKWxVIzLXomYhYzFNJoa3ef/BhcBJby5hLkttRXCxD9eV3SKZs7VWRuUJ+0JwfSiIuSJ1+bkBmmTFX7qEMaDJ2iI2SgppcdGZqZB+JBjW6i9a0cZwp26PqFBzvJ5bNdQTAegig+ZcYrXU2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jvLV/qMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB57C4CEE9;
	Tue, 11 Mar 2025 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741707199;
	bh=MCqwH3mV4tj+FfJtnhU86SiwE0li2LEuzK+uGsmH31c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvLV/qMfeAJbtSnacTa9Y67EhcwwAJjT8nviK5qTHB1USYJIMyR3m7CdBJDOTP/Ij
	 9dpzG7j4Z+ig1u6oQoQSrCfatybsmCRBsyWZxPDIEyY00OCKgp/FscJK3Y6z+5HMC8
	 LgQMG4VJSEhUgTXmEwBEQi+auYHgJmJ4E5YFhKvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 280/462] net: add dev_net_rcu() helper
Date: Tue, 11 Mar 2025 15:59:06 +0100
Message-ID: <20250311145809.432469354@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 482ad2a4ace2740ca0ff1cbc8f3c7f862f3ab507 ]

dev->nd_net can change, readers should either
use rcu_read_lock() or RTNL.

We currently use a generic helper, dev_net() with
no debugging support. We probably have many hidden bugs.

Add dev_net_rcu() helper for callers using rcu_read_lock()
protection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250205155120.1676781-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: dd205fcc33d9 ("ipv4: use RCU protection in rt_is_expired()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h   | 6 ++++++
 include/net/net_namespace.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3380668478e8a..06b37f45b67c9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2361,6 +2361,12 @@ struct net *dev_net(const struct net_device *dev)
 	return read_pnet(&dev->nd_net);
 }
 
+static inline
+struct net *dev_net_rcu(const struct net_device *dev)
+{
+	return read_pnet_rcu(&dev->nd_net);
+}
+
 static inline
 void dev_net_set(struct net_device *dev, struct net *net)
 {
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 0dfcf2f0ef62a..3cf6a5c17b84c 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -340,7 +340,7 @@ static inline struct net *read_pnet(const possible_net_t *pnet)
 #endif
 }
 
-static inline struct net *read_pnet_rcu(possible_net_t *pnet)
+static inline struct net *read_pnet_rcu(const possible_net_t *pnet)
 {
 #ifdef CONFIG_NET_NS
 	return rcu_dereference(pnet->net);
-- 
2.39.5




