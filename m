Return-Path: <stable+bounces-177376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAEFB404ED
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C093C5E48BF
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A026B31A57D;
	Tue,  2 Sep 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmB65lEi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74331A553;
	Tue,  2 Sep 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820445; cv=none; b=DOWFZIUPy6sPuu6c79UKETiKsL35SSrPqAWfadm3rKtWmcrV6tdsjYJ3Q6NkhVAuKpTmeLGCzqQfEZ8OZTVQboumzO/ufxAbv3PPjhHgMq+Y83+6Nnf9g1FtQzYhc+4zLBxTLiKHIY8dcxobpnL5aharBkgeV/agAGaUT8v2z0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820445; c=relaxed/simple;
	bh=XtjuRy4xH4CR5aDG/WkVuU/2IJUtxtrkHsdbKa1l3Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qW/DmSYvst6R8IljmL14ghRxkkRWagvqHPl0F9DBUtr+hXfi1Iy1aYuf5/LK05GRovQou7h0Rdpfp+AuvNJrLQy+cIifV9ThuqHz9DLlcRx7BDP3yBiPmdqMqUMb/GS9uuI/KgPYWXJO9L/SAYdU4J2GSpLlx3ZijqSYxAejBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmB65lEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CF8C4CEED;
	Tue,  2 Sep 2025 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756820445;
	bh=XtjuRy4xH4CR5aDG/WkVuU/2IJUtxtrkHsdbKa1l3Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmB65lEiBhxqPV6vf1KNG4SFp/AzZ3bQv+aFoGhnwZCoZPbIh+ho1UMZGk7gKo7x/
	 bRx6sUqCFGLRVokXqKbenrW8UTyB+mAldC/qIudMjn7KgP9Du058NjSVt244AR3uah
	 OOGR70gHxKJ2RAhCszsYqR1v9i8oXq7BdwkfNjkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takamitsu Iwai <takamitz@amazon.co.jp>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 30/50] net: rose: split remove and free operations in rose_remove_neigh()
Date: Tue,  2 Sep 2025 15:21:21 +0200
Message-ID: <20250902131931.715546660@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131930.509077918@linuxfoundation.org>
References: <20250902131930.509077918@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takamitsu Iwai <takamitz@amazon.co.jp>

[ Upstream commit dcb34659028f856c423a29ef9b4e2571d203444d ]

The current rose_remove_neigh() performs two distinct operations:
1. Removes rose_neigh from rose_neigh_list
2. Frees the rose_neigh structure

Split these operations into separate functions to improve maintainability
and prepare for upcoming refcount_t conversion. The timer cleanup remains
in rose_remove_neigh() because free operations can be called from timer
itself.

This patch introduce rose_neigh_put() to handle the freeing of rose_neigh
structures and modify rose_remove_neigh() to handle removal only.

Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250823085857.47674-2-takamitz@amazon.co.jp
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/rose.h    |  8 ++++++++
 net/rose/rose_route.c | 15 ++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/net/rose.h b/include/net/rose.h
index 23267b4efcfa3..174b4f605d849 100644
--- a/include/net/rose.h
+++ b/include/net/rose.h
@@ -151,6 +151,14 @@ struct rose_sock {
 
 #define rose_sk(sk) ((struct rose_sock *)(sk))
 
+static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
+{
+	if (rose_neigh->ax25)
+		ax25_cb_put(rose_neigh->ax25);
+	kfree(rose_neigh->digipeat);
+	kfree(rose_neigh);
+}
+
 /* af_rose.c */
 extern ax25_address rose_callsign;
 extern int  sysctl_rose_restart_request_timeout;
diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index a7054546f52df..b406b1e0fb1e7 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -234,20 +234,12 @@ static void rose_remove_neigh(struct rose_neigh *rose_neigh)
 
 	if ((s = rose_neigh_list) == rose_neigh) {
 		rose_neigh_list = rose_neigh->next;
-		if (rose_neigh->ax25)
-			ax25_cb_put(rose_neigh->ax25);
-		kfree(rose_neigh->digipeat);
-		kfree(rose_neigh);
 		return;
 	}
 
 	while (s != NULL && s->next != NULL) {
 		if (s->next == rose_neigh) {
 			s->next = rose_neigh->next;
-			if (rose_neigh->ax25)
-				ax25_cb_put(rose_neigh->ax25);
-			kfree(rose_neigh->digipeat);
-			kfree(rose_neigh);
 			return;
 		}
 
@@ -331,8 +323,10 @@ static int rose_del_node(struct rose_route_struct *rose_route,
 		if (rose_node->neighbour[i] == rose_neigh) {
 			rose_neigh->count--;
 
-			if (rose_neigh->count == 0 && rose_neigh->use == 0)
+			if (rose_neigh->count == 0 && rose_neigh->use == 0) {
 				rose_remove_neigh(rose_neigh);
+				rose_neigh_put(rose_neigh);
+			}
 
 			rose_node->count--;
 
@@ -513,6 +507,7 @@ void rose_rt_device_down(struct net_device *dev)
 		}
 
 		rose_remove_neigh(s);
+		rose_neigh_put(s);
 	}
 	spin_unlock_bh(&rose_neigh_list_lock);
 	spin_unlock_bh(&rose_node_list_lock);
@@ -569,6 +564,7 @@ static int rose_clear_routes(void)
 		if (s->use == 0 && !s->loopback) {
 			s->count = 0;
 			rose_remove_neigh(s);
+			rose_neigh_put(s);
 		}
 	}
 
@@ -1301,6 +1297,7 @@ void __exit rose_rt_free(void)
 		rose_neigh = rose_neigh->next;
 
 		rose_remove_neigh(s);
+		rose_neigh_put(s);
 	}
 
 	while (rose_node != NULL) {
-- 
2.50.1




