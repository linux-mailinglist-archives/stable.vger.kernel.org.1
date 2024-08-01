Return-Path: <stable+bounces-65091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5D1943E49
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A946F284204
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E24814A4C1;
	Thu,  1 Aug 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9OniIEB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A0132116;
	Thu,  1 Aug 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472380; cv=none; b=SkHXfKDXSU7uqsaA0Sk2QW99aCKGXTNBVdK/4o1uvqZrBbrUNXOFfBBlefXJlVOw9J9TZ9DgRoTTNARyK+ARCjNzpPwBdBarFuiMHPD79qTqrmRn9unB5RWiW6P7MQZiI5MAsAdwypmBRL3jfSbIf5noURuyNb+Bq5O2ha/5D+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472380; c=relaxed/simple;
	bh=vnaC5lBEnO91/OM6LKOnmMx+k9CVAr/TfHtx8O4pkuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUJ3EFal6mayFyuSQTYzRKED6JmlPaMJOnuQ5V6jnGGTnYMk79ga2V/CT9caCpytbdCazHE+QcT+gh//gsC6UjZfiFZ1aLxdL7TPS6SDcgMZ8rOOkzndwBS8aOyhWoQqPH3dPw+Gjds4j+SHu1iC+0iJ8HpgQo3fuPJHfS3wTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9OniIEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED8AC32786;
	Thu,  1 Aug 2024 00:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472379;
	bh=vnaC5lBEnO91/OM6LKOnmMx+k9CVAr/TfHtx8O4pkuo=;
	h=From:To:Cc:Subject:Date:From;
	b=a9OniIEBtf7ZlxIvKV3r9H2KImBeAufhxIhu4TBCEzrPHxKnrOecIoi+SOJ9l2Wea
	 jaRGCbWN/wQAYUth6+WCtW6a/xZpc8ZvVXYcRPbHrCRG8LNQeQNmwEX42lGKS8yj7F
	 qXomG7REFGHgvtPcaKEMfe6V9CsSwtQLyBoI6XH/5CY3D7+qojxuDXJ6DVRBAtoR39
	 IKAB9HGUsUvIV5csJGXA9LLQT4NYaQXKF7AN3nHTjMlKb4vJ9W6I/9ht3836SE2H3G
	 EKw4uX+cPUymsajI9b6HBRV3w50Nx0+m7mswhkrLdlhFFqlvbX36uq8JIdCRunFAQF
	 QE5NDWJpR9wZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alvin Lee <alvin.lee2@amd.com>,
	Sohaib Nadeem <sohaib.nadeem@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 01/47] drm/amd/display: Assign linear_pitch_alignment even for VM
Date: Wed, 31 Jul 2024 20:30:51 -0400
Message-ID: <20240801003256.3937416-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit 984debc133efa05e62f5aa1a7a1dd8ca0ef041f4 ]

[Description]
Assign linear_pitch_alignment so we don't cause a divide by 0
error in VM environments

Reviewed-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ef151a1bc31cd..12e4beca5e840 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1107,6 +1107,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 		return NULL;
 
 	if (init_params->dce_environment == DCE_ENV_VIRTUAL_HW) {
+		dc->caps.linear_pitch_alignment = 64;
 		if (!dc_construct_ctx(dc, init_params))
 			goto destruct_dc;
 	} else {
-- 
2.43.0


