Return-Path: <stable+bounces-172132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8150AB2FD3D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97875626CF3
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8481F03DE;
	Thu, 21 Aug 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PJts/0Gf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B384D279DB6
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786489; cv=none; b=YCg9o4h298+MrwXg73rgUecRmydRg+E+LIgXwcNHTiALBUZER0ryM7TsyK4p+Cz/2vKVTWQ75Aqx3zNSHQonH1Xh6H8+OW8qGWZYva1gfGRjxEjoaMsKA942eLrb7Tm5kvWJVSly+uo0xrrS56kaudZg7wJvL+M+K3rqOqxBxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786489; c=relaxed/simple;
	bh=BKgiNpVchJ+N8rxJj3UbTC/ZaFcVADrkfHcsD+wCh1I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z4D1IRreccnrXyTWm9B5q3gsV8TjKQMj7FR91JrjpnokTK3gyU1qDODzYbQ9tfOy65qT953Siyl2o653470u121403/Y8lhIv2B1q30OFoC6zdRRCB0J3h99L7vBR54zQTe6VMUqdU9OWjC16/dDpqnyP7bq4RtAx+GtIO5RYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PJts/0Gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D340C4CEEB;
	Thu, 21 Aug 2025 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786489;
	bh=BKgiNpVchJ+N8rxJj3UbTC/ZaFcVADrkfHcsD+wCh1I=;
	h=Subject:To:Cc:From:Date:From;
	b=PJts/0GfgWP8aRfgKhJr9Ury1Chd7VICy2yNldwADifMhGxFcIZtEiLdt2mxFdumn
	 aauxcXGsAW8mLwjugx0Pe27qoLFfYewtCzcm7UDZr8h5nIPN498g7Bx9lxilI2khbh
	 y1Xn2Kd3/LqEOGopzOPcnx4QvAI9Ybq2bMITSpwQ=
Subject: FAILED: patch "[PATCH] media: qcom: camss: cleanup media device allocated resource" failed to apply to 5.15-stable tree
To: vladimir.zapolskiy@linaro.org,bod@kernel.org,bryan.odonoghue@linaro.org,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:27:55 +0200
Message-ID: <2025082155-riches-diaper-55d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 69080ec3d0daba8a894025476c98ab16b5a505a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082155-riches-diaper-55d5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 69080ec3d0daba8a894025476c98ab16b5a505a4 Mon Sep 17 00:00:00 2001
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Date: Tue, 13 May 2025 17:23:45 +0300
Subject: [PATCH] media: qcom: camss: cleanup media device allocated resource
 on error path

A call to media_device_init() requires media_device_cleanup() counterpart
to complete cleanup and release any allocated resources.

This has been done in the driver .remove() right from the beginning, but
error paths on .probe() shall also be fixed.

Fixes: a1d7c116fcf7 ("media: camms: Add core files")
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 06f42875702f..f76773dbd296 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -3625,7 +3625,7 @@ static int camss_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
-		goto err_genpd_cleanup;
+		goto err_media_device_cleanup;
 	}
 
 	v4l2_async_nf_init(&camss->notifier, &camss->v4l2_dev);
@@ -3680,6 +3680,8 @@ static int camss_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
 	pm_runtime_disable(dev);
+err_media_device_cleanup:
+	media_device_cleanup(&camss->media_dev);
 err_genpd_cleanup:
 	camss_genpd_cleanup(camss);
 


