Return-Path: <stable+bounces-210412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D93ADD3BA55
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 23:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 737723048EEA
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 22:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC13C270552;
	Mon, 19 Jan 2026 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI/7nbaF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096C1917ED
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768860234; cv=none; b=bJaeq93Glwu/id3pJ90Z5wUxYqz2zJNHW4/JjzQC9SeGD9VddCJydZHO9K/xgqFSOlD46CvC1OSynxRM/zItFdNShYGVntyqzuZyzOWZNAbXjnwggJV9/jDECV+pWR97PdTD0dfrNP38YEk2H0asmos0IflTv7iOGTvCwK2v0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768860234; c=relaxed/simple;
	bh=bmGJAZor5pkSAPGReUaZtxy8jX5eaHdLHdoSixPdYgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOyY7FV0BtUsM98mfZrtbxd+KWP3zgC1UPhBJEGjh3+9JZycoy0kMjMCxHlzF5Ox8lJM72LIsgA0pEd5rLxPH64Q7NInAkgLAmbBEqLMo3MkmWZ2aaYq7oa/KJ0UU7Sa1jdgGAViwZ07qkuwljSRoUWg5lqA1QpE6HnoUR4NMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI/7nbaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B5CC116C6;
	Mon, 19 Jan 2026 22:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768860234;
	bh=bmGJAZor5pkSAPGReUaZtxy8jX5eaHdLHdoSixPdYgw=;
	h=From:To:Cc:Subject:Date:From;
	b=JI/7nbaFZglst8nNcDUJfS+Po9n7Z6ofK//8fuqKkq2IXL103URY/upyDBpOUd4T4
	 Gjf5Hn7mQmEQMWZSrDXYwKxAFgfbaSQMjgd3CizpurLdHOTfQWoayLbAPhQ9dLpCuX
	 HUZBohWh+LLCf4YOZWBDo+3XV/TElobXatA8TF7TYcRiILSEvbFaQ54Sdj5ig2a7v2
	 RKaEclBssaMMkdZZ58Jaivpq1pXhqbIaPNIRJ1UAi/fPt9n+G1h3slNIZsasytl88D
	 Er1v2xI5d+XYdn6MljZp7muMo0crIYxnRRMbf22SR/fXAqlk2MRQz8DPT4a5EATduH
	 mCFrQPOJCRXsg==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 6.12] drm/amd/display: mark static functions noinline_for_stack
Date: Mon, 19 Jan 2026 15:02:33 -0700
Message-ID: <20260119220232.1125319-2-nathan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

commit a8d42cd228ec41ad99c50a270db82f0dd9127a28 upstream.

When compiling allmodconfig (CONFIG_WERROR=y) with clang-19, see the
following errors:

.../display/dc/dml2/display_mode_core.c:6268:13: warning: stack frame size (3128) exceeds limit (3072) in 'dml_prefetch_check' [-Wframe-larger-than]
.../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:7236:13: warning: stack frame size (3256) exceeds limit (3072) in 'dml_core_mode_support' [-Wframe-larger-than]

Mark static functions called by dml_prefetch_check() and
dml_core_mode_support() noinline_for_stack to avoid them become huge
functions and thus exceed the frame size limit.

A way to reproduce:
$ git checkout next-20250107
$ mkdir build_dir
$ export PATH=/tmp/llvm-19.1.6-x86_64/bin:$PATH
$ make LLVM=1 O=build_dir allmodconfig
$ make LLVM=1 O=build_dir drivers/gpu/drm/ -j

The way how it chose static functions to mark:
[0] Unset CONFIG_WERROR in build_dir/.config.
To get display_mode_core.o without errors.

[1] Get a function list called by dml_prefetch_check().
$ sed -n '6268,6711p' drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c \
  | sed -n -r 's/.*\W(\w+)\(.*/\1/p' | sort -u >/tmp/syms

[2] Get the non-inline function list.
Objdump won't show the symbols if they are inline functions.

$ make LLVM=1 O=build_dir drivers/gpu/drm/ -j
$ objdump -d build_dir/.../display_mode_core.o | \
  ./scripts/checkstack.pl x86_64 0 | \
  grep -f /tmp/syms | cut -d' ' -f2- >/tmp/orig

[3] Get the full function list.
Append "-fno-inline" to `CFLAGS_.../display_mode_core.o` in
drivers/gpu/drm/amd/display/dc/dml2/Makefile.

$ make LLVM=1 O=build_dir drivers/gpu/drm/ -j
$ objdump -d build_dir/.../display_mode_core.o | \
  ./scripts/checkstack.pl x86_64 0 | \
  grep -f /tmp/syms | cut -d' ' -f2- >/tmp/noinline

[4] Get the inline function list.
If a symbol only in /tmp/noinline but not in /tmp/orig, it is a good
candidate to mark noinline.

$ diff /tmp/orig /tmp/noinline

Chosen functions and their stack sizes:
CalculateBandwidthAvailableForImmediateFlip [display_mode_core.o]:144
CalculateExtraLatency [display_mode_core.o]:176
CalculateTWait [display_mode_core.o]:64
CalculateVActiveBandwithSupport [display_mode_core.o]:112
set_calculate_prefetch_schedule_params [display_mode_core.o]:48

