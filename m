Return-Path: <stable+bounces-188108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2ABBF170E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690AD1886818
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA4E2F83DF;
	Mon, 20 Oct 2025 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poZjyXvO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2825776
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965695; cv=none; b=EkxPeqNJ2sOSDfcPi7grmVGdI5r4/H+6o6jI2Cp18TLgbawLdMnxQ833BZsVN3YUSXJTQPxWRI+E03bPdUhjbvXJFVMXi3V8kosC3+BbogbEZRNos+PRBbuPa3Dmk70glBPyDBo573PwXh4Sj8yFwBBW3C9helBfjijJTyxjMMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965695; c=relaxed/simple;
	bh=3DVHwH/rf9qNlrY0RvRXZOXH99UtXeH78Fic1R06siw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/P0CnhrKZpH+DLItyQBWbTuKyii/G4bErqwDgALWlylf8JuRNG+wSsVru7rtSO678vYKB9Y5kinL+peJ+4Y6wHIC+gIQX6WbqaLI2sst2X2Vw/3gRSCWVHRrOi7bPg9jAn+2zoOAEivfN86Chfn7dlLWEFYHyLj1wLWuzyW8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poZjyXvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07713C4CEF9;
	Mon, 20 Oct 2025 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965693;
	bh=3DVHwH/rf9qNlrY0RvRXZOXH99UtXeH78Fic1R06siw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poZjyXvO9yWr2V5MHhqsRvb5M11nOinAum1mAqQka4e5x4qgoxkKUF7hKPLVfaRep
	 vmazfgw5JplXum7Z4inXS8rSPn6eqN7QWIsJTK6uUpxRsS250RsiX1pWuh7xbpQQQB
	 /RPAUZprhouZQYYNI2DiVYtZoL9V9SykWUVi1gA9ZJ7cdxFqgX/mwqVJ9AYwEyUcqm
	 77EcOaYzfOcgoS7CNAO/OhCi1jisXd3xvTUW33ragSqL3uAGahXZNyzQMmD+7w5CdJ
	 q9W23nY0yYqQ0cEyoOtDd+hWE7T9U3+YqNqB7nY7Be0b2BOzBW5BEYfJ7vKc6cC0oc
	 ev9cTRj1iX/1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended
Date: Mon, 20 Oct 2025 09:08:10 -0400
Message-ID: <20251020130810.1766634-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101623-attractor-shopper-b67e@gregkh>
References: <2025101623-attractor-shopper-b67e@gregkh>
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
[ removed apex/wakeup variable declarations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 790bc8fbf21da..0bd2847bb4b12 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -797,17 +797,15 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, IIO_ICM42600);
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
@@ -839,10 +837,13 @@ static int inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
 	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
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


