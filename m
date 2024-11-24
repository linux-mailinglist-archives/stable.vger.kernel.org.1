Return-Path: <stable+bounces-95151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6790F9D76E7
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7182C028CE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9501F75BA;
	Sun, 24 Nov 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+LHin/N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A11F75B1;
	Sun, 24 Nov 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456150; cv=none; b=c/Atje0RIyGcr2mE5g/QFEkoRUjl9i9vlRfO2TTHa19cQ9zZn1iusJzmD+8GqRqrwSvwBpUWyF0jzVdrHEbQhmvTU0c+Aa3NcODUGisiKbsT8FWUxarHae6sMG2jMhCWJeKY1zoQXc4UVLLZbiFQCiRIHZpp0x6OCCq0TGW1nZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456150; c=relaxed/simple;
	bh=yGPGMyQZFTXQas2BqkdJeLo6v8KQGoWBCTxMsT6oE2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GySfuDj4sphjL5omwxaQeSmMzimj04drFnBZuD03MrQBcWL2z3tsJJQX9+ehYzDXmxKqQocN2Prf4GIefO2IHfacAxMW+7GxxpsCyeUBR0KaqcFKwpOdNxVr7lvQfamOwl3OWIvqc9uOW8WrZrxnO+OmID1bo0/kqg4MahksEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+LHin/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A5EC4CECC;
	Sun, 24 Nov 2024 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456150;
	bh=yGPGMyQZFTXQas2BqkdJeLo6v8KQGoWBCTxMsT6oE2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+LHin/NjixIf6DCQqgsUxNLTUyRY38S5PxQ25iXfy9w5jdsiIXeFWbba3HIRihBq
	 MFkbl5REscCaXRSrThxwxM+me9eDXM1uqNH/WDNkj7jC8pbY9q4Npw3fjY9NyuM1q8
	 qsV38H3hG9KS8aQCvn5wNOdjXBOWnHfc/aKLFIaVRvkqdm2n+wJIvB+ZddlJRa1aEZ
	 gc6L/bbd3H5hIYeWuSR1OLUsyqS/jFa3DGdIQpeGV2ixNHQqERuDGl4IuAtCU1HpcG
	 6mloUCaO6dxs3pUP9rsq4XrWk+OHrf3CGZSxrfiAPt8IOyX6cy35aJzF2fSpCJFU2n
	 QEoHgSd92ssrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	viro@zeniv.linux.org.uk,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 61/61] netpoll: Use rcu_access_pointer() in __netpoll_setup
Date: Sun, 24 Nov 2024 08:45:36 -0500
Message-ID: <20241124134637.3346391-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit c69c5e10adb903ae2438d4f9c16eccf43d1fcbc1 ]

The ndev->npinfo pointer in __netpoll_setup() is RCU-protected but is being
accessed directly for a NULL check. While no RCU read lock is held in this
context, we should still use proper RCU primitives for consistency and
correctness.

Replace the direct NULL check with rcu_access_pointer(), which is the
appropriate primitive when only checking for NULL without dereferencing
the pointer. This function provides the necessary ordering guarantees
without requiring RCU read-side protection.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e082139004093..1791462f1600a 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -633,7 +633,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		goto out;
 	}
 
-	if (!ndev->npinfo) {
+	if (!rcu_access_pointer(ndev->npinfo)) {
 		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
 		if (!npinfo) {
 			err = -ENOMEM;
-- 
2.43.0


