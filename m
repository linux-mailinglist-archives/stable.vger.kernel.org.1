Return-Path: <stable+bounces-43242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F518BF081
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B101F21754
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F5F132814;
	Tue,  7 May 2024 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIVl44gx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB484E0E;
	Tue,  7 May 2024 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122775; cv=none; b=iBgYh4U3px9fK2hYCYBgFp6oXopGgbQ9bdlmtAY491q4ZjPcl5x4DRDNY/bqCCpWERMt8HoWs0dJRePhiCelL93JXSXf+0m0t3kmtFUSRFLAynWqj1yxZhZUTBU3Uux35g3Lth/dkQKzAAGLdcEhr4rGLySGgZ3khzVlUAooj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122775; c=relaxed/simple;
	bh=dxxZl0Xg/c6zGK7bn3CYkhYnA/QOT4vjOBqkFPX91g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IE2KXaOCFQD1qs6m4vtJREZi7YOVw+eLxnboZPPBho7t6z8BJ74XPSrjqYS0i84EOKL8rwL2sdzrnv0mJceMWW4RYlFO+e52MJnElXYHEit3juyruVqgtyfoOW7inhgNfRpKLzAlP4DeZycALCFPsnypS2yJ2hnuGjF03GgrLxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIVl44gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF7BC4DDE7;
	Tue,  7 May 2024 22:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122775;
	bh=dxxZl0Xg/c6zGK7bn3CYkhYnA/QOT4vjOBqkFPX91g4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIVl44gx7INC0G8/0GGkKUUKAHaiaa2W7+1Ll2SGkUqttepkhWoO9iAiVr+gDVdHl
	 Sxs1g1lw0rU8gXlFXeVdVTjSDo/tCQUvuAimL2q9g0kA+5O7bcHk0xSlCdDEeFvA54
	 SKqqghn46WT6MhAFfkl3xjsqjA5Xvsj/SS5fdZBXNGc1o9t6ZBMogJpVUbykpa6xzF
	 futetZ6el+CQWIimJiq+DRQGe2FslkfaCCjWEOrDzjHO/+NRLRts7DJrG/BzjesjcA
	 YFxmaKWs/ftXOLTGQCc5UG8t+eF/hmNlJ69WEDuSTc3RIuCN2FZ20D1sCHkkgcIZx2
	 eSxWuCpXWDOVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	evan.quan@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	kevinyang.wang@amd.com,
	le.ma@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 09/19] drm/amd/pm: Restore config space after reset
Date: Tue,  7 May 2024 18:58:31 -0400
Message-ID: <20240507225910.390914-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 30d1cda8ce31ab49051ff7159280c542a738b23d ]

During mode-2 reset, pci config space registers are affected at device
side. However, certain platforms have switches which assign virtual BAR
addresses and returns the same even after device is reset. This
affects pci_restore_state() as it doesn't issue another config write, if
the value read is same as the saved value.

Add a workaround to write saved config space values from driver side.
Presently, these switches are in platforms with SMU v13.0.6 SOCs, hence
restrict the workaround only to those.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6a28f8d5bff7d..be4b7b64f8785 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2039,6 +2039,17 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static void smu_v13_0_6_restore_pci_config(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int i;
+
+	for (i = 0; i < 16; i++)
+		pci_write_config_dword(adev->pdev, i * 4,
+				       adev->pdev->saved_config_space[i]);
+	pci_restore_msi_state(adev->pdev);
+}
+
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 {
 	int ret = 0, index;
@@ -2060,6 +2071,20 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	/* Restore the config space saved during init */
 	amdgpu_device_load_pci_state(adev->pdev);
 
+	/* Certain platforms have switches which assign virtual BAR values to
+	 * devices. OS uses the virtual BAR values and device behind the switch
+	 * is assgined another BAR value. When device's config space registers
+	 * are queried, switch returns the virtual BAR values. When mode-2 reset
+	 * is performed, switch is unaware of it, and will continue to return
+	 * the same virtual values to the OS.This affects
+	 * pci_restore_config_space() API as it doesn't write the value saved if
+	 * the current value read from config space is the same as what is
+	 * saved. As a workaround, make sure the config space is restored
+	 * always.
+	 */
+	if (!(adev->flags & AMD_IS_APU))
+		smu_v13_0_6_restore_pci_config(smu);
+
 	dev_dbg(smu->adev->dev, "wait for reset ack\n");
 	do {
 		ret = smu_cmn_wait_for_response(smu);
-- 
2.43.0


