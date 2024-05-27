Return-Path: <stable+bounces-46477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F07888D069F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BD51F237CB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEF37345F;
	Mon, 27 May 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owC2v79c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC17344F;
	Mon, 27 May 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825103; cv=none; b=pcmhRjQDjGMAu59NnF09SrZTvt0+uberoG1He4uw1KlI3OyJ1kdkHgvXt3POHz4Issv3Jaz4TIE/wD+SCfG3+AtBwiutJFTsQdjnZLlnFnQcNV6s/0MUf2HIwWaQLwTuA5voyiHOtJ623UiQiqVCYIF6MakUYLFw3rypR/V3SEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825103; c=relaxed/simple;
	bh=FlBZCzmT0a6aZg1CQ2btL1d7i3NzplDFKuGezfER560=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOjdtFrXn7Yu2a6l3qmhtrSqzrcE08o2H2TWr+W6jwFhY1T4OjOCoyG5lOiGdJN7snMMFl+vdDS1YMRzSajoqjhb2y18KHKPYOXeixE5gyEF3e5eGg6ATMN3qcr7F000RkwWI+J4Zwa/kHWzUsWybiV3S395K2j3ifJLkkLyx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owC2v79c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D10C4AF07;
	Mon, 27 May 2024 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825102;
	bh=FlBZCzmT0a6aZg1CQ2btL1d7i3NzplDFKuGezfER560=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owC2v79ce3AwK8Jqpu75DyIMdP8wI0HAWP49jlHdAtHthPHjltVrZOJDS1CtCRFUU
	 OvI01Wsmh7wjkrpfx9QMkAvuaaTP6gEUtoMpC+ujZKrEvVM5Ta+H4gZSxb1Hy1TkDZ
	 fkVpYz+JhmPZmnMuXBJOctVlvJ+u4YkuUsaL/oFlOJykhp3imluZmQoSWkE8AMtG/R
	 iboP6sYf1yCwNX5KISBDgiqBFxIKG4rdR5/KltS2pKuPdQBf6hu1LQYkKXDPFT5LNj
	 Wq3ie7XrfFnMKEy1gKj7CubjWGZND3DxRBcNws+oyGofyP+3SMizFdBb3MlePSflZp
	 +mNoDjSp8Tbgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Duncan Ma <duncan.ma@amd.com>,
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
	chiahsuan.chung@amd.com,
	samson.tam@amd.com,
	dillon.varone@amd.com,
	alvin.lee2@amd.com,
	jinze.xu@amd.com,
	Qingqing.Zhuo@amd.com,
	cruise.hung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 02/23] drm/amd/display: Workaround register access in idle race with cursor
Date: Mon, 27 May 2024 11:50:03 -0400
Message-ID: <20240527155123.3863983-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155123.3863983-1-sashal@kernel.org>
References: <20240527155123.3863983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit b5b6d6251579a29dafdad25f4bc7f3ff7bfd2c86 ]

[Why]
Cursor update can be pre-empted by a request for setting target flip
submission.

This causes an issue where we're in the middle of the exit sequence
trying to log to DM, but the pre-emption starts another DMCUB
command submission that requires being out of idle.

The DC lock aqusition can fail, and depending on the DM/OS interface
it's possible that the function inserted into this thread must not fail.

This means that lock aqusition must be skipped and exit *must* occur.

[How]
Modify when we consider idle as active. Consider it exited only once
the exit has fully finished.

Consider it as entered prior to actual notification.

Since we're on the same core/thread the cached values are coherent
and we'll see that we still need to exit. Once the cursor update resumes
it'll continue doing the double exit but this won't cause a functional
issue, just a (potential) redundant operation.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 23 +++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 6083b1dcf050a..a72e849eced3f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1340,16 +1340,27 @@ void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_
 	 * Powering up the hardware requires notifying PMFW and DMCUB.
 	 * Clearing the driver idle allow requires a DMCUB command.
 	 * DMCUB commands requires the DMCUB to be powered up and restored.
-	 *
-	 * Exit out early to prevent an infinite loop of DMCUB commands
-	 * triggering exit low power - use software state to track this.
 	 */
-	dc_dmub_srv->idle_allowed = allow_idle;
 
-	if (!allow_idle)
+	if (!allow_idle) {
 		dc_dmub_srv_exit_low_power_state(dc);
-	else
+		/*
+		 * Idle is considered fully exited only after the sequence above
+		 * fully completes. If we have a race of two threads exiting
+		 * at the same time then it's safe to perform the sequence
+		 * twice as long as we're not re-entering.
+		 *
+		 * Infinite command submission is avoided by using the
+		 * dm_execute_dmub_cmd submission instead of the "wake" helpers.
+		 */
+		dc_dmub_srv->idle_allowed = false;
+	} else {
+		/* Consider idle as notified prior to the actual submission to
+		 * prevent multiple entries. */
+		dc_dmub_srv->idle_allowed = true;
+
 		dc_dmub_srv_notify_idle(dc, allow_idle);
+	}
 }
 
 bool dc_wake_and_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cmd *cmd,
-- 
2.43.0