CheckGlobalPrefetchAdmissibility [dml2_core_dcn4_calcs.o]:544
calculate_bandwidth_available [dml2_core_dcn4_calcs.o]:320
calculate_vactive_det_fill_latency [dml2_core_dcn4_calcs.o]:272
CalculateDCFCLKDeepSleep [dml2_core_dcn4_calcs.o]:208
CalculateODMMode [dml2_core_dcn4_calcs.o]:208
CalculateOutputLink [dml2_core_dcn4_calcs.o]:176

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[nathan: Fix conflicts in dml2_core_dcn4_calcs.c]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This also addresses a warning seen in linux-6.12.y with allmodconfig and
recent versions of clang:

  drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6713:12: error: stack frame size (4288) exceeds limit (4096) in 'dml_core_mode_support' [-Werror,-Wframe-larger-than]
   6713 | dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
        |            ^
---
 .../gpu/drm/amd/display/dc/dml2/display_mode_core.c  | 12 ++++++------
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c  |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index d0b7fae7d73c..97852214a15d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -1736,7 +1736,7 @@ static void CalculateBytePerPixelAndBlockSizes(
 #endif
 } // CalculateBytePerPixelAndBlockSizes
 
-static dml_float_t CalculateTWait(
+static noinline_for_stack dml_float_t CalculateTWait(
 		dml_uint_t PrefetchMode,
 		enum dml_use_mall_for_pstate_change_mode UseMALLForPStateChange,
 		dml_bool_t SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
@@ -4458,7 +4458,7 @@ static void CalculateSwathWidth(
 	}
 } // CalculateSwathWidth
 
-static  dml_float_t CalculateExtraLatency(
+static noinline_for_stack dml_float_t CalculateExtraLatency(
 		dml_uint_t RoundTripPingLatencyCycles,
 		dml_uint_t ReorderingBytes,
 		dml_float_t DCFCLK,
@@ -5915,7 +5915,7 @@ static dml_uint_t DSCDelayRequirement(
 	return DSCDelayRequirement_val;
 }
 
-static dml_bool_t CalculateVActiveBandwithSupport(dml_uint_t NumberOfActiveSurfaces,
+static noinline_for_stack dml_bool_t CalculateVActiveBandwithSupport(dml_uint_t NumberOfActiveSurfaces,
 										dml_float_t ReturnBW,
 										dml_bool_t NotUrgentLatencyHiding[],
 										dml_float_t ReadBandwidthLuma[],
@@ -6019,7 +6019,7 @@ static void CalculatePrefetchBandwithSupport(
 #endif
 }
 
-static dml_float_t CalculateBandwidthAvailableForImmediateFlip(
+static noinline_for_stack dml_float_t CalculateBandwidthAvailableForImmediateFlip(
 													dml_uint_t NumberOfActiveSurfaces,
 													dml_float_t ReturnBW,
 													dml_float_t ReadBandwidthLuma[],
@@ -6213,7 +6213,7 @@ static dml_uint_t CalculateMaxVStartup(
 	return max_vstartup_lines;
 }
 
-static void set_calculate_prefetch_schedule_params(struct display_mode_lib_st *mode_lib,
+static noinline_for_stack void set_calculate_prefetch_schedule_params(struct display_mode_lib_st *mode_lib,
 						   struct CalculatePrefetchSchedule_params_st *CalculatePrefetchSchedule_params,
 						   dml_uint_t j,
 						   dml_uint_t k)
@@ -6265,7 +6265,7 @@ static void set_calculate_prefetch_schedule_params(struct display_mode_lib_st *m
 				CalculatePrefetchSchedule_params->Tno_bw = &mode_lib->ms.Tno_bw[k];
 }
 
-static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
+static noinline_for_stack void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 {
 	struct dml_core_mode_support_locals_st *s = &mode_lib->scratch.dml_core_mode_support_locals;
 	struct CalculatePrefetchSchedule_params_st *CalculatePrefetchSchedule_params = &mode_lib->scratch.CalculatePrefetchSchedule_params;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 54969ba7e2b7..d18b60c9761b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -2774,7 +2774,7 @@ static double dml_get_return_bandwidth_available(
 	return return_bw_mbps;
 }
 
-static void calculate_bandwidth_available(
+static noinline_for_stack void calculate_bandwidth_available(
 	double avg_bandwidth_available_min[dml2_core_internal_soc_state_max],
 	double avg_bandwidth_available[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max],
 	double urg_bandwidth_available_min[dml2_core_internal_soc_state_max], // min between SDP and DRAM
@@ -4066,7 +4066,7 @@ static bool ValidateODMMode(enum dml2_odm_mode ODMMode,
 	return true;
 }
 
-static void CalculateODMMode(
+static noinline_for_stack void CalculateODMMode(
 	unsigned int MaximumPixelsPerLinePerDSCUnit,
 	unsigned int HActive,
 	enum dml2_output_format_class OutFormat,
@@ -4164,7 +4164,7 @@ static void CalculateODMMode(
 #endif
 }
 
-static void CalculateOutputLink(
+static noinline_for_stack void CalculateOutputLink(
 	struct dml2_core_internal_scratch *s,
 	double PHYCLK,
 	double PHYCLKD18,
@@ -6731,7 +6731,7 @@ static void calculate_bytes_to_fetch_required_to_hide_latency(
 	}
 }
 
-static void calculate_vactive_det_fill_latency(
+static noinline_for_stack void calculate_vactive_det_fill_latency(
 		const struct dml2_display_cfg *display_cfg,
 		unsigned int num_active_planes,
 		unsigned int bytes_required_l[],
-- 
2.52.0


