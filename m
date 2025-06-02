Return-Path: <stable+bounces-148536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD0ACA43C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661F818847B4
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DE9292088;
	Sun,  1 Jun 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI7YVanR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F6264F99;
	Sun,  1 Jun 2025 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820746; cv=none; b=fF64ECrup7gaDG49pDPIDL4YTy/fowFBDMLwytkHkYTXLk/B+gvdAN4mNcUKoChwJMsdYB4MnpZxal3k4Z1PoPDExFhAOIygORlpg2+NhyOZ6wA9ApqOcfLkKXzNEy1dJBlSErkMNv9pDc1sqIrD816nMWXw7ONXlARHuAfDq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820746; c=relaxed/simple;
	bh=Hi+u6xACvnljfk+RoXAgBNCMsFdimHTuU7lAQgjM7oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cri/En7N7hGSj72A0/gYJlSlfYDO4VG6/hiFDnOuppEGZZfwZTWFawth3a9rAjNkHURFHVhicNJ9NtnYgluITkZOGJdeWkxXVpODDU5QwKIAQtB0J/6soMuKPZqmJlTtW3UO9iHHaYXBVSvD1tvrDr5MNI6ucmsjSRicLJyMsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI7YVanR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B5EC4CEEE;
	Sun,  1 Jun 2025 23:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820745;
	bh=Hi+u6xACvnljfk+RoXAgBNCMsFdimHTuU7lAQgjM7oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZI7YVanRuBcM31/AY/ZE3rIJ2ygMEEWwO3bn3cl6+vEFawZLlRJNp8oDYcdWgycCx
	 xsHZTCatS40LQFgpGHTARntbgZqz60ou34IUeSG7phOcmxhrQkSQ08v8FXO3qcvZx4
	 qRIWUjjuF2V8IbiOjNmc6atvSS9F5+ZYIzfEeBOZfpVaYXzvGgNMoaVBrsGRkCyGU5
	 QhugCPyrCvwnwpfjSzSP0q7/COWPNPInwYFqkGxG5Dc9sQmnFlfb4SVdAFpQ3pXBb2
	 b43E/LgTDsc54I5T2M2j1QFIgLxCxamwnkF9QlUIyKIbn31sLrmX5R25KrV0lrtD07
	 m+4tRXZ+Em8Hg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: TungYu Lu <tungyu.lu@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
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
	alex.hung@amd.com,
	rodrigo.siqueira@amd.com,
	hamzamahfooz@linux.microsoft.com,
	v.shevtsov@mt-integration.ru,
	ivlipski@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 060/102] drm/amd/display: Correct prefetch calculation
Date: Sun,  1 Jun 2025 19:28:52 -0400
Message-Id: <20250601232937.3510379-60-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Transfer-Encoding: 8bit

From: TungYu Lu <tungyu.lu@amd.com>

[ Upstream commit 33bc89949b4366dff2dca30bc61ba1c0cbcd2ab2 ]

[Why]
The minimum value of the dst_y_prefetch_equ was not correct
in prefetch calculation whice causes OPTC underflow.

