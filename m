Return-Path: <stable+bounces-188095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C761BF16D5
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DC164F5D6C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84824DD09;
	Mon, 20 Oct 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMrGlEo2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B282D23B8
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965362; cv=none; b=W6QQfZ4Bf+eq4a3v5O5BEJsNvZFMgh9xuGMz9Bof+GkYTqxLIGGZSbB25s+UVhzKlsghgiOxrqOf1LFdBBLmDhdQV9+VRYOqxvwTzo8UbBu9jAzJRYFUjqa92D6hb6ZaHN0p+gWotFV9UrXd+0HltBuiToi+N50fAFCVAwPpNVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965362; c=relaxed/simple;
	bh=zkUCGoxE6+UgTWjyNBFE1gTjclXdmnZjMARrP5IAiI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiTVlEu0825bp6ecapck6QHuLCoSkJ+oJdFEQq2vKvdOMnethnJ6Igb1wOQeq1Nhx2xWK108C9Dn8pDgAcuoO4MW0EMpIbB1SRD06oEE+VopYAFBQUUl4Sdor/DSTNMKH5w3AQTl0oixnURzGAc0ax8PH9+KWxjTgkA0DovqKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMrGlEo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF48C113D0;
	Mon, 20 Oct 2025 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965362;
	bh=zkUCGoxE6+UgTWjyNBFE1gTjclXdmnZjMARrP5IAiI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMrGlEo2Od8qWaZlN2J+xcTyi0BWZDkszmr6bsbMKOhtqQe/fv7glUA3BKqe7oycD
	 C3nH5N7x+PwYgxKoJNb4L2/ssQ0wnYXzIXMqYueF5939zgrgdnR7dMGmul8OaZzwP8
	 eolnQ/uz1lHmHOzMJRyodrk7SnP3JogBVNHic13mprNFQfgfrZHJMwfDXGZev+dUhx
	 kOAkKahRBbMChlgbaRxXcEntA6Fo5hoqkFHv6Sgg/kE56ScfuDPYp1mYUQY8ZyVAkB
	 m6rWO2Jzc6l9cK+/Ge2WsenDIjHacsCVhy9JGvYBIrrGr0/Ur+Pa2aKuo/lg/nfKb+
	 pKL87TV2NdiOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] iio: imu: inv_icm42600: Simplify pm_runtime setup
Date: Mon, 20 Oct 2025 09:02:39 -0400
Message-ID: <20251020130239.1763909-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020130239.1763909-1-sashal@kernel.org>
References: <2025101601-manicure-opposite-4330@gregkh>
 <20251020130239.1763909-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Nyekjaer <sean@geanix.com>

[ Upstream commit 0792c1984a45ccd7a296d6b8cb78088bc99a212e ]

Rework the power management in inv_icm42600_core_probe() to use
devm_pm_runtime_set_active_enabled(), which simplifies the runtime PM
setup by handling activation and enabling in one step.
Remove the separate inv_icm42600_disable_pm callback, as it's no longer
needed with the devm-managed approach.
Using devm_pm_runtime_enable() also fixes the missing disable of
autosuspend.
Update inv_icm42600_disable_vddio_reg() to only disable the regulator if
the device is not suspended i.e. powered-down, preventing unbalanced
disables.
Also remove redundant error msg on regulator_disable(), the regulator
framework already emits an error message when regulator_disable() fails.

This simplifies the PM setup and avoids manipulating the usage counter
unnecessarily.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250901-icm42pmreg-v3-1-ef1336246960@geanix.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 24 ++++++-------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 790bc8fbf21da..f7acf2def71b2 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -667,20 +667,12 @@ static void inv_icm42600_disable_vdd_reg(void *_data)
 static void inv_icm42600_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42600_state *st = _data;
-	const struct device *dev = regmap_get_device(st->map);
-	int ret;
-
-	ret = regulator_disable(st->vddio_supply);
-	if (ret)
-		dev_err(dev, "failed to disable vddio error %d\n", ret);
-}
+	struct device *dev = regmap_get_device(st->map);
 
-static void inv_icm42600_disable_pm(void *_data)
-{
-	struct device *dev = _data;
+	if (pm_runtime_status_suspended(dev))
+		return;
 
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
+	regulator_disable(st->vddio_supply);
 }
 
 int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
@@ -777,16 +769,14 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 		return ret;
 
 	/* setup runtime power management */
-	ret = pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
 		return ret;
-	pm_runtime_get_noresume(dev);
-	pm_runtime_enable(dev);
+
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42600_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_put(dev);
 
-	return devm_add_action_or_reset(dev, inv_icm42600_disable_pm, dev);
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, IIO_ICM42600);
 
-- 
2.51.0


