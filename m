Return-Path: <stable+bounces-140790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F3AAAB90
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189313A8C66
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0702395270;
	Mon,  5 May 2025 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAyRMsj8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C639526D;
	Mon,  5 May 2025 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486269; cv=none; b=CyML+69CgTOTSEUqnQ+3KZsaifdIT2QcoJzFmqQOEMX6vUxcPffWD4yYSuaUhO0Z0aCzJ7MOLCe41/OpKD4YANWOJsKQJAPguqFL9xokD8p+YK65DHfW5j39lGwN++vzcnPR1j6okcoQXlL9iyt2Oc8UButfCBTu3XWtmKCXGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486269; c=relaxed/simple;
	bh=CeU6s5BbPhsa/BxUt2Sys/rxJHd55eFqxtKzORCPOkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+uv04WIP0PDzFTuUjGz7xoVXM4s7W/WjiaDEMzuBdGFalk2TR53Vb/sWEFJMaFtvOJ2hmc2znYQuaLj9klGLE62paypAPy3q8IYISOPtd8zX1r4uPhornq+s+LCFbOfUhQhsgbdFTvCShASmnE0PZxZxk0GUSbYhdw4A/+vuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAyRMsj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C25DC4CEE4;
	Mon,  5 May 2025 23:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486267;
	bh=CeU6s5BbPhsa/BxUt2Sys/rxJHd55eFqxtKzORCPOkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAyRMsj8Fpg62uTdcG1B2Oiy8WEhxgTQfFQu+vZJWxVUIoTckiM2kVDBbHNu7kIve
	 wIWH4jCyC8NE6Cir4FUphC77+up15yIUjeSca7PYrZd9wSRUEiffHTtbqUk9/Nc0qE
	 9AfqAolcPmMlAQtdQSVLudQMUDzzn89a6ySGtaymmH3IOopQrDUAx1KpTZd1BHi4Pa
	 jcgjSUYBO0DT4QF9Ggw3ddkHzV4GMY6LdHaEQtuQuoHZErfPulTu4aoG0ZdcuVFTzR
	 iacTk7nMb4snLkkDNhgW6pAdeZfveCwRjrgX862GgU7YzMMcXnq8MmzXqhaI64Z1qU
	 E3sqxlx8MaYlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	alex.hung@amd.com,
	chiahsuan.chung@amd.com,
	sunil.khatri@amd.com,
	aurabindo.pillai@amd.com,
	Yilin.Chen@amd.com,
	mwen@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 230/294] drm/amd/display/dm: drop hw_support check in amdgpu_dm_i2c_xfer()
Date: Mon,  5 May 2025 18:55:30 -0400
Message-Id: <20250505225634.2688578-230-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 33da70bd1e115d7d73f45fb1c09f5ecc448f3f13 ]

DC supports SW i2c as well.  Drop the check.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e6bc590533194..877cc70ae1e79 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7468,7 +7468,7 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
-	if (!ddc_service->ddc_pin || !ddc_service->ddc_pin->hw_info.hw_supported)
+	if (!ddc_service->ddc_pin)
 		return result;
 
 	cmd.payloads = kcalloc(num, sizeof(struct i2c_payload), GFP_KERNEL);
-- 
2.39.5


