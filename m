Return-Path: <stable+bounces-83739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F899C258
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0A61C26A20
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 07:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F814C5AE;
	Mon, 14 Oct 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kT6Uvwc1"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1A155359;
	Mon, 14 Oct 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892755; cv=none; b=IJWRPeAqMPC090B7J/uKRvepscJQFMn5kVFSKbru4ZbdxDKj4MGsQJBWcPZ8SOsznhTBQJC9mTckKopl/T/Q0+igMbfsbcOIG917fVswAcuC/aP0Ax1ZID0DtPNjlCArdM3aSP6YNyGKlPb8psf9Fjs8mLXFnyjLCbxwDigGjhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892755; c=relaxed/simple;
	bh=lszqkzooi/14FP99VptZF43wt7uBIMlNx7+MBmNiqIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxlkbwsLZBY4HHW3O5zKZ9SmAotkr6HTYygooftMRV7WNDYChDsbGpkAOpNjpiE3guj0MWnMtH6CdHJAnL1Wypccr7AuPCB7gX1DqaGKDrYs9aH9GHfdmoUe787ui/wzDP1Kz6cZ4UA+MYVyMs5WFM3EQJ75yosMRNZ6nfNLQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kT6Uvwc1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0718C667;
	Mon, 14 Oct 2024 09:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728892651;
	bh=lszqkzooi/14FP99VptZF43wt7uBIMlNx7+MBmNiqIc=;
	h=From:To:Cc:Subject:Date:From;
	b=kT6Uvwc1VoOMx3WJ0Y8lQoateub1sA/c+//xoPAMtNhZKQCnq+JtkyZ1aQCOe2iKj
	 d4jPffbVa2r1gMPIMbeuqSMdEnNUkc7naY7aMswECj5VLHskuk923UQnd5XmJx95Bk
	 flqgP+VtnLpdUWQ13tmgf6KOnnwowqEEdSODeH/w=
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
Date: Mon, 14 Oct 2024 13:29:00 +0530
Message-ID: <20241014075900.86537-1-umang.jain@ideasonboard.com>
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


