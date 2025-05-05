Return-Path: <stable+bounces-140229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5284AAA67F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6355A3F7F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220F290BAC;
	Mon,  5 May 2025 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfAey4zF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2D290BA2;
	Mon,  5 May 2025 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484454; cv=none; b=sBoipE8W70ATS+/wAchyHV/yaqYDbA2R8GFfzDdho76bnBd2SAhznhLI2LsNYtP/2obTvXScDe1I7LbuTZzXVy3vYnbZngx77+//TX42buFGHvHkBrXm30ZnKNqzKzhv/afX2Vru0fNQYNOYLvq51BonkoPg2TxQg1zsiLXLNWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484454; c=relaxed/simple;
	bh=xGriufvVZPlZ5QnT5KOyB6D6wmvwkD8MYSfWZWJKXnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdowYdHHVz9tKkVJn4AknEVa+HWsSQQ0xlvvbUXn4wuaJea42Ul3SpOGNLPymjP9sYwQ91qWsPY6LYuf/q9PBUYH+Tl8sOi3Pwy1nyFjRTsYA2hdG3PUfGnO3KUid+61xIo/yo+Yt0cEQK2jVfAjp/jKyQFkx/4EMWLwKOWer0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfAey4zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C966C4CEEE;
	Mon,  5 May 2025 22:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484454;
	bh=xGriufvVZPlZ5QnT5KOyB6D6wmvwkD8MYSfWZWJKXnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WfAey4zF9MXbJXCtt0DzQ70rwQwuuGz8oJBWZR7Cu4CaDATvp2f4nuZbNKQuuVgus
	 RlnZeHQW9b8ayykWwsafGHYqrh9MnHHnVWQRHiaOXIxKIuFLJ7priskbaXhJkNZOTl
	 5eTzzMa+fdO2W1AQ3ceAQjDacPlk1XB9rJeRbOSJtf8GmX4eQ26qiDqFK08DbLj+3L
	 Gv3XAt975sK6zbfPWoBow6FnPluHU2R9K5RKEVp3/nZHFbE+XfX+cRmHYXf89ZID+4
	 7LfZnHMyTolY5jdNg+bCVLGtATI1BJFRPjd00FXh7sL86r2v7eBV49M7MTu9tHuR18
	 vLToU3ZIg12/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiwu Zhang <shiwu.zhang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	lijo.lazar@amd.com,
	sunil.khatri@amd.com,
	candice.li@amd.com,
	YiPeng.Chai@amd.com,
	le.ma@amd.com,
	Feifei.Xu@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 481/642] drm/amdgpu: enlarge the VBIOS binary size limit
Date: Mon,  5 May 2025 18:11:37 -0400
Message-Id: <20250505221419.2672473-481-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Shiwu Zhang <shiwu.zhang@amd.com>

[ Upstream commit 667b96134c9e206aebe40985650bf478935cbe04 ]

Some chips have a larger VBIOS file so raise the size limit to support
the flashing tool.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 665cc277cdc05..6dded11a23acf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -44,7 +44,7 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_atomfirmware.h"
 
-#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*3)
+#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*16)
 
 static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_rap_terminate(struct psp_context *psp);
-- 
2.39.5


