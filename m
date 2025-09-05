Return-Path: <stable+bounces-177870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51AB461E8
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E3D16F184
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BF231C56C;
	Fri,  5 Sep 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzq/5sKD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3131C563
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095959; cv=none; b=hG0SztQo/6yPpC5WolzeCCRjSp5uY1qmLPJEne2tBLiV89gIOCPG0sVk9/kMRFKTA8R0kGxeGgSVbMwOde1paFk5GoaOyDmQkx8qGy5/3HU2VnbDqMc3JP6Pjugi2xQ0oeefHskZ2qr73Wk4Cfc2PS6xBdgDPknhpIqAgIBVXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095959; c=relaxed/simple;
	bh=x/JibCo4i9LeM/v+0RuRaeRth9e5wqoTpP8DozmjfX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7iJITuFJXKF4nTyxKe49UdPxkmsdD6FT2TI97feXqOWGeaYfEQ3F6sQW9ZEtt2TK9+68pzHU5yG/2jNeyBFryVN2FgpgdCmz9I5CBl0aQERWrM+4MSSlrupJohRn+nGGKSbGC8OkdL5F0RMrz16TnGPIuA5qq0vlMzDr1bKM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzq/5sKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EE6C4CEF1;
	Fri,  5 Sep 2025 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757095959;
	bh=x/JibCo4i9LeM/v+0RuRaeRth9e5wqoTpP8DozmjfX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzq/5sKDc+ZHwXoHk8YXEdBulmrjxLKXf3ZKxyfvHDRDbFUTYUehq0z6eUZSDEGdr
	 asr8ejipgZhhlmWJgc5o1/h0lokuVDGoYwnamoXB1QN6ko9yHgNu3hk2g8eC8+qOG0
	 /rY3URVYyDJSDz729P0r1ZeDrni81u2eDQ0YChHvhUYEJkEGb+dpdVtNkM3qelesEF
	 qOolapR0pCu20zZkr08UeVpwOOfYAFTOp7zORtKyHFtfBokk6saCHPsIKgUxUnpxSB
	 zfniiXWpxD6IKtlAe7dv/NRATixWYkxP4bODQCjZWJEzQoKQjZF19BxZgG2t7Bx2oo
	 3O9cFf3YpoPig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	Guolin Yang <guolin.yang@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] vmxnet3: update MTU after device quiesce
Date: Fri,  5 Sep 2025 14:12:36 -0400
Message-ID: <20250905181236.2924099-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052426-pleading-slip-af7c@gregkh>
References: <2025052426-pleading-slip-af7c@gregkh>
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
index 50a7a1abb90a0..f3c628a64b954 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3147,8 +3147,6 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	netdev->mtu = new_mtu;
-
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
@@ -3162,6 +3160,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
+		netdev->mtu = new_mtu;
 		vmxnet3_adjust_rx_ring_size(adapter);
 		err = vmxnet3_rq_create_all(adapter);
 		if (err) {
@@ -3178,6 +3177,8 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 				   "Closing it\n", err);
 			goto out;
 		}
+	} else {
+		netdev->mtu = new_mtu;
 	}
 
 out:
-- 
2.50.1


