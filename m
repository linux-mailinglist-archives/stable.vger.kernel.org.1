Return-Path: <stable+bounces-46500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA38D06F8
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8241F2294C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7A7346F;
	Mon, 27 May 2024 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBkf1ghO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9A61FE8;
	Mon, 27 May 2024 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825237; cv=none; b=HRevj/gABUU2GVDUjdStJthOlIRVUh8O5K9IeCF8cNnErykLdd/BuwIQzf9LJajUHWO3CM/kQ6dU2xovLffGaCcph6vB1C8EAeWH6tvhNkgoCjV2qVLTYUerl5+QS9eyKB2/T9/mhrgehohAeFxOkzQ3wtzBm+cPmR7lCIOXup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825237; c=relaxed/simple;
	bh=eppQxK4PetzeXvgVooh76qGI6E57PRhm0gp5biWijPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaNhVpROzbLsVaZnc9NUrLBYZYDMrBbkuF3NdXy7h6ihbLZUxy5XMSlS9gVV8rI2rI+pfrqwXLIAo7KIZ8BPEYlp9tSL7g+5wX8p66ZLG3Ykr9YSx9fMqVfH+Z+prS8E0rPq6znNKXnjx2dYvzplzMJl/9++eH1yJLAhsA/0oGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBkf1ghO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E48C2BBFC;
	Mon, 27 May 2024 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825237;
	bh=eppQxK4PetzeXvgVooh76qGI6E57PRhm0gp5biWijPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBkf1ghOqZNX5M4Km4Ek2VzECU/SDnn/iVUpgFWOQEuEITp5fNZmjSOm2TJSErEbI
	 qgIsVcO8xTJw8gb0FBGT1pm+kuJjAHoZKkGp9QEV2U9WiKVdC2xczF5ns+OGoo3C7i
	 lCTdR0+4NV4WgOE7fxdFQoq3vdWR3JqLn/GbI5IbkfiwBbXSNVNNeLyWvRxQtxG2VK
	 eEwMU+ro66JP5PuNvTvgAq27dPBcSSz60Rpi6YFDCIwf8YqJ6Pmb9pmGTe5FToaK44
	 CFlTZw09bcapod4WjG72nqfoq9ghMd9wQbUACp0kYFA8NBxB3u0kHLOjnDAMUlGV+p
	 3KftXmATscdnw==
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
	alvin.lee2@amd.com,
	dillon.varone@amd.com,
	samson.tam@amd.com,
	jinze.xu@amd.com,
	Qingqing.Zhuo@amd.com,
	cruise.hung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 02/20] drm/amd/display: Workaround register access in idle race with cursor
Date: Mon, 27 May 2024 11:52:45 -0400
Message-ID: <20240527155349.3864778-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155349.3864778-1-sashal@kernel.org>
References: <20240527155349.3864778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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
index 9084b320849a6..447dab3864019 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1320,16 +1320,27 @@ void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_
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


