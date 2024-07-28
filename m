Return-Path: <stable+bounces-62207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C53A93E6EE
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169F7B21DAE
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C2C12CD9B;
	Sun, 28 Jul 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz6n2HPs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261D12C80F;
	Sun, 28 Jul 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181732; cv=none; b=g8iSYzEjPxLmjMSRPB/CwWajp8hJTDo2L1gQeGArI1ZJW2Ui0ulyB6zCHBLqvHk2d5ilXwP6dvkaNPOu4wXw9kzk/4I36MMx3PYdb0NahRp4VTubBalrnlzO6VkmaJ/7siW9HzlDW7kA5oOi7yPb8wkYLpUCg7augNQJig3AqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181732; c=relaxed/simple;
	bh=3RbZEmv3ueRYc7d2reFUBDA0ITSIHzNnhuy1wfBzJZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Udh8FI90oFdFissQX7JlGhy3bTd+Sh3goml1wFCBGjqDS1ZBEvLVfUrMm1QAXZsNKHbhaJHhmy2t59c/6lvEPBSlWQ1jSMWTaYr8EqHeSY65EC5PtXuI0hW49q1ZgiNNyg542lThxctofVtoIzedjGgQbNwlzL0qnlcPgEZIleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz6n2HPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4E1C32782;
	Sun, 28 Jul 2024 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181732;
	bh=3RbZEmv3ueRYc7d2reFUBDA0ITSIHzNnhuy1wfBzJZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wz6n2HPsumBcEMmXiZzZtuCjvrQGyOJfVKpTDxtcLBf5mMnTGldXuEVFSr8XlyEiR
	 F5rV28CjD+9PEGzugH2KrymnAuV1OJvv7+bnDq2fe0EM1qbJUwhezRKs4gg358rENE
	 NzH9mS7zwqdXaUCIwG0ik3I4Dsdp2/8J2trIiQY+96Jl0EouQadBb7ioTxXfwSBCVm
	 CF6p80uMTRV9352nciVEA6SODdrVIjHjf4gdSROTDnNqcapJP/q9m9cYMu0hemEysJ
	 KEWEESpjtDxCmfIitmYEDdjpbGlObL3M5DGyHlbjPDuwtHxJSD/DbM3rdK1J9T/h8n
	 GPdKLF3+a2YKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	roman.li@amd.com,
	mario.limonciello@amd.com,
	joshua@froggi.es,
	wayne.lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 09/17] drm/amd/display: Add null checker before passing variables
Date: Sun, 28 Jul 2024 11:47:19 -0400
Message-ID: <20240728154805.2049226-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154805.2049226-1-sashal@kernel.org>
References: <20240728154805.2049226-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 8092aa3ab8f7b737a34b71f91492c676a843043a ]

Checks null pointer before passing variables to functions.

This fixes 3 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 31bae620aeffc..6189685af1fda 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2636,7 +2636,8 @@ static int dm_suspend(void *handle)
 
 		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
 
-		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
+		if (dm->cached_dc_state)
+			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
 		amdgpu_dm_commit_zero_streams(dm->dc);
 
@@ -6388,7 +6389,8 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 		aconnector->dc_sink = aconnector->dc_link->local_sink ?
 		aconnector->dc_link->local_sink :
 		aconnector->dc_em_sink;
-		dc_sink_retain(aconnector->dc_sink);
+		if (aconnector->dc_sink)
+			dc_sink_retain(aconnector->dc_sink);
 	}
 }
 
@@ -7121,7 +7123,8 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 640, 480);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		amdgpu_dm_connector_add_common_modes(encoder, connector);
+		if (encoder)
+			amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
-- 
2.43.0


