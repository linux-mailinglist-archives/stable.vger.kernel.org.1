Return-Path: <stable+bounces-188114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14812BF1765
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26DB84F5B6B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DC030DD2F;
	Mon, 20 Oct 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTGN4qsx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5852FB0BC
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965834; cv=none; b=tk7NeZ8bxiwR+IEqv9TR8RKuoRwlNtZgaGKstj7I9ym3NWJyFkGfi+5lzyxQvmLPeGhlkejN+W8jKdbcsLXv13Cv/tAHlBJBz8oXWGCdJobkmYdKrIBo9jiqVVHdWr9ZEoKGSlHu182TgkrdRlSKGVxWSMSRgUFr4fMF7F3G/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965834; c=relaxed/simple;
	bh=LPsN56EZ3SnTp4GM0t2qPocnuET1JEbzA/pCtm016Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3oqGUjTH7hzOsXRnwhi0PLNnKm8l99u/Fyeqi78yuSwGTDJlj6ZWcG2FJ+w4XGViYHlDh6+wA1p6CPzECvtX24StltMxGI+AFh2ylvXDa/1Eb49jTbKKuqJ9tlCdQmt93RDrSYZDjFm1AXUPlGSqBrXffYhi8zAPE1tyJ3zj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTGN4qsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1F0C116C6;
	Mon, 20 Oct 2025 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965834;
	bh=LPsN56EZ3SnTp4GM0t2qPocnuET1JEbzA/pCtm016Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTGN4qsxKCAt7k3smxihWHRI3JObai5/Mw7r5dMg0I7Z+vCKiHKlfYbAsoqjVMvO8
	 tGKe0roz04PLo3UROm2/FBh+v/BRgpXqGMlDLZQbhe5OUYwUMXtMxtInyGxUdOQLBi
	 it24W1j34zy2TTY6r5kb3DiPLvcZi+zUj2IF3XjPZ9TWhholsxw639TLVCiVRziTPU
	 60u0zlhQmxYVEuwojJyIMXkn5Nn20X82O4CEhBan0AA6XKJdY31FLw9mbl3OiStV4U
	 O7aLTtm+XTwVMQgDsYwnXWv1RHVdckj73WlmayQflS6cRrv8kWz57rugMinT7hdCiR
	 NXit1DEGMP0WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended
Date: Mon, 20 Oct 2025 09:10:30 -0400
Message-ID: <20251020131030.1767726-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020131030.1767726-1-sashal@kernel.org>
References: <2025101624-blazing-sharpener-111d@gregkh>
 <20251020131030.1767726-1-sashal@kernel.org>
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
[ Placed early return before regulator enable instead of APEX wakeup logic ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index f955c3d01fef9..cee9dee004a31 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -680,17 +680,15 @@ EXPORT_SYMBOL_GPL(inv_icm42600_core_probe);
 static int __maybe_unused inv_icm42600_suspend(struct device *dev)
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
@@ -722,10 +720,13 @@ static int __maybe_unused inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	struct inv_icm42600_timestamp *gyro_ts = iio_priv(st->indio_gyro);
 	struct inv_icm42600_timestamp *accel_ts = iio_priv(st->indio_accel);
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


