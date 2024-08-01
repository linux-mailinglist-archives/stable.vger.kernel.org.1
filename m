Return-Path: <stable+bounces-65141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA2943F19
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0445280CF0
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C681AED59;
	Thu,  1 Aug 2024 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWvqbDK8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2C1AD9C8;
	Thu,  1 Aug 2024 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472621; cv=none; b=BnT/EWuJ6+UQOA0xpQUj0aR9YjJVPDxw74Kv32GDqfOKcHnio5+Zt7kywntY+M4lFvzo7cNgkMLS8GJjOmAaBc6EBf7lhfljAUsJyyYJkL4XXCIIw46eIZcStAXFqGnk+NFPK1g/fQUvygdWeDwUdx5rvdKM9UgqGPmkBWeQLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472621; c=relaxed/simple;
	bh=zDAPWNBv87Qqx+AtGXKPZq395SwmdpUPHqqeL4/CMgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLwto3b0GiDogtTX/x+u47PCrDdSSukFeO9lwm6oAodrPllSTM2f89LM/rtdWjFskj2VBYRlDZwNgdlk8o7l6AAYRsJgc1LQ9D2bEd8A2jw81J02ckqGNofHPJTTKQhaUAgJ9oOqFcxqBobQdzEgKvMmdlqg3h4g71DrIa/9n4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWvqbDK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F48C4AF0C;
	Thu,  1 Aug 2024 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472620;
	bh=zDAPWNBv87Qqx+AtGXKPZq395SwmdpUPHqqeL4/CMgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWvqbDK8Ml9SDvupex566NHwl//umXAeGqm3hTEauRG7Aa8JdpDjT5GkJWZm0pJZj
	 PI6Ds56HKB7ybgJFrtc8AKAKu5NVnpFi5UmRilGLFKG2DoF2Hfdrw87Pqj0hwdEWcB
	 BnaliJemY52lbCtnBLrIf+y+AXO0JJBvbQX47sJnbIbWf0LPJdmzE67CbzTZlZ7jDJ
	 RHR1ApH4Pl/L/t5hUaff58zo3ljdMFPajoTCZ72LMtXz5VFS6e1Ozv6LhYTX0VYT7a
	 b+u+lhi9Ic0bzwJvx8Ce5neKqJzKU8P1rdLUR4ZFASxNgDuVt13j3iDuFj45Q5YeMt
	 4rkIbMNhhPyNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <Tim.Huang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	Zhigang.Luo@amd.com,
	Hawking.Zhang@amd.com,
	Yunxiang.Li@amd.com,
	victor.skvortsov@amd.com,
	victorchengchi.lu@amd.com,
	Vignesh.Chander@amd.com,
	surbhi.kakarya@amd.com,
	danijel.slivka@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 04/38] drm/amdgpu: fix uninitialized scalar variable warning
Date: Wed, 31 Jul 2024 20:35:10 -0400
Message-ID: <20240801003643.3938534-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit 9a5f15d2a29d06ce5bd50919da7221cda92afb69 ]

Clear warning that uses uninitialized value fw_size.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index d6f2951035959..bd53844a8ba4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -404,6 +404,8 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	uint64_t retired_page;
 	uint32_t bp_idx, bp_cnt;
 
+	memset(&bp, 0, sizeof(bp));
+
 	if (bp_block_size) {
 		bp_cnt = bp_block_size / sizeof(uint64_t);
 		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-- 
2.43.0


