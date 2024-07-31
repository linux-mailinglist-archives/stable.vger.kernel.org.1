Return-Path: <stable+bounces-64861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF9943B01
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F52281047
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938B7156C63;
	Thu,  1 Aug 2024 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9Uth3Uj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DECE13D8B0;
	Thu,  1 Aug 2024 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471162; cv=none; b=gPEJUQ2uwTgViEgm6h3pIOOIcfIMy66KC0sLFp9aSVAIRPrMH4FbzU7grQpQ6HXc1fYkOO+fciYTm/a/zMPnhXyhh5C8Do7UYYv5QQvdXmd35a9uofL7a5qwwa2WUgGttqARmJt00j97K1lg5z82tIi8cvSdm+1XkMgMP2dVD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471162; c=relaxed/simple;
	bh=BGS5wAJx3zxI9NSSDUYUvaAvLVv/o/NtJZwvzfr2PdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcV3hxiQyTud4rs6udiLrjFoVSXBEzpC+35e4dTQBDKWxenDAV98aix9TnXhw31FLplWUbasnoJbPJ4hbFmt/rNzTzqeiLvLnjrkDaq0JzjXrILidQztV4IPPkFfgd5RxMU5zZFZ42lHT8hG+KSxyqTOJZzi6p1m9QrFJmrvy8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9Uth3Uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A14C32786;
	Thu,  1 Aug 2024 00:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471161;
	bh=BGS5wAJx3zxI9NSSDUYUvaAvLVv/o/NtJZwvzfr2PdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C9Uth3UjJ59M5lorRjlkn2jakdLUNQmMcROChxbKLzvFrnMK4aDhU9gvZ92cF4p0v
	 K6cg2vO5H5I5gBzQlmsqWpOUNBS0Sy0tas5BDIQPgROlR35+jLBSPz8man3cTUyJNJ
	 pDM9zub0x8sk4dH64TcuwPUTcaG3dQ0kqrLASDKx4zX1HQv41dY3MAKyzmShdsN64I
	 BHYkjbGdMJ0sdIBg93aqII1xJSrQYT5uy/Xji+s0T2AVae9E5OvUAKluLoad+fDwUt
	 bUwJquuHutypcrlkAoToKwp+Z5WUOVn18HqkNYxZphdENB1PT2AcXzbh4akHQspgjk
	 pUXJhbqTmQUQw==
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
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	electrodeyt@gmail.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 036/121] drm/amdgpu: fix mc_data out-of-bounds read warning
Date: Wed, 31 Jul 2024 19:59:34 -0400
Message-ID: <20240801000834.3930818-36-sashal@kernel.org>
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
index 52b12c1718eb0..7dc102f0bc1d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1484,6 +1484,8 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
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


