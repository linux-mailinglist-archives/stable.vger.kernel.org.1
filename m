Return-Path: <stable+bounces-135027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4C5A95E15
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCD11899261
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123981E5B7E;
	Tue, 22 Apr 2025 06:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tpiUauE4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706B135A63
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303098; cv=none; b=sgmOAZvuuzJBMsVzHzMS5lBThjsllxLI6QDtV1bjtqEHFw4BIw5a1H/ViG2so/ceBCDXSE9eH3BirR92tvT3g5+xKySiNaM2n51GxYq2+kPnPvqO84zEL5f7mQCIsty6uwox3H9oq4oxnHV8i9dvmSfvcefFgsSerKcyzvi+Ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303098; c=relaxed/simple;
	bh=gK/sxEFvEoIkttzqJXxIj1FxU/8HvVGxPirqDyaSYu4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tHhbmjHfUOKskYFTKyhHTzd/0H878s9ziyUs9oQfhkXBwMcvVnpsfVkQqIpgKDy5U4HggM3oE0PYYX+tlMb1iq7bo8JVyyCAu+o3OHqF8nzB7EHHm4k+iaKJx+WTJkUG5QyrLrzkbSXtF8l9rwSOHJfgnBgqV+rCulcw557SRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tpiUauE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF131C4CEEA;
	Tue, 22 Apr 2025 06:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303098;
	bh=gK/sxEFvEoIkttzqJXxIj1FxU/8HvVGxPirqDyaSYu4=;
	h=Subject:To:Cc:From:Date:From;
	b=tpiUauE4Te18vLMiCGK5DhPD3R8Xvvopnz7bwa2r2bU5lXiYweht1yQb3JYIcqySW
	 L9sV8dn/i0Ti5jZCDiZEuAHpFliix/DJiXI3tIBmV1uhD/oVV/QqpcHfcz5LgfUebr
	 SJ6UR1emykjjbvEJ87NXClzdiO5T1zfgRHH7ZJh8=
Subject: FAILED: patch "[PATCH] drm/xe: Ensure fixed_slice_mode gets set after ccs_mode" failed to apply to 6.14-stable tree
To: niranjana.vishwanathapura@intel.com,lucas.demarchi@intel.com,matthew.brost@intel.com,matthew.d.roper@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:24:55 +0200
Message-ID: <2025042255-relight-tyke-0d59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 262de94a3a7ef23c326534b3d9483602b7af841e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042255-relight-tyke-0d59@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 262de94a3a7ef23c326534b3d9483602b7af841e Mon Sep 17 00:00:00 2001
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Date: Thu, 27 Mar 2025 11:56:04 -0700
Subject: [PATCH] drm/xe: Ensure fixed_slice_mode gets set after ccs_mode
 change

The RCU_MODE_FIXED_SLICE_CCS_MODE setting is not getting invoked
in the gt reset path after the ccs_mode setting by the user.
Add it to engine register update list (in hw_engine_setup_default_state())
which ensures it gets set in the gt reset and engine reset paths.

v2: Add register update to engine list to ensure it gets updated
after engine reset also.

Fixes: 0d97ecce16bd ("drm/xe: Enable Fixed CCS mode setting")
Cc: stable@vger.kernel.org
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://lore.kernel.org/r/20250327185604.18230-1-niranjana.vishwanathapura@intel.com
(cherry picked from commit 12468e519f98e4d93370712e3607fab61df9dae9)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index 8c05fd30b7df..93241fd0a4ba 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -389,12 +389,6 @@ xe_hw_engine_setup_default_lrc_state(struct xe_hw_engine *hwe)
 				 blit_cctl_val,
 				 XE_RTP_ACTION_FLAG(ENGINE_BASE)))
 		},
-		/* Use Fixed slice CCS mode */
-		{ XE_RTP_NAME("RCU_MODE_FIXED_SLICE_CCS_MODE"),
-		  XE_RTP_RULES(FUNC(xe_hw_engine_match_fixed_cslice_mode)),
-		  XE_RTP_ACTIONS(FIELD_SET(RCU_MODE, RCU_MODE_FIXED_SLICE_CCS_MODE,
-					   RCU_MODE_FIXED_SLICE_CCS_MODE))
-		},
 		/* Disable WMTP if HW doesn't support it */
 		{ XE_RTP_NAME("DISABLE_WMTP_ON_UNSUPPORTED_HW"),
 		  XE_RTP_RULES(FUNC(xe_rtp_cfeg_wmtp_disabled)),
@@ -461,6 +455,12 @@ hw_engine_setup_default_state(struct xe_hw_engine *hwe)
 		  XE_RTP_ACTIONS(SET(CSFE_CHICKEN1(0), CS_PRIORITY_MEM_READ,
 				     XE_RTP_ACTION_FLAG(ENGINE_BASE)))
 		},
+		/* Use Fixed slice CCS mode */
+		{ XE_RTP_NAME("RCU_MODE_FIXED_SLICE_CCS_MODE"),
+		  XE_RTP_RULES(FUNC(xe_hw_engine_match_fixed_cslice_mode)),
+		  XE_RTP_ACTIONS(FIELD_SET(RCU_MODE, RCU_MODE_FIXED_SLICE_CCS_MODE,
+					   RCU_MODE_FIXED_SLICE_CCS_MODE))
+		},
 	};
 
 	xe_rtp_process_to_sr(&ctx, engine_entries, ARRAY_SIZE(engine_entries), &hwe->reg_sr);


