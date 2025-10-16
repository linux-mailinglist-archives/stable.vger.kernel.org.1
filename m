Return-Path: <stable+bounces-186055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA6BE3788
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B60D435885F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C077932D7E4;
	Thu, 16 Oct 2025 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tZbey40W"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335232D7DF
	for <Stable@vger.kernel.org>; Thu, 16 Oct 2025 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618679; cv=none; b=TlVm+mRzJlfqvYa9BfJQtYi6d6TXc4TTK2l9w0ckDMP7F9RcfLq0gaHMsxfvBxobYT3hs3/qkCsDmvkyZ59bzQp6ZVU3BuSPjLuoqW3NoCO/V+kXHH2723quF52aPT3hcrU4CFSwi5NISNZYwykCJt77ChCFQx7RGH0jRe8avHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618679; c=relaxed/simple;
	bh=oxs1U+kJDpsQXdkSJuhZbjG0qMHgxlmPVVmcW/zRTBU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c4Glx/OBJkASKVZcIv8ACUnEJZvZUmWHL0MusMlHvN5pAdV2+SJBH+cCXtnodSLmVH/BICYEjiDt4osB3N8OsKPaaxJzRgnec9+9cXx2l+muZlgx9KR8uLIHlCLgmmLuR4EZ3/9u9CbuA2klWvFcxzhaHPQbNP4htf/+mfylgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tZbey40W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0A6C4CEF1;
	Thu, 16 Oct 2025 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760618679;
	bh=oxs1U+kJDpsQXdkSJuhZbjG0qMHgxlmPVVmcW/zRTBU=;
	h=Subject:To:Cc:From:Date:From;
	b=tZbey40WgJr4cdSLBZOLFoWb4HOGU7zJOtTjDLK8RS/QJH471LCfQ+eJstmNfyfhW
	 HOK2zGrF6teU3HX4r2Ma51IRnhpXy4cCJ4gwjnumAGYmoM/KLAJlpHRKMVo2Qv1l7j
	 spaTjij0k3bCzSwcLTGvLTTYt0qSVeDJvpe/lv6c=
Subject: FAILED: patch "[PATCH] iio: imu: inv_icm42600: Simplify pm_runtime setup" failed to apply to 6.6-stable tree
To: sean@geanix.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:44:02 +0200
Message-ID: <2025101601-document-unwound-ffc9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0792c1984a45ccd7a296d6b8cb78088bc99a212e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101601-document-unwound-ffc9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0792c1984a45ccd7a296d6b8cb78088bc99a212e Mon Sep 17 00:00:00 2001
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 1 Sep 2025 09:49:13 +0200
Subject: [PATCH] iio: imu: inv_icm42600: Simplify pm_runtime setup

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

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a4d42e7e2180..76d8e4f14d87 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -711,20 +711,12 @@ static void inv_icm42600_disable_vdd_reg(void *_data)
 static void inv_icm42600_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42600_state *st = _data;
-	const struct device *dev = regmap_get_device(st->map);
-	int ret;
+	struct device *dev = regmap_get_device(st->map);
 
-	ret = regulator_disable(st->vddio_supply);
-	if (ret)
-		dev_err(dev, "failed to disable vddio error %d\n", ret);
-}
+	if (pm_runtime_status_suspended(dev))
+		return;
 
-static void inv_icm42600_disable_pm(void *_data)
-{
-	struct device *dev = _data;
-
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
+	regulator_disable(st->vddio_supply);
 }
 
 int inv_icm42600_core_probe(struct regmap *regmap, int chip,
@@ -824,16 +816,14 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
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
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, "IIO_ICM42600");
 


