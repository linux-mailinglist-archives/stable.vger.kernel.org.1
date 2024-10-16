Return-Path: <stable+bounces-86498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 003979A0AEF
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 15:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AC71C2453E
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD120966C;
	Wed, 16 Oct 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VL1qOkup"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD13208D7A;
	Wed, 16 Oct 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083759; cv=none; b=GjP0Tu9NqV36RNGPeWT83cEtva8AxHV272H6hh//1d/mD1SI5vIYeyYLR2RmBSwffnkM0jFyoJ34frwIQdbmpav76MsYuwVtDxI69xNho2cyWc0WIcdbfAM7201gVTOofX/NYaRTGio3UrzSFT02fK3s0NFicrxfDwhKM/YgQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083759; c=relaxed/simple;
	bh=bDAzz8rEagZA0Ehp3iX6ifhXsUe2CA1xnyoJA1RJ0iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNYmY+6SNlR9gAU4BC1VAz33FB7ikickwB8RQ38P2lg97fSZXt9dYQSMjMRBjg/QEwo1CTk100FEjGHF0Lf9QCBfkSc0p4kDMLH2arVCQAfiVQdzXj6CfxfNVIWxzHYv3qMukfEC38klJcNxOyTVOl4o/VShygJljSxPQG5N0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VL1qOkup; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B2444F50;
	Wed, 16 Oct 2024 15:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729083653;
	bh=bDAzz8rEagZA0Ehp3iX6ifhXsUe2CA1xnyoJA1RJ0iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VL1qOkupAdXhqRkKe0reDiXstfkIcizMYur9p3i/iRH8ceZ1I8O13eefEBOaWzUOg
	 ZZhI80xe2xScgbKeXShsR2buVSNPm1De8aLqaTYVTBB2cKt3TMqvqpby4D5FPwNpFI
	 z/odzB2VRn93gRvJvCfZe4ItWpiKtHZbBdwr8+hQ=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	kernel-list@raspberrypi.com,
	Umang Jain <umang.jain@ideasonboard.com>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v4 1/2] staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state allocation
Date: Wed, 16 Oct 2024 18:32:24 +0530
Message-ID: <20241016130225.61024-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016130225.61024-1-umang.jain@ideasonboard.com>
References: <20241016130225.61024-1-umang.jain@ideasonboard.com>
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
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
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


