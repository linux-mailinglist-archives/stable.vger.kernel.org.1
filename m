Return-Path: <stable+bounces-49162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9538FEC1F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08F71F298CD
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E901AD9C1;
	Thu,  6 Jun 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OPKf9PKr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A1198824;
	Thu,  6 Jun 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683332; cv=none; b=C6pWj4MuZujP6yPvtIzo0K2sS0hFKMPHE33X3JtxaFTTi6rQfV3p7nfMo1T1qbGiiOIlHGyUKTCRc9DFn93c+D/lTfyK13PYKEyg5I9Q5J0j7H+BwgpCxsrmiV+WrZgTyVBxmZxD37PXQd79SJ1JbIT/GaAmpKKtZvdB85D+zsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683332; c=relaxed/simple;
	bh=uyY8jOx0m36cBOmHl39OhUXNykoOSSbzIcDOyfzXmgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMlg8wNp1kH3z2Kz4lLEfxY7eygniEiUqQlZ78PwklC5nvuuQ+PMQchSyOeBwjJxysRUA260ADU7i7TPAt9HqUhV4iJqKUa3FmRfsKQkeiAyNkU/wmDt8T0SMTbg2QaEQMbRpgaqU/NM6h39UKpRMRdA22ZD7vk6NOArWq9M87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OPKf9PKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43487C2BD10;
	Thu,  6 Jun 2024 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683332;
	bh=uyY8jOx0m36cBOmHl39OhUXNykoOSSbzIcDOyfzXmgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPKf9PKrsKG7LHSGe5HPXVRlvlIjwYh84HvRrn3dNyEBkzX7/jXpGa6ZBcJYx/zmk
	 RGp43YY4OR7JHsTcZhNKncJMdS1bQ7tkAcVz6cWpiDJHpNBTu2EbaZlngVmo9l7Fb/
	 wdmST2NKkx+V+pYMrwAkZX4/gl91tYk8f5H2o+QQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 214/473] drm/msm/dp: allow voltage swing / pre emphasis of 3
Date: Thu,  6 Jun 2024 16:02:23 +0200
Message-ID: <20240606131706.990181110@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 22578178e5dd6d3aa4490879df8b6c2977d980be ]

Both dp_link_adjust_levels() and dp_ctrl_update_vx_px() limit swing and
pre-emphasis to 2, while the real maximum value for the sum of the
voltage swing and pre-emphasis is 3. Fix the DP code to remove this
limitation.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Tested-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/577006/
Link: https://lore.kernel.org/r/20240203-dp-swing-3-v1-1-6545e1706196@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c |  6 +++---
 drivers/gpu/drm/msm/dp/dp_link.c | 22 +++++++++++-----------
 drivers/gpu/drm/msm/dp/dp_link.h | 14 +-------------
 3 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index b20701893e5b3..2c501261f2323 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1014,14 +1014,14 @@ static int dp_ctrl_update_vx_px(struct dp_ctrl_private *ctrl)
 	if (ret)
 		return ret;
 
-	if (voltage_swing_level >= DP_TRAIN_VOLTAGE_SWING_MAX) {
+	if (voltage_swing_level >= DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(ctrl->drm_dev,
 				"max. voltage swing level reached %d\n",
 				voltage_swing_level);
 		max_level_reached |= DP_TRAIN_MAX_SWING_REACHED;
 	}
 
-	if (pre_emphasis_level >= DP_TRAIN_PRE_EMPHASIS_MAX) {
+	if (pre_emphasis_level >= DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(ctrl->drm_dev,
 				"max. pre-emphasis level reached %d\n",
 				pre_emphasis_level);
@@ -1112,7 +1112,7 @@ static int dp_ctrl_link_train_1(struct dp_ctrl_private *ctrl,
 		}
 
 		if (ctrl->link->phy_params.v_level >=
-			DP_TRAIN_VOLTAGE_SWING_MAX) {
+			DP_TRAIN_LEVEL_MAX) {
 			DRM_ERROR_RATELIMITED("max v_level reached\n");
 			return -EAGAIN;
 		}
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index ceb382fa56d5b..e4f9decec970f 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -1102,6 +1102,7 @@ int dp_link_get_colorimetry_config(struct dp_link *dp_link)
 int dp_link_adjust_levels(struct dp_link *dp_link, u8 *link_status)
 {
 	int i;
+	u8 max_p_level;
 	int v_max = 0, p_max = 0;
 	struct dp_link_private *link;
 
@@ -1133,30 +1134,29 @@ int dp_link_adjust_levels(struct dp_link *dp_link, u8 *link_status)
 	 * Adjust the voltage swing and pre-emphasis level combination to within
 	 * the allowable range.
 	 */
-	if (dp_link->phy_params.v_level > DP_TRAIN_VOLTAGE_SWING_MAX) {
+	if (dp_link->phy_params.v_level > DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(link->drm_dev,
 			"Requested vSwingLevel=%d, change to %d\n",
 			dp_link->phy_params.v_level,
-			DP_TRAIN_VOLTAGE_SWING_MAX);
-		dp_link->phy_params.v_level = DP_TRAIN_VOLTAGE_SWING_MAX;
+			DP_TRAIN_LEVEL_MAX);
+		dp_link->phy_params.v_level = DP_TRAIN_LEVEL_MAX;
 	}
 
-	if (dp_link->phy_params.p_level > DP_TRAIN_PRE_EMPHASIS_MAX) {
+	if (dp_link->phy_params.p_level > DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(link->drm_dev,
 			"Requested preEmphasisLevel=%d, change to %d\n",
 			dp_link->phy_params.p_level,
-			DP_TRAIN_PRE_EMPHASIS_MAX);
-		dp_link->phy_params.p_level = DP_TRAIN_PRE_EMPHASIS_MAX;
+			DP_TRAIN_LEVEL_MAX);
+		dp_link->phy_params.p_level = DP_TRAIN_LEVEL_MAX;
 	}
 
-	if ((dp_link->phy_params.p_level > DP_TRAIN_PRE_EMPHASIS_LVL_1)
-		&& (dp_link->phy_params.v_level ==
-			DP_TRAIN_VOLTAGE_SWING_LVL_2)) {
+	max_p_level = DP_TRAIN_LEVEL_MAX - dp_link->phy_params.v_level;
+	if (dp_link->phy_params.p_level > max_p_level) {
 		drm_dbg_dp(link->drm_dev,
 			"Requested preEmphasisLevel=%d, change to %d\n",
 			dp_link->phy_params.p_level,
-			DP_TRAIN_PRE_EMPHASIS_LVL_1);
-		dp_link->phy_params.p_level = DP_TRAIN_PRE_EMPHASIS_LVL_1;
+			max_p_level);
+		dp_link->phy_params.p_level = max_p_level;
 	}
 
 	drm_dbg_dp(link->drm_dev, "adjusted: v_level=%d, p_level=%d\n",
diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
index 9dd4dd9265304..79c3a02b8dacd 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.h
+++ b/drivers/gpu/drm/msm/dp/dp_link.h
@@ -19,19 +19,7 @@ struct dp_link_info {
 	unsigned long capabilities;
 };
 
-enum dp_link_voltage_level {
-	DP_TRAIN_VOLTAGE_SWING_LVL_0	= 0,
-	DP_TRAIN_VOLTAGE_SWING_LVL_1	= 1,
-	DP_TRAIN_VOLTAGE_SWING_LVL_2	= 2,
-	DP_TRAIN_VOLTAGE_SWING_MAX	= DP_TRAIN_VOLTAGE_SWING_LVL_2,
-};
-
-enum dp_link_preemaphasis_level {
-	DP_TRAIN_PRE_EMPHASIS_LVL_0	= 0,
-	DP_TRAIN_PRE_EMPHASIS_LVL_1	= 1,
-	DP_TRAIN_PRE_EMPHASIS_LVL_2	= 2,
-	DP_TRAIN_PRE_EMPHASIS_MAX	= DP_TRAIN_PRE_EMPHASIS_LVL_2,
-};
+#define DP_TRAIN_LEVEL_MAX	3
 
 struct dp_link_test_video {
 	u32 test_video_pattern;
-- 
2.43.0




