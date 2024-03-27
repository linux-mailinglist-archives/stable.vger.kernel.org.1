Return-Path: <stable+bounces-32970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5555488E883
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E5F1F32C40
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244C4146002;
	Wed, 27 Mar 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+RkH3Ug"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05A5A4DC
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551914; cv=none; b=DIhDnlIidHokakJ5NK0xRWFlplX1ynkMrhjLnkWLYaCxjvXGCW1PRr8CMm7zEVr25tHevYf9dBKK6Ws55NznVOe8q61WaNUTgzwe5f0SjW7Z700UKyWibcYy52aS2PVrQjPE7KNUExvNADtV+HgfePNcUhIKA3O7Vy2cXmoA0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551914; c=relaxed/simple;
	bh=aops87D4HqbwK5G9dG9Don6o0UqSp4pC1D50QOe6zYs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OTvKLhC91inkbkcHek0eTFHZvuU8N184llbIysGb9h9rLntomcB4x1Y2solTY0ZO2XyIsmkxFPqbeHuj923oVzh+h0r6q6lyN7QEANPvhweFw6JpkxxWF0J36Wk2h9YebVOFa+L8Wd2lAx6vsRt6JHy8eNBJjnIslui2XlFZNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+RkH3Ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF1DC433F1;
	Wed, 27 Mar 2024 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711551914;
	bh=aops87D4HqbwK5G9dG9Don6o0UqSp4pC1D50QOe6zYs=;
	h=Subject:To:Cc:From:Date:From;
	b=o+RkH3UgQeviGfzIXNFBA1iNoocSdF/lYYfmYWpGfB3kIJmbrLKrhjasNE36gKlER
	 145AxDbHTE2ElYdxY3q0KZflMEWya+gt+xI3HRcvvfzSziVAVgEb+ySX3lZDGrsNYT
	 3vI54+RKBYxZUELaS0hqPiu8vsv8rUt9Mo00nPdQ=
Subject: FAILED: patch "[PATCH] phy: qcom-qmp-combo: fix drm bridge registration" failed to apply to 6.7-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,dmitry.baryshkov@linaro.org,neil.armstrong@linaro.org,quic_bjorande@quicinc.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:05:11 +0100
Message-ID: <2024032711-saxophone-flammable-5cc1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x d2d7b8e88023b75320662c2305d61779ff060950
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032711-saxophone-flammable-5cc1@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

d2d7b8e88023 ("phy: qcom-qmp-combo: fix drm bridge registration")
35921910bbd0 ("phy: qcom: qmp-combo: switch to DRM_AUX_BRIDGE")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d2d7b8e88023b75320662c2305d61779ff060950 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Sat, 17 Feb 2024 16:02:27 +0100
Subject: [PATCH] phy: qcom-qmp-combo: fix drm bridge registration

Due to a long-standing issue in driver core, drivers may not probe defer
after having registered child devices to avoid triggering a probe
deferral loop (see fbc35b45f9f6 ("Add documentation on meaning of
-EPROBE_DEFER")).

This could potentially also trigger a bug in the DRM bridge
implementation which does not expect bridges to go away even if device
links may avoid triggering this (when enabled).

Move registration of the DRM aux bridge to after looking up clocks and
other resources.

Note that PHY creation can in theory also trigger a probe deferral when
a 'phy' supply is used. This does not seem to affect the QMP PHY driver
but the PHY subsystem should be reworked to address this (i.e. by
separating initialisation and registration of the PHY).

Fixes: 35921910bbd0 ("phy: qcom: qmp-combo: switch to DRM_AUX_BRIDGE")
Fixes: 1904c3f578dc ("phy: qcom-qmp-combo: Introduce drm_bridge")
Cc: stable@vger.kernel.org      # 6.5
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20240217150228.5788-6-johan+linaro@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 1ad10110dd25..e19d6a084f10 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -3566,10 +3566,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = drm_aux_bridge_register(dev);
-	if (ret)
-		return ret;
-
 	/* Check for legacy binding with child nodes. */
 	usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
 	if (usb_np) {
@@ -3589,6 +3585,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
+	ret = drm_aux_bridge_register(dev);
+	if (ret)
+		goto err_node_put;
+
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)


