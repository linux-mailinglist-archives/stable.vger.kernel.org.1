Return-Path: <stable+bounces-66113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C3694CA00
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 08:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA38F289250
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 06:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698B516C68F;
	Fri,  9 Aug 2024 06:00:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24D184
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183247; cv=none; b=VqyxfyIhPptWrdUzjCj1/MXroRrz/Q+mYQN3IYW3LEZlcyy8b18de3wDP5UEiVbQ5S8wpi98U7ZcQewA3ob+QQQicIoJVc81uIUg94+G3YJYhHqa+h9mmdK8jSc6iGT+Qi+6Y5cAwiWjH48SKAFkDQ7MqN1X4XuqEIH501A3GF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183247; c=relaxed/simple;
	bh=zCMzth6Sa7g7pRT3hgV+qq9be4LXkCkRh07T0W47094=;
	h=From:Date:Subject:To:Cc:Message-Id; b=M8M1ryqtnfBUz0GeUv4hodKWAnJ1uutfayE2FNq9ZlAp7EQoawRu16OJO+4pdG682JsywdNmqkXlFSqY7ZacV01BSZv03L77vynhRoVFj+l7s6LHXXkDhjP4FglvnUCSmOPtgav3EmGo3chcqUhUROKuHY7sU1DGApBP7FZyGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1scIg8-0003CE-0A;
	Fri, 09 Aug 2024 06:00:44 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Fri, 09 Aug 2024 05:56:38 +0000
Subject: [git:media_stage/master] media: qcom: camss: Fix ordering of pm_runtime_enable
To: linuxtv-commits@linuxtv.org
Cc: Johan Hovold <johan+linaro@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1scIg8-0003CE-0A@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: qcom: camss: Fix ordering of pm_runtime_enable
Author:  Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:    Mon Jul 29 13:42:03 2024 +0100

pm_runtime_enable() should happen prior to vfe_get() since vfe_get() calls
pm_runtime_resume_and_get().

This is a basic race condition that doesn't show up for most users so is
not widely reported. If you blacklist qcom-camss in modules.d and then
subsequently modprobe the module post-boot it is possible to reliably show
this error up.

The kernel log for this error looks like this:

qcom-camss ac5a000.camss: Failed to power up pipeline: -13

Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoVNHOTI0PKMNt4_@hovoldconsulting.com/
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/qcom/camss/camss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

---

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 51b1d3550421..d64985ca6e88 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -2283,6 +2283,8 @@ static int camss_probe(struct platform_device *pdev)
 
 	v4l2_async_nf_init(&camss->notifier, &camss->v4l2_dev);
 
+	pm_runtime_enable(dev);
+
 	num_subdevs = camss_of_parse_ports(camss);
 	if (num_subdevs < 0) {
 		ret = num_subdevs;
@@ -2323,8 +2325,6 @@ static int camss_probe(struct platform_device *pdev)
 		}
 	}
 
-	pm_runtime_enable(dev);
-
 	return 0;
 
 err_register_subdevs:
@@ -2332,6 +2332,7 @@ err_register_subdevs:
 err_v4l2_device_unregister:
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
+	pm_runtime_disable(dev);
 err_genpd_cleanup:
 	camss_genpd_cleanup(camss);
 

