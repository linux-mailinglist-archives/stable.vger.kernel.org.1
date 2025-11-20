Return-Path: <stable+bounces-195417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EAAC7622B
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2DD05241EE
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1830505B;
	Thu, 20 Nov 2025 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwWvPOjK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E84285073
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763668621; cv=none; b=uRINnxuyXut3IKNiNGkXGzCWsMQgxoATt8BoFzbOye2TMPzt827OCk7pMIQxDCL6tx+P1xFuP5f5Xz0eWFJus1IkQ0oYWcR0vx1rL6HJFLsTbUfmiTgQdxnngfAS6CFG/LN3La/IF61zK/+Lijd5j2Wmboq0GiJQWEyLDHk1LMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763668621; c=relaxed/simple;
	bh=4Yvbb3g077zKwbyMMLqqeQa7gk57PHN5LK72XxE4wag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBiHiMPmJZ88qoNIokhH8zGX36uXcIGW01yWGAF2SRZ/Nu0NkT4BjZqsSJrx93+0cFuCZn5suPhHDaqM7C8oz9EYkU1VDRsXGqz0QfUi2M325u6WBWnT453SYlXsJlQz7V95XOypyfCZYeEXl/z0HMy76BTnCgQGZEcQXu2Y1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwWvPOjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68844C116B1;
	Thu, 20 Nov 2025 19:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763668621;
	bh=4Yvbb3g077zKwbyMMLqqeQa7gk57PHN5LK72XxE4wag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwWvPOjKNE9brYwbgPdTuEbrfh4Iqr3Jojccf9ZLqQV1gbiC54/4JZc2mnu+KHKXr
	 PkJFCzm03fvHf/PkCskTPSfBRIFYFsW6RMuuVpniAaONff1qY1lbnmBvmNG4X69sv3
	 Ms3pvTCgOyz7Y9+VvlGt8yfYyOioRXxiI1XiwoFVX3s2XSrM5P2n6bcivy0f9s3h7N
	 OOOlUq1ja/OuG9fiRQ9l/c3XmJcw5T8CZdKVJx5O/ncaGk/waaEEo2pukDvq5cd/Ie
	 nMQOJ1lQm75rOfuFo5qWDnce5TSEvQVmtFayRGBs+m1pi+MIG+IC8E0N/axpry8oyn
	 Iuew+6nwSwTWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] net: netpoll: fix incorrect refcount handling causing incorrect cleanup
Date: Thu, 20 Nov 2025 14:56:56 -0500
Message-ID: <20251120195656.2297634-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120195656.2297634-1-sashal@kernel.org>
References: <2025112006-author-harmony-d5f7@gregkh>
 <20251120195656.2297634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 49c8d2c1f94cc2f4d1a108530d7ba52614b874c2 ]

commit efa95b01da18 ("netpoll: fix use after free") incorrectly
ignored the refcount and prematurely set dev->npinfo to NULL during
netpoll cleanup, leading to improper behavior and memory leaks.

Scenario causing lack of proper cleanup:

1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
   allocated, and refcnt = 1
   - Keep in mind that npinfo is shared among all netpoll instances. In
     this case, there is just one.

2) Another netpoll is also associated with the same NIC and
   npinfo->refcnt += 1.
   - Now dev->npinfo->refcnt = 2;
   - There is just one npinfo associated to the netdev.

3) When the first netpolls goes to clean up:
   - The first cleanup succeeds and clears np->dev->npinfo, ignoring
     refcnt.
     - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
   - Set dev->npinfo = NULL, without proper cleanup
   - No ->ndo_netpoll_cleanup() is either called

4) Now the second target tries to clean up
   - The second cleanup fails because np->dev->npinfo is already NULL.
     * In this case, ops->ndo_netpoll_cleanup() was never called, and
       the skb pool is not cleaned as well (for the second netpoll
       instance)
  - This leaks npinfo and skbpool skbs, which is clearly reported by
    kmemleak.

Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
clarifying comments emphasizing that npinfo cleanup should only happen
once the refcount reaches zero, ensuring stable and correct netpoll
behavior.

Cc: <stable@vger.kernel.org> # 3.17.x
Cc: Jay Vosburgh <jv@jvosburgh.net>
Fixes: efa95b01da18 ("netpoll: fix use after free")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20251107-netconsole_torture-v10-1-749227b55f63@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index f053141b88968..a92ed89376ab3 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -843,6 +843,10 @@ void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -852,8 +856,7 @@ void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 
 	skb_pool_flush(np);
 }
-- 
2.51.0


