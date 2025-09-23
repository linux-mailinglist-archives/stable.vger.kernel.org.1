Return-Path: <stable+bounces-181479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C0B95D99
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AE52E161A
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C722DEA79;
	Tue, 23 Sep 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C22JLwAL"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2942857D8
	for <Stable@vger.kernel.org>; Tue, 23 Sep 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630851; cv=none; b=V9KDqGGzTjoh4YXrI2Fgy2viJjNDfN2J/z2nLfXw72YI1lPUL1DIf7RcDLk7G8YkD6Z2qxUGRBGkgj6zGr+liJeAOBec265PbHgh6mkbJ56Dr09NMIRZSmdMavaO+ANm9H8u1goSzaegmqQZi14wZAA5N6AC/otvTdUVVnLTsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630851; c=relaxed/simple;
	bh=nQU8zIiwBd4Xs2XZrdYIMkfUA5WRtFVoNZf2iZpxFhU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=AaVyZM5dxot6HispVn/cDVItNVoP8545NLL8J6dp6Vp3xXufrdgO5mjEVJMOPnBgXzvVrzE1EWG0ghkygrdyavxMcAj5AW+OF+FxSMxATMgyRI0+f3pxaO6cua+rva8eJOi+nsuj+19ld59+6F6yIJWjZLnMaMyopinS9mUxtlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C22JLwAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94856C4CEF5;
	Tue, 23 Sep 2025 12:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758630850;
	bh=nQU8zIiwBd4Xs2XZrdYIMkfUA5WRtFVoNZf2iZpxFhU=;
	h=Subject:To:From:Date:From;
	b=C22JLwALnT0gUl3s05GGyNzRUBd3aXsY7Wr4mTr4VYZ8vvaIc6tRE7dIbrz/3ZPdK
	 QswXcwWddUTJdbW7+lPGUTmRrmm4xQ94CS6Lat52TjZfPjvVe7lL7Kw4/OhKMfWUul
	 1r/bbNRKkLJABkWjqU4eF6succqt8VQ6zK1SYPr0=
Subject: patch "iio: imu: inv_icm42600: Simplify pm_runtime setup" added to char-misc-next
To: sean@geanix.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Sep 2025 14:19:20 +0200
Message-ID: <2025092320-chitchat-dismiss-a19d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: inv_icm42600: Simplify pm_runtime setup

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 0792c1984a45ccd7a296d6b8cb78088bc99a212e Mon Sep 17 00:00:00 2001
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 1 Sep 2025 09:49:13 +0200
Subject: iio: imu: inv_icm42600: Simplify pm_runtime setup

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
---
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 24 ++++++-------------
 1 file changed, 7 insertions(+), 17 deletions(-)

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
 
-- 
2.51.0



