Return-Path: <stable+bounces-148391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7653ACA1B9
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0D83B2A8B
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F8325F996;
	Sun,  1 Jun 2025 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2ALfnFM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45B25F993;
	Sun,  1 Jun 2025 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820342; cv=none; b=qw8KHlkyPaJmIGF3yLcFxivBIAgYfPxCui6JchkFh4b5hcDUtj2oqQUe2jAd/5IoJSTMp3JjzheuO+gtGR6nOViAe9itJeY4h5vjqVixVw9CCthLUMWOPjIYUFIkUZXN+PEGCPjpfdwtHO6xR7dtx5PAgYKVzkFkJvzzJ+yq6yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820342; c=relaxed/simple;
	bh=v7iuiDi1cfL9bA1B17SrshztrjCI1bjyMxJuzqGdkWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qSQXFgH9OcGRk9EUAPuGv333XvIaHHhdJzuq2KUAzIRswjyC3E5gVUMkkT83OHspWROw0Ll+fQ6kZ/FAfjiupJlYY6UOirGwV8RUrdV28HDTZV0ff+Dv1vJzMDbeEukQTlQSuO+cgToetJSWWlnwTMDoAHERqvWBOV+xvNmQ7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2ALfnFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B164C4CEF3;
	Sun,  1 Jun 2025 23:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820341;
	bh=v7iuiDi1cfL9bA1B17SrshztrjCI1bjyMxJuzqGdkWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2ALfnFMIPTx8VbwoLE/KVyunjHdRD3WPZrg5gmaZQELvqrhdukG5Bif2JBj5OLb/
	 6pSRddlNsZ9Ym6bgCfPizyyjih/eKJdO/XuESYpkxHqhcBQxDR/OSogckOVreK+S1o
	 BH11WqqXqcBVvFAimFY4ORgfuUQx7RV51zT/qEKtuZXRV/nhsKv5zBt4JDtk3nv/g6
	 TFVt9V9LlUaNI7Xb133XSeJiLeZtSBRPt6s/fwDsjjRhMuR1F1Zgo+1YXQzY4AoC8q
	 6p6OYVkVF1r8clj8BiDv/pCQ6cx753wWWK/1tvZ5jQLyGSdxnj1XduvjuNx/qBEfgq
	 R3FEGlvKrKaew==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Mark Broadworth <mark.broadworth@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	austin.zheng@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 025/110] drm/amd/display: Avoid divide by zero by initializing dummy pitch to 1
Date: Sun,  1 Jun 2025 19:23:07 -0400
Message-Id: <20250601232435.3507697-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 7e40f64896e8e3dca471e287672db5ace12ea0be ]

[Why]
If the dummy values in `populate_dummy_dml_surface_cfg()` aren't updated
then they can lead to a divide by zero in downstream callers like
CalculateVMAndRowBytes()

[How]
Initialize dummy value to a value to avoid divide by zero.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees.
**Analysis:** This is a classic divide-by-zero prevention fix that
follows the exact same pattern as all the similar commits marked "YES"
in the historical examples. The commit: 1. **Fixes a critical bug**:
Prevents division by zero errors that could cause kernel crashes or
undefined behavior 2. **Extremely minimal and safe change**: Only
changes `out->PitchC[location] = 0;` to `out->PitchC[location] = 1;` on
line 900 of
`drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c` 3.
**Well-documented issue**: The commit message clearly explains that
dummy values in `populate_dummy_dml_surface_cfg()` can lead to divide by
zero in downstream callers like `CalculateVMAndRowBytes()` 4. **Follows
established pattern**: The fix is identical to Similar Commits #1, #2,
and #5 which were all marked "YES" for backporting The code change is in
the `populate_dummy_dml_surface_cfg()` function where dummy/placeholder
values are initialized. Setting `PitchC[location]` to 1 instead of 0
ensures that any downstream code performing calculations using this
value as a denominator won't encounter division by zero errors. **Key
evidence supporting backporting:** - **AMD Display subsystem**: This is
a critical graphics subsystem where crashes can severely impact user
experience - **Crash prevention**: Division by zero can cause kernel
panics - **Zero risk of regression**: Changing a dummy value from 0 to 1
has no functional impact other than preventing crashes - **Small,
contained fix**: Single line change in one function - **Clear
precedent**: Multiple similar commits fixing divide-by-zero in AMD
display code have been backported This fix directly addresses a
potential stability issue with minimal risk, making it an ideal
candidate for stable tree backporting under the kernel's stable tree
rules.

 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index ab6baf2698012..5de775fd8fcee 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -896,7 +896,7 @@ static void populate_dummy_dml_surface_cfg(struct dml_surface_cfg_st *out, unsig
 	out->SurfaceWidthC[location] = in->timing.h_addressable;
 	out->SurfaceHeightC[location] = in->timing.v_addressable;
 	out->PitchY[location] = ((out->SurfaceWidthY[location] + 127) / 128) * 128;
-	out->PitchC[location] = 0;
+	out->PitchC[location] = 1;
 	out->DCCEnable[location] = false;
 	out->DCCMetaPitchY[location] = 0;
 	out->DCCMetaPitchC[location] = 0;
-- 
2.39.5


