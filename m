Return-Path: <stable+bounces-188103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB01BF16B4
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E983BDADD
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4438E19C553;
	Mon, 20 Oct 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7pQPi79"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329C2FFDFF
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965508; cv=none; b=X+ClgbPF/gV87YYZuuEMurepJr6IliZUgt1YiUt7di9Q98VK5SpDV0vu/sYmicAD8VFek00ZKPHEUNcQIbT3WJgYu5DhFgwMHE659A9zoe5lLaL5dKsk1RbpHHWV/oAsi6XNy5NDVtVuIItGa0slROlNrKMHZlZpaEhIpBDMGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965508; c=relaxed/simple;
	bh=PmJ8HWPjPUxEJi5JfAiox46llEx09C1OREpE6hfCr04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIZYF2ZljTD9eSYRfpjE4EkaEybZx9vPhnBEH/gOI7gB0vYGdz6UtaF2Hb4KI1mnnMrgK/h8i7SGchEhebp1zQC1ByKlDuE56Ey+pMFslh8KQroXSKsZz9xJBJ4rI6g9mpRNRzeqeYaS4oiL6tOsVCuNAPr2mWv2u5iznX0KFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7pQPi79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25E7C113D0;
	Mon, 20 Oct 2025 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965507;
	bh=PmJ8HWPjPUxEJi5JfAiox46llEx09C1OREpE6hfCr04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7pQPi79RYADmosajrUYeNWg9ufad7ogPHLRDAWuFjwn+pVW/Kg44q4KKof425uxj
	 Q51BkyWUcmpdOBFJazbgmSnOTBTyxbjJtESDTDRy8B8bCLBmaey0olnmG/1GG2YRM5
	 TwtYShWpSCE/31X6/V7q3rKFOQF0zq2QFZJ+qO8B9IWGNNRpfHG8GGUzNHKEmMpBS4
	 z1PDtB0Zw+/zMJWRmDe18ufvNpENgDjFKqZugRS4K0QwSZNR6ShNmoMFB6qpd3tY9V
	 IEU3JCaJa5xkkvmWiMjco1wNkWRqeIyN1SA+i4c3WRK0wVLV0sDzwWU4gsg0rtU1Qk
	 HZyYfUs7OPljg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] iio: imu: inv_icm42600: Simplify pm_runtime setup
Date: Mon, 20 Oct 2025 09:05:03 -0400
Message-ID: <20251020130503.1764881-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020130503.1764881-1-sashal@kernel.org>
References: <2025101603-magnetism-bonded-4bc7@gregkh>
 <20251020130503.1764881-1-sashal@kernel.org>
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
index 4703507daa051..367d2efd89e05 100644
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


