Return-Path: <stable+bounces-177869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15FB46197
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7625A2F7A
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF31C36CDF5;
	Fri,  5 Sep 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL5QwZ7W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBDE3568F9
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095196; cv=none; b=DjoEGwv/caihRDYea09Nx0haXs488+w8V7KxGm3e0tt+Txvsi+cRFgFzbSNqVlvHhK/LyPWbU8ZG6xbYpdthMW0f2dm+kpVPEBRv8b4Pgdru8mOJhb139y8OjUpaqICcZ759rzFUKr5MZ9hESfjMnAJTFN2cpJjLrgDTL2MjVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095196; c=relaxed/simple;
	bh=wrrLTSjqbPHyp23okGnE20BYpOu4JBJg34wBN8FgvLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s42rmcKN2FC1WK+JDZn9zaCeJNrzuDKi8B4JDnrz0q2zwhhOLQq+ggnIAhlWeq/QT9rJkBH4vDCOBfx9igKr4mGucxqa+Cmn2/XehCxSi/RDyCy2P5ikxL69XFQeyP4PNV6bhNA2K+iD1Za9KRJ4f2BbuAjHIgwOGAh8/+WCQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL5QwZ7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAB1C4CEF1;
	Fri,  5 Sep 2025 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757095196;
	bh=wrrLTSjqbPHyp23okGnE20BYpOu4JBJg34wBN8FgvLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bL5QwZ7WRYrAGZr1TZAaYhDa0Mr8THmtDGzDHBAkORrDPNuEyDJvi496yUUYC0Lbl
	 pdPXmelhGjFnrI+m+hIZ8c5tiMzK0p/CIpA3LzPnraOmt1fCvUcBOeRf1iToMfxpbN
	 qC+q8ZEtL8wYyojz4LOC4lrMaPCYj8rDqge4X+GrUpvtehbcaCORDHcmRHGtJbqewX
	 drW/gnsW+ybeQtwNlGFwzUO3ySl6ihT05WTOu679XCyYyVPyXIgs3kEij5EWzbtroJ
	 kZIsr9eEl3wY9bCKKMplSDxGVkymmyaNchCmnc9b7G+ICqKScXOctT0thJJR9fOqgi
	 blB7cJ0CUZvig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	Guolin Yang <guolin.yang@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] vmxnet3: update MTU after device quiesce
Date: Fri,  5 Sep 2025 13:59:53 -0400
Message-ID: <20250905175953.2282428-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052425-posture-finlike-af9b@gregkh>
References: <2025052425-posture-finlike-af9b@gregkh>
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
index 78d8c04b00a7f..269e0bf1301a7 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3175,8 +3175,6 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	netdev->mtu = new_mtu;
-
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
@@ -3190,6 +3188,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
+		netdev->mtu = new_mtu;
 		vmxnet3_adjust_rx_ring_size(adapter);
 		err = vmxnet3_rq_create_all(adapter);
 		if (err) {
@@ -3206,6 +3205,8 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 				   "Closing it\n", err);
 			goto out;
 		}
+	} else {
+		netdev->mtu = new_mtu;
 	}
 
 out:
-- 
2.50.1


