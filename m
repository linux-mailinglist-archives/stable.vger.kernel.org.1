Return-Path: <stable+bounces-64868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31400943B3B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F5C1C2061F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42345140E38;
	Thu,  1 Aug 2024 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx396toj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17621E522;
	Thu,  1 Aug 2024 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471216; cv=none; b=VXo7A3vXzm1LZxF/Z4w+m1IZzZAsmcfIvqO/F18PiQAFDKh3oD69uVLlA156F01CI1UhWBEXhh7KJ4KTJTvvSuBUngMFgbUpmLibl/XJqRrJ55fPKs8aTzk89nbiDesiEXj8tZGnhrLv8f9HKFuYtZhVKCnEQ+CmlYvnPTF2KgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471216; c=relaxed/simple;
	bh=7cDXmX14A2iHqD9MJ8FWQmZOM4Bw6lWEeJbAe1jomfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJhpGTj5TbpYdznNZnKs8Q1K0OTexONYtu+Pb0XfQ0fX/uI3JcaGZYa9/O3zqXM19sSCQQTo+yeFHdknekTua1ME871g1aJ8bvx+Ob8OgVplSaNXYx6jaSa7Bxy4cqtGLGh45fyvBPyZDcX54W2/GcHH/u/puw9zn6YNenUE78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx396toj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3067C116B1;
	Thu,  1 Aug 2024 00:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471215;
	bh=7cDXmX14A2iHqD9MJ8FWQmZOM4Bw6lWEeJbAe1jomfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fx396tojjA9vlvr0IJHQzpLt/F2VmQuLlg8IQgwdaPZy9/RihET1q+1CTX0nbtbKL
	 RxXXOtNEveTPTgO4dlued+mzfcC2XnT6w/N+NonOJW5BWwoOW5CWQeo9rbq1PAWbjF
	 KdmFdeL1+ktv9OibXTjiq8PtVKAJ5ANKoZ+pGmk2DcH8f6zh6ZpliReb1omNSWeZPb
	 cbCiP9x14y5J8SBP2hHuzKjCPMecKjc1KwkXtRV+YKvrP9rIffJK4RzK22pBopfyK4
	 4Hvm8iLLvAQf2CYAmrEd9Wx8S5WSpj2AojTP40lVnRh4XKTmaeLPJtiWvNogdC74Sp
	 vhKS0o4o8h5Lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	saleemkhan.jamadar@amd.com,
	leo.liu@amd.com,
	Veerabadhran.Gopalakrishnan@amd.com,
	yifan1.zhang@amd.com,
	sonny.jiang@amd.com,
	sunil.khatri@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 043/121] drm/amdgpu/vcn: remove irq disabling in vcn 5 suspend
Date: Wed, 31 Jul 2024 19:59:41 -0400
Message-ID: <20240801000834.3930818-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>

[ Upstream commit 10fe1a79cd1bff3048e13120e93c02f8ecd05e9d ]

We do not directly enable/disable VCN IRQ in vcn 5.0.0.
And we do not handle the IRQ state as well. So the calls to
disable IRQ and set state are removed. This effectively gets
rid of the warining of
      "WARN_ON(!amdgpu_irq_enabled(adev, src, type))"
in amdgpu_irq_put().

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 851975b5ce298..9b87d6a49b398 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -229,8 +229,6 @@ static int vcn_v5_0_0_hw_fini(void *handle)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-
-		amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
 	}
 
 	return 0;
@@ -1226,22 +1224,6 @@ static int vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_s
 	return ret;
 }
 
-/**
- * vcn_v5_0_0_set_interrupt_state - set VCN block interrupt state
- *
- * @adev: amdgpu_device pointer
- * @source: interrupt sources
- * @type: interrupt types
- * @state: interrupt states
- *
- * Set VCN block interrupt state
- */
-static int vcn_v5_0_0_set_interrupt_state(struct amdgpu_device *adev, struct amdgpu_irq_src *source,
-	unsigned type, enum amdgpu_interrupt_state state)
-{
-	return 0;
-}
-
 /**
  * vcn_v5_0_0_process_interrupt - process VCN block interrupt
  *
@@ -1287,7 +1269,6 @@ static int vcn_v5_0_0_process_interrupt(struct amdgpu_device *adev, struct amdgp
 }
 
 static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
-	.set = vcn_v5_0_0_set_interrupt_state,
 	.process = vcn_v5_0_0_process_interrupt,
 };
 
-- 
2.43.0


