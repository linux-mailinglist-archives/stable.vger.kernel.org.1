Return-Path: <stable+bounces-41692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33C8B5756
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D11A1F22500
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652DA52F9A;
	Mon, 29 Apr 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q92vpOJm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201853385
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392150; cv=none; b=fl4kcx3AzDcfEYIyMN6Bw6LjsdSKVkHFrTQkQbIeuozy+RLKZf/Tzq/t9Kpq8DVLgGTnngHXVFXfo637oee992IL4iNkbSDcwAVqZ0rmt6QZQwEJmLtdP2Jm4LJfLM9INQtLEQvynap8tg/qm5L4RMuvvzNHpVLk+tp6PIfoU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392150; c=relaxed/simple;
	bh=oVZ4rbCip4mxFRyT7/jP8j/BZx08Nnqes3OuuroIHaw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GrHdlbvWBtHftDoSekSAhtjWnqmaI//1FgwhtiKjzVuGzS8QkDk8KvROWDvVpzSuH9BoJNN3rPUCkvQGn1UT5vGgFdlPgQFOf+uwBx5JyvS84CNqb4AOXZJwuwFrZVAfEGqT+Xa37y06VGW2QW3KHMJW0oP6tAHyzY26v/oei/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q92vpOJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D0EC113CD;
	Mon, 29 Apr 2024 12:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714392150;
	bh=oVZ4rbCip4mxFRyT7/jP8j/BZx08Nnqes3OuuroIHaw=;
	h=Subject:To:Cc:From:Date:From;
	b=Q92vpOJmmwskoq3WnldTXzIJetY2NHBb3ccDiGHyf29oZkSUjle4RSd2y3kdymNgY
	 89a6rlVTv/5n8N5pdyS+mYnbngjGE0YgwahNCWzb5Wv5Bgzlu9MRiReBxT4Lwy0Pu6
	 bgFZbQkAtFY4+g/65Ksf/Mcub6L+/e9g0w0nDnBw=
Subject: FAILED: patch "[PATCH] phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6" failed to apply to 6.6-stable tree
To: johan+linaro@kernel.org,dmitry.baryshkov@linaro.org,quic_abhinavk@quicinc.com,swboyd@chromium.org,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 14:02:19 +0200
Message-ID: <2024042919-enlisted-punch-79a5@gregkh>
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
git cherry-pick -x 025a6f7448f7bb5f4fceb62498ee33d89ae266bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042919-enlisted-punch-79a5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

025a6f7448f7 ("phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6")
ef643d55fdeb ("phy: qcom: qmp: split DP PHY registers to separate headers")
7b98cf0e9b5f ("phy: qcom-qmp: pcs: Add v7 register offsets")
dc32762214e4 ("phy: qcom-qmp: move PCS MISC V4 registers to separate header")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 025a6f7448f7bb5f4fceb62498ee33d89ae266bb Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 8 Apr 2024 11:30:23 +0200
Subject: [PATCH] phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6

Commit 5abed58a8bde ("phy: qcom: qmp-combo: Fix VCO div offset on v3")
fixed a regression introduced in 6.5 by making sure that the correct
offset is used for the DP_PHY_VCO_DIV register on v3 hardware.

Unfortunately, that fix instead broke DisplayPort on v5_5nm and v6
hardware as it failed to add the corresponding offsets also to those
register tables.

Fixes: 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")
Fixes: 5abed58a8bde ("phy: qcom: qmp-combo: Fix VCO div offset on v3")
Cc: stable@vger.kernel.org	# 6.5: 5abed58a8bde
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Link: https://lore.kernel.org/r/20240408093023.506-1-johan+linaro@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 2a6f70b3e25f..c21cdb8dbfe7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -153,6 +153,7 @@ static const unsigned int qmp_v5_5nm_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN,
 
 	[QPHY_DP_PHY_STATUS]		= QSERDES_V5_DP_PHY_STATUS,
+	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V5_DP_PHY_VCO_DIV,
 
 	[QPHY_TX_TX_POL_INV]		= QSERDES_V5_5NM_TX_TX_POL_INV,
 	[QPHY_TX_TX_DRV_LVL]		= QSERDES_V5_5NM_TX_TX_DRV_LVL,
@@ -177,6 +178,7 @@ static const unsigned int qmp_v6_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN,
 
 	[QPHY_DP_PHY_STATUS]		= QSERDES_V6_DP_PHY_STATUS,
+	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V6_DP_PHY_VCO_DIV,
 
 	[QPHY_TX_TX_POL_INV]		= QSERDES_V6_TX_TX_POL_INV,
 	[QPHY_TX_TX_DRV_LVL]		= QSERDES_V6_TX_TX_DRV_LVL,
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h
index f5cfacf9be96..181057421c11 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v5.h
@@ -7,6 +7,7 @@
 #define QCOM_PHY_QMP_DP_PHY_V5_H_
 
 /* Only for QMP V5 PHY - DP PHY registers */
+#define QSERDES_V5_DP_PHY_VCO_DIV			0x070
 #define QSERDES_V5_DP_PHY_AUX_INTERRUPT_STATUS		0x0d8
 #define QSERDES_V5_DP_PHY_STATUS			0x0dc
 
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h
index 01a20d3be4b8..fa967a1af058 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v6.h
@@ -7,6 +7,7 @@
 #define QCOM_PHY_QMP_DP_PHY_V6_H_
 
 /* Only for QMP V6 PHY - DP PHY registers */
+#define QSERDES_V6_DP_PHY_VCO_DIV			0x070
 #define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
 #define QSERDES_V6_DP_PHY_STATUS			0x0e4
 


