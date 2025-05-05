Return-Path: <stable+bounces-140733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF36AAAF0E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3582A3B3B11
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0354838AF46;
	Mon,  5 May 2025 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adHDJEVT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA637A145;
	Mon,  5 May 2025 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486105; cv=none; b=CiPcSUg55dJ6/UCEB/H57aJ87UVZvfFoW46cOiaRkeXu/grdyDwjBMTkH98o3vErUih780/sgJHiYYEt7TN0sljoyywUurfQCgqE0AXB6Zg0nHQIvhSHf31V+N8X5v860Dykg0uY8y61P42zENJvevLH/JNYTtKaJl+IN4FmOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486105; c=relaxed/simple;
	bh=pD5kfYiJdtuvkaUD/3HrDrFCvRj1sBU4MPXQsYiRKlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZB56zA0bc2T21yqIAkLjB3OUrOUTaUfG2chz18Eg5EyCJec5AIs4rkzFr/MlUPXaXR58wWoMTXWpY5rmx+hdnKWwtgHtWIJdXeALjGt1b9u8YaL8EZ09mKRsHsd5/pMoajPlhTs7HURmcX7uYxRbyckqTxX9jThnK+Ai6HAGKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adHDJEVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A7CC4CEE4;
	Mon,  5 May 2025 23:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486104;
	bh=pD5kfYiJdtuvkaUD/3HrDrFCvRj1sBU4MPXQsYiRKlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adHDJEVTcLv8Viw74x0KzbiMwiwjIdRBUkC2iSYqziyLP8BeGUgdE83xQS/y69OAm
	 GlIWF+RDjrXDsgZJ99BhvdnmtunOBOkLGKU6DDSASkKxROe4iwtC6ypakqsedDMyg1
	 m4eXmO6/XtPlYn7mQnA8BkxTrUamsAp5911XcuaRZOLcNl1Ydo+FkCCP9WHfYyDdWq
	 5a2X/i80Axzd5j9Yxtefg2UBH8PIBrggKrgG+S8yDiUK2fFqt56CFFMDojCB9lXCIU
	 wMUyufG/4+y/Robz/FeX6BtM2IZZpsWfJnOU2I0+dVWl0ZvMWiZ8rDnKY29/mXaCZ2
	 F51pzgYENusKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charlene Liu <Charlene.Liu@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	jun.lei@amd.com,
	rostrows@amd.com,
	Daniel.Sa@amd.com,
	alex.hung@amd.com,
	Syed.Hassan@amd.com,
	martin.leung@amd.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 156/294] drm/amd/display: fix dcn4x init failed
Date: Mon,  5 May 2025 18:54:16 -0400
Message-Id: <20250505225634.2688578-156-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit 23ef388a84c72b0614a6c10f866ffeac7e807719 ]

[why]
failed due to cmdtable not created.
switch atombios cmdtable as default.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c     | 9 ---------
 .../gpu/drm/amd/display/dc/bios/command_table_helper2.c  | 3 +--
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index ab0adabf9dd4c..7dc84b62eb0ac 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -101,7 +101,6 @@ static void init_dig_encoder_control(struct bios_parser *bp)
 		bp->cmd_tbl.dig_encoder_control = encoder_control_digx_v1_5;
 		break;
 	default:
-		dm_output_to_console("Don't have dig_encoder_control for v%d\n", version);
 		bp->cmd_tbl.dig_encoder_control = encoder_control_fallback;
 		break;
 	}
@@ -237,7 +236,6 @@ static void init_transmitter_control(struct bios_parser *bp)
 		bp->cmd_tbl.transmitter_control = transmitter_control_v1_7;
 		break;
 	default:
-		dm_output_to_console("Don't have transmitter_control for v%d\n", crev);
 		bp->cmd_tbl.transmitter_control = transmitter_control_fallback;
 		break;
 	}
@@ -407,8 +405,6 @@ static void init_set_pixel_clock(struct bios_parser *bp)
 		bp->cmd_tbl.set_pixel_clock = set_pixel_clock_v7;
 		break;
 	default:
-		dm_output_to_console("Don't have set_pixel_clock for v%d\n",
-			 BIOS_CMD_TABLE_PARA_REVISION(setpixelclock));
 		bp->cmd_tbl.set_pixel_clock = set_pixel_clock_fallback;
 		break;
 	}
@@ -553,7 +549,6 @@ static void init_set_crtc_timing(struct bios_parser *bp)
 			set_crtc_using_dtd_timing_v3;
 		break;
 	default:
-		dm_output_to_console("Don't have set_crtc_timing for v%d\n", dtd_version);
 		bp->cmd_tbl.set_crtc_timing = NULL;
 		break;
 	}
@@ -670,8 +665,6 @@ static void init_enable_crtc(struct bios_parser *bp)
 		bp->cmd_tbl.enable_crtc = enable_crtc_v1;
 		break;
 	default:
-		dm_output_to_console("Don't have enable_crtc for v%d\n",
-			 BIOS_CMD_TABLE_PARA_REVISION(enablecrtc));
 		bp->cmd_tbl.enable_crtc = NULL;
 		break;
 	}
@@ -863,8 +856,6 @@ static void init_set_dce_clock(struct bios_parser *bp)
 		bp->cmd_tbl.set_dce_clock = set_dce_clock_v2_1;
 		break;
 	default:
-		dm_output_to_console("Don't have set_dce_clock for v%d\n",
-			 BIOS_CMD_TABLE_PARA_REVISION(setdceclock));
 		bp->cmd_tbl.set_dce_clock = NULL;
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 8538f13e01bfb..8ff139a6b85db 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -84,8 +84,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 		return true;
 
 	default:
-		/* Unsupported DCE */
-		BREAK_TO_DEBUGGER();
+		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return false;
 	}
 }
-- 
2.39.5


