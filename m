Return-Path: <stable+bounces-95235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A949D7588
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A6DB3108E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9D0240FED;
	Sun, 24 Nov 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/tEkjCC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E510240FE5;
	Sun, 24 Nov 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456425; cv=none; b=X985C7ctovcpB96UK/QrslQsUA4OZOnsJBDn5j4aSU4bJOeg21udsLuY/qdvwiE7qRUTpCDDC0Y0kCqZONQOd6Ogn/XxaSqn3biHSFVy3M4f2QHOkhQbgipwnvY6Edm1TJwXif0zH9jGv09g0MSN2yYWUdWyodOy6+bqRQChITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456425; c=relaxed/simple;
	bh=pXZyNcESKO1/12y1rcyEuI8zYSSFEPtGF4s6DVtZrf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I02u4Kb2b/YCkFZt+ofTzjyhwnqL4LmiNgpc+GIUfyTH3p8/RPDiLE1t+Xut2MlQiC1OHNcVtkM2qm9EpP8UAe84fVn/RRT91bCe5o37TdjiVqMhmyTsK/drGcipvD7nWbO8afnjdx4xpjmq5NgM1Y9hy2PDuDhHiG+0BCR664w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/tEkjCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B534EC4CED1;
	Sun, 24 Nov 2024 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456425;
	bh=pXZyNcESKO1/12y1rcyEuI8zYSSFEPtGF4s6DVtZrf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/tEkjCCgqoNAKQ/YQ2YM9GjHFPyh8bSc8JNdAhIU3MibCOJ4TgLPGo8t9tkSpl97
	 Yg7XDiMhpHv2dfzWVnI0Cxj+7rFJOfid3fIzI5bCmqI8yuTqBl5GOA7J9EL1aj7L8U
	 I+xzWNtjKtkYpqmG6yMDSq6EM4qll2/skKoGSzBaYu1PsYwhucB9e01xkHikga02Xu
	 u/B3hHtDs9ehMTWf8hHK7SN9Y3+5igKWI5zSTqfTNH+WscE3NvrqjI6qWNAynhSNu5
	 3dKQShgIDaUaF6jEDWNOQ8GImGm8Z6ADbZaeUEuGJ6pkoKIjbdW+v/ocwh3OXw2OOk
	 OAApMui/ELW3w==
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
Subject: [PATCH AUTOSEL 5.15 36/36] netpoll: Use rcu_access_pointer() in __netpoll_setup
Date: Sun, 24 Nov 2024 08:51:50 -0500
Message-ID: <20241124135219.3349183-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index 2a9d95368d5a2..597e83e2bce86 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -636,7 +636,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		goto out;
 	}
 
-	if (!ndev->npinfo) {
+	if (!rcu_access_pointer(ndev->npinfo)) {
 		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
 		if (!npinfo) {
 			err = -ENOMEM;
-- 
2.43.0


