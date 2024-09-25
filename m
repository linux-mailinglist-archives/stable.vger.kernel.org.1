Return-Path: <stable+bounces-77258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CF5985B31
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976B9B243B4
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A051922EE;
	Wed, 25 Sep 2024 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWjcd1q6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7D31BA284;
	Wed, 25 Sep 2024 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264846; cv=none; b=sZvbVObQzpYVKG8wx3OapHXaCRX7WNY/wr8hbm/sXcAlZa88wN2BprUOhcXv1r+sG+7BtyawaWK8jHUt1k6T7bsXFmyOsnneuJ1go7GNKwm5zLA4qfy5s3au55+jHwXQhR9G4yv4XrukNW0l9ci1vYkltuaueJO4Voj+hhUCMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264846; c=relaxed/simple;
	bh=rzK5O95JgbjDpL/AA5VaWdPSBZInlDNs7nukUFJRlWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMIYiK0Q4NbjycWfYkbZpd0Aw4YgNFyt69sb9Thn2cLw6mxFzujNzCQa7RT4mFlLuEnKhcs9rSqqZGS7YhE+FGyYwO644jvDs620rC9xMyKowbP4vG1Da6lTPoI5E2AmiY8zas/mk3ueEwmGPvruU7XYuyRMuNFKJbiqXWm3HZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWjcd1q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B0DC4CEC3;
	Wed, 25 Sep 2024 11:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264845;
	bh=rzK5O95JgbjDpL/AA5VaWdPSBZInlDNs7nukUFJRlWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWjcd1q6MFAyf6Qs88iQs06wqP0+Fg9ojK/ETBmVmI7yaBCmo68Er6A3jySWkdcAg
	 MeNlWbagJqR2SrcZV80mB6VcPmh9BtzAar9P4WV9jqWBHquFbNBTOIojZZr34/52z7
	 YmQkAyln/fiqYbOIoN/7WMw4rNnH40E+ZdMotL6kGAjQI9aTFxctVF/Q174DvHAf5p
	 x1qIQMOAf4U9iyljNwV9An3O/HNjTbd0c3sXclTw3yIDW8mc9fOO62Z543+1pBVw90
	 Zqe23c0u4dz62dIoQzvDR52h3Jl5zeapLtJ3RSDWnRk71KYyctubeWlVnI50i+3vHr
	 HOfZDF2sGL67w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Roper <matthew.d.roper@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 160/244] drm/xe: Name and document Wa_14019789679
Date: Wed, 25 Sep 2024 07:26:21 -0400
Message-ID: <20240925113641.1297102-160-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Matt Roper <matthew.d.roper@intel.com>

[ Upstream commit 1d734a3e5d6bb266f52eaf2b1400c5d3f1875a54 ]

Early in the development of Xe we identified an issue with SVG state
handling on DG2 and MTL (and later on Xe2 as well).  In
commit 72ac304769dd ("drm/xe: Emit SVG state on RCS during driver load
on DG2 and MTL") and commit fb24b858a20d ("drm/xe/xe2: Update SVG state
handling") we implemented our own workaround to prevent SVG state from
leaking from context A to context B in cases where context B never
issues a specific state setting.

The hardware teams have now created official workaround Wa_14019789679
to cover this issue.  The workaround description only requires emitting
3DSTATE_MESH_CONTROL, since they believe that's the only SVG instruction
that would potentially remain unset by a context B, but still cause
notable issues if unwanted values were inherited from context A.
However since we already have a more extensive implementation that emits
the entire SVG state and prevents _any_ SVG state from unintentionally
leaking, we'll stick with our existing implementation just to be safe.

Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240812181042.2013508-2-matthew.d.roper@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_lrc.c        | 35 +++++++++++++++++++++---------
 drivers/gpu/drm/xe/xe_wa_oob.rules |  2 ++
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 58121821f0814..974a9cd8c3795 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -5,6 +5,8 @@
 
 #include "xe_lrc.h"
 
+#include <generated/xe_wa_oob.h>
+
 #include <linux/ascii85.h>
 
 #include "instructions/xe_mi_commands.h"
@@ -24,6 +26,7 @@
 #include "xe_memirq.h"
 #include "xe_sriov.h"
 #include "xe_vm.h"
+#include "xe_wa.h"
 
 #define LRC_VALID				BIT_ULL(0)
 #define LRC_PRIVILEGE				BIT_ULL(8)
@@ -1581,19 +1584,31 @@ void xe_lrc_emit_hwe_state_instructions(struct xe_exec_queue *q, struct xe_bb *b
 	int state_table_size = 0;
 
 	/*
-	 * At the moment we only need to emit non-register state for the RCS
-	 * engine.
+	 * Wa_14019789679
+	 *
+	 * If the driver doesn't explicitly emit the SVG instructions while
+	 * setting up the default LRC, the context switch will write 0's
+	 * (noops) into the LRC memory rather than the expected instruction
+	 * headers.  Application contexts start out as a copy of the default
+	 * LRC, and if they also do not emit specific settings for some SVG
+	 * state, then on context restore they'll unintentionally inherit
+	 * whatever state setting the previous context had programmed into the
+	 * hardware (i.e., the lack of a 3DSTATE_* instruction in the LRC will
+	 * prevent the hardware from resetting that state back to any specific
+	 * value).
+	 *
+	 * The official workaround only requires emitting 3DSTATE_MESH_CONTROL
+	 * since that's a specific state setting that can easily cause GPU
+	 * hangs if unintentionally inherited.  However to be safe we'll
+	 * continue to emit all of the SVG state since it's best not to leak
+	 * any of the state between contexts, even if that leakage is harmless.
 	 */
-	if (q->hwe->class != XE_ENGINE_CLASS_RENDER)
-		return;
-
-	switch (GRAPHICS_VERx100(xe)) {
-	case 1255:
-	case 1270 ... 2004:
+	if (XE_WA(gt, 14019789679) && q->hwe->class == XE_ENGINE_CLASS_RENDER) {
 		state_table = xe_hpg_svg_state;
 		state_table_size = ARRAY_SIZE(xe_hpg_svg_state);
-		break;
-	default:
+	}
+
+	if (!state_table) {
 		xe_gt_dbg(gt, "No non-register state to emit on graphics ver %d.%02d\n",
 			  GRAPHICS_VER(xe), GRAPHICS_VERx100(xe) % 100);
 		return;
diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index 08f7336881e32..d4c33dbc14c7a 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -30,3 +30,5 @@
 22019338487	MEDIA_VERSION(2000)
 		GRAPHICS_VERSION(2001)
 16023588340	GRAPHICS_VERSION(2001)
+14019789679	GRAPHICS_VERSION(1255)
+		GRAPHICS_VERSION_RANGE(1270, 2004)
-- 
2.43.0


