Return-Path: <stable+bounces-38349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3E78A0E27
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402D11C21F3A
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F00145B3E;
	Thu, 11 Apr 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P0PIYSd+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103A1448EF;
	Thu, 11 Apr 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830293; cv=none; b=hkw9bEUgD4nmym3MRinwTZMiJwWFvT1DQQEePdiajJLHoWlzsj6qT9tNuCUjqspjhTLhVRtj22/A0PmsDuzhONiu5G1if/PEqW+USx4lQ31bqzc4S69Pmw6Z4E11/WYfnL4VjFs17n0tg4lgiwhHn2DOOo8N+JKXPKwU6cqKfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830293; c=relaxed/simple;
	bh=pHAZZSRzlXXzJ3d86d0J+7Ls0AZtyCm93IHUXQsKln4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bM0FylZun2DJ3r1pJ0BBLzuyzX9MOdE/M8ql6RS2TB/AKA4QDtPgyUZeyaxIzbvs3J1MAEMaJWDjaTsyiJ6pkxxcWe8F1kPEyASECTUmYZ7A6sW5W8LjVvXU2uHQ57YGA72KS3oMGzdy/GPcSOe366E4rQJIWcr0+Ht4TKz/c2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P0PIYSd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B123FC433C7;
	Thu, 11 Apr 2024 10:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830293;
	bh=pHAZZSRzlXXzJ3d86d0J+7Ls0AZtyCm93IHUXQsKln4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0PIYSd+d12Dlu7ml/V7Yvp2zsWmnieFyzcD8jDN3suZffSuMsUWMdTgLFsS0l3/G
	 I5cCBpGl28MOQkhSRliJA2FvNTgXCm3PKtsX79Xms8afpOXq+fr6yeK4GkxUcCeZ/d
	 XPikx7hkSUhjpbParWU5lNs0U+y7Q3BQ3zo8pPoM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 052/143] net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()
Date: Thu, 11 Apr 2024 11:55:20 +0200
Message-ID: <20240411095422.483096548@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
References: <20240411095420.903937140@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 00af2aa93b76b1bade471ad0d0525d4d29ca5cc0 ]

Many syzbot reports show extreme rtnl pressure, and many of them hint
that smc acquires rtnl in netns creation for no good reason [1]

This patch returns early from smc_pnet_net_init()
if there is no netdevice yet.

I am not even sure why smc_pnet_create_pnetids_list() even exists,
because smc_pnet_netdev_event() is also calling
smc_pnet_add_base_pnetid() when handling NETDEV_UP event.

[1] extract of typical syzbot reports

2 locks held by syz-executor.3/12252:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.4/12253:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.1/12257:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.2/12261:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.0/12265:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.3/12268:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.4/12271:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.1/12274:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.2/12280:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>
Cc: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Link: https://lore.kernel.org/r/20240302100744.3868021-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_pnet.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 9f2c58c5a86b7..2adb92b8c4699 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -806,6 +806,16 @@ static void smc_pnet_create_pnetids_list(struct net *net)
 	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
 	struct net_device *dev;
 
+	/* Newly created netns do not have devices.
+	 * Do not even acquire rtnl.
+	 */
+	if (list_empty(&net->dev_base_head))
+		return;
+
+	/* Note: This might not be needed, because smc_pnet_netdev_event()
+	 * is also calling smc_pnet_add_base_pnetid() when handling
+	 * NETDEV_UP event.
+	 */
 	rtnl_lock();
 	for_each_netdev(net, dev)
 		smc_pnet_add_base_pnetid(net, dev, ndev_pnetid);
-- 
2.43.0




