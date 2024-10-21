Return-Path: <stable+bounces-87247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE60B9A6414
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518701F21117
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FC41EF940;
	Mon, 21 Oct 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KNJkexRg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59591953B9;
	Mon, 21 Oct 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507034; cv=none; b=kv2quvF6TZdjmqOkdHF++UUT/kve8VQ79lUgALb6jFCXoUthU5Zf7OPMQqOwDjHnvnbyYJpa2lS6f6vTJv4FmbMSJ3UTTWh0LWFVhYTOi2R0tDUPt4w8LOe309MFbRg9UzsPAw7jbHhGd/K42LGCU/46+eJ61MAoEJSh9Rfx20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507034; c=relaxed/simple;
	bh=5Q3QMMQO78EDPgvgHdg7nilcWSq/v8d4KCAvWRuyEmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFJicLFoNrUlwx0B6Zujwn2QWTgHekuABXDQ0raqC/pkHwDpdygnM7rIN7jCVW0QkbYPkKE3Ak+xEoYjrkXtT1SCruMYgNiUTkCltjgdnjNyzl6+ruAR53rRzixvlPolPPzhxML3ei5y6aOrstA4NL2m4cTBAUerXwUDCm5pzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KNJkexRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535D6C4CEC3;
	Mon, 21 Oct 2024 10:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507034;
	bh=5Q3QMMQO78EDPgvgHdg7nilcWSq/v8d4KCAvWRuyEmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNJkexRgiqrZmwSzZZMZZXIC1TRvemz2Z0DeG13HlJYiGmv48eKhGGiETBEdNzWy5
	 WJ0fG7o5l3DsZ48RFGbAqWIhrmtPQ8VDihRb+z9ME9Wc6XwphX7HWzGQhJTEoP7b60
	 NGwwPQAvp0f1ABUJLKgKgDeRBGgeTa3vrtaeE+WQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 068/124] drm/amdgpu/swsmu: Only force workload setup on init
Date: Mon, 21 Oct 2024 12:24:32 +0200
Message-ID: <20241021102259.364985016@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
References: <20241021102256.706334758@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit cb07c8338fc2b9d5f949a19d4a07ee4d5ecf8793 upstream.

Needed to set the workload type at init time so that
we can apply the navi3x margin optimization.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3618
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3131
Fixes: c50fe289ed72 ("drm/amdgpu/swsmu: always force a state reprogram on init")
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 580ad7cbd4b7be8d2cb5ab5c1fca6bb76045eb0e)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1843,7 +1843,7 @@ static int smu_bump_power_profile_mode(s
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 					  enum amd_dpm_forced_level level,
 					  bool skip_display_settings,
-					  bool force_update)
+					  bool init)
 {
 	int ret = 0;
 	int index = 0;
@@ -1872,7 +1872,7 @@ static int smu_adjust_power_state_dynami
 		}
 	}
 
-	if (force_update || smu_dpm_ctx->dpm_level != level) {
+	if (smu_dpm_ctx->dpm_level != level) {
 		ret = smu_asic_set_performance_level(smu, level);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to set performance level!");
@@ -1889,7 +1889,7 @@ static int smu_adjust_power_state_dynami
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 
-		if (force_update || smu->power_profile_mode != workload[0])
+		if (init || smu->power_profile_mode != workload[0])
 			smu_bump_power_profile_mode(smu, workload, 0);
 	}
 



