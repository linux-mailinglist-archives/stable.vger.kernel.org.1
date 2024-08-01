Return-Path: <stable+bounces-65048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC26943DD5
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1D1285DC2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFEF1B7030;
	Thu,  1 Aug 2024 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUAsjHef"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73AA1B7020;
	Thu,  1 Aug 2024 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472172; cv=none; b=fxu0wXFsQF/IzTPwNjqfEACdtQj3uneepMPFIYKh4KcWCQquPidiIgf9k9x6/HB6QuMJtj9/k2b6RdrW91DZb2x+/MB6CMYj0gvpfByAOk+lAXBntnk8UCZwrwPJBrt0+DDQSe7jbOtQX6VxNoRBIXWaLBh3ZR1QuiX8v1Vma48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472172; c=relaxed/simple;
	bh=g7eo0RrkP1NLLYcWEOC3tLxo1r+lEnCQH2vs6Qr++nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDFFz2sLgBrXLViMXMBl0ImW5m4TIzRt5UX3F1az+Cf6X/xXsWtjsu6iHpWnWeNm79OtD1A88J3j16aGnX0BEXTyojbuOpswBzQsuqIAmQ3ysj9lm0zrKiIYYPKLtYLnh2gjVS7GeOO3kUmnE1yJSmvySzynvmK2LdgIbKsDr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUAsjHef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F03C4AF0C;
	Thu,  1 Aug 2024 00:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472172;
	bh=g7eo0RrkP1NLLYcWEOC3tLxo1r+lEnCQH2vs6Qr++nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUAsjHefONFaBqDHM/jhncDm7QxuJypkhZ0G4FHfMkphNGkiyeZ7IMuQqQcEA6Fsb
	 p/14auXumDcebhPDGlEztw2GiAikTVCyqSRZiru9GLz/LTsLRjkfv1IbVgB7ImvJ+K
	 W2L24VQqixHs2qLqu2qXhQQYc8StbsG89U0NWykHhnch93meUIBCNBdazgz6tR35Rl
	 684nSwUCfBL23wn/hERPMXN6FJ0ivSt7/hwbSJgrKnk0iRC3KGrypT9Fu9wkMTmdMd
	 rOYKvNM24N2YAiZwM6lN+5n8tLDnbLaJTOBrpN1BDFSn3CYkfLMYqMMN38jPNMlxG6
	 TpGAJV7ID06QQ==
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
Subject: [PATCH AUTOSEL 6.1 19/61] drm/amdgpu: fix mc_data out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:25:37 -0400
Message-ID: <20240801002803.3935985-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 9ba4817a91484..816014ea53817 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1476,6 +1476,8 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
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


