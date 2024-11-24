Return-Path: <stable+bounces-95135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA109D7397
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4A5164806
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48006224C1E;
	Sun, 24 Nov 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxf5jic/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D1224C1B;
	Sun, 24 Nov 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456110; cv=none; b=lXryAAHInCM1aDccH2iSbyNcwUW/Ye0uSZFeOh6C+RsWXMOLr4O/SE3WWLznVJEwn66kQLeI3+z6mV7TGIGJZLeLDUYH7E45prqDNNiyRSRmD3IBgH7kqtgclmJUbx/kmf53COQtsGHiPyYLsDbzvcFQwKXVsCI3/5X4zLj8sEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456110; c=relaxed/simple;
	bh=B0dPmkXNR/i8Hy+8GjgGH03tqgsYlJAJLejgL8eA0p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHrqw1+Qvn79mhHH8pH2F4iinzHk/z/FFOnO5jMdfQRrIBwnBsEdCHA7OPt3F2kzigssC1EqYYXlOCBd/i8u0vZjhCPxpMz3i9y70jjEv76Q2Hz5JeGUQiYTNBKRi6EqdJS2tx+ijmzlUxkI9Xwd8bogBr0KXO5GSW84eS4yF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxf5jic/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F1EC4CECC;
	Sun, 24 Nov 2024 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456109;
	bh=B0dPmkXNR/i8Hy+8GjgGH03tqgsYlJAJLejgL8eA0p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxf5jic/+SU0haypdEYG4ju3l4Wm4Y5eaUxZS2oVLpVkHKrTNGMfo0FD/MNzyl7/+
	 4AjfWPddMmCuqv+Azvt5oZDUtzOOd7mLHk9oiNU/XUh2L3Bpbt4aMCRPBpBKrX/6wK
	 Cw4TVfRFE6lKU6KmhlR5ohdXB7yMRsOykFSW5V5En5MxFkTNLjtJZkE+8TATtt9hWX
	 dfWZmIKu8cONsvaaAXtezvei2yMhTOGhQFaBXSgdn44zozfEExm8ctzKOql1GE+GeE
	 74h30J24YpRH0g2JR6OEOQpxrj8HGtwfmLLaYil3LZDkn8nXJBYUgPxO2Usrd2BAqu
	 IaetCnwqX5y5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Victor Zhao <Victor.Zhao@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	Hawking.Zhang@amd.com,
	mario.limonciello@amd.com,
	Jun.Ma2@amd.com,
	Yunxiang.Li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 45/61] drm/amdgpu: skip amdgpu_device_cache_pci_state under sriov
Date: Sun, 24 Nov 2024 08:45:20 -0500
Message-ID: <20241124134637.3346391-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Victor Zhao <Victor.Zhao@amd.com>

[ Upstream commit afe260df55ac280cd56306248cb6d8a6b0db095c ]

Under sriov, host driver will save and restore vf pci cfg space during
reset. And during device init, under sriov, pci_restore_state happens after
fullaccess released, and it can have race condition with mmio protection
enable from host side leading to missing interrupts.

So skip amdgpu_device_cache_pci_state for sriov.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9c99d69b4b083..d95f88d9a94bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5841,6 +5841,9 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
 	r = pci_save_state(pdev);
 	if (!r) {
 		kfree(adev->pci_state);
-- 
2.43.0


