Return-Path: <stable+bounces-177873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C26B46230
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970955E00F1
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29B12F85B;
	Fri,  5 Sep 2025 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4PiSgzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7033E7
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096595; cv=none; b=b3+rCbTgvsq9xsNtczkJCZ3FE9Vz8blDkjK/MBk04FvyGtnftLIiwtga2gl8n2ZuWvqh/3oK41XUD37D+LLVL3uoBfWv6tQT54IrIIkg8la2SO2cl7MVvNI/iT87UshpGdlPaj8SDOJhPTOzUi/V3x0N92DK4w3YqvWrEVC96tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096595; c=relaxed/simple;
	bh=6sVh43Law8wFN7XKiJF55f8Io3G+RjTy2HNRTy1k3Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJfXQ0nEVgVqgS7DM/EtPwqLhVAYkrnHIbAnUpam9RIAUObPXCCRt5rbBXfuMBMiPRF6kWCF1kfk7A9W3KwbpzmqwIdlWnrqRT00pgUW1hlwrlxyTU9R+0w3HUKl+C7LoacTAnMvUDHzAwXLTSC5QSL+ebtOb/Rd8oXmdzv9lWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4PiSgzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF83C4CEF1;
	Fri,  5 Sep 2025 18:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757096595;
	bh=6sVh43Law8wFN7XKiJF55f8Io3G+RjTy2HNRTy1k3Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W4PiSgzQ/eyP8gIwxJvQVVMRC/SD2SGs2jutk4Zz1sEkRTc5mK7XGv4sElgYCI+Cn
	 WEcB+Sqcrz2LOliDtcJVLBfT1aTOgceJZjNe3OP+K3B99Hi2SbzCleEOmSgmfQZkmo
	 Z9qE4Rw9nwALqjV9oCVd/ydr9l3ofcjPk3acSTSAwNtcCzGSX/Codh+b+lXa+fyd9L
	 pAqIm/67JUHs7U61L+44rfrFWQU2/KITcOktVRCbcHVu0PG9FSFaY9g5BiGCAguRyO
	 sOZAXmOkcoFetg1gIptyPRFbpHzziNyoasaI9GLDNeynm+TSyNyWYTtATEOXFhdDgC
	 VK1EB1BSjSksA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	Guolin Yang <guolin.yang@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] vmxnet3: update MTU after device quiesce
Date: Fri,  5 Sep 2025 14:23:12 -0400
Message-ID: <20250905182312.3024955-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052427-entrust-arousal-0ad5@gregkh>
References: <2025052427-entrust-arousal-0ad5@gregkh>
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
index 609f65530b9b0..a51c4ad9ed204 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2998,8 +2998,6 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	netdev->mtu = new_mtu;
-
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
@@ -3013,6 +3011,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
+		netdev->mtu = new_mtu;
 		vmxnet3_adjust_rx_ring_size(adapter);
 		err = vmxnet3_rq_create_all(adapter);
 		if (err) {
@@ -3029,6 +3028,8 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 				   "Closing it\n", err);
 			goto out;
 		}
+	} else {
+		netdev->mtu = new_mtu;
 	}
 
 out:
-- 
2.50.1


