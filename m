Return-Path: <stable+bounces-177866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6929B46093
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B5216BF9B
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7523E342;
	Fri,  5 Sep 2025 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFV7JbbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA63191DB
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094390; cv=none; b=RiJYCE7TnK6oho0K8XNX4OSgoInXRv04c/iyI61huwsqFQHztuTH5FMYs8uAl/eCveQf3C7x3ZxrNvS8mkQ48m05DFpljAhLsNy3rNBi0jlcn5IYmkkG8SY6rI4AuhlZPNC0wBb7pscr/xre5zTEssGY9SVPni2sljHkZ2T2+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094390; c=relaxed/simple;
	bh=MqseLuxtjjng7fZlBkERzUZtZq8rYge/7MSpbXzuB7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qp2BulYvjVM0Pihc/rKqAiwyyvCt8kNUlnrK1vxSm74JsSLiUC2iLVX9QcoSBI5bVesw0OuMUbiHg446e5B1HyVGXpsUnw6oDzW2VzMVj34VKu7p+/0rT9I0SyL7kVu7Reqb3jlgQCQfu7V8jz/ZJWHvSapBHlGTu1wvddt2RGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFV7JbbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA17EC4CEF1;
	Fri,  5 Sep 2025 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757094389;
	bh=MqseLuxtjjng7fZlBkERzUZtZq8rYge/7MSpbXzuB7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFV7JbbN1o0gWYy5H1klFMEUhQP94BSIjjazqav8DOFY47RMhSc5cl3AH2vaGf3gU
	 9002gkFDL/0jmeaJ7ABaGjiYICINVZCHkvLSmGd2Bjph0ISPxhpjJsT/bKVvHTrBPk
	 I8gzIHqbsjqz24h6R43Dn/Nc9Gj8FXLKlhAhDdhsGAPZSr+WA5xrbc0pC4UgqotDcc
	 xaquxK1Z8EVz9FHGqX658gZ3VpZpW+LFViw8Ggq2kFTpoFpsgizewwvqR9bgXbZmcN
	 jiF9BZJm+efEtMJriTIsQXVy5eICfVCUc2jjaXQRv9y7g8IMKdh3X/dZOHRK8gX9jY
	 8VuFtErbVtHCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	Guolin Yang <guolin.yang@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] vmxnet3: update MTU after device quiesce
Date: Fri,  5 Sep 2025 13:46:24 -0400
Message-ID: <20250905174625.2222428-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052425-willed-landline-ff5b@gregkh>
References: <2025052425-willed-landline-ff5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ronak Doshi <ronak.doshi@broadcom.com>

[ Upstream commit 43f0999af011fba646e015f0bb08b6c3002a0170 ]

Currently, when device mtu is updated, vmxnet3 updates netdev mtu, quiesces
the device and then reactivates it for the ESXi to know about the new mtu.
So, technically the OS stack can start using the new mtu before ESXi knows
about the new mtu.

This can lead to issues for TSO packets which use mss as per the new mtu
configured. This patch fixes this issue by moving the mtu write after
device quiesce.

Cc: stable@vger.kernel.org
Fixes: d1a890fa37f2 ("net: VMware virtual Ethernet NIC driver: vmxnet3")
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
Changes v1-> v2:
  Moved MTU write after destroy of rx rings
Link: https://patch.msgid.link/20250515190457.8597-1-ronak.doshi@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ no WRITE_ONCE() in older trees ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 8714e49004842..86b913d5ac5b7 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3315,8 +3315,6 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	netdev->mtu = new_mtu;
-
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
@@ -3330,6 +3328,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
+		netdev->mtu = new_mtu;
 		vmxnet3_adjust_rx_ring_size(adapter);
 		err = vmxnet3_rq_create_all(adapter);
 		if (err) {
@@ -3346,6 +3345,8 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 				   "Closing it\n", err);
 			goto out;
 		}
+	} else {
+		netdev->mtu = new_mtu;
 	}
 
 out:
-- 
2.50.1


