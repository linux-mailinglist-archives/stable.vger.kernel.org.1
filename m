Return-Path: <stable+bounces-65107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B36943EA2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E735B282D6E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4041D9173;
	Thu,  1 Aug 2024 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chr+jruj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BF1D9165;
	Thu,  1 Aug 2024 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472455; cv=none; b=fSp7k7DdeGFpyBPnpAG7j0V+2ZldDG7z9CvucmFMn4ItKmKvNB9kN8a2Id5S9g8PWF6CmhBxqR22A3+oaZlAzi8NzF5HdKVsZmZCs7eXiS2BERW+goLxJnTJDaBaDzoOAC98/BzZq+4pEB0jb8V5kVhEPQnxgdi1yTMzXoM3+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472455; c=relaxed/simple;
	bh=hzEIJqmKt/TyooB3GCxnYfRiBmaoOjTGSeUdvk/Pqz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0neMewXkZiSrbUdcR2Thf7A3XpGXrZOigUiA2IUBM9hNqN5QlPv8ajBxFhpM/daaB3vFSOcnU3FwuuvsuEQmkkUogCgbA4yaLIYJ8lZOxAqyNEDZhlgG6ebJ/ArqAXBVEZbJxbG6w+HB2t/Xbo9Z/vtzklyZ8hyI2tiJINwq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chr+jruj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B9DC116B1;
	Thu,  1 Aug 2024 00:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472454;
	bh=hzEIJqmKt/TyooB3GCxnYfRiBmaoOjTGSeUdvk/Pqz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chr+jrujPuSCmJcDku/fTrixiOBJDrsfIIoqg3zDJn5PxXOkQW+QuoWWlk8405T24
	 wGQ9ILyzLhJYanGm2y/ZWqe4gxs+R6HNdQ6xpQt13G31w2k4ZTjF7RP7VYlYN7hLh/
	 DPRsZ7hT+OHZYomkwCBkTvJX5q+247tRvrGn9iwlIW/gqEHmqQnFr20ko2Q6NMHLlR
	 RMHZZWs1aN/Hopw+lo+rKYY+G5gV9ANII7iwYrv5T1xiw+UpxERTseX2kXEhkS7lNH
	 B6gAnhj1RV8819jROZhfVD/q6RKwFHcU7xjtC7uZ+VWx8x03fLxmuMxLgzukg91JYY
	 rDUeXdIGaQ7TQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	electrodeyt@gmail.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 17/47] drm/amdgpu: fix mc_data out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:31:07 -0400
Message-ID: <20240801003256.3937416-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit 51dfc0a4d609fe700750a62f41447f01b8c9ea50 ]

Clear warning that read mc_data[i-1] may out-of-bounds.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 96b7bb13a2dd9..07b1d2460a855 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1475,6 +1475,8 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 										(u32)le32_to_cpu(*((u32 *)reg_data + j));
 									j++;
 								} else if ((reg_table->mc_reg_address[i].pre_reg_data & LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
+									if (i == 0)
+										continue;
 									reg_table->mc_reg_table_entry[num_ranges].mc_data[i] =
 										reg_table->mc_reg_table_entry[num_ranges].mc_data[i - 1];
 								}
-- 
2.43.0


