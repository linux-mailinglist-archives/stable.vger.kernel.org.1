Return-Path: <stable+bounces-188101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E16BF16EA
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 370964F6A5F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6EB2F7AC0;
	Mon, 20 Oct 2025 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R30FtvKl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F51C5D7D
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965481; cv=none; b=UfWzkQj3hzBdFzAhPu7gNvzzsKJRAH6AtPcihfaiON3cbqHOf1YVhWGctLF4fVLgdq4+IzoXDlhxtdY3mGqQU+uuMSmLE0XLts7zl8ZEZjeLa0xLDumioumESVAKadlzaSTr1oe0hdlmrSf3Bq3DFEtmQv7xWtFahGNpdR161dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965481; c=relaxed/simple;
	bh=wNjBp/mverybAZ5vsQ0A3OK9SWTCgbViqKTU5ryONYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bin7OkLq0dNbvMVpOuhptHQc4+PrZj3CflRR9Id+62pI8CahiVj9miTp7SOCIE3yImaZXd6hAZiwpdSjKlJEkGYNyTDHyj9fhImHJJpfvk/fB3iKzuZIOWovTQ0WgwnVDH/4FJyAqQ6+K4qBHK+QZAFP/4RwlxfAy7dse/irFJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R30FtvKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAB1C116C6;
	Mon, 20 Oct 2025 13:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965480;
	bh=wNjBp/mverybAZ5vsQ0A3OK9SWTCgbViqKTU5ryONYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R30FtvKlAW+Tjn6NrU1pAAdEE7xZV0DVIsBwWzdIsHKgaQcnxMiu7Zf9j0lF5pm2m
	 F/GbuzvWI/uWU6UqeDD/wvaK30WviDe9gEwPMHiQ8F8R9vFV/VqVVC28IuC3EzI6Us
	 HJt9P5j1xV8sd6k4GKAhjaogw5PDSxFkGBZA7oCu1AoKSFCoYhlOOcZ1MYhgo0oqrW
	 BHDLpwn/3Jvkwt7ECPEjHWpmzHMJJgY8tV0ggxiuLUC3J1K3zo33gTv1fGFAkREIYa
	 OPQnDdm4VN6JjJqOBL1UlU4jINnlrIsGVpOzIkQk//sTmsJTmOjFVLI9MVVDST9KVb
	 y7T36wxBQHH6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] iio: imu: inv_icm42600: Simplify pm_runtime setup
Date: Mon, 20 Oct 2025 09:04:36 -0400
Message-ID: <20251020130436.1764668-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020130436.1764668-1-sashal@kernel.org>
References: <2025101603-foster-panning-5b9a@gregkh>
 <20251020130436.1764668-1-sashal@kernel.org>
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
index f955c3d01fef9..f6ed2354163e4 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -550,20 +550,12 @@ static void inv_icm42600_disable_vdd_reg(void *_data)
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
@@ -660,16 +652,14 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
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
 EXPORT_SYMBOL_GPL(inv_icm42600_core_probe);
 
-- 
2.51.0


