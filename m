Return-Path: <stable+bounces-177860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431CFB4602B
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B673D1BC8C39
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8632F7AC3;
	Fri,  5 Sep 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWZylA1t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8630B535
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093507; cv=none; b=qxf+oB71hwHJJqPOboM/7OPUXv64HJZLYtAVJ7mwd8vOGVxB1JO+Kt6tDeWtZQBTYQintJWoLTTmpeJ+oKW+J2kehdiRhGJ5ntlDVluyvXH9PxBhN7c+2XY9eBaWxynDLBaflmDoNsqH8iLwtpf2aRiYUZUAxqXUHUNSO2jjCKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093507; c=relaxed/simple;
	bh=lF55XsbUS+767Te79JyCKKMqizxwcNJygwnqyUMEE9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj+E+4onFIpvoUkHiy+qsqkKxW+mo+8k8aNlfZgVeb4SBip7GbzFp1ByOkHlbFKBNJnTFzueaNcyxl3PritrP7R2LqVBuISc2NNuh4o3cl8tNizIghos52uboX+rZbL9t0yB70cUPTtIIuksnlKVkempq269VVdbPJF3d8NQ5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWZylA1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D655EC4CEF1;
	Fri,  5 Sep 2025 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757093506;
	bh=lF55XsbUS+767Te79JyCKKMqizxwcNJygwnqyUMEE9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DWZylA1t2n7x5VihDTyRzVzOMt9JvgSf4lz30qfNqqhHmvRP9vUZqrg2GtqNv87cH
	 M7hxiSmGZZrfzf/+iBbDBHxaDfi8QqqWoECkM/zZaNyAf8eM6KNeDLs+TvToAlbFZ5
	 n1AILxcjj7coBgs8eBnMU9g684MdYa9+PIfB+0GqaYGI2ImR1AFVbPdv8TdqAofBgJ
	 f6ObIf5h1yZPyp9as5ujF9BLCb+SO/X0MPmyYjlXxDsO/DwzdQyWZBUSilU0pnA/77
	 xlH+H83RcHE+OFNZHrDQ8+8PyvZFA8o/yVK2li0vXPMGzENjXHB/reQGWqokcZMLYb
	 bGQO7CD3rf6hA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	Guolin Yang <guolin.yang@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] vmxnet3: update MTU after device quiesce
Date: Fri,  5 Sep 2025 13:31:43 -0400
Message-ID: <20250905173143.2078431-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052424-banjo-exorcist-8407@gregkh>
References: <2025052424-banjo-exorcist-8407@gregkh>
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
index afd78324f3aa3..6e4023791b476 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3483,8 +3483,6 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	netdev->mtu = new_mtu;
-
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
@@ -3498,6 +3496,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
+		netdev->mtu = new_mtu;
 		vmxnet3_adjust_rx_ring_size(adapter);
 		err = vmxnet3_rq_create_all(adapter);
 		if (err) {
@@ -3514,6 +3513,8 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 				   "Closing it\n", err);
 			goto out;
 		}
+	} else {
+		netdev->mtu = new_mtu;
 	}
 
 out:
-- 
2.50.1


