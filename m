Return-Path: <stable+bounces-16194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD09483F19D
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648B8B22A3E
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554881F95B;
	Sat, 27 Jan 2024 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sy0mzkRG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D12200AA
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397128; cv=none; b=EikecyQt0evuKo7WCYVKxo1bUGXQXrH1eCroxu2LmoVbRGplobyoWlEr0MvHJfvBYNVkjb9v26Sk3/qQKyZzFmJAHbNQ3yyYMNoqeuy8m3pPyQtV9oOmw+7CdiwRZUKPQiP2LOhhEGt4UyZW+spkBcwfxOT4G2g09HKPyOJWlM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397128; c=relaxed/simple;
	bh=IgQq8ipUpJgX23yvZ5pfcL7zZr2w0ojtcAJFMv04azc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZS6UaNjTXsOFH6fU7jRuJTd3TR/MEginZk1iNbgWxkiL38nfTcH97V/U8nf4uSXnKpWet+LC6pffOKCwOiFLYVYvThA7UHW3CG6uNEOJQ4oFyaPg58Oyw5Ti6246ucynb+psD+bad9eUvrh3pZc7BmVfliceHbAR5v1zGryQqWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sy0mzkRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87398C433F1;
	Sat, 27 Jan 2024 23:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397127;
	bh=IgQq8ipUpJgX23yvZ5pfcL7zZr2w0ojtcAJFMv04azc=;
	h=Subject:To:Cc:From:Date:From;
	b=Sy0mzkRGT+k5y7jpXsg2qgT2ZU4uqKm6+ot1LQJtNU1bCLOsIf8dE2vOtZ1f9Y+v5
	 SFHiOP1AZuYV/a9ZkdtjTMDleemIWT0pbTIvLgU+C+88KohVDyLsJm4/k8UNLUOrx/
	 Uu1LCWr6FAit6eg0BAHKfjl4y3YOfR9y8bKzYWwE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix MPCC 1DLUT programming" failed to apply to 6.7-stable tree
To: ilya.bakoulin@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,krunoslav.kovac@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:12:06 -0800
Message-ID: <2024012706-preseason-curtain-27eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x a953cd8cac6be69fba0b66e6fb46d1324d797af4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012706-preseason-curtain-27eb@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

a953cd8cac6b ("drm/amd/display: Fix MPCC 1DLUT programming")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a953cd8cac6be69fba0b66e6fb46d1324d797af4 Mon Sep 17 00:00:00 2001
From: Ilya Bakoulin <ilya.bakoulin@amd.com>
Date: Tue, 7 Nov 2023 15:07:56 -0500
Subject: [PATCH] drm/amd/display: Fix MPCC 1DLUT programming

[Why]
Wrong function is used to translate LUT values to HW format, leading to
visible artifacting in some cases.

[How]
Use the correct cm3_helper function.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 6a65af8c36b9..5f7f474ef51c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -487,8 +487,7 @@ bool dcn32_set_mcm_luts(
 		if (plane_state->blend_tf->type == TF_TYPE_HWPWL)
 			lut_params = &plane_state->blend_tf->pwl;
 		else if (plane_state->blend_tf->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					plane_state->blend_tf,
+			cm3_helper_translate_curve_to_hw_format(plane_state->blend_tf,
 					&dpp_base->regamma_params, false);
 			lut_params = &dpp_base->regamma_params;
 		}
@@ -503,8 +502,7 @@ bool dcn32_set_mcm_luts(
 		else if (plane_state->in_shaper_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
 			// TODO: dpp_base replace
 			ASSERT(false);
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					plane_state->in_shaper_func,
+			cm3_helper_translate_curve_to_hw_format(plane_state->in_shaper_func,
 					&dpp_base->shaper_params, true);
 			lut_params = &dpp_base->shaper_params;
 		}


