Return-Path: <stable+bounces-195500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 617BEC78E88
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 12:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E48FF2D9F7
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14353346FA8;
	Fri, 21 Nov 2025 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFBTkWLR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0DD2EC0AC;
	Fri, 21 Nov 2025 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763725955; cv=none; b=Dz/FTTCixfotf3n3YtQFV0V8QBq9o8TQreKQlOqdVkW5pxPOxJhSoocannUyt6Letp+ueSezdlnAOzwiS3KlHM1WwXAZX8jdJL/nljOTjfpFEcX5XXK5h8MtX5PvVZbJGXEfadxmWlytpH8ObY0XQuQ4z3UM7RFAvh7/tpijflQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763725955; c=relaxed/simple;
	bh=BjV9u6tBh3Z2pPD14LCQ3iw02Kr9iWTm3PzMnmvVkrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YF+93PDd0Qx9UkMtfCzvbnoE1aYCRng7HWWr7jwc1BS9Z156HTk4XVkrerOIKGzxR6mXuz+B0OOYIGDAEmFhbw8csRfYV83jJSyLklbTFmhghU7C86HGEejKQzUXpstHoDMJ3HTh/pRzfPxEAgrOcVmncD6MzhQwU8SiIalov78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFBTkWLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47695C4CEF1;
	Fri, 21 Nov 2025 11:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763725955;
	bh=BjV9u6tBh3Z2pPD14LCQ3iw02Kr9iWTm3PzMnmvVkrU=;
	h=From:To:Cc:Subject:Date:From;
	b=qFBTkWLRoIpqVgOwHxQqW56VmN72uOuESojAKT2cZWZ4p0aitb48zzb51O4PIaXPU
	 laN8koIJ2NuID5qKNUVmoyx+yAhq5NKvEiCtBP3yxmfgwQ6iC/5D5aXQV9oydFY3XW
	 Y+tZ62NdIOpJdMHteJ5+B0VZjeG6CEhh49rrHTHi4IyQasafU3W8k973ScCSboaRCW
	 /Zo7pOAVypXve8r4TyNmooNPXTrSkiv35XbM5fGFDW0JbWBqEc0DDZ4kSM9wH4IMEg
	 Q7A1XU+pCsYII5ecVUSnk+A7L1bvP1ImrGaQNCK08ew9rGnmuBASmfmOmhCFLQb0ou
	 qgWo/usoYk7Qg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vMPgo-000000002DI-3sfX;
	Fri, 21 Nov 2025 12:52:35 +0100
From: Johan Hovold <johan@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH] perf/arm_cspmu: fix device leaks on module unload
Date: Fri, 21 Nov 2025 12:52:13 +0100
Message-ID: <20251121115213.8481-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the references taken when looking up the backend
devices during vendor module unload.

Fixes: bfc653aa89cb ("perf: arm_cspmu: Separate Arm and vendor module")
Cc: stable@vger.kernel.org	# 6.7
Cc: Besar Wicaksono <bwicaksono@nvidia.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index efa9b229e701..e0d4293f06f9 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1365,8 +1365,10 @@ void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match)
 
 	/* Unbind the driver from all matching backend devices. */
 	while ((dev = driver_find_device(&arm_cspmu_driver.driver, NULL,
-			match, arm_cspmu_match_device)))
+			match, arm_cspmu_match_device))) {
 		device_release_driver(dev);
+		put_device(dev);
+	}
 
 	mutex_lock(&arm_cspmu_lock);
 
-- 
2.51.2


