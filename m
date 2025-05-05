Return-Path: <stable+bounces-140449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFDBAAA8D0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492404A0A3C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499AE27CCFB;
	Mon,  5 May 2025 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndEGs2fw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F51354E3D;
	Mon,  5 May 2025 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484874; cv=none; b=MqaEiQIQCN+3I6iqR4xKhSuC6f35ByMAOrLMgJ/VZAMgm1czk9Mzn5ndF7kHHUSSdgFzCPX4C7D/kYYV/sN0dkicmbGLE7hFZmx+KuHZPeg85EppzPoEfUm9/pZB2y0iJGTkkReehwD9sc4WLA+ygINnsKqOu3cm8Z5zK3jZJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484874; c=relaxed/simple;
	bh=/IlDwJ49jagFVw6FqWpWHEd67mcvNnNJnn2BQHnVmuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAdvEFNjflAi0pPQ02BQE6vm8ZNJH2hdWhoz6epHym94gy0Q2VehMIBztYrS1IC6ZdpZtdtHiJ0tX3e4FeTirlf/LFxYcsfgTHiLVsZvRbDV+VlO+botN4QwIn88JKpiHkkkDR7F+Wd3GaTeZFF/H/o8qG8N2RJyUxw9jGihR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndEGs2fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3E0C4CEE4;
	Mon,  5 May 2025 22:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484873;
	bh=/IlDwJ49jagFVw6FqWpWHEd67mcvNnNJnn2BQHnVmuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndEGs2fweMkX9UCjiKPXNOJtf/1546J/I5CDIwEt+hzmo9BxxReXb2eEcUTIg3CPx
	 b8MJHltM1PYf0cLmL5uztxcGaP2E86pte03YvFz/HDoxDjkDzUSbpbUFCKvnhW2FeJ
	 eA/nZfIDtXQia0LYTmo98raU/rqkWxc+VaqeObp8cvYhzVIuFsaUK0uxcxtZ4ZtC0y
	 QjpfsteL91nZML1Ko+3aVuuA3x0Yms2BQhO2jnuJGek10tKCchGt7R2ckklte0Jdi/
	 tLZtVcHWRbgXbmeccmo3nVWJ82Ct5QqM4QQrOUlBm864wQ11LAqZMr8YkZZNZIj4Jc
	 1QcQyxoQs3sQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Victor Skvortsov <victor.skvortsov@amd.com>,
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
Subject: [PATCH AUTOSEL 6.12 058/486] drm/amdgpu: Skip pcie_replay_count sysfs creation for VF
Date: Mon,  5 May 2025 18:32:14 -0400
Message-Id: <20250505223922.2682012-58-sashal@kernel.org>
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

From: Victor Skvortsov <victor.skvortsov@amd.com>

[ Upstream commit 9c05636ca72a2dbf41bf0900380f438a0de47319 ]

VFs cannot read the NAK_COUNTER register. This information is only
available through PMFW metrics.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 24d007715a14a..ef0aa2dd33aa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -168,6 +168,24 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
 static DEVICE_ATTR(pcie_replay_count, 0444,
 		amdgpu_device_get_pcie_replay_count, NULL);
 
+static int amdgpu_device_attr_sysfs_init(struct amdgpu_device *adev)
+{
+	int ret = 0;
+
+	if (!amdgpu_sriov_vf(adev))
+		ret = sysfs_create_file(&adev->dev->kobj,
+					&dev_attr_pcie_replay_count.attr);
+
+	return ret;
+}
+
+static void amdgpu_device_attr_sysfs_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev))
+		sysfs_remove_file(&adev->dev->kobj,
+				  &dev_attr_pcie_replay_count.attr);
+}
+
 static ssize_t amdgpu_sysfs_reg_state_get(struct file *f, struct kobject *kobj,
 					  struct bin_attribute *attr, char *buf,
 					  loff_t ppos, size_t count)
@@ -4028,11 +4046,6 @@ static bool amdgpu_device_check_iommu_remap(struct amdgpu_device *adev)
 }
 #endif
 
-static const struct attribute *amdgpu_dev_attributes[] = {
-	&dev_attr_pcie_replay_count.attr,
-	NULL
-};
-
 static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 {
 	if (amdgpu_mcbp == 1)
@@ -4475,7 +4488,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	} else
 		adev->ucode_sysfs_en = true;
 
-	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
+	r = amdgpu_device_attr_sysfs_init(adev);
 	if (r)
 		dev_err(adev->dev, "Could not create amdgpu device attr\n");
 
@@ -4605,7 +4618,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_pm_sysfs_fini(adev);
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
-	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
+	amdgpu_device_attr_sysfs_fini(adev);
 	amdgpu_fru_sysfs_fini(adev);
 
 	amdgpu_reg_state_sysfs_fini(adev);
-- 
2.39.5


