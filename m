Return-Path: <stable+bounces-77239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCCA985AC1
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E40D28643C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930ED18734F;
	Wed, 25 Sep 2024 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epD2qNIc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA04187341;
	Wed, 25 Sep 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264725; cv=none; b=JnqiD0J2IwkWpN+SItr/dsVAvjB9eaadUS5yWmLF1iu7jolhYB2rPfbsi4ZZs3rPt6SvQlq+RHRx87bmC1f7hrjUkHuNNWLUIhV4LQHVj+4vY/IIdS1Ytf5Jj1Fr3LiZHfaNS6Cys9+oKayL1jUOZYM+D6vIb6O+6/CFuh1JsNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264725; c=relaxed/simple;
	bh=4n+/Pf9FVTBvA2R2Ja+tTFoE5Fy8ivlNmeSWvPigQAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGJYls3yqv25VD69Ao0y2goWLygxM8cM7niDJRiRSYwCP4MU8WiBGBsEALG8OQjq0Kccihoz2EpvzTKGlF29QLC4mXRKK/muOjBW7e9Uq+g1Rr6b0dMJArsLGL5tbKG05Ytbi9UO6kX128xuBJ1NkdbpJooAYWRZOl41A/R6gTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epD2qNIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8330C4CEC3;
	Wed, 25 Sep 2024 11:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264724;
	bh=4n+/Pf9FVTBvA2R2Ja+tTFoE5Fy8ivlNmeSWvPigQAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epD2qNIciWGCN4xfdanRjcV4ROoLu8Ks73N4f6J10SOqns56NSj1abGOy3apQflZN
	 7qui8yGQTW2nvnVhz/vR7GT+fXO/de/sdUnxt8sS+JO2NlREIu/+gQ2nErssW2SdwM
	 8legmP/naWmFOI3IbjkuzGK1l8oW7HKShaaGfGWqEsxFybBVk7mCPWsjQ4bCb3PTfh
	 QagjKSqVELTD1y+BZfxpdkfH67DtYQiNp01fkHvgw0tdLxdyVPSif4iKxxPV3oAwUS
	 uN+b3nZ2obqkO9Q47rRO7Q8FTCUN+89LLBc5NAP8Ip4ZOJtdjbL8anBWO2s7SqW5nr
	 jffHTSxzQO+NA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Suraj Kandpal <suraj.kandpal@intel.com>,
	Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 141/244] drm/xe/hdcp: Check GSC structure validity
Date: Wed, 25 Sep 2024 07:26:02 -0400
Message-ID: <20240925113641.1297102-141-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Suraj Kandpal <suraj.kandpal@intel.com>

[ Upstream commit b4224f6bae3801d589f815672ec62800a1501b0d ]

Sometimes xe_gsc is not initialized when checked at HDCP capability
check. Add gsc structure check to avoid null pointer error.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722064451.3610512-4-suraj.kandpal@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
index 990285aa9b261..0af667ebebf98 100644
--- a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
+++ b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
@@ -40,10 +40,14 @@ bool intel_hdcp_gsc_check_status(struct xe_device *xe)
 {
 	struct xe_tile *tile = xe_device_get_root_tile(xe);
 	struct xe_gt *gt = tile->media_gt;
+	struct xe_gsc *gsc = &gt->uc.gsc;
 	bool ret = true;
 
-	if (!xe_uc_fw_is_enabled(&gt->uc.gsc.fw))
+	if (!gsc && !xe_uc_fw_is_enabled(&gsc->fw)) {
+		drm_dbg_kms(&xe->drm,
+			    "GSC Components not ready for HDCP2.x\n");
 		return false;
+	}
 
 	xe_pm_runtime_get(xe);
 	if (xe_force_wake_get(gt_to_fw(gt), XE_FW_GSC)) {
@@ -53,7 +57,7 @@ bool intel_hdcp_gsc_check_status(struct xe_device *xe)
 		goto out;
 	}
 
-	if (!xe_gsc_proxy_init_done(&gt->uc.gsc))
+	if (!xe_gsc_proxy_init_done(gsc))
 		ret = false;
 
 	xe_force_wake_put(gt_to_fw(gt), XE_FW_GSC);
-- 
2.43.0


