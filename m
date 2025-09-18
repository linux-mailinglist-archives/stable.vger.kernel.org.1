Return-Path: <stable+bounces-178193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FB6B47DA0
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44D617CA3C
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0C527FB21;
	Sun,  7 Sep 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TWcT59m4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE61B424F;
	Sun,  7 Sep 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276060; cv=none; b=QJ/whZjvqqJrq7NQ2MxgaRl0NbuMcdIE6HaVE3iKQosM7bdpgD4NgqX1mVGbljrbDys9b4cyFYnqnyBDe9CnDFQAzp/reBHcqfp9WFyDHheeIptRg9+ht0kTwWS/zjEE5ezpVFEfj4ktGho1Qhgmix9OXNiVZP5HCSMpByB5yTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276060; c=relaxed/simple;
	bh=l5NOygkF8W5Ukg9SvatM2/gVwnxdR1IESTB5ciDO3FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcR33qINB5zKsgkJ5qWDtESWh6VO14fxfQVHfvYh+1iQf55uORRL1IQZIVHxEHVChiP5eb8ylI8/f71up4yscMQrqOZG6qz6PIteBfWzoWTCH9mUI2FgmVL8v/ovLoCuIGUHbJthbmPkL6/jQ2SM37fNuq9RpQWP/SZhpQenojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TWcT59m4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541CCC4CEF0;
	Sun,  7 Sep 2025 20:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276059;
	bh=l5NOygkF8W5Ukg9SvatM2/gVwnxdR1IESTB5ciDO3FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWcT59m4ImqE+1+O5fDRDrGzcnXKFg9EnY1Bezy5kTEgh7AHPi7/sxlQ4EKFBTBw+
	 vFtAbhYzxswZQqfCqTf9s04KHoe1yY3e7XD1Pt2KS+tABi9IyMGY8HLlssl7tfzlYQ
	 n7WYSO29rnK/dv1UOm1Sg+fPHl4nsuLMQOeKhdU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ronak Doshi <ronak.doshi@broadcom.com>,
	Guolin Yang <guolin.yang@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 50/64] vmxnet3: update MTU after device quiesce
Date: Sun,  7 Sep 2025 21:58:32 +0200
Message-ID: <20250907195604.790183369@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195603.394640159@linuxfoundation.org>
References: <20250907195603.394640159@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vmxnet3/vmxnet3_drv.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3175,8 +3175,6 @@ vmxnet3_change_mtu(struct net_device *ne
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	netdev->mtu = new_mtu;
-
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
@@ -3190,6 +3188,7 @@ vmxnet3_change_mtu(struct net_device *ne
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
+		netdev->mtu = new_mtu;
 		vmxnet3_adjust_rx_ring_size(adapter);
 		err = vmxnet3_rq_create_all(adapter);
 		if (err) {
@@ -3206,6 +3205,8 @@ vmxnet3_change_mtu(struct net_device *ne
 				   "Closing it\n", err);
 			goto out;
 		}
+	} else {
+		netdev->mtu = new_mtu;
 	}
 
 out:



