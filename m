Return-Path: <stable+bounces-1889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2314C7F81DA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E492835A7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E5E364B7;
	Fri, 24 Nov 2023 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lCPa/jPD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC33C2E64F;
	Fri, 24 Nov 2023 19:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1A8C433C8;
	Fri, 24 Nov 2023 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852523;
	bh=xSX0sPwff08dsrESNGOd4G9Ev6oqhwWl1ekYVtjbHmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCPa/jPDx0/OkrYj+B9UHUKANkd7aAnNvvDcbsknCpueOW2NtFOPGDJcnAeHQNuG6
	 RoKjaM/2iVCjydo3pVnB2mDT7JUk+5kq3wqSA/ledoh4fNwz2M29VHtfI3NvphHbvk
	 IXsQDXbixpHL2JOLzHcpTJhJKiBvHy2hMaHfQpqE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kuogee Hsieh <khsieh@codeaurora.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 018/193] drm/msm/dp: skip validity check for DP CTS EDID checksum
Date: Fri, 24 Nov 2023 17:52:25 +0000
Message-ID: <20231124171947.904413107@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit a251c9d8e30833b260101edb9383b176ee2b7cb1 ]

The DP CTS test for EDID last block checksum expects the checksum for
the last block, invalid or not. Skip the validity check.

For the most part (*), the EDIDs returned by drm_get_edid() will be
valid anyway, and there's the CTS workaround to get the checksum for
completely invalid EDIDs. See commit 7948fe12d47a ("drm/msm/dp: return
correct edid checksum after corrupted edid checksum read").

This lets us remove one user of drm_edid_block_valid() with hopes the
function can be removed altogether in the future.

(*) drm_get_edid() ignores checksum errors on CTA extensions.

Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Kuogee Hsieh <khsieh@codeaurora.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/555361/
Link: https://lore.kernel.org/r/20230901142034.580802-1-jani.nikula@intel.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 4e8a19114e87d..93a2ee0f772fc 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -264,26 +264,9 @@ int dp_panel_get_modes(struct dp_panel *dp_panel,
 
 static u8 dp_panel_get_edid_checksum(struct edid *edid)
 {
-	struct edid *last_block;
-	u8 *raw_edid;
-	bool is_edid_corrupt = false;
+	edid += edid->extensions;
 
-	if (!edid) {
-		DRM_ERROR("invalid edid input\n");
-		return 0;
-	}
-
-	raw_edid = (u8 *)edid;
-	raw_edid += (edid->extensions * EDID_LENGTH);
-	last_block = (struct edid *)raw_edid;
-
-	/* block type extension */
-	drm_edid_block_valid(raw_edid, 1, false, &is_edid_corrupt);
-	if (!is_edid_corrupt)
-		return last_block->checksum;
-
-	DRM_ERROR("Invalid block, no checksum\n");
-	return 0;
+	return edid->checksum;
 }
 
 void dp_panel_handle_sink_request(struct dp_panel *dp_panel)
-- 
2.42.0




