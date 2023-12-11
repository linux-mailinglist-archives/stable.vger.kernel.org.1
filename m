Return-Path: <stable+bounces-5394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5222F80CBAD
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830C11C20FA6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EEB47794;
	Mon, 11 Dec 2023 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1/Q5I/z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E634776B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 13:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAB8C433D9;
	Mon, 11 Dec 2023 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302825;
	bh=NXBnlBnAK5VH1xe11LnSdcoEO4WXNeFKs998K6Ux3e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1/Q5I/zK/7OQth177uZ0xyTpbId58dSH9DEokQGi43/k/7KxQeOeRt1WVwruzPjL
	 5S6EOnLL7a0oJAmq6/r9NhGq93M6IPbTPmOG8KiDOOyQ8UmROG4PXcBndf/FQFl4Qm
	 2tvOWE/CQaxlMEQjCCud2GNzxpWxxPhKysJP8nUXBdWMZpNi20kVnT2vog+kJzPWPh
	 pX4r5D5vZNKqiH+QAzAvlSEbVlm40enKO3FbhOhLMFbr/Ee1G/wVTHODXwKGoAH7sl
	 dyGnwasbKAeDCqRxu0SCdrwcTqPcAlu5Oivn9xsceZeo6CHNvIYrMVbfBkhOVuf02c
	 cvtn/+yi6bcgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ivan Lipski <ivlipski@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Sun peng Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	qingqing.zhuo@amd.com,
	Wayne.Lin@amd.com,
	lyude@redhat.com,
	aurabindo.pillai@amd.com,
	srinivasan.shanmugam@amd.com,
	sungjoon.kim@amd.com,
	hamza.mahfooz@amd.com,
	mikita.lipski@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 39/47] drm/amd/display: Add monitor patch for specific eDP
Date: Mon, 11 Dec 2023 08:50:40 -0500
Message-ID: <20231211135147.380223-39-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Ivan Lipski <ivlipski@amd.com>

[ Upstream commit 3d71a8726e05a35beb9de394e86ce896d69e563f ]

[WHY]
Some eDP panels's ext caps don't write initial value cause the value of
dpcd_addr(0x317) is random.  It means that sometimes the eDP will
clarify it is OLED, miniLED...etc cause the backlight control interface
is incorrect.

[HOW]
Add a new panel patch to remove sink ext caps(HDR,OLED...etc)

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 4b230933b28eb..87a1000b85729 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -63,6 +63,12 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_fams = true;
 		break;
+	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xA7AB):
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
+		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.remove_sink_ext_caps = true;
+		break;
 	default:
 		return;
 	}
-- 
2.42.0


