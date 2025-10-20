Return-Path: <stable+bounces-188097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC9FBF16E1
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E093A4F766F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1752FE587;
	Mon, 20 Oct 2025 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hj4Z+ARX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28428136F
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965387; cv=none; b=F5HtlBjinYzvo7iPtYI5n86i4gM9/VyPWijQnc/wsPl8BKUng8N+7tPCQd1r32m1qbFMqqlPOBELCCdm6yiwav7vxvGgXHtRmWtIw/fjrgek+hazRnM0KouhQTE9rYuEfqt9me8D+my/j9+MRcA77IeN3cJHHfWW0aDxofvMjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965387; c=relaxed/simple;
	bh=3+X4obhRO5Mb0p+85HmwcNxP7Rl/+6NTRi7vHDRsZjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jg5OPP1oZkorfOpuPRFMocvtJwdLpVo94QmJWhiQihErld36mZWcpiiCpEtMXIJ+FskB9QPfO1izpxTOsmQcMM1lA/nguWPBKAuJtXPvWDVdJU5M0KoIOj/rmsZ5hAiMRChMxbFVkofjJTHzS+NwmG140g7Nliybk2uiPLgtvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hj4Z+ARX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A3C116B1;
	Mon, 20 Oct 2025 13:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965386;
	bh=3+X4obhRO5Mb0p+85HmwcNxP7Rl/+6NTRi7vHDRsZjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hj4Z+ARXuJnLzZFqpO5QMriBJv+oxnPptOHhwi6U3dGFuysBZ7GHMkFowHrQyLb0L
	 Q0LY1wmOEu4mGLAgg8HIgKuDjYv7sEE7xadXi7/pPzRhr+nlzk4+LIfbc/klQqhIYe
	 NzoCugZH84kRwOzp5y/oxkDHdL965MpZW7n7oWaSvmfoWcJ05HCl2/9g5gKmnrmoiz
	 otGb/wmaqPNECiN1C0ayULPG4cSjspnBVOE7Km98ZFyY9ND0GqjyHzlWTUgZ+dUFZd
	 Z1Uk/PRSmPQ1Yox+03sCoBZWgNnUgdvVTLrBWS1+y2HqRRCyyLQ1VpIndzmMH1rNiO
	 yvn+Gck8nD1Kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] iio: imu: inv_icm42600: Simplify pm_runtime setup
Date: Mon, 20 Oct 2025 09:03:03 -0400
Message-ID: <20251020130303.1764135-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020130303.1764135-1-sashal@kernel.org>
References: <2025101601-document-unwound-ffc9@gregkh>
 <20251020130303.1764135-1-sashal@kernel.org>
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
index a1f055014cc65..a4c8bdba254cd 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -567,20 +567,12 @@ static void inv_icm42600_disable_vdd_reg(void *_data)
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
@@ -677,16 +669,14 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
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


