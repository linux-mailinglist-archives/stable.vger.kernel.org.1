Return-Path: <stable+bounces-94979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2DB9D71CF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70490289868
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F1A1E47BF;
	Sun, 24 Nov 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZZ3sNgJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55911E47BD;
	Sun, 24 Nov 2024 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455487; cv=none; b=Tv+iheVq5dSbaBxUztJItGWkyJNpb7bfXQJTbNayuyki3WjGhry/hTK5Qi3bYhZhy9kr43uOmT8MvbCR07eSMxb+4h+qrv24plg6uP7N5FK26G4ZpKppbed6dHH1J8nOQyIalHpFegw+p1JNOoMgrnXruJlUfd4IdkPSThDMsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455487; c=relaxed/simple;
	bh=6qpLETf+kOwUrCLEccqQYhhsq3uZlIqyryFpJGYZjbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o77C+73BDk9ThrNq3B+ufkSlXluNDZcZQ9MeyvO5SPSL6rYNiHsMeady42To7hmfZ0oJCKVjAhv5Y9eP7eRK4K9FgxBj1HPA9/n1WkXmVWKB+1xcqTGOSmqFRn4fkOtPJSbiwhrcD/cjCHKlbdS504HDhHH6D5SCu+dAgRJYi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZZ3sNgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF31FC4CECC;
	Sun, 24 Nov 2024 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455487;
	bh=6qpLETf+kOwUrCLEccqQYhhsq3uZlIqyryFpJGYZjbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZZ3sNgJsmcwtqWGeR0Eq3yaIusbWaeULMkWpSUk45L+FEeiqLRl7F3FZvpBqUxoZ
	 9bo6Kj4wcIz7hxqa5FJ1fwcN1Xm/THz6ucYakxya1hMRIGhbP6oSHj/Cjs7w+P0dfv
	 YLOC4qs5dxf7yIZSBPr18CYfFgvR6KUTIzhT5FI/krpoyngbqbJ3BksMp0BOj27K5N
	 IVJHyeCELtdiU2vPvrGzdLIqZAp3t4jZaExXdwjuKgoFr8Pm0MRQDtpn4u+2trkJ1Y
	 5HzzGg1O+Z8CLlx1Xh2Ds0SdzQ6DTLjgRfSVfBNmuIHWvSf1dgiU/8S97yUOjCZz/i
	 sP+ek4Lk/2wNg==
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
Subject: [PATCH AUTOSEL 6.12 083/107] drm/amdgpu: skip amdgpu_device_cache_pci_state under sriov
Date: Sun, 24 Nov 2024 08:29:43 -0500
Message-ID: <20241124133301.3341829-83-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index c2394c8b4d6b2..cea38ddf1e617 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6344,6 +6344,9 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
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


