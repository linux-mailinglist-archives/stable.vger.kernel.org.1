Return-Path: <stable+bounces-77676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEF998603E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31FF9B31334
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1852E22AA8D;
	Wed, 25 Sep 2024 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byyqIXJ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A422AA7D;
	Wed, 25 Sep 2024 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266670; cv=none; b=R2LSiCND4+Xcz3WcHokCXu5XnJwOtkCVlKQJfK9AiYMaEw5hZ+XOgfcqwPZYxDit23jefCs0Vm+08S08D7EYjo6ZH/xCqMc7xDO3x1FZXlSvlIFR6n8LNGNMPkOq/USj2Hx91bfXR8fx3cRIzIUulQlt2Eo+elAKSGtTjGKwP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266670; c=relaxed/simple;
	bh=0CNEPWq4RZvRIWKF8Bn/2ZdESenKkYkmew7bFKIHEtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzLbiQfSijedzvhid3R3iF+jrq594IWqMSykcLk9yWUM/Qq/ovmHfXrWNSoz0BQja2sE9Wb2Jk0T6pTQFPVzwfSXCdiN4AP/nsPjSpwWvdRsLXZeIfvzGp1FnmOZgSmQ9NxS8Oer6FLDZts59a9uWR8aoh7FYmMcscCOdtSfR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byyqIXJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA332C4CEC7;
	Wed, 25 Sep 2024 12:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266670;
	bh=0CNEPWq4RZvRIWKF8Bn/2ZdESenKkYkmew7bFKIHEtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byyqIXJ81rxi8WSpYQdUQx8syAqfJKoRg0wWXPflSccNEpKGgTrWm8OScy0t8puBT
	 9OkVMz+uasb71d5AKmRSgGAtYCKW+EMsAd7tBSR+Gtc5S9cgbDOD6EJW9OohtVUmeK
	 92qVPJPzWBMdH3j1a4nEH0pUL9bc8hLJKlembXpaVyhzH/aB7VHDIV4ObZUCaVvVsS
	 O75cjbfaaAhSJ7EULjvRxOLz5i/LPI5ll5jNxj8t8ELo4HzZAU4931K771tAtBNTQr
	 2rAiOZTgnzHZThfgkCpz7liq5gmCbtr7SvhIk8QLhms+CePb03MMS1H82wZhqOexYx
	 FOmXMf4liPfmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sunil.khatri@amd.com,
	zhenguo.yin@amd.com,
	kevinyang.wang@amd.com,
	Jun.Ma2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 128/139] drm/amdgpu/gfx10: use rlc safe mode for soft recovery
Date: Wed, 25 Sep 2024 08:09:08 -0400
Message-ID: <20240925121137.1307574-128-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit ead60e9c4e29c8574cae1be4fe3af1d9a978fb0f ]

Protect the MMIO access with safe mode.

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index cd594b92c6129..53c99bc6abb33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8748,7 +8748,9 @@ static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void
-- 
2.43.0


