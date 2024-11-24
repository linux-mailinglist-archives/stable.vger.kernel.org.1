Return-Path: <stable+bounces-95260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E2C9D74AE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8462890BE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64438241451;
	Sun, 24 Nov 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWspryQR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63A241427;
	Sun, 24 Nov 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456506; cv=none; b=AlN0Y+RiqOt4s8XFYWEO0qvb/Qt8n/zixNyjFiWHUA0Ml5ZKF0XUpTekorzp+nAfJtuMWHmaVOdGBVyGK2tO4QEz/iuXahATm8MapTakver86+C0qKv4fd+lQNEOj3m2FxfEj/QIi2WjsBRM0JJEV3YFTD+oqM+wI5muSUiDeb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456506; c=relaxed/simple;
	bh=bdTFARV6cdbNuxkjqQpVHEGm6exVS8yC+rCCLpYusc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3IkqzqRJ9zW3q9AWfwAtwTdNwIeWRA0uusXESCnlF3bFQhYws+hP5Bs66tv1VmexIac2HlNikmWB9vn9BR9FAQrM6cU1jEWM4h4poerPR6LZOxDhvHkxcObYFAYlt3ym0cSvzfN21koK9qxCzYhF0dHmcJ6r6OxRXAIrUC0oIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWspryQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B5BC4CED1;
	Sun, 24 Nov 2024 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456506;
	bh=bdTFARV6cdbNuxkjqQpVHEGm6exVS8yC+rCCLpYusc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWspryQRLfCYpEzol9JrYJEyI+69Br5W6YoCaBHkN5ZfoOwVx5iQLg3SIm7fxjAKr
	 MjvBA1cocF21tPmy1+AvtppYcYU8hc1hQdiBbTcCLbXMnWRuMqHVpcjqqfUNgBSAWT
	 VLHkj+MFV8Kxmbjw2fsS8WBswjXVB66NzzKWyjA8eXvZ5TpMxxE/HE5rCU+couRqo+
	 Dwj40F5xSewFpycc3yKrbhNoE8qUGSiZU8o6rDsunEhe6bD71I238mkYCFa7W3rp3c
	 j9LlBCzh+4A6/y9XqKnhpTSyiZoNsWInSufYfysADbxx8hq4VyNZyS71Z71+VooUNl
	 qf4xAonwVH3uA==
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
Subject: [PATCH AUTOSEL 5.10 25/33] drm/amdgpu: skip amdgpu_device_cache_pci_state under sriov
Date: Sun, 24 Nov 2024 08:53:37 -0500
Message-ID: <20241124135410.3349976-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index e833c02fabff3..2f42471e578ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5088,6 +5088,9 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
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


