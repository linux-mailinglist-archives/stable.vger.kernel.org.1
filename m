Return-Path: <stable+bounces-42336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A2A8B727F
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB1BB20519
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690E412CD90;
	Tue, 30 Apr 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZGqBBMu/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279861E50A;
	Tue, 30 Apr 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475329; cv=none; b=PAIlds0oHK8QZZ9Mk1omUK6iDipFNG5fl5xnK6Zjgvjl6o4vLrcJ13KvynPQTtPdsK58TOsV7PxAmFSAJpmKSR0+CI2PUJWZPyU3g7CLcrEyUmW64ESSR0+7L4fLTXe3LuIQu+p2BNzJpeFB+gTB01twS2zOj4J6fU1WnVdbD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475329; c=relaxed/simple;
	bh=Cjk2XUUujfqFPcegyMPs9chzbvlgc/hk+Cx4Kf4t1RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewR6bFn1M/44YVAlR0MzgepexU447KtHmmMvawn+SlO3ax0ZBkJcGNBNwLGL8FIe45J7SEabaGQHawEYMlbQZpMYpIvMxjfy9yRr/mNRyVmJnffrIf+JQV3vq3Iafg1Ja09ga9i+a8hE5epJhoMmrVbA9JyFyH8lTz0zea3hYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZGqBBMu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A969C2BBFC;
	Tue, 30 Apr 2024 11:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475329;
	bh=Cjk2XUUujfqFPcegyMPs9chzbvlgc/hk+Cx4Kf4t1RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGqBBMu/LR2JXI8KhZV+GuAKFleMbJovjL8nZlr9vp59AZe8hNClRL+PBE05bFrig
	 NDsss8sevMkXmouKioHgWwzz0/DmKIpvRQ6NAA8E2fWoxNnuiX9A+FIL7zHcTVZcM2
	 i5y9Ia+ZrL69UP4lrn0FvXGMlMOYuppJNuoMVT2o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <v4bel@theori.io>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 063/186] net: gtp: Fix Use-After-Free in gtp_dellink
Date: Tue, 30 Apr 2024 12:38:35 +0200
Message-ID: <20240430103059.867864511@linuxfoundation.org>
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

[ Upstream commit f2a904107ee2b647bb7794a1a82b67740d7c8a64 ]

Since call_rcu, which is called in the hlist_for_each_entry_rcu traversal
of gtp_dellink, is not part of the RCU read critical section, it
is possible that the RCU grace period will pass during the traversal and
the key will be free.

To prevent this, it should be changed to hlist_for_each_entry_safe.

Fixes: 94dc550a5062 ("gtp: fix an use-after-free in ipv4_pdp_find()")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 2b5357d94ff56..63f932256c9f5 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1111,11 +1111,12 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 static void gtp_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct gtp_dev *gtp = netdev_priv(dev);
+	struct hlist_node *next;
 	struct pdp_ctx *pctx;
 	int i;
 
 	for (i = 0; i < gtp->hash_size; i++)
-		hlist_for_each_entry_rcu(pctx, &gtp->tid_hash[i], hlist_tid)
+		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
 
 	list_del_rcu(&gtp->list);
-- 
2.43.0




