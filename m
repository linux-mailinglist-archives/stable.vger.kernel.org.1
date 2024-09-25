Return-Path: <stable+bounces-77466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A2A985DC7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF175B294A6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465801EBFE3;
	Wed, 25 Sep 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmY7EVoe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329C1B29DB;
	Wed, 25 Sep 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265904; cv=none; b=F94M8KUwHYZnHnzgXb2SW6oqMkaPsOw2OYa7yqyiklB8Z1MnMnTflHivl8vX1OV5kAqVWqP1vvC2QaURvkUIorUXq9qYtu76l9SmIHt4FFtm47acwB/HuD6NJ+6pS7cY05wzXkcJetXn6cNqfofyEMcSoP/kdVEAY6RHog5MNMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265904; c=relaxed/simple;
	bh=PIrSWSe1p/OzEoLjFK1fW3I3p/lUQ7HiMkPO+JrSeR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+Bsb9RYzYaTQMo2+pR9GHp+4V4HBvq2/mzaY0Ndx9UbvpFd8aHd1Ubchf/ooeGs8mSsqh4YnlJY/Zpy7MDnQGc2hh01HINBA66qCUVMZ98Qu4psnVD+V9KPKG4Q/qA3obz4RzKlaFW6ItWknSQd9FKvlXKb+8ezNqffF8wH0Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmY7EVoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E9EC4CEC3;
	Wed, 25 Sep 2024 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265903;
	bh=PIrSWSe1p/OzEoLjFK1fW3I3p/lUQ7HiMkPO+JrSeR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmY7EVoeHaTWEPHgResZXTfPDdqJqzo83H9heT9qGbEFdSusL5d603ahHOniANjIf
	 WLYrAl/ezmabFUfZOkZ/UX9WW3Ph4H1rC5t6dp1S9MLEfZjLqGtNrcnQByf1/iaZMp
	 tLdbonFMenFGl9fwS8CygAMNEEOOUcovefwj1YRKoGhGiYPLacqnXODl9hBDynNRki
	 NcLkMiaW1gLGWjTYN4Qt1AeWZO21N/pozsUeav/AMw7SX3xDMEPg12zeGOsMgKzJ3U
	 MwVuibbinH4J/D8whftxBQHhKHMwyaFY6DZfDo6dOP35/IVWpoVjBjsx7tYT42KZEz
	 aUrXKKXFJQeWg==
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
Subject: [PATCH AUTOSEL 6.10 121/197] drm/xe/hdcp: Check GSC structure validity
Date: Wed, 25 Sep 2024 07:52:20 -0400
Message-ID: <20240925115823.1303019-121-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index b3d3c065dd9d8..2f935771658e6 100644
--- a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
+++ b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
@@ -39,10 +39,14 @@ bool intel_hdcp_gsc_check_status(struct xe_device *xe)
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
@@ -52,7 +56,7 @@ bool intel_hdcp_gsc_check_status(struct xe_device *xe)
 		goto out;
 	}
 
-	if (!xe_gsc_proxy_init_done(&gt->uc.gsc))
+	if (!xe_gsc_proxy_init_done(gsc))
 		ret = false;
 
 	xe_force_wake_put(gt_to_fw(gt), XE_FW_GSC);
-- 
2.43.0


