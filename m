Return-Path: <stable+bounces-77323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858BD985BCB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460FD287EFF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C0C1A00DE;
	Wed, 25 Sep 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf8sPTYA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275941A00D7;
	Wed, 25 Sep 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265180; cv=none; b=GAQxkhDpBA9TfDzxz4iPiyrPg5rjXKk3IPaVNqCTQXv2U58PaBUXy63CNLt6qKc+ZIaCGLDkphS5Y3yIN6/l2pfvW3qBoltfH1zr/CAyMEFeUS17ykMGVfJoLa2JQ3iqGH+RceE0upN7LXl0NEUaWSDgMEH/l7hm9JNY0WeADUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265180; c=relaxed/simple;
	bh=F5K3EUs7bmUksDI8jNzKhnbmoQAbhXS8dUA6E+dxQ0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSDUSWFr2+5IcUkf2D++lae9MbXgtYdbJIAmhA11fErNA35YJOcohdKWUNG9w4NghZdOm/fNju9imh6rrPPKSG5+ll+rIhcd5cEwJ3K95mFeMOeCOE395mrHn8lzxkRXnjNRe3qxA0OZrsHi9wqhKp2310xhMWxZaX7gOsY8ZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf8sPTYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E958C4CEC3;
	Wed, 25 Sep 2024 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265180;
	bh=F5K3EUs7bmUksDI8jNzKhnbmoQAbhXS8dUA6E+dxQ0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xf8sPTYABZENSvABmm+6crd4xPGBcCTXgfUX997M1chbXkT57p0aG3W2y16/iSeT9
	 6emaccNIOEGTQD0DyDoYfBGzmbPoxyiNQoEDY+R3DY336Xo//m6Edo5VK40umeeOlH
	 hBvPmWIE7S1w3RT+BhqySMhkvUoe2xvD6CPG3JC0p2nm8Y0er1IpfeSU/0Eel5I6m0
	 f6zGB5pqKa+0fcMpK8gEmZKZESDdOtsK6gwCjfzAadV5P4J1ON/541dA89OTf4NORB
	 Fp1eD9Hnlqrm6sniUTDA7/ICYe+nueWKq5UsgmkTJu5eGZt5+Zo0JwNesxKl2ZISnm
	 D8HirY2xQu7bQ==
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
	Jun.Ma2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 225/244] drm/amdgpu/gfx10: use rlc safe mode for soft recovery
Date: Wed, 25 Sep 2024 07:27:26 -0400
Message-ID: <20240925113641.1297102-225-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index 5b41c6a44068c..1bb602c4f9b3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8889,7 +8889,9 @@ static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
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


