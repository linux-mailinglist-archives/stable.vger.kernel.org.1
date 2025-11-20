Return-Path: <stable+bounces-195410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11480C761B6
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 15F02244EB
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B53043D1;
	Thu, 20 Nov 2025 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rc3idv1Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BA1A0BF3
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667789; cv=none; b=aiJXJg2hEbwRaNF33NU22Qk4NtcBiQHiZQW7tXktDbbD88ZCET7TWgKxLjFhdsjKeAxPLGdcfXzw/YHy2EhZmGdwp9KPwCPu1hZFhSdeKySa73oB9PUXgnQL5RX4bhtyz+Ie8ch6dL4jP9jCWX3v3X3kg8ddPj1Xxx9wCo4WBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667789; c=relaxed/simple;
	bh=rkGQWjdKCRGNRJ4S5cA0AGD7hqIxNu6YsmXnIHhG+i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUfpDeYIFr6ckdoING2Ni+D20PtzGEvuCK+7sMwfiKOSwOh2SxZJq5MYIg1ZQsWrivCMK1Ldr1D6iWK1GDRgmNsJi/lnFXfUMIk+V3Svp8p0wl/ZsV3IDF/rnDBa9VKyYzjyH8Fwu+C57P+TMy0nQkg7DRtyD3Q7ksilBPuqJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rc3idv1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ADEC116B1;
	Thu, 20 Nov 2025 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763667788;
	bh=rkGQWjdKCRGNRJ4S5cA0AGD7hqIxNu6YsmXnIHhG+i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rc3idv1YpVfQCR1huU+KQ00BZ6fWDLhqtdBp/+Kh+WSb72eMb4KqgISOo7muEkazm
	 4L0KwurwzV5OJryTejVIXH4JZTMQOwQht03msaCEyKtwX82CevXXDxzb1SYwSb6BBx
	 AcAduiZNAJP4Cp8SInZVEYDH2HwVyZFtAQMPPINmI8+f4a2cD2IHuiU4lw7JCU8RX/
	 JmN7u95f6upxBU3GeenjYtU4x6PKTzGIc2cbhPjDunl0zzFacXHTqaItuuM5AXmupp
	 WWRuLDWbIKayl++Wj8ueEqwTZOQWZishmgiL3lRfy28FFZ8tMsqhTXRnj9cXjTnePy
	 nNThT+HOiIZMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] net: netpoll: fix incorrect refcount handling causing incorrect cleanup
Date: Thu, 20 Nov 2025 14:43:03 -0500
Message-ID: <20251120194303.2293083-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120194303.2293083-1-sashal@kernel.org>
References: <2025112005-polio-gratify-8d3b@gregkh>
 <20251120194303.2293083-1-sashal@kernel.org>
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
index 3f6dca03fa600..47e6fb660f03e 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -841,6 +841,10 @@ void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -850,8 +854,7 @@ void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 
 	skb_pool_flush(np);
 }
-- 
2.51.0


