Return-Path: <stable+bounces-65047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3920F943E70
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C199B2B7CE
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574018CBE5;
	Thu,  1 Aug 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utfuLO6v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435FE1CEE10;
	Thu,  1 Aug 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472168; cv=none; b=XgbFa/4jsbMitpxItC+Xq5Yxll8q8L106wCYHDc/IEG5GMGQ93ttDSrCNhCKyoKHLrd2aZUhaBZfaL9g4TeXtTV51pRXaCVcOaOE72qiEUhCWuBQpbqPzn1yyWDgWe/SwWidmD9nbFnwL1D17pvfrlVXaniWykh4iDsGPFMw2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472168; c=relaxed/simple;
	bh=H9DwXDIaGWACfzvn9LOU8qIZUZNbaRFqtoQigqpipv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9IUVW6c1hjCzpx39hB3IerxXJ3htubNk7gzcs4TGVP/HAEdDZVQYrdVlT3Ir7FWZ9bhTwsEZdwgSpkf3IsbBsw4PQ5d4WuYdKxFnpqmZ8s+T1s95f/JGO9TQU4kB+V+QgJVC3qFg3M5/ctoBOVhwDhUKfIGxQf+c6ccLf2/ZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utfuLO6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DBCC116B1;
	Thu,  1 Aug 2024 00:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472168;
	bh=H9DwXDIaGWACfzvn9LOU8qIZUZNbaRFqtoQigqpipv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utfuLO6vk5xvfq+FLhQfDQ1MNgPt73lrmDbUo66TAeblkE/9pN+CkatRl01oNXsei
	 Q6583SJlHl1RIwjYUgs/AgdpXCcLaoic+XCxFhGK9q10LI8SorhlBhgwvjDSAeJIz9
	 3pTumJTNdq0Vs4VE6E81P51SNmhWIv4V5HntkpIIZtsnk+RUjrcdupUhE27lM/Szte
	 ZRw/o3vu5SwleNXBt5MJ0XsJAygJ9IPizQVXI5tZnxtRNHzb5xFvXXyR1o9FbmTR/T
	 xYagb8BYvZ3qSNHs348/3mn0kFujTgvOwc8aUg2zNqlsqI0ejmGyVG2FPGKyN4Du30
	 k3LCldRQcYYeg==
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
	srinivasan.shanmugam@amd.com,
	guchun.chen@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 18/61] drm/amdgpu: fix ucode out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:25:36 -0400
Message-ID: <20240801002803.3935985-18-sashal@kernel.org>
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

[ Upstream commit 8944acd0f9db33e17f387fdc75d33bb473d7936f ]

Clear warning that read ucode[] may out-of-bounds.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index f1a0503791905..682de88cf91f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -213,6 +213,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		struct amdgpu_firmware_info *ucode;
 
 		id = fw_type_convert(cgs_device, type);
+		if (id >= AMDGPU_UCODE_ID_MAXIMUM)
+			return -EINVAL;
+
 		ucode = &adev->firmware.ucode[id];
 		if (ucode->fw == NULL)
 			return -EINVAL;
-- 
2.43.0


