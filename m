Return-Path: <stable+bounces-43221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9F58BF034
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0AD1F235E2
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4490B8615E;
	Tue,  7 May 2024 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxbAwJUv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D197FBAA;
	Tue,  7 May 2024 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122675; cv=none; b=c/ueVWNpmb5p6Dd35YgX9rfJDir5tfkKLqWU1CtIcuk+113E+jnujoe5gAdDe89hWAyHt8w3ckHC/7ZPXUQ+XJWVCqWYlJxXkdWSUzeeRSNRQRJFGiibjAY+tu2Q7z/p1ReNCRMHMaEUGVAZqAp/4YaM9EiYJrI04Bi0Bs4ZENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122675; c=relaxed/simple;
	bh=udNWqAkvlsLASnmTFzv403Ly/z9YdIt7N7LlhQs4C2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWuMKvbEP/96YTKwrbjhcedRTPTAfJ0eHCqsXjoe/mqKgK3AcTwktM1u7589G6UHXGYgPdBZj6PHtZomkNZ7m+R3MiYPnJQP0kPzg00clWkOYMtZ36EDoY+SSy6dwxABwgbrLO9Fq/c2l6ZIzPZ9UYT+Q1ODoybiRi9n/UXC+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxbAwJUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C27C3277B;
	Tue,  7 May 2024 22:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122674;
	bh=udNWqAkvlsLASnmTFzv403Ly/z9YdIt7N7LlhQs4C2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxbAwJUvTkBoW8QUHQPUrOKGKDbU7y5hLveb080WPQoxY1x8tO+ErUJ6BdSkuBaqT
	 GkYX4Xgrfje7uEvtXJsCbeUCA1Ld8bPfDUqwqy3OrUqgxqwSWcifk0tcIfyOUJOrvC
	 m1R/dFu/jv7jC9RB2vlKjNpE//y+LhdwwtFuEI0FlPKpcMl1bs7/S3IAoI3SDdeTPU
	 B3VM7IUBm/3+NACSW2XBNODQ3d/2NlZmfpUm7Aa0hs/cKITFUQqHlcqVrlTVcjOmT5
	 dRqs+fwukKdDm4MVyelPohzV9AVHqNkkmj+YqfP8jOFp0V2RX/9q84ivII6ZTpyFns
	 8bbbM/kDBqrhA==
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
Subject: [PATCH AUTOSEL 6.8 11/23] drm/amd/pm: Restore config space after reset
Date: Tue,  7 May 2024 18:56:37 -0400
Message-ID: <20240507225725.390306-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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
index 78491b04df108..ddb11eb8c3f53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2205,6 +2205,17 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	return sizeof(*gpu_metrics);
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
@@ -2226,6 +2237,20 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
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


