Return-Path: <stable+bounces-62161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F04E993E645
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A503A1F216F3
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D44768E1;
	Sun, 28 Jul 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1aRzG4m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C358AC4;
	Sun, 28 Jul 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181449; cv=none; b=L2yBpcyjn6CYU2g40LjgeD2r+DrmH+noA7csPio8Gum4YECBB+fMdR8mXnW1vEIeFg1UVVRVzw/SJ6FLOa4q5V9PlOXu38pMIbe/ygob1YICLPsBdi9SapqwW+jnr5ZiPxDZn4WpFeDranzU/VEYC6an8ZAvrDB5CKYNvsaxFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181449; c=relaxed/simple;
	bh=//kbkqWOWdabnFabnQMqR01tzonJaYt9e+wxnQ1B8Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0t9jpAkMTvJ2iVIywdmHOZhP0uykrNYQvFtYk5TdAVEXAdzNV4o4pSG9tLASDUas06UcBlIBxDig8KJAPldNu7HUg3V+pG5so33KDGol+J66scqLUA7RhgQxHZWq/x7pWxoAm0YduoAt2c9FmSP4ns/yLcPg43t/cebubsluPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1aRzG4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3712BC116B1;
	Sun, 28 Jul 2024 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181448;
	bh=//kbkqWOWdabnFabnQMqR01tzonJaYt9e+wxnQ1B8Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1aRzG4m3HmYqDuHHBF8O390u0TUwbquWv9uu9oCCsp8zO9fD3M5uttgt323mhrP4
	 5OAZZzbcgxl5QHOVER+8qbt4YopqTPGuBMex1OmzJtmQVK9NwjMw8zlzqgGY+uAccX
	 vJZQUlkiCBcdjt1JHafivKQTKD2GMyKnv7z1IO60/bzc44YPdMhkTuLGUT4EbNGDKK
	 JCJKAZ9Eu9zy+njEJ1lwv/5GxyLfSVDBnB3Z4prJfZ4gVzU93VBrACJ3vDZ8wdbojl
	 QMCMycyvvh3kbMSNh1m9TYLBJwn7XbbYouk4LHEe2VyNOOUlEPYdrUkuTgUlkfPgwl
	 l5Vq2J4YfB5gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	Bhawanpreet.Lakha@amd.com,
	rdunlap@infradead.org,
	chiahsuan.chung@amd.com,
	srinivasan.shanmugam@amd.com,
	anthony.koo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 17/34] drm/amd/display: Wake DMCUB before sending a command for replay feature
Date: Sun, 28 Jul 2024 11:40:41 -0400
Message-ID: <20240728154230.2046786-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 3601a35a2e9d640233f4bc3496f7603b93f9c143 ]

[Why]
We can hang in place trying to send commands when the DMCUB isn't
powered on.

[How]
For functions that execute within a DC context or DC lock we can wrap
the direct calls to dm_execute_dmub_cmd/list with code that exits idle
power optimizations and reallows once we're done with the command
submission on success.

For DM direct submissions the DM will need to manage the enter/exit
sequencing manually.

We cannot invoke a DMCUB command directly within the DM execution helper
or we can deadlock.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 4f559a025cf00..f820647443d16 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -84,7 +84,7 @@ static void dmub_replay_enable(struct dmub_replay *dmub, bool enable, bool wait,
 
 	cmd.replay_enable.header.payload_bytes = sizeof(struct dmub_rb_cmd_replay_enable_data);
 
-	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 
 	/* Below loops 1000 x 500us = 500 ms.
 	 *  Exit REPLAY may need to wait 1-2 frames to power up. Timeout after at
@@ -127,7 +127,7 @@ static void dmub_replay_set_power_opt(struct dmub_replay *dmub, unsigned int pow
 	cmd.replay_set_power_opt.replay_set_power_opt_data.power_opt = power_opt;
 	cmd.replay_set_power_opt.replay_set_power_opt_data.panel_inst = panel_inst;
 
-	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
 /*
@@ -231,7 +231,7 @@ static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
 	cmd.replay_set_coasting_vtotal.header.payload_bytes = sizeof(struct dmub_cmd_replay_set_coasting_vtotal_data);
 	cmd.replay_set_coasting_vtotal.replay_set_coasting_vtotal_data.coasting_vtotal = coasting_vtotal;
 
-	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
 /*
-- 
2.43.0


