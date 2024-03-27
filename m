Return-Path: <stable+bounces-32762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9689E88E232
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 14:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF51297C7B
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707A16D9AF;
	Wed, 27 Mar 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYf7irH6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443616D9A8;
	Wed, 27 Mar 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542040; cv=none; b=ZdMdgqEefyclgo6ur/R7FnT/KuZykRvzWlvTfPnmdAx/yORJPlwmuoagD9w0kVN2dFTabPg0T3ZcMNzMnQmJsrRIa7chhGWkbgsbI1aG64uDlUF3FAr3QnYv9LiEKHCA25lgsM+9ahZNMXS62tiyo9t9Fpu0zvYloFWyzbWTqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542040; c=relaxed/simple;
	bh=YjlmFgL1wRu2w2PgjIIiHqNf7JbJuwD/bCtZgF1EcoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1Rz9xbmLzNkzHIZ9WUa8CHCvJzqxkpNqvABWh2m+1/So5Kjx6AsT0ynu/2yhZwoDJ0qNey3ikacprvxLGUgjy8zpFwmRDT6fTHIDoMocTQ/geaB9qMNzY7MfTW3MG2aqyG5SFjAK5AifdRsBzESSiJF8IddqsFAAPBSJpaQJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYf7irH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC613C433C7;
	Wed, 27 Mar 2024 12:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542039;
	bh=YjlmFgL1wRu2w2PgjIIiHqNf7JbJuwD/bCtZgF1EcoE=;
	h=From:To:Cc:Subject:Date:From;
	b=oYf7irH6hprsBTv8v0l3s+0n+PhuHzp+BOcYjNskZujO2OHS0I3VkOvyZvFMmMsbH
	 5cDtiSTDD/GW+laD14uXOV69I3sRYlyrobTNX46adBA9vnbx76I2L6iO3orlFMCfQD
	 SGJzC0m5/xXTkbkPG9ZmeMJpaL0+c7aS/B+E0uVZVcs/tskJl4TD0yn2C4Ooza1sjo
	 UrpRGy8syPDN4hobJUTzzIR8rkCmAsmy6uXxPAILc06aXcjaJxHNjqTySbZcwscUcP
	 NKJm5XXUYCr3e+sLf3I0e7pujEEHZg3mwU+0bu/aMsd9XnQIJ5T7YpWsAy/Mn4DN6o
	 by6G2+I0v/pMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	josip.pavic@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Anthony Koo <anthony.koo@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/amd/display: Allow dirty rects to be sent to dmub when abm is active" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:20:37 -0400
Message-ID: <20240327122038.2836192-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7fb19d9510937121a1f285894cffd30bc96572e3 Mon Sep 17 00:00:00 2001
From: Josip Pavic <josip.pavic@amd.com>
Date: Fri, 9 Feb 2024 16:05:18 -0500
Subject: [PATCH] drm/amd/display: Allow dirty rects to be sent to dmub when
 abm is active

[WHY]
It's beneficial for ABM to know when new frame data are available.

[HOW]
Add new condition to allow dirty rects to be sent to DMUB when ABM is
active. ABM will use this as a signal that a new frame has arrived.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5211c1c0f3c0c..613d09c42f3b9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3270,6 +3270,9 @@ static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_s
 	if (stream->link->replay_settings.config.replay_supported)
 		return true;
 
+	if (stream->ctx->dce_version >= DCN_VERSION_3_5 && stream->abm_level)
+		return true;
+
 	return false;
 }
 
-- 
2.43.0





