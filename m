Return-Path: <stable+bounces-195414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5DEC76228
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 627D7359D55
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6709B30100C;
	Thu, 20 Nov 2025 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6sH7cZG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D2285073
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763668619; cv=none; b=P1wcrhigqW8P3++RaCXeZAzpemaNr3wzT8oDFBV18NwDhEn38QncU5H/NyO8ew93NhJcixVpLrS6SsL/+CbLTtyxY3GJpDGLBrwyg2E+DiSYnJASdSaHyOSzvpR1c2aD6f2altxxAM6J7ZA4U79Fj02ka9dqQ//u/K4XqgFQFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763668619; c=relaxed/simple;
	bh=ymGmhV/Q7E9Z/DYEnoRlKNkgH1wFm43dTTrQ4kuO4P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vq0qOwiV/0eiEsphdrbA2iyYgD2Kulna7aNek/e4zw7b3NWKt/i9dc/oaf5+VST/CZD4ZBQEl0XPxZ7l40oJ4XF3mkQQ73ZQnuzsZOsXRB1BOWExDrsM8ivtWUF637ClaVkdxsDCSuXB6e+YHpLnYuGPaUgr7sGIoAKiPwX96Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6sH7cZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1995BC4CEF1;
	Thu, 20 Nov 2025 19:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763668618;
	bh=ymGmhV/Q7E9Z/DYEnoRlKNkgH1wFm43dTTrQ4kuO4P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6sH7cZG87rx5mUqbAyvz5Qm02ikgJ24xOlFvv2UKi5+4O1jGGMPfasGeKu34NgZL
	 y83FEdX0sQnG3E27RYAvY6ZA5KPrd9/0W3Ybe2EcGuZTHnbS8repEy2DluDgu5K9LQ
	 omJgzyTutmRa5aD7PFTvQFQ5dV4IFZFbcjEn+yIJ55lBBBupbQcIDFNc1Y4ucDGFzc
	 eiSfE3ZnkLuQmocDT/i672xdUcaxikRVu3eUnFmH1qh5BU2LxeOF39GAIwg74YdfTa
	 2a8gXug21F3tPl1mS4mfHMfg9wtWqUaFEJqTzw6i1XXGrAzsPdGeiazr3KCSzkLa+H
	 2jfeyglpihd9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] netpoll: remove netpoll_srcu
Date: Thu, 20 Nov 2025 14:56:53 -0500
Message-ID: <20251120195656.2297634-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112006-author-harmony-d5f7@gregkh>
References: <2025112006-author-harmony-d5f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9a95eedc81deb86af1ac56f2c2bfe8306b27b82a ]

netpoll_srcu is currently used from netpoll_poll_disable() and
__netpoll_cleanup()

Both functions run under RTNL, using netpoll_srcu adds confusion
and no additional protection.

Moreover the synchronize_srcu() call in __netpoll_cleanup() is
performed before clearing np->dev->npinfo, which violates RCU rules.

After this patch, netpoll_poll_disable() and netpoll_poll_enable()
simply use rtnl_dereference().

This saves a big chunk of memory (more than 192KB on platforms
with 512 cpus)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20240905084909.2082486-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 49c8d2c1f94c ("net: netpoll: fix incorrect refcount handling causing incorrect cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 2bdb1e84c6c8a..8c3379c1ecf07 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -48,8 +48,6 @@
 
 static struct sk_buff_head skb_pool;
 
-DEFINE_STATIC_SRCU(netpoll_srcu);
-
 #define USEC_PER_POLL	50
 
 #define MAX_SKB_SIZE							\
@@ -220,24 +218,21 @@ EXPORT_SYMBOL(netpoll_poll_dev);
 void netpoll_poll_disable(struct net_device *dev)
 {
 	struct netpoll_info *ni;
-	int idx;
+
 	might_sleep();
-	idx = srcu_read_lock(&netpoll_srcu);
-	ni = srcu_dereference(dev->npinfo, &netpoll_srcu);
+	ni = rtnl_dereference(dev->npinfo);
 	if (ni)
 		down(&ni->dev_lock);
-	srcu_read_unlock(&netpoll_srcu, idx);
 }
 EXPORT_SYMBOL(netpoll_poll_disable);
 
 void netpoll_poll_enable(struct net_device *dev)
 {
 	struct netpoll_info *ni;
-	rcu_read_lock();
-	ni = rcu_dereference(dev->npinfo);
+
+	ni = rtnl_dereference(dev->npinfo);
 	if (ni)
 		up(&ni->dev_lock);
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL(netpoll_poll_enable);
 
@@ -843,8 +838,6 @@ void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
-	synchronize_srcu(&netpoll_srcu);
-
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
-- 
2.51.0


