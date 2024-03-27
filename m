Return-Path: <stable+bounces-32972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F097A88E886
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979311F31D33
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FE9140E5E;
	Wed, 27 Mar 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Hqv3Pet"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F6136E1C
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551938; cv=none; b=YCGxKShi0wAuv+yWGi9M/PrFZS4DKrcWiRfL+yioDukj0sEtpWCWUvHrp9X6wz12m3uR+g8MmCG+TGklNcD8wxTO9PQeIdsVFYZEqwFRpbJtKEaLVZQfdpSj4nUGLF/LJs3wpILOSZMC8bGewmoKv+f3S9zRtLiICBfQE5igcO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551938; c=relaxed/simple;
	bh=6YSpyk+dwsAMo7NK72mZbTg9gC+n7p7lsCMwVZkLr+Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WwhcXGlYn3HNdvHkwar34u1mAXkzuARPniuUwTu+qufr78DrAiKY0XQRz2W8qCzXZjF3YlfYffoZpgKcNvR2eSn1Cha/uR2O/EdSTpu95+BxqS+diifsa2OMgv3n+0/J6GNVZSQ9HANR/Lrh9YyugZJyjJKWqW6yevwtbusT7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Hqv3Pet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9506BC433C7;
	Wed, 27 Mar 2024 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711551938;
	bh=6YSpyk+dwsAMo7NK72mZbTg9gC+n7p7lsCMwVZkLr+Y=;
	h=Subject:To:Cc:From:Date:From;
	b=0Hqv3PethWHmMhXnwPw8hjXvAKskrmeqhDjV5pREejW6v9heEdF18dqtHd+s8bHRO
	 AhfwOatc+4ChYLcrVu6Tl9U/DMZqyO3z9VcTycLkfd1IdQjCTXz59lC+XIBOZu5SX9
	 g/g8ANtqcGnVSRztFisWZ+WlDmMdAI9ziPHymT74=
Subject: FAILED: patch "[PATCH] phy: qcom-qmp-combo: fix type-c switch registration" failed to apply to 6.7-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,dmitry.baryshkov@linaro.org,neil.armstrong@linaro.org,quic_bjorande@quicinc.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:05:27 +0100
Message-ID: <2024032727-sureness-hungrily-02e0@gregkh>
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
git cherry-pick -x 47b412c1ea77112f1148b4edd71700a388c7c80f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032727-sureness-hungrily-02e0@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

47b412c1ea77 ("phy: qcom-qmp-combo: fix type-c switch registration")
d2d7b8e88023 ("phy: qcom-qmp-combo: fix drm bridge registration")
35921910bbd0 ("phy: qcom: qmp-combo: switch to DRM_AUX_BRIDGE")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47b412c1ea77112f1148b4edd71700a388c7c80f Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Sat, 17 Feb 2024 16:02:28 +0100
Subject: [PATCH] phy: qcom-qmp-combo: fix type-c switch registration

Due to a long-standing issue in driver core, drivers may not probe defer
after having registered child devices to avoid triggering a probe
deferral loop (see fbc35b45f9f6 ("Add documentation on meaning of
-EPROBE_DEFER")).

Move registration of the typec switch to after looking up clocks and
other resources.

Note that PHY creation can in theory also trigger a probe deferral when
a 'phy' supply is used. This does not seem to affect the QMP PHY driver
but the PHY subsystem should be reworked to address this (i.e. by
separating initialisation and registration of the PHY).

Fixes: 2851117f8f42 ("phy: qcom-qmp-combo: Introduce orientation switching")
Cc: stable@vger.kernel.org      # 6.5
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20240217150228.5788-7-johan+linaro@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index e19d6a084f10..17c4ad7553a5 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -3562,10 +3562,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qmp_combo_typec_switch_register(qmp);
-	if (ret)
-		return ret;
-
 	/* Check for legacy binding with child nodes. */
 	usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
 	if (usb_np) {
@@ -3585,6 +3581,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
+	ret = qmp_combo_typec_switch_register(qmp);
+	if (ret)
+		goto err_node_put;
+
 	ret = drm_aux_bridge_register(dev);
 	if (ret)
 		goto err_node_put;


