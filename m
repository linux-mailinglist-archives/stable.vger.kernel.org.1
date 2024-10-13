Return-Path: <stable+bounces-83650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA99699BA7F
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 19:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7835DB2155B
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9061474B8;
	Sun, 13 Oct 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PuU6+da+"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB0231CB3;
	Sun, 13 Oct 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728839792; cv=none; b=CQ0enHX8t02Dmljlxgsl1msqvvd02aVUrKKubW1AQ4FvU+FnJA78OvXJCKXi6R+vxeDzsQZhBNqhtWzZ7KVb5JWfcrs5/lPFY+tFQr3wH4uJsl0BAzTgrJrCImT8qlSL9S0c7SCK4ZQcWqhZW66KvDNrYCcMDOK+v+3vp3Je3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728839792; c=relaxed/simple;
	bh=lszqkzooi/14FP99VptZF43wt7uBIMlNx7+MBmNiqIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMnyMlKh0Sfw8whLWesyxMQs2v/oMQjlwNDP+FWQfeCXyf28Qnuib/qTDoX7PUrhVqEnnS07kZmgCNa4wxpnEKdf1/hwLBWiI4gKc+8wwp1Nq2B3ykyr5mj5x94lckSgUQe4/eIL+oXsB5WDNAIH1DiHRy2dyQqM3j4DVwekEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PuU6+da+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1AE774CE;
	Sun, 13 Oct 2024 19:14:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728839688;
	bh=lszqkzooi/14FP99VptZF43wt7uBIMlNx7+MBmNiqIc=;
	h=From:To:Cc:Subject:Date:From;
	b=PuU6+da+27o+EnRc06HCMOStCI3/M8zn4fintv8jUqifpgxnZxZlSW9rzf2tB+Rr9
	 C1X/Lm9pRUi9Pd0t9ThnIorPoH1JkLkGjJyH0P92i+nFcRdGRhtMq4tWMeboW7AoLH
	 vCcylIg3Nyg6jqry69sobrpi+ajoTTPeCpFa4/1w=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: vchiq_arm: Utilize devm_kzalloc in the probe() function
Date: Sun, 13 Oct 2024 22:46:13 +0530
Message-ID: <20241013171613.457070-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two resources, 'mgmt' and 'platform_state' are currently allocated
dynamically using kzalloc(). Unfortunately, both are subject to memory
leaks in the error handling paths of the probe() function.

To address this issue, use device resource management helper devm_kzalloc()
for proper cleanup during allocation.

Cc: stable@vger.kernel.org
Fixes: 1c9e16b73166 ("staging: vc04_services: vchiq_arm: Split driver static and runtime data")
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 29e78700463f..373cfdd5b020 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -285,7 +285,7 @@ vchiq_platform_init_state(struct vchiq_state *state)
 {
 	struct vchiq_arm_state *platform_state;
 
-	platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
+	platform_state = devm_kzalloc(state->dev, sizeof(*platform_state), GFP_KERNEL);
 	if (!platform_state)
 		return -ENOMEM;
 
@@ -1344,7 +1344,7 @@ static int vchiq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	mgmt = kzalloc(sizeof(*mgmt), GFP_KERNEL);
+	mgmt = devm_kzalloc(&pdev->dev, sizeof(*mgmt), GFP_KERNEL);
 	if (!mgmt)
 		return -ENOMEM;
 
@@ -1402,8 +1402,6 @@ static void vchiq_remove(struct platform_device *pdev)
 
 	arm_state = vchiq_platform_get_arm_state(&mgmt->state);
 	kthread_stop(arm_state->ka_thread);
-
-	kfree(mgmt);
 }
 
 static struct platform_driver vchiq_driver = {
-- 
2.45.2


