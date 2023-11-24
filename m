Return-Path: <stable+bounces-1859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5577F81B2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB19282E0B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA64364A5;
	Fri, 24 Nov 2023 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kYnBZiHD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224D2E84A;
	Fri, 24 Nov 2023 19:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BC7C433C7;
	Fri, 24 Nov 2023 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852449;
	bh=4WMDsdUc2wOeQH+hcS1Y551vdY25JELelcovV00pclc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYnBZiHDEMnQS0ySXlToukpW/yBS5aOek/VXPxeIMJ1JH24f8N0ky/MY/cxU/wyEM
	 lD1/nwPbOLD2KszKrQDK2FUjPKjl1bCM6sACde28P3c7PgqPAr0w1u2yf6DWyd3nir
	 JGi9llhVOYQoNcZTHZKQnIC2zgs7W99Ly5j+KoGw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 361/372] drm/amdgpu/smu13: drop compute workload workaround
Date: Fri, 24 Nov 2023 17:52:28 +0000
Message-ID: <20231124172022.329072321@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

commit 23170863ea0a0965d224342c0eb2ad8303b1f267 upstream.

This was fixed in PMFW before launch and is no longer
required.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |   32 +------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1645,38 +1645,10 @@ static int smu_v13_0_0_set_power_profile
 		}
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
-		(((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xC8)) ||
-		((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xCC)))) {
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_COMPUTE_BIT,
-					   (void *)(&activity_monitor_external),
-					   false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
-
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
-		}
-
-		workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       PP_SMC_POWER_PROFILE_CUSTOM);
-	} else {
-		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-		workload_type = smu_cmn_to_asic_specific_index(smu,
+	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
 						       smu->power_profile_mode);
-	}
 
 	if (workload_type < 0)
 		return -EINVAL;



