Return-Path: <stable+bounces-195442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE19C76E9F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 03:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E66E44E5F51
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 02:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17219296BD4;
	Fri, 21 Nov 2025 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmcHJwZi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AB28DEE9
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690381; cv=none; b=ma5Tsj9NCVPFWmyjLeBgQmY/phjjJaOlefnEmhcM7Bu6ux3Tt/hjAIxpRhqKLFH7o7Udse+JMchJJDSNwHdHWfmMvXTPF5RIHGaJW3eNSKnm7V28ziZZXwYkZC08YzCP5JEUjdcUzk91u3GOrei5SulDz6xespFf6IioF4Gm1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690381; c=relaxed/simple;
	bh=fp8cNnDB+QoL4KRJllevskRRnHRl4DQW29ksZEVXdGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjpT5yJHfJkaoyFacEcoZ682FgR/ONDdmv/10dcHOTISi+qhbp0R02qXzw/LiPwmXfhE4OyofELVW7wgbNYlTBsnWJKZgLwo0twXGTtOPGNf9eVrDBsyr4PVaL75Hl3t3wPabQFUpkrlpogSY9fi3DdCLzuvWvC5oru8SrTBzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmcHJwZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CF2C4CEF1;
	Fri, 21 Nov 2025 01:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763690381;
	bh=fp8cNnDB+QoL4KRJllevskRRnHRl4DQW29ksZEVXdGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OmcHJwZipS5e91N3C8NobvTeZpsL2cJWfuHSynb/dFo+cYLzVLcXmrIuQwzFAUQ6b
	 RLMblmGufjbjHJqnQMOcjsrrOdDV1fhDa7ZmUf+85nTOdh+bZHHDRMU75o9KzlLcOj
	 5eWT/Zghy7NXzJEtf4hcZsHxXwSvS/2JqTtLNGGp6TzvH9cKk+63HNFvDNycYToPMS
	 hxKVhKlm+qM92KkWBOhF9y3kgbtE6cacLBCeV+ydN2OrWAhvd1Alc+LpIL23fphi8t
	 diPhNCsovhDVKAWDfcatadJxGy1zxaSVGaVBdPP+HJzqCgJlP2nxDjDdnur80Zmpy9
	 HaXHiHQR7cBcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: netpoll: fix incorrect refcount handling causing incorrect cleanup
Date: Thu, 20 Nov 2025 20:59:38 -0500
Message-ID: <20251121015938.2338360-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112010-elm-hardwired-dce7@gregkh>
References: <2025112010-elm-hardwired-dce7@gregkh>
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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index db18154aa2383..489e1269c65f0 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -863,6 +863,10 @@ void __netpoll_cleanup(struct netpoll *np)
 
 	synchronize_srcu(&netpoll_srcu);
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -872,8 +876,7 @@ void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 }
 EXPORT_SYMBOL_GPL(__netpoll_cleanup);
 
-- 
2.51.0


