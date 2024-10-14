Return-Path: <stable+bounces-83767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8A499C6B1
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 12:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB62285839
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8C215CD6E;
	Mon, 14 Oct 2024 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PLaQws46"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8415D5B6;
	Mon, 14 Oct 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900398; cv=none; b=NOE5yPkx+cBZxDBp6THqwUGEyU33I24z++xrI5oE5O6sK9UYLm8+/lbzrt4uslX0L6hHRsP+666DWxF6e0CiYBpzt6DdQ/A2r7+bE1uHdZleAL3FZJzafRJFF5/bVluYXnZvYZKJQqPJFr0TV5BzljdsICO4rZIBeUoC+A2sbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900398; c=relaxed/simple;
	bh=uaq+VezdUHJKrUYtj9d7VcOn+0AYecZGUvHEZTIw4WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAHEeb6tfbSmCZVIeDZA0+mLhm9FwO+m9mq3xbC82KwID4z/T3Qq8UgQ1r4Xm+9PoT+Tg8QoLOdWNMhyre0vJXKmSPDJdmsaDw6kpejVi/PNzMzJNbpUHR2ERipTwUe14doPZt3fy20ESnAFdc7amsnO5055RB7so+EGLkYk5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PLaQws46; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A086A1449;
	Mon, 14 Oct 2024 12:04:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728900294;
	bh=uaq+VezdUHJKrUYtj9d7VcOn+0AYecZGUvHEZTIw4WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLaQws46jfL+o5Ua+94/BFY1mef7eOr6tAzSKlxIG5hujGe6A2NPODDUBkA91nUSh
	 1BsT6JrZREMf4IVGNEsdD7tsT0riBZpbyInuRS0cwKlV2pcQQUHXvsmrU1/jYobUHj
	 /Tng7MrJwYBekMGK2msIITfQBUpCD0lIuWmSePPA=
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
	Umang Jain <umang.jain@ideasonboard.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] staging: vchiq_arm: Utilize devm_kzalloc() for allocation
Date: Mon, 14 Oct 2024 15:36:24 +0530
Message-ID: <20241014100624.104987-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014100624.104987-1-umang.jain@ideasonboard.com>
References: <20241014100624.104987-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct drv_mgmt 'mgmt' is currently allocated dynamically using
kzalloc(). Unfortunately, it is subjected to memory leaks in the error
handling paths of the probe() function.

To address this issue, use device resource management
helper devm_kzalloc(), to ensure cleanup after the allocation.

Cc: stable@vger.kernel.org
Fixes: 1c9e16b73166 ("staging: vc04_services: vchiq_arm: Split driver static and runtime data")
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 7ece82c361ee..8412be7183fc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1343,7 +1343,7 @@ static int vchiq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	mgmt = kzalloc(sizeof(*mgmt), GFP_KERNEL);
+	mgmt = devm_kzalloc(&pdev->dev, sizeof(*mgmt), GFP_KERNEL);
 	if (!mgmt)
 		return -ENOMEM;
 
@@ -1397,8 +1397,6 @@ static void vchiq_remove(struct platform_device *pdev)
 
 	arm_state = vchiq_platform_get_arm_state(&mgmt->state);
 	kthread_stop(arm_state->ka_thread);
-
-	kfree(mgmt);
 }
 
 static struct platform_driver vchiq_driver = {
-- 
2.45.2


