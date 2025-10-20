Return-Path: <stable+bounces-188116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D59B6BF176B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6CF1884ED6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3672FB0BC;
	Mon, 20 Oct 2025 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTuc1S2d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8DF2836A0
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965878; cv=none; b=dldRWtjp4V3Phj9EeNGJqyFIa3ZOcPNwXHN5P6ujyOZzpMVjPcsfmlwJMkaUGCNzkS6bRPu/73wxlEtp1W8FUs2GdxhjNQfWjanVv8sGmrj+cySSKzkk+0do/yL/E35lS8NpHs/Ini8qwbGa8Z+9Xi2zbElabnIiBc9a5UBK1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965878; c=relaxed/simple;
	bh=vXiolcoMlN5Pxo7c1BMV9BLU1Wt1PM7mQNzBqSMpKY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1LDZqUurb8MYmd7ZlcwC6gbh9WHO+d85z5Nuv8v3hZuwseo8bEP8nNKLTQIAOJBcXmcvTeZggaAz4aORJXO4KsZuj5deaIwx3t7/xdjMCU9lYZNchba4Eg4lfIcT7F0oaP7pquZ8afFoDikt18DRdGYqEqpt92c6B1NPZs3zUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTuc1S2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77ECC116C6;
	Mon, 20 Oct 2025 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965878;
	bh=vXiolcoMlN5Pxo7c1BMV9BLU1Wt1PM7mQNzBqSMpKY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTuc1S2dcvb71JzI/AyrPz6r/xlfxanLCs54hpjvVMTOOXSQtqxN0ROWn7wBBTLt2
	 A2/3XDgZndVD21cYJ3t/FNG/YqF//bK+rbf4MhIehNc2WwDXSlY+9eO7/Uwqe4wg3F
	 EM9J5MoHlPgJK02als4tK7X/Xpj0Rn/68Pi3/stcvOda241h9v4814IJHc2by3Y3p5
	 cOaEqPoyERC4WqZBNxImnu3XY5J3ZCTedx7p0bDt6GlF08Z7K0qUV8lYTD6H0pRB1B
	 tQ+kxeLqdiHaaWzneZDl9tKbWQsJLp2V/6PatE9+LcyquZiuBunKbpnYlnhloLH4da
	 2JBbKgdis2IMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended
Date: Mon, 20 Oct 2025 09:11:14 -0400
Message-ID: <20251020131114.1768095-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020131114.1768095-1-sashal@kernel.org>
References: <2025101624-legacy-gab-3e94@gregkh>
 <20251020131114.1768095-1-sashal@kernel.org>
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
[ adjusted context to non-APEX suspend/resume implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 4703507daa051..2032769f1d639 100644
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


