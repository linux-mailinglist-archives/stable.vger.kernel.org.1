Return-Path: <stable+bounces-188110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D9BF173E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5933E78F6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584831691F;
	Mon, 20 Oct 2025 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+nfEHnR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746D31691C
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965746; cv=none; b=ppIL8xRDetBlGf+NptLYzahvl0XEfL3broFsSCqEE90Hknu2m+ZghOMuQSLPSMqYeWSRd8JsKf7Wkg+X5BoVgg8o2W4+V/DlGDLFUsSItxhfCu7+20o3rLB4FxoFPr1Ap55BzoNxGjzwt9jQO6BqDIo3DIHsD7urQgocT6lsLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965746; c=relaxed/simple;
	bh=EsIwTYcSVSiO4M5cWQmkFYAz4BI6YpaZ/sgbt+cGGgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jX5HN6r3hARl0wIzK/G6HlLO0z8mvaGn7HjoEn2WpRCAuQuYKkurPIqlIQw3WMojoaOqxh+Im+L0ykxt70nrbaRghs4wO+Czs5J/f/2q6GnMtYjIDggJt32xo/uzXOBMiRkgPxRejjQLHOTIb75ZbrzEg69mXMkshNLVkkwRkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+nfEHnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA44C113D0;
	Mon, 20 Oct 2025 13:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965745;
	bh=EsIwTYcSVSiO4M5cWQmkFYAz4BI6YpaZ/sgbt+cGGgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+nfEHnRIuQ5H39YLE1Xjb413vO5uQv8wsXIY2fc/BVdDIHIsCgPG45UsU86Nnwe8
	 Xkf/D6XO0g07Y9rfxHCFzhy7pm5//FDN3yQmhMiv4TuBL6lceoLQEat6+md/Cfw3HW
	 xOtjOLFPlgYpZkWYF/x7G3qsnvl+6OaUXD9NFs2vgeJoLgD71IGOkntuO7pyMFxCMh
	 X1ZkN3hm4YSFUgw2iUQzsus3kN1cxT/o8fBE1e/XuzQIrF2C/Y3KGAF4i+jU7/gt/T
	 nwzUvcfSDKSPrsg61KM4u3gm0aB7Lhjpt9OLxGMp6hjABjdn9bwx5nuIVTmUT/pkN5
	 f0IjvnIQ4IXoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended
Date: Mon, 20 Oct 2025 09:09:00 -0400
Message-ID: <20251020130900.1766996-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020130900.1766996-1-sashal@kernel.org>
References: <2025101623-dry-crummiest-15b3@gregkh>
 <20251020130900.1766996-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Nyekjaer <sean@geanix.com>

[ Upstream commit 466f7a2fef2a4e426f809f79845a1ec1aeb558f4 ]

Do as in suspend, skip resume configuration steps if the device is already
pm_runtime suspended. This avoids reconfiguring a device that is already
in the correct low-power state and ensures that pm_runtime handles the
power state transitions properly.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250901-icm42pmreg-v3-3-ef1336246960@geanix.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ adjusted context due to missing APEX/WoM features in older kernel version ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a1f055014cc65..8a9383e87540a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -697,17 +697,15 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, IIO_ICM42600);
 static int inv_icm42600_suspend(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
 	st->suspended.gyro = st->conf.gyro.mode;
 	st->suspended.accel = st->conf.accel.mode;
 	st->suspended.temp = st->conf.temp_en;
-	if (pm_runtime_suspended(dev)) {
-		ret = 0;
+	if (pm_runtime_suspended(dev))
 		goto out_unlock;
-	}
 
 	/* disable FIFO data streaming */
 	if (st->fifo.on) {
@@ -739,10 +737,13 @@ static int inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	struct inv_sensors_timestamp *gyro_ts = iio_priv(st->indio_gyro);
 	struct inv_sensors_timestamp *accel_ts = iio_priv(st->indio_accel);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
+	if (pm_runtime_suspended(dev))
+		goto out_unlock;
+
 	ret = inv_icm42600_enable_regulator_vddio(st);
 	if (ret)
 		goto out_unlock;
-- 
2.51.0