[How]
Add the min operation of dst_y_prefetch_equ in prefetch calculation
for legacy DML.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: TungYu Lu <tungyu.lu@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** ## Analysis This commit should be backported to stable kernel
trees. Here's my detailed analysis: ### **Bug Description and Impact**
The commit fixes a critical hardware register overflow issue in AMD
display's prefetch calculation that causes OPTC (Output Pipe and Timing
Control) underflow. OPTC underflow is a serious display issue that can
cause: - Screen corruption or artifacts - Display timing problems -
Potential system instability during display operations ### **Code Change
Analysis** The fix adds a single line in three DCN (Display Core Next)
versions (30, 31, 314): ```c dst_y_prefetch_equ =
dml_min(dst_y_prefetch_equ, 63.75); // limit to the reg limit of U6.2
for DST_Y_PREFETCH ``` This change: 1. **Prevents register overflow**:
The DST_Y_PREFETCH register is limited to 8 bits with U6.2 format,
meaning maximum value is 63.75 2. **Applies early in calculation**: The
limit is applied to `dst_y_prefetch_equ` before it's used in subsequent
calculations 3. **Matches existing pattern**: DCN21 already has this
exact fix (commit 9857bb9457fe5 from 2021), establishing this as a
known, proven solution ### **Why This Should Be Backported** 1.
**Important Bug Fix**: Fixes a hardware register overflow that causes
visible display issues affecting end users 2. **Minimal Risk**: - Single
line addition in each file - No architectural changes - Simply enforces
hardware register limits that should have been there - Proven safe
(already in DCN21 for 3+ years) 3. **Contained Scope**: Only affects AMD
display prefetch calculations in legacy DML (Display Mode Library)
versions 4. **Clear User Impact**: OPTC underflow causes noticeable
display problems that users would report 5. **Follows Stable Criteria**:
- Small, obvious fix - Addresses hardware limitation - Low regression
risk - Similar to reference commits marked "YES" for backporting ###
**Comparison with Similar Commits** Looking at the provided examples: -
**Similar Commit #1** (YES): Also fixes prefetch calculation with min
operation and has `Cc: stable@vger.kernel.org` - **Similar Commit #2**
(YES): Fixes prefetch calculation loop variables and explicitly tagged
for stable backport - **Similar Commit #4** (NO): Same type of
DST_Y_PREFETCH guard fix but wasn't tagged for stable The pattern shows
that prefetch calculation fixes that prevent register overflow and have
clear user impact are good backport candidates. ### **Hardware Context**
This affects DCN 3.0, 3.1, and 3.14 hardware generations. The fact that
DCN 2.1 already had this fix suggests this was a systematic issue across
multiple hardware generations that needed addressing. The fix is
essential for proper display functionality and represents a critical
hardware constraint that must be enforced to prevent register overflow
and subsequent display corruption.

 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index f1fe49401bc0a..8d24763938ea6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -1002,6 +1002,7 @@ static bool CalculatePrefetchSchedule(
 
 	dst_y_prefetch_equ = VStartup - (Tsetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime
 			- (*DSTYAfterScaler + *DSTXAfterScaler / myPipe->HTotal);
+	dst_y_prefetch_equ = dml_min(dst_y_prefetch_equ, 63.75); // limit to the reg limit of U6.2 for DST_Y_PREFETCH
 
 	Lsw_oto = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC);
 	Tsw_oto = Lsw_oto * LineTime;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index f567a9023682d..ed59c77bc6f60 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -1105,6 +1105,7 @@ static bool CalculatePrefetchSchedule(
 	Tr0_oto_lines = dml_ceil(4.0 * Tr0_oto / LineTime, 1) / 4.0;
 	dst_y_prefetch_oto = Tvm_oto_lines + 2 * Tr0_oto_lines + Lsw_oto;
 	dst_y_prefetch_equ =  VStartup - (*TSetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime - (*DSTYAfterScaler + *DSTXAfterScaler / myPipe->HTotal);
+	dst_y_prefetch_equ = dml_min(dst_y_prefetch_equ, 63.75); // limit to the reg limit of U6.2 for DST_Y_PREFETCH
 	dst_y_prefetch_equ = dml_floor(4.0 * (dst_y_prefetch_equ + 0.125), 1) / 4.0;
 	Tpre_rounded = dst_y_prefetch_equ * LineTime;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 5865e8fa2d8e8..9f3938a50240f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -1123,6 +1123,7 @@ static bool CalculatePrefetchSchedule(
 	Tr0_oto_lines = dml_ceil(4.0 * Tr0_oto / LineTime, 1) / 4.0;
 	dst_y_prefetch_oto = Tvm_oto_lines + 2 * Tr0_oto_lines + Lsw_oto;
 	dst_y_prefetch_equ =  VStartup - (*TSetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime - (*DSTYAfterScaler + *DSTXAfterScaler / myPipe->HTotal);
+	dst_y_prefetch_equ = dml_min(dst_y_prefetch_equ, 63.75); // limit to the reg limit of U6.2 for DST_Y_PREFETCH
 	dst_y_prefetch_equ = dml_floor(4.0 * (dst_y_prefetch_equ + 0.125), 1) / 4.0;
 	Tpre_rounded = dst_y_prefetch_equ * LineTime;
 
-- 
2.39.5


