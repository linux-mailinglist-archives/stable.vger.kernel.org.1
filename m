Return-Path: <stable+bounces-148769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215A6ACA69A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CAF3BF205
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD687320721;
	Sun,  1 Jun 2025 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxaltH6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F52750FB;
	Sun,  1 Jun 2025 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821294; cv=none; b=Im7ImSsPVlipYcZN1/yYYEAmxGRJ11dq+HdhKoaT3PWvTDwh8a5+U08gt3beI+IrQXe1gzQBd3IzhpHuQ4tjCs6b1cdJML7NtlCpUJexGPHgV2fKOxvQM4UEJCYvnLQ3aaLE/NidTR7qXOr+k2hyYzyMXIXhzT0k7Z6TGSBcjFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821294; c=relaxed/simple;
	bh=OXrgR/+f5g/9yphxneWaCTWThdaSJ48Qv/g9azg1yio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEjJYn886TUzoVcdSrjG6fqD3riXL5mYwwbQOOUSZD6SDL/TLaMUTPOuPmE043Yd9yBR2weF9g42aYsL7eVytXmHVWl9Pe+0gybAYd1ydQIKYLIiYDY9IEJ8saSfH8nXzpwUUzAEBfnoySCkWHD3isr4i+nFBhKta5C07o/t2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxaltH6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD242C4CEE7;
	Sun,  1 Jun 2025 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821294;
	bh=OXrgR/+f5g/9yphxneWaCTWThdaSJ48Qv/g9azg1yio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxaltH6Y8I/kEA+34A9CN+EtE16t3TnwclWYLJwUNVcT6TdLz5pH21BlHyVsgsQeT
	 IpKkLW0EBD5idPGJO7Umb5NPttAueaseCWig4hxliBUEI4d71Ehh2WyaZg13vwijiZ
	 THZBiXD2C9DcAck25qawZMiijOAC9LRO7wSoMiiJD+xDtbdBvvypGab34LA0SVkGeb
	 Er3fggUEgNqm+i1yYUcz8kPo8dbdWGFOYLljbVDxfqBFIifRdBfjd85Y5ZvGn9Woi7
	 fn3i/z1ni0Bvj/NN/UlKYMQNDZ8xfCIjXgUFlDhAqGzOob7CCvLwvCN1oII9tY9sQW
	 WlmK8MvDPaiIw==
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
	v.shevtsov@mt-integration.ru,
	hamzamahfooz@linux.microsoft.com,
	aurabindo.pillai@amd.com,
	ivlipski@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 32/58] drm/amd/display: Correct prefetch calculation
Date: Sun,  1 Jun 2025 19:39:45 -0400
Message-Id: <20250601234012.3516352-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601234012.3516352-1-sashal@kernel.org>
References: <20250601234012.3516352-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.140
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
index 69521368ddb61..1c1ca628728ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -1005,6 +1005,7 @@ static bool CalculatePrefetchSchedule(
 
 	dst_y_prefetch_equ = VStartup - (Tsetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime
 			- (*DSTYAfterScaler + *DSTXAfterScaler / myPipe->HTotal);
+	dst_y_prefetch_equ = dml_min(dst_y_prefetch_equ, 63.75); // limit to the reg limit of U6.2 for DST_Y_PREFETCH
 
 	Lsw_oto = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC);
 	Tsw_oto = Lsw_oto * LineTime;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 9c84561ff3bc4..e62be92dc4fcf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -1103,6 +1103,7 @@ static bool CalculatePrefetchSchedule(
 	Tr0_oto_lines = dml_ceil(4.0 * Tr0_oto / LineTime, 1) / 4.0;
 	dst_y_prefetch_oto = Tvm_oto_lines + 2 * Tr0_oto_lines + Lsw_oto;
 	dst_y_prefetch_equ =  VStartup - (*TSetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime - (*DSTYAfterScaler + *DSTXAfterScaler / myPipe->HTotal);
+	dst_y_prefetch_equ = dml_min(dst_y_prefetch_equ, 63.75); // limit to the reg limit of U6.2 for DST_Y_PREFETCH
 	dst_y_prefetch_equ = dml_floor(4.0 * (dst_y_prefetch_equ + 0.125), 1) / 4.0;
 	Tpre_rounded = dst_y_prefetch_equ * LineTime;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 5b47ccde64241..68e5d6a7f63fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -1124,6 +1124,7 @@ static bool CalculatePrefetchSchedule(
 	Tr0_oto_lines = dml_ceil(4.0 * Tr0_oto / LineTime, 1) / 4.0;
 	dst_y_prefetch_oto = Tvm_oto_lines + 2 * Tr0_oto_lines + Lsw_oto;
 	dst_y_prefetch_equ =  VStartup - (*TSetup + dml_max(TWait + TCalc, *Tdmdl)) / LineTime - (*DSTYAfterScaler + *DSTXAfterScaler / myPipe->HTotal);
+	dst_y_prefetch_equ = dml_min(dst_y_prefetch_equ, 63.75); // limit to the reg limit of U6.2 for DST_Y_PREFETCH
 	dst_y_prefetch_equ = dml_floor(4.0 * (dst_y_prefetch_equ + 0.125), 1) / 4.0;
 	Tpre_rounded = dst_y_prefetch_equ * LineTime;
 
-- 
2.39.5


