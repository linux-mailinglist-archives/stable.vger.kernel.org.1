Return-Path: <stable+bounces-95296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B7E9D7774
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 19:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB57B24129
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FD824BFDC;
	Sun, 24 Nov 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbKMXSLm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B262724BFD6;
	Sun, 24 Nov 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456614; cv=none; b=cMXL3qxdLahDbvWgGc0NnMsaCCGRrCfP+uD5qDQ4KWJS9WBM7srlyqrgTjJruafe1AHO3HOnokQy4tLcZKOxpb45pt4FjznE8bRKstUtwGJCn2Xa6P7EbZ4pFkWsPXPYDiX8Qff8QqtFIbjr9C0ei3HWnkz5sHHSDt9PzoSdFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456614; c=relaxed/simple;
	bh=+SavanS+peFDtun9ThuhSkPysREvObdvfpHagGM5VXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIb0sB/UhDQMkmQpGgyxzGmlqKq+l/vDX0BBakAuymlasOGWAy0coiQ0Eak+eihX4c9poAlzGOUsYCXCMJxv6CNcPyyM0DDcarjLUZ2I0EM/M+DZNNImKGjJb6KVtV6dlxaLF6pqEwFUOsFhJt7dbEOg/xs8vkb6mAmou3e/RBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbKMXSLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930D2C4CED6;
	Sun, 24 Nov 2024 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456614;
	bh=+SavanS+peFDtun9ThuhSkPysREvObdvfpHagGM5VXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbKMXSLmixiC/kRtAGgIpDpSMOLAs/Hn1wNIXD3h9ln/FzLIO3FPoKtix55p1J+Em
	 AwjZZjOm1EKDhY+496Fbmfg0XwiemOio3E7QOh0gmO9I2+hA8cf/UCWk4cHMuXt9Zj
	 v42A09yzo9zOjHY7j2eRlgdg2Fo+SX0ViL+6vX5PK7+P+Zcv9EgUUhWLjVUStJICRi
	 RFKDgOf9vuwBgLyaGGVQVsfJ1OlEt8oqGo8GXPp9UWNBspbRKcR6ejXkoU+kp/rY9W
	 Y+qFkV8ku7dAfFK3LQWYSKN9BDlk4vYXGAepA1jr7PBZ7MEzAPSjJRRGt6jJFQ0uK4
	 Cgoj2Ff4HiJmg==
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
Subject: [PATCH AUTOSEL 5.4 28/28] netpoll: Use rcu_access_pointer() in __netpoll_setup
Date: Sun, 24 Nov 2024 08:55:28 -0500
Message-ID: <20241124135549.3350700-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index 9b263a5c0f36f..9a67aa989d606 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -615,7 +615,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		goto out;
 	}
 
-	if (!ndev->npinfo) {
+	if (!rcu_access_pointer(ndev->npinfo)) {
 		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
 		if (!npinfo) {
 			err = -ENOMEM;
-- 
2.43.0


