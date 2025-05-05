Return-Path: <stable+bounces-140575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AA4AAAE44
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14611BA10DE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FE92D643B;
	Mon,  5 May 2025 22:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzXcnKji"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7636909E;
	Mon,  5 May 2025 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485182; cv=none; b=jCcZ0BTJKPqMFkSVSnQrahV2MEKNfqgUqsVBwRbZhYirASogHjAlNd5hOrDnbO4l2kYhRhn0P3xNTKxKEZNFn1NvDWhQ7tnzqKtJK9hNYp/CUCNS60wc2qw/3KRk+75ruuJG4M6XfDkKLCUjuvASjA7/pD1vEI/B2YnV/xzxqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485182; c=relaxed/simple;
	bh=+dGpTB9Cr1Pv5zc/njAKVzCK/O1t+wRSBvjY9YEFxss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZ3ogHOrOXpBJVA2N4GFnaZQqXTdo4NrTOZv9wm7i4H3zcfq3XG0f0dtd7ms9S9+BDYVRBNFlWISOYkwu8NfbgrmD8KgXqybarf36kdelX7LBD1n2gEJlyVZs9uvsdhzQdX59LUow0l/PvAC9gJmTFBnr4EzZqaF5XWLy1V4hqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzXcnKji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42868C4CEED;
	Mon,  5 May 2025 22:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485182;
	bh=+dGpTB9Cr1Pv5zc/njAKVzCK/O1t+wRSBvjY9YEFxss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzXcnKjiXE1tA7T7XXSyGz63/Y0+mnULochoO/y1lyxraeTJKyS/BnpxhqlFeuWVP
	 h3E7ElZN63x5I2vNQDJJnBnVPfR19piZz8RtbHkTJXGZlWlp2GzH8kDD13zkNvNW+W
	 KckeOUPmVWGgDKTTAat4x9st9Aa6m6cPZobFgH8hV7SF4anByOQphH7lwB44SVi9hR
	 s999cKFXw/5IbJoq8SZyVLLASWHOUR18fbuooD/kTqPc+RLTWANzQVMVtKlTc4D0sp
	 tDirB1CzznAcXf63rNNJThzUfy8B0MLX2Xt6AKfjs6ypa5Ps845d0RGKBo3F1b4qPI
	 6BHYFlkrckvJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dillon Varone <Dillon.Varone@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	chiahsuan.chung@amd.com,
	Alvin.Lee2@amd.com,
	aurabindo.pillai@amd.com,
	alex.hung@amd.com,
	Ilya.Bakoulin@amd.com,
	Leo.Zeng@amd.com,
	Iswara.Nagulendran@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 200/486] drm/amd/display: Fix p-state type when p-state is unsupported
Date: Mon,  5 May 2025 18:34:36 -0400
Message-Id: <20250505223922.2682012-200-sashal@kernel.org>
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

From: Dillon Varone <Dillon.Varone@amd.com>

[ Upstream commit a025f424af0407b7561bd5e6217295dde3abbc2e ]

[WHY&HOW]
P-state type would remain on previously used when unsupported which
causes confusion in logging and visual confirm, so set back to zero
when unsupported.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index bb766c2a74176..ab6ed9dc5f4db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -508,6 +508,7 @@ void set_p_state_switch_method(
 	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx || !vba)
 		return;
 
+	pipe_ctx->p_state_type = P_STATE_UNKNOWN;
 	if (vba->DRAMClockChangeSupport[vba->VoltageLevel][vba->maxMpcComb] !=
 			dm_dram_clock_change_unsupported) {
 		/* MCLK switching is supported */
-- 
2.39.5


