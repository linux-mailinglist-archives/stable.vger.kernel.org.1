Return-Path: <stable+bounces-83766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB35399C6AF
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 12:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBAC1F22E43
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B4615B546;
	Mon, 14 Oct 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kdnrhXWv"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E50158DD8;
	Mon, 14 Oct 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900396; cv=none; b=KoHchX+577UWiFm8Mc4e44SIgHQZ98Yfg93AgnovaH/PYjuZnTBnqcalhRQKiqxKgCO2TKxhwWjNbx8xXlQIxPeYdrrqtfG9vZ1WoqdJVjzFNREHaFOtxY9vLtNMKxz9KfFfQ1ppGAGmkumhL4sNZaGV5v3ZJQgJfHD92vFc0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900396; c=relaxed/simple;
	bh=OG70jJR+91myI+hPfV/bHA4o5/PggLwB9TA01NFxDwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQRt7B39F5t8bkHPKEhiBslUN+Vz/+bec2cXWwMfR1bT3Iocl8kt7AwwHWARfAz1o8SCOg+1tB2DessRXE64BLrhshTlDEsfKAWJ/BhmkM0j9YkF7UJJZxkjHY2LMma+pVvbjRroZT2uWWgZOiwuipdNrkNsXk7YvKcS1dPeSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kdnrhXWv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 361D796C;
	Mon, 14 Oct 2024 12:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728900292;
	bh=OG70jJR+91myI+hPfV/bHA4o5/PggLwB9TA01NFxDwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdnrhXWvsk4jeVG/EosuAP9pGJUTtvHZC2UtcyFZytQ3PvX4deCU+W3hMxlYSkYY6
	 QZk1+uDwpJEjJ9KUKVCteB8STI98z2+zebY5r3MtSQJIPqaC6LgihQUXQM5BTydjif
	 bVxlUXjnKoHcSQYtPCJpvgVRsUq107FW5KM6uIfI=
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
Subject: [PATCH v3 1/2] staging: vchiq_arm: Utilise devm_kzalloc() for allocation
Date: Mon, 14 Oct 2024 15:36:23 +0530
Message-ID: <20241014100624.104987-2-umang.jain@ideasonboard.com>
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

The struct vchiq_arm_state 'platform_state' is currently allocated
dynamically using kzalloc(). Unfortunately, it is never freed and is
subjected to memory leaks in the error handling paths of the probe()
function.

To address the issue, use device resource management helper
devm_kzalloc(), to ensure cleanup after its allocation.

Fixes: 71bad7f08641 ("staging: add bcm2708 vchiq driver")
Cc: stable@vger.kernel.org
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index af623ad87c15..7ece82c361ee 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -285,7 +285,7 @@ vchiq_platform_init_state(struct vchiq_state *state)
 {
 	struct vchiq_arm_state *platform_state;
 
-	platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
+	platform_state = devm_kzalloc(state->dev, sizeof(*platform_state), GFP_KERNEL);
 	if (!platform_state)
 		return -ENOMEM;
 
-- 
2.45.2


