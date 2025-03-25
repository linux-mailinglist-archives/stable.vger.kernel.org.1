Return-Path: <stable+bounces-126607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F47A7093F
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 19:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD177A6070
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE871F2C5B;
	Tue, 25 Mar 2025 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZFfbhnN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8341C84AE;
	Tue, 25 Mar 2025 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928154; cv=none; b=m06eFcLCxZMSsQfL9zd6ZapszJkj9cq5P7oC6LsKP8uI2gXxGi7wU85kCwzL40Vbn+lG1sKUH4EiFP00B0bXdUiAYu1KTQF5yPq0mW+nAivMdJS3PbxsXA5df6V1LWmbeJ/C2JXpsB604Y8E0LEd6tFkySOoZvWE7L0q0QtNXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928154; c=relaxed/simple;
	bh=UTL901inkbdnXMs+G/Z6z+kgEDFCe5XJ5SSbeGhGR8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8pNqr9Fn9T0xHbzeSt2jKYoB7FRuIydZbGREu8wImjK1w+qKxF/EJ/UKomdlw4b0bkvXZcqQBptQfE8lfg8reVdncQMEMI5OHjzVpVGCFPGVTANE/tk3zC8cbiahRqXDASsTUdWPDvZwGTf0LYBzgxwfPYP7FP52RCx3Hugrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZFfbhnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC98C113D0;
	Tue, 25 Mar 2025 18:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928153;
	bh=UTL901inkbdnXMs+G/Z6z+kgEDFCe5XJ5SSbeGhGR8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZFfbhnNXWmuU/o9PRcxacRwP9ntjhDAkD8RwFVI6BQls04fqCzD0FPiAGCKTC9LV
	 Tk9AFK02rYuB+dJVFGVAqqiiqvmrL+1oqYtYv+J6vJ9d2O1eRiXQQCdXfo34NBsCsa
	 PWePPfV4I5zo1q/CMvqiqm7aPOugNTWf06R/me2J5je5cuEywCFnWIdrlfJpiGQx67
	 IAIjrzI0XcGrT13nfW6YTxBsMMmCZlpkXnchrzrc1Yxa/6Hicz4S7ymgEc9QgSjFWn
	 /wrl3e5i4q2t50SQoVain4OpE/JF5HRDCPmEOT6GOpuLMTjR0lY+sKWT7aUch6T9tI
	 +aDnVUOwvuC9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lo-an Chen <lo-an.chen@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	aurabindo.pillai@amd.com,
	rodrigo.siqueira@amd.com,
	duncan.ma@amd.com,
	jinze.xu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 6/7] drm/amd/display: Fix incorrect fw_state address in dmub_srv
Date: Tue, 25 Mar 2025 14:42:14 -0400
Message-Id: <20250325184215.2152123-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325184215.2152123-1-sashal@kernel.org>
References: <20250325184215.2152123-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.8
Content-Transfer-Encoding: 8bit

From: Lo-an Chen <lo-an.chen@amd.com>

[ Upstream commit d60073294cc3b46b73d6de247e0e5ae8684a6241 ]

[WHY]
The fw_state in dmub_srv was assigned with wrong address.
The address was pointed to the firmware region.

[HOW]
Fix the firmware state by using DMUB_DEBUG_FW_STATE_OFFSET
in dmub_cmd.h.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Lo-an Chen <lo-an.chen@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f57b38ac85a01bf03020cc0a9761d63e5c0ce197)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index a3f3ff5d49ace..9d2250d84f291 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -708,7 +708,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	cw6.region.base = DMUB_CW6_BASE;
 	cw6.region.top = cw6.region.base + fw_state_fb->size;
 
-	dmub->fw_state = fw_state_fb->cpu_addr;
+	dmub->fw_state = (void *)((uintptr_t)(fw_state_fb->cpu_addr) + DMUB_DEBUG_FW_STATE_OFFSET);
 
 	region6.offset.quad_part = shared_state_fb->gpu_addr;
 	region6.region.base = DMUB_CW6_BASE;
-- 
2.39.5


