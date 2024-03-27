Return-Path: <stable+bounces-32971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9285888E884
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C7284FC0
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EE2136E1A;
	Wed, 27 Mar 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KY8keIkg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90671400D
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551928; cv=none; b=Txpu3f7ruA9tvWf1N9gP8FfOOuztK8tTFmC7QZMZ+iAEHefcYcQVxKgr2GkNPZxFvyU7BS4Zcld3NU7fuMRv25zqPtzUVECQovf6dlIbY2xN8q+NXCK26FBouo8SVa96/bp/9UR8WCs8lOM3PKvhyHn0tFTSU6xSyoyckA858Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551928; c=relaxed/simple;
	bh=qHz20XcM8F+xfhYM2QrmiTn96YhugXjsF77fgutuTOQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VLyRrcjzJSL6e4/oMVgAxVSr07WsQl4+uhyQKkIfevjGCwziHq3f2BJGOqOQCKltJ6hy/4RouWo8MhMoy7gbbLu1yK+xe5mnXylBWDzuVEw1M+qMfvYSH47S4/BfGnhUTr0X5BeWmVKmT4Ayj2OnGNEQOITCM4Ca/+cxp11LKu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KY8keIkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2520EC43390;
	Wed, 27 Mar 2024 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711551928;
	bh=qHz20XcM8F+xfhYM2QrmiTn96YhugXjsF77fgutuTOQ=;
	h=Subject:To:Cc:From:Date:From;
	b=KY8keIkg1oNzCcJ4wvO2cAquOyrq7Pj90Z8eGRMqZaXYeNU1+fqb+cd6KE2umqo/u
	 oeYBnHtuzYPyHu1azHaRzJI3BkKqASrPACerTU2c+W+09bDBiPYz8HZ8m38//HLEl/
	 6blDU1xUOZ0E3/EXjVMWMzR4ntpkH9NaagVioa3g=
Subject: FAILED: patch "[PATCH] phy: qcom-qmp-combo: fix drm bridge registration" failed to apply to 6.6-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,dmitry.baryshkov@linaro.org,neil.armstrong@linaro.org,quic_bjorande@quicinc.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:05:12 +0100
Message-ID: <2024032712-safehouse-yearning-1b84@gregkh>
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
git cherry-pick -x d2d7b8e88023b75320662c2305d61779ff060950
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032712-safehouse-yearning-1b84@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


