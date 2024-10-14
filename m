Return-Path: <stable+bounces-83732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A3C99BFDB
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06531F22EC7
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574BB13D62B;
	Mon, 14 Oct 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="l1Mga8Ra"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078E140E34;
	Mon, 14 Oct 2024 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886396; cv=none; b=sjQUSWucvHZqHjgJ7vwBrf5GtjSqlZKlK376xlpifmxR+5leWT3Sehj6y4gsJRu4sXf4Vs2yILz9RpDYVp0TF3Mqrt9NRlu4s+Va2RzlGlTyinYUCyAOZVIqt7apyIYqJMDbx5GWctVmaMbJqOWYuJ5GwiMIyqRON0kgBQtBYTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886396; c=relaxed/simple;
	bh=R0ESmbzFoRfF6h/C7QRmHY0ayx/GIqhuCW301plDmS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcsy+wgenWh4MiNG4cSSI76Jaasf70OhXLwuLs3VXt1L4muY+cr9IADqnNEPKnyPoCGMcgNQV+IqQmNdoGiGRfe5HwmeqmreZteDZvt/wVXLf+GmX0cE80rExDdkjRDpszmfC19xLDyWuCheMIy8haRf0eMZrrRHsl4jILBb87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=l1Mga8Ra; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C536C1449;
	Mon, 14 Oct 2024 08:11:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728886287;
	bh=R0ESmbzFoRfF6h/C7QRmHY0ayx/GIqhuCW301plDmS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1Mga8RaGaPAhu/5YnUVxk6lyC17G8cY2tZ3L/xPmkJd/wXJlh1mQ5SFw18M6F/rq
	 I1Q26HcpGYWWFxibC0YMkrYOCCyIb7+rYlvhpIv10PuLqliU8VdgCKt63LjHej6rfz
	 w0WMgH5AabMaHUeW3OHtFhGylSHfBGgS+ds811Bk=
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
Subject: [PATCH v2 2/2] staging: vchiq_arm: Utilize devm_kzalloc() for allocation
Date: Mon, 14 Oct 2024 11:42:56 +0530
Message-ID: <20241014061256.21858-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014061256.21858-1-umang.jain@ideasonboard.com>
References: <20241014061256.21858-1-umang.jain@ideasonboard.com>
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
index 146442a3552c..373cfdd5b020 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
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


