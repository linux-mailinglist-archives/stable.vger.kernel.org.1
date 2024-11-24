Return-Path: <stable+bounces-95317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD79D7533
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DE42831C2
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1552500AA;
	Sun, 24 Nov 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMAVB3g6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6833C24F277;
	Sun, 24 Nov 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456677; cv=none; b=Vxqa/+YgJdrdKlqhtsFe4l/fqLid8Tsx8JOi2gHyTt9CzW5I27K9TdvC7Id4FXPjGGBvwxb90/NMBIz38n1zIq2V0jjmc3WxlHg5oWjYlBmARlB4UwqKCj7NgRP8kjdpRFc58CXiGy0pkNdl4zOUg2LuZuWBJWc1facnsNAalrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456677; c=relaxed/simple;
	bh=EV77wtSBrNdDmH72AasMmhi+JblaXbfFaBAxCePQgS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r24gsBRgQLw3KFCmPM1tl7/P602PV/k3JgRtVZSjejvmRI15ekBU63rNuYF+eG0wjbxe+tjm7si17bfFKJqGyXy/PgRmkMWKDxEmkvhKmpdCdK7tdX6jGQzkqYeSReu53eZX2IZ8gDBwp718+YECU3Q7hb6tyapwrVvTLxJWEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMAVB3g6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DB3C4CED1;
	Sun, 24 Nov 2024 13:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456677;
	bh=EV77wtSBrNdDmH72AasMmhi+JblaXbfFaBAxCePQgS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMAVB3g6TZ1JMJKl1oK0PPo4Ebr0S1gEBg7H25enl25kH8Fzp1ztHPTylMHXRS4oX
	 R+d90MkHpPoVKdNwCNE6vzf0Sz3HJPDYdoIBasjZwKXdKoijK36oXwlkMGJng7bg0M
	 nSg5n7CHow6K+z82LYam5gHy/Qo/SElJI3RvFYXDmpWDLOQ6iA7wztuoBBYaiML/05
	 cdxovwmjMeStZAOXDiCdqGT12Y1ThjY2N4LdDhmSL5z3o1+upFVljxbKsrg50yYShP
	 TtNq/KmCcrQ06VB9YRXFgYoowvP+8rA0eAQUKqWkaB1V9KKhdSFu1Vuirsn7GK1mgL
	 lPXkOX6WnSr5Q==
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
Subject: [PATCH AUTOSEL 4.19 21/21] netpoll: Use rcu_access_pointer() in __netpoll_setup
Date: Sun, 24 Nov 2024 08:56:54 -0500
Message-ID: <20241124135709.3351371-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
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
index 08f0da9e6a809..0df6ae0fb71e5 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -616,7 +616,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		goto out;
 	}
 
-	if (!ndev->npinfo) {
+	if (!rcu_access_pointer(ndev->npinfo)) {
 		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
 		if (!npinfo) {
 			err = -ENOMEM;
-- 
2.43.0


