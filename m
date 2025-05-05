Return-Path: <stable+bounces-141536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F4AAB447
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85546167B3D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5D5475A5F;
	Tue,  6 May 2025 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wvnx8IjG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7982EC2A7;
	Mon,  5 May 2025 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486627; cv=none; b=RXEniyNLGJjXjMU5qQQTngDY84NIVE818CURblDZGuEfqLS1oqEPPxPGlshRCfym/NWHO0XtDas8kSTZ9bfK+0nhnyy+alBPqiYA8QNLsp7RqL3yRxNlXGhx93wfByAGaB5Zk2hHO2ztorfqXlFNbo2C3YZopCr9mPnrcVoWM0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486627; c=relaxed/simple;
	bh=r5AQF+oigG8egmbB5HLrF/CuRsnRD4AS+UcLw76z0Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqQ2ELOzY5D+J2VRU9rM7t275h8gif/sRbaLgAV0JYmrlNuuO0umkz5Tgxoc752vnJYVB0AkbuiWRyL1KPYBqBtfoxZJ9p5dRJG2Mm0lNcsoDblG9lOqbWuLXH6GxGbDrxjVoqnz8qCey6EELVPphFRMRF4nzfUHys1Y6A4d8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wvnx8IjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1536FC4CEED;
	Mon,  5 May 2025 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486627;
	bh=r5AQF+oigG8egmbB5HLrF/CuRsnRD4AS+UcLw76z0Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wvnx8IjG78ZN9Nw7jmzwKwZ/AdDrKj8v/J+/nFXC6iOKg/RrOZPftTXRfCRGdMaLm
	 buCP5zXBV6zGhfAl2Q1WwUcb5QPk43xk4zKTewO8rV88K/xr3UlBOq/jXbXNEs/vuX
	 vtC9S6gxWYtuNkcQzi48U8N/VdDO3ATyZLzgZZ1Q+bsDqwdMOTN68PYDfYDn4Dcghz
	 3vHVKV+LQO85m5/QCwhCIYPgscBLE3XyTWJFdxDxmCMOKd6nx2MngnVmY5bZoJB54Q
	 +iasK2VcHtKShqJy2LHAweQaxVQc2eDLP+78k2wIlSyDXkpYVaTBrFDE1UBV/RGD2Z
	 Jj+1pms7pfjIA==
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
	alex.hung@amd.com,
	Daniel.Sa@amd.com,
	rostrows@amd.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 124/212] drm/amd/display: fix dcn4x init failed
Date: Mon,  5 May 2025 19:04:56 -0400
Message-Id: <20250505230624.2692522-124-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index f52f7ff7ead4b..dfdd3b9c0e152 100644
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
@@ -239,7 +238,6 @@ static void init_transmitter_control(struct bios_parser *bp)
 		bp->cmd_tbl.transmitter_control = transmitter_control_v1_7;
 		break;
 	default:
-		dm_output_to_console("Don't have transmitter_control for v%d\n", crev);
 		bp->cmd_tbl.transmitter_control = transmitter_control_fallback;
 		break;
 	}
@@ -413,8 +411,6 @@ static void init_set_pixel_clock(struct bios_parser *bp)
 		bp->cmd_tbl.set_pixel_clock = set_pixel_clock_v7;
 		break;
 	default:
-		dm_output_to_console("Don't have set_pixel_clock for v%d\n",
-			 BIOS_CMD_TABLE_PARA_REVISION(setpixelclock));
 		bp->cmd_tbl.set_pixel_clock = set_pixel_clock_fallback;
 		break;
 	}
@@ -561,7 +557,6 @@ static void init_set_crtc_timing(struct bios_parser *bp)
 			set_crtc_using_dtd_timing_v3;
 		break;
 	default:
-		dm_output_to_console("Don't have set_crtc_timing for v%d\n", dtd_version);
 		bp->cmd_tbl.set_crtc_timing = NULL;
 		break;
 	}
@@ -678,8 +673,6 @@ static void init_enable_crtc(struct bios_parser *bp)
 		bp->cmd_tbl.enable_crtc = enable_crtc_v1;
 		break;
 	default:
-		dm_output_to_console("Don't have enable_crtc for v%d\n",
-			 BIOS_CMD_TABLE_PARA_REVISION(enablecrtc));
 		bp->cmd_tbl.enable_crtc = NULL;
 		break;
 	}
@@ -873,8 +866,6 @@ static void init_set_dce_clock(struct bios_parser *bp)
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


