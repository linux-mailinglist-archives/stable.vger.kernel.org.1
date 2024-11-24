Return-Path: <stable+bounces-95199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0CF9D7769
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 19:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2010C20F66
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292923A2F7;
	Sun, 24 Nov 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4ezu0T3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42923A2EE;
	Sun, 24 Nov 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456309; cv=none; b=m3iTuej4Pac0OO+N4iGeyOEIoJ5xKHp+EPE5UcMPAOGVwpU3BqENTZtw9vutbQesxw93ouQDWxS7NRbgXkUPFnizAG8JOuhJyWl2Z+1dx817XWlqLJfq4QdX+cA7ebEx70jBGHFI759/DSMFK19HUC7l1AwMYyd7ORObgm93zJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456309; c=relaxed/simple;
	bh=svzg4bV4PMWFAo2BNI/Ynjkn7kpYitURQ2y4MFeURlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY8rTqiYkvW58dQaXZXWl52jo7dsdFei2Mso2pGbPHxWDAXMuTyCEwfQ4bjkL7XHu2COX/tCOO1QxD11vJePP/wXL5uJfhMED+MFxT97oH2kziIgDLKs3dCyCa42DGtqe2/uvQ79iKBbjOmRZsGM5f2lV9jvXmh0Xd9zpDV6xS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4ezu0T3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F63C4CED1;
	Sun, 24 Nov 2024 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456309;
	bh=svzg4bV4PMWFAo2BNI/Ynjkn7kpYitURQ2y4MFeURlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4ezu0T3yQw+Dc+cRZHpV5bcHKrXX+fzUsTdJXZ36qsg9f/a7DmkxJ13mNFnZSKTx
	 ohCWkMrH6iFdVCDdOIo9+/v3eDjCPC/uVyROcFgSPpM4KcLPJZDwa3yNs8fLP0m4/n
	 vm/XNsb9eGvt0hwFxmQ3O2tHg4obaI4ss6PHOMiN15v+QrP80YVEBIyvIeEmW+M4id
	 ky05NTpgxD+SyBP1XycFXR2Tp93NEwfD2N1A5DPtxufXmPnJUU/wZjqAj/zWz48DIB
	 +P6AnGe4t7X/btV4lkkLL2h8OWNgdkUV/tP1nJXueXI2kqdvX/Jf7pmiEZVac91s/v
	 jskHoq9lVAJpg==
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
Subject: [PATCH AUTOSEL 6.1 48/48] netpoll: Use rcu_access_pointer() in __netpoll_setup
Date: Sun, 24 Nov 2024 08:49:11 -0500
Message-ID: <20241124134950.3348099-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index fd2195cfcb4aa..681eeb2b73992 100644
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


