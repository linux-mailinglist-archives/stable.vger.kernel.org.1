Return-Path: <stable+bounces-171882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A17B2D786
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C4F16680A
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD01F18991E;
	Wed, 20 Aug 2025 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q9PQZEH1"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C141DF74F
	for <Stable@vger.kernel.org>; Wed, 20 Aug 2025 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680766; cv=none; b=V//xK10alXIzF0N9eGVM0WVsyKIskuQUqu9Tao/Xm46uhuUqODwEVWZ/hUoxg1mRmuBBOGGicu87iqkq3Q+/Zs43LGYNX/3ze7V7KuhNhh66PR+XB3RMVX0ITM7IkzuzraK7m3RNDLE/zuLnkP8wrAiCEEe5Nq4u3qkPHEoDtMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680766; c=relaxed/simple;
	bh=xUYE3Hwp/DF0oTqsuThYejwoNMaCLjwHfPdV3vqP1p0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=lCqi6tRPLpUlioPXKjkgiY3t4gxNPgAlETHZ8AhjCOOQDxoUIE4hwIXfeWHpYlGr+OxwT/t7eDpTPiVXAyUMa/dUAvxGx/UTASnKIV9aC4EHym3o/JF6Y4NfgrOXpoREwFh/XbIlfcgLmK3E4S745AhcOrUgJEiXp8Ebtkf/bQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q9PQZEH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7C9C4CEEB;
	Wed, 20 Aug 2025 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755680766;
	bh=xUYE3Hwp/DF0oTqsuThYejwoNMaCLjwHfPdV3vqP1p0=;
	h=Subject:To:From:Date:From;
	b=q9PQZEH1zgPOofRxy1YISd0GgvmNaVUuAfOxbRa0pPhy+W0pA3RmlzuER5qEZADyt
	 K35hS04wBurFKscV+DlMMDzoeoVaQAAeZmagagkvLk/rgBUqN7nrHpSOIFPRSKIFt5
	 UpZ7p9l+2yfTvivPad1gRjcLaof923BwVxQP4KkQ=
Subject: patch "iio: adc: rzg2l: Cleanup suspend/resume path" added to char-misc-linus
To: claudiu.beznea.uj@bp.renesas.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,prabhakar.mahadev-lad.rj@bp.renesas.com,ulf.hansson@linaro.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 Aug 2025 11:05:36 +0200
Message-ID: <2025082036-distinct-disfigure-c20a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: rzg2l: Cleanup suspend/resume path

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a3c6eabe3bbd6b0e7124d68b2d3bc32fed17362e Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Date: Sun, 10 Aug 2025 15:33:27 +0300
Subject: iio: adc: rzg2l: Cleanup suspend/resume path

There is no need to manually track the runtime PM status in the driver.
The pm_runtime_force_suspend() and pm_runtime_force_resume() functions
already call pm_runtime_status_suspended() to check the runtime PM state.

Additionally, avoid calling pm_runtime_put_autosuspend() during the
suspend/resume path, as this would decrease the usage counter of a
potential user that had the ADC open before the suspend/resume cycle.

Fixes: 563cf94f9329 ("iio: adc: rzg2l_adc: Add suspend/resume support")
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20250810123328.800104-2-claudiu.beznea.uj@bp.renesas.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rzg2l_adc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 9674d48074c9..0cb5a67fd497 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -89,7 +89,6 @@ struct rzg2l_adc {
 	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
-	bool was_rpm_active;
 };
 
 /**
@@ -541,14 +540,9 @@ static int rzg2l_adc_suspend(struct device *dev)
 	};
 	int ret;
 
-	if (pm_runtime_suspended(dev)) {
-		adc->was_rpm_active = false;
-	} else {
-		ret = pm_runtime_force_suspend(dev);
-		if (ret)
-			return ret;
-		adc->was_rpm_active = true;
-	}
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
 
 	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	if (ret)
@@ -557,9 +551,7 @@ static int rzg2l_adc_suspend(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active)
-		pm_runtime_force_resume(dev);
-
+	pm_runtime_force_resume(dev);
 	return ret;
 }
 
@@ -577,11 +569,9 @@ static int rzg2l_adc_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (adc->was_rpm_active) {
-		ret = pm_runtime_force_resume(dev);
-		if (ret)
-			goto resets_restore;
-	}
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		goto resets_restore;
 
 	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret)
@@ -590,10 +580,7 @@ static int rzg2l_adc_resume(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active) {
-		pm_runtime_mark_last_busy(dev);
-		pm_runtime_put_autosuspend(dev);
-	}
+	pm_runtime_force_suspend(dev);
 resets_restore:
 	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	return ret;
-- 
2.50.1



