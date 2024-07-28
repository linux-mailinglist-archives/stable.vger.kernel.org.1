Return-Path: <stable+bounces-62165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DB493E65D
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AEE28109B
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE4578C84;
	Sun, 28 Jul 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBsnnTeb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1AC6F30B;
	Sun, 28 Jul 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181478; cv=none; b=jW84epV2aG0ltZVDZd4/V9blb3GwoihSpuH4ERZuUyb8UHFxH1xTsn8hMepyBzetrQ6X00ch3hOM8ptAwT+iuw/gmKsoX3Zw3JAXG4lDvEs56YmkyS4VLLiNMEYE26yiP92mRqSI/lAm4aR5wVkdqoAa5izYccwkj49V3kUvT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181478; c=relaxed/simple;
	bh=wTYvYkVYZyoLRinwSZxNj8Hn2zyab3zHtSkrx2lEGJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/xHqZME951ndqWoPvryave9WFkygLEvtkpcJEQ3VshtumAG748QinOPZWCdrJrzsWuKREMDOgLe3upVuIdlEfsbTr401Xp8lYCzKVATiL2DnItrU+1LL81uNp+xQtHkWoUWOG2ELYNSpHo/9noI162ziJDq4jSIg6CO+mgX/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBsnnTeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73750C116B1;
	Sun, 28 Jul 2024 15:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181478;
	bh=wTYvYkVYZyoLRinwSZxNj8Hn2zyab3zHtSkrx2lEGJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBsnnTebz6xZ451++Diae/gCV/Ke4QL4ALxaRKjA18O8lcEv+C9UJy9kcNYQnIwYF
	 55+4bT5GSWme5JzL3LsyXayETUhRpF6znW/5N9QahXmJRUPvhIcH1i8JHi9+RgmNPf
	 shy2QH41Ma7RlF7q8vdqpcBkj3TF8EOpnGzsQF2eVbZ4Rm5UyIiYVMmSq3gh6YDL8L
	 DUjrpjJE2MYvAO8GjO0aDWgB9p4XVrAlEPQmuR8ZR9CS0KSlHMG4OVfVpAwVSV51xF
	 J302BS2RFbuJPKiJa2z0DFpiLNjhQ3E7TdXgyPAmtcPwo7CGqGsgTZkAyyAQ5ZHiBz
	 uUabRH3N6p44A==
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
Subject: [PATCH AUTOSEL 6.10 21/34] drm/amd/display: Add null checker before passing variables
Date: Sun, 28 Jul 2024 11:40:45 -0400
Message-ID: <20240728154230.2046786-21-sashal@kernel.org>
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
index 3cdcadd41be1a..964bb6d0a3833 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2701,7 +2701,8 @@ static int dm_suspend(void *handle)
 
 		dm->cached_dc_state = dc_state_create_copy(dm->dc->current_state);
 
-		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
+		if (dm->cached_dc_state)
+			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
 		amdgpu_dm_commit_zero_streams(dm->dc);
 
@@ -6788,7 +6789,8 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 		aconnector->dc_sink = aconnector->dc_link->local_sink ?
 		aconnector->dc_link->local_sink :
 		aconnector->dc_em_sink;
-		dc_sink_retain(aconnector->dc_sink);
+		if (aconnector->dc_sink)
+			dc_sink_retain(aconnector->dc_sink);
 	}
 }
 
@@ -7615,7 +7617,8 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 1920, 1080);
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


