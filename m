Return-Path: <stable+bounces-95069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A36B9D75BA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78CEAB2131A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC320ADF8;
	Sun, 24 Nov 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGZuOxIZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B920ADF0;
	Sun, 24 Nov 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455885; cv=none; b=baj2N/+QGTFD4Fm3D00VVP2W3w6Pge+RzQpk14Yte0mR0uucQhGyf9LUUbyocYGMjGl4+wzKexFsQWinBV0coM8bzd0uI1z6gsF8ttUJF38aezbGyxztACpTSNazuMNwPiKBGMT5BuYsk2DlNLwWmWE34z65rwReeY3EZmawz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455885; c=relaxed/simple;
	bh=/s+/VeFjJnzR6LP11OT0Qr+tOhqlkt6aZuN10ZmrTvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFR8GwpErrM1yNdFimTpB8flg9vqPnP0xQTGdjoM6mrQU/eo9XSTtEQ3beMRfQdoWvuTRFX9Ixu2T6SEVx09bGvXwlMXc4uWYFhDLbeCC4I3hn8f7TGISKVS0Pf7xjtYdYeDwOjs1Be+HIAnQhdmH+4F/gilYbbFjB2GnLGgAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGZuOxIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB72C4CECC;
	Sun, 24 Nov 2024 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455885;
	bh=/s+/VeFjJnzR6LP11OT0Qr+tOhqlkt6aZuN10ZmrTvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGZuOxIZ7KfHq2Lg+8H1DH6F9wIaDWpQe0osqTeYgxXJ+gJeG2E/ah2CAd0wAE49L
	 qqMJ5JoW0SQYtfTiyn9tgAxsDwCgb0A/Vyk86h3WSpKPayYJ2PDEjyVCGtFOuKMFGw
	 lgzoGEirSvRaR8vemin3hRFtErhDKkiWyNkLuqF8M/e9gAVyW/at40IoQLfLsntmzH
	 u1y7Gpt3XNgschRzySNfzebTIhr+d7Y2AVWgTvx6wfSplf6WbqZxk3VMf6I1pW1K97
	 mi1+hdwmDl5J5Bf/NFgb+7It7ywtSwcossMepBlR/Y3MiSxlbBnal1+AWKAxPusEFO
	 mbGv5pDCokHkQ==
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
Subject: [PATCH AUTOSEL 6.11 66/87] drm/amdgpu: skip amdgpu_device_cache_pci_state under sriov
Date: Sun, 24 Nov 2024 08:38:44 -0500
Message-ID: <20241124134102.3344326-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index bcacf2e35eba0..62a9e714ad69b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6387,6 +6387,9 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
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


