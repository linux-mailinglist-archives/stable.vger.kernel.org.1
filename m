Return-Path: <stable+bounces-201066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F05DCCBEF5D
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 17:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DB9330026B5
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C9A2EBB8D;
	Mon, 15 Dec 2025 16:36:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BDB7494
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816601; cv=none; b=NGC4/gdNb06BNiPYEmO95UrnbM3GlaUlkBQDRyYP1eKXJCVHwTEQ6Wrva8fJNbBZr3MCl+sTkIL1q/AlXnp2q9IebYOrv0tjXA/i85BSEAlxN1k1m6FJtz+mdYti2SUMMf3XJ+IseA4pegrQba85/+u+QEjQnoOMjdOGOCEV9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816601; c=relaxed/simple;
	bh=0RY55mfFGBRtNJiEK3rjYCjDswnCcRH35/VFzL8Oigk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2awdfuWTv4MAIjCIVJFyPYjsIPhizKnJdbejxTc3gMPshAGPl7J+HrnMNeu6DZnYFBV/oxRb/l+73y+LqTv3c53b8zGpycfXI8F9cPzPHpPV5XRm3jHOG4VlgzN7LTEx8gAJJpZdpuupXwEZbJs5wH84M0aAYWGPXktX/etoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dVQgQ4pTnz6Cy;
	Mon, 15 Dec 2025 17:36:34 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dVQgQ0R3wzCMS;
	Mon, 15 Dec 2025 17:36:34 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Mon, 15 Dec 2025 17:36:14 +0100
Subject: [PATCH 1/2] accel/rocket: fix unwinding in error path in
 rocket_core_init
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-rocket-error-path-v1-1-eec3bf29dc3b@cherry.de>
References: <20251215-rocket-error-path-v1-0-eec3bf29dc3b@cherry.de>
In-Reply-To: <20251215-rocket-error-path-v1-0-eec3bf29dc3b@cherry.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

When rocket_job_init() is called, iommu_group_get() has already been
called, therefore we should call iommu_group_put() and make the
iommu_group pointer NULL. This aligns with what's done in
rocket_core_fini().

If pm_runtime_resume_and_get() somehow fails, not only should
rocket_job_fini() be called but we should also unwind everything done
before that, that is, disable PM, put the iommu_group, NULLify it and
then call rocket_job_fini(). This is exactly what's done in
rocket_core_fini() so let's call that function instead of duplicating
the code.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/accel/rocket/rocket_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index abe7719c1db46..b3b2fa9ba645a 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -59,8 +59,11 @@ int rocket_core_init(struct rocket_core *core)
 	core->iommu_group = iommu_group_get(dev);
 
 	err = rocket_job_init(core);
-	if (err)
+	if (err) {
+		iommu_group_put(core->iommu_group);
+		core->iommu_group = NULL;
 		return err;
+	}
 
 	pm_runtime_use_autosuspend(dev);
 
@@ -76,7 +79,7 @@ int rocket_core_init(struct rocket_core *core)
 
 	err = pm_runtime_resume_and_get(dev);
 	if (err) {
-		rocket_job_fini(core);
+		rocket_core_fini(core);
 		return err;
 	}
 

-- 
2.52.0


