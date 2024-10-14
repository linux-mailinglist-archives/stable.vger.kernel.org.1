Return-Path: <stable+bounces-84510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE3699D08A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A33B26790
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCD21AC891;
	Mon, 14 Oct 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YGV+pYph"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B81AC427;
	Mon, 14 Oct 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918257; cv=none; b=szRouGtAzZ9T0fS0YMiaLBc00yHXo+Tu/jNAUP0K8IxJkRJRoHydnn/D7jDUAkTIh9NBCx1uOer1F4PjDr0wgYDqEEXSgqge8Lwe5BY21vR94Iew/9n4+m4ufW4CPt8QgYr9BtCkAeK7LwOKHsJVe86ai3ImRnxgWyjKPXmjozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918257; c=relaxed/simple;
	bh=tZtCtJkpi7kf3cOFECYHNeDzkwSHZM+qWinHaqhgQj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBxsFzV2ZkUPsSA/QzJU/gQhrEIBzGpWVR+FsGFunnKQN7cND0IBR5xiPZiunwsbigh9RYFORla8TFRX+dTYd5Y1gyfd3AwQi4ZLlcWQ+tBvg700QG182vbYLgMPohYD55ZDmLKpeGuwwZlQr7TK8Pyhtgtuan+NrrwhRIT8CHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YGV+pYph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F67C4CED0;
	Mon, 14 Oct 2024 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918256;
	bh=tZtCtJkpi7kf3cOFECYHNeDzkwSHZM+qWinHaqhgQj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGV+pYphQSm/h33dsmIoX31DfzWlC0EhU0Jk/vYDJBP+Z+9jH6qnC2YO9q2k8WFr5
	 K0cntqsCGwCVtu9vqXxLwZaiPJ6DF/ianoTZxGCCj8Zz2N9Y/3/fiFG6pRl4rEmjyI
	 /mKwLsSj1gREd4BuXrrhXCebKjcN/9GKy7YK8yZU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 270/798] netfilter: nf_tables: Keep deleted flowtable hooks until after RCU
Date: Mon, 14 Oct 2024 16:13:44 +0200
Message-ID: <20241014141228.541057015@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 642c89c475419b4d0c0d90e29d9c1a0e4351f379 ]

Documentation of list_del_rcu() warns callers to not immediately free
the deleted list item. While it seems not necessary to use the
RCU-variant of list_del() here in the first place, doing so seems to
require calling kfree_rcu() on the deleted item as well.

Fixes: 3f0465a9ef02 ("netfilter: nf_tables: dynamically allocate hooks per net_device in flowtables")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a68b2193393c8..ed09b1fdda16e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8619,7 +8619,7 @@ static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 		flowtable->data.type->setup(&flowtable->data, hook->ops.dev,
 					    FLOW_BLOCK_UNBIND);
 		list_del_rcu(&hook->list);
-		kfree(hook);
+		kfree_rcu(hook, rcu);
 	}
 	kfree(flowtable->name);
 	module_put(flowtable->data.type->owner);
-- 
2.43.0




