Return-Path: <stable+bounces-140477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3111DAAAE0A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF875A1681
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B186359622;
	Mon,  5 May 2025 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1ynIDJ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB32BDC34;
	Mon,  5 May 2025 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484930; cv=none; b=MhH2siKhe2UkcmEYBtw8ctQajIELDkpWW6cWq5WXnADacWISx5VIv0l9BxWTuqF5B3SwDuD4xNuN6TWZFdEPqCDQyme56105rp13CEVS6cZUa2v5ev/krOEdC1Jt1lo8PlSRpWPSdrzEOFycufQm9KPDc5KXiQFG9ZG97PU7Hp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484930; c=relaxed/simple;
	bh=SQcrBdDgxw+dhMtgvd5xGs4Las/eqms4Rb/CtpJWtOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ed3LPyRZ5okNtThMMabR7Kgh7/n4Q5rEampi11MT7zEMOMsDyhmbaaoPWSgGmSNWbU6gZ9UMVRFm0lNJfdEPsmmJ+mSN2cYigQK7cwKsIg5h6J7BvlO4m+ZXHlI8ji7Pm1VUbBvKgoaNCY2QEByXfEfP+OF9UIxbWFx8+RDC9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1ynIDJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772BDC4CEE4;
	Mon,  5 May 2025 22:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484929;
	bh=SQcrBdDgxw+dhMtgvd5xGs4Las/eqms4Rb/CtpJWtOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1ynIDJ0fZLWhcFm8j61z5fah6T/vPZ5AeETRcwtKk8RVyBqD5xKY8g6VyDlZ6zCA
	 6c+j7GTTX4NDFc4uGTaB62n+Z2CYUFq7grMqQHP8ZxcRTb3Fm5/mW//cfzKSj3nXsn
	 Nwr7ST5W/T8pRXpfdfo1ZWwQu6lYJES97FW67561swh+zZ2BScQi9gv+0hDPqkZ8K+
	 UHJ8fafx3kFk2WTOG2lI8UgpvTKS5u3nX2d6OmnNVynVS3S1Lg5ltMtgPr5Ee+VGr1
	 ryiaJo6NxAkSZ6Z8YeRC+gLJ/hCnd0B0iXnP3AbJn410snU8UfYH4UxuGUKf9Um4mJ
	 atL4pG/nKEr8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Flora Cui <flora.cui@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	Hawking.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 082/486] drm/amdgpu: release xcp_mgr on exit
Date: Mon,  5 May 2025 18:32:38 -0400
Message-Id: <20250505223922.2682012-82-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Flora Cui <flora.cui@amd.com>

[ Upstream commit b5aaa82e2b12feaaa6958f7fa0917ddcc03c24ee ]

Free on driver cleanup.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ef0aa2dd33aa8..9cc7596688abd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4668,6 +4668,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	kfree(adev->fru_info);
 	adev->fru_info = NULL;
 
+	kfree(adev->xcp_mgr);
+	adev->xcp_mgr = NULL;
+
 	px = amdgpu_device_supports_px(adev_to_drm(adev));
 
 	if (px || (!dev_is_removable(&adev->pdev->dev) &&
-- 
2.39.5


