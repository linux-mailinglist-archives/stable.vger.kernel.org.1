Return-Path: <stable+bounces-141002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029E4AAAFE9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37C91A8770C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA3F289E3B;
	Mon,  5 May 2025 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF/s79h1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B53B0276;
	Mon,  5 May 2025 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487222; cv=none; b=YcrZyslv7Yd5ncD2HV4wFCTFK5Vt+2qSawr04ZeHnkAyKJesS46K3bzWOHVZOYwJizhXLfFJ6jq03iKDQevZWqNpSyq+DFKmsghPJSog2M8j/XydCetqtOqNaQZtzXhqZ1l3X2cj14kleCnGNgAu75N8RewF8hHhTcV81nmSWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487222; c=relaxed/simple;
	bh=k40S57gUKzkMY6NrdXhh76SOm+scxM+YTGiI9RwSkRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8GDOI2qZzd7DHBn3niZG9cDViZARQzYVw9erZGY7Q8ZuI16+doCchNW0OjI/0xYSQIGc0uoSwc/NikMoL+KpU3eaAk9PxtxOholLnSuzuqGpfu07twLOD1TLfcOCojNGh4q0PYrI8F9AtX3yPK3UEU1Xt32KFizKQSyqtAb5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF/s79h1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A3DC4CEE4;
	Mon,  5 May 2025 23:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487221;
	bh=k40S57gUKzkMY6NrdXhh76SOm+scxM+YTGiI9RwSkRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gF/s79h1kCvRXT9XKsHfhmjRr3W+i35f5fpaKLu3uN57YRIB0KrjAx5nRzqgO0WPS
	 Dd6t5VHKUXMigMzgjOJi/BL2HuW5h1djVMm9ymhE37b8EBmBXd3MVdmsA1+bhMddES
	 nJ0fqfnDIHF/aaB4f8WHd2bJ1nCw/0l4mcSwmI8DOjgmQ3B3YHNQrezvuxP4xeNhzt
	 FHhKySUCat62eZ57B/oGVdZBx9FkefmqfxBibQnM+Rb5sFNe6qSTbwl+XLINCMd4eJ
	 80h1pmtVdP+YhBsi2AqdvxU8PklwIxxrsDUdHmU3V6v2wrgUuBcy8dcA86Ebfr9i1q
	 Xv0Sq+ANr5BhQ==
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
	Daniel.Sa@amd.com,
	alex.hung@amd.com,
	rostrows@amd.com,
	martin.leung@amd.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 064/114] drm/amd/display: fix dcn4x init failed
Date: Mon,  5 May 2025 19:17:27 -0400
Message-Id: <20250505231817.2697367-64-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 25bdf1c38e0ad..42b87f4ef2856 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -103,7 +103,6 @@ static void init_dig_encoder_control(struct bios_parser *bp)
 		bp->cmd_tbl.dig_encoder_control = encoder_control_digx_v1_5;
 		break;
 	default:
-		dm_output_to_console("Don't have dig_encoder_control for v%d\n", version);
 		bp->cmd_tbl.dig_encoder_control = encoder_control_fallback;
 		break;
 	}
@@ -234,7 +233,6 @@ static void init_transmitter_control(struct bios_parser *bp)
 		bp->cmd_tbl.transmitter_control = transmitter_control_v1_6;
 		break;
 	default:
-		dm_output_to_console("Don't have transmitter_control for v%d\n", crev);
 		bp->cmd_tbl.transmitter_control = transmitter_control_fallback;
 		break;
 	}
@@ -339,8 +337,6 @@ static void init_set_pixel_clock(struct bios_parser *bp)
 		bp->cmd_tbl.set_pixel_clock = set_pixel_clock_v7;
 		break;
 	default:
-		dm_output_to_console("Don't have set_pixel_clock for v%d\n",
-			 BIOS_CMD_TABLE_PARA_REVISION(setpixelclock));
 		bp->cmd_tbl.set_pixel_clock = set_pixel_clock_fallback;
 		break;
 	}
@@ -487,7 +483,6 @@ static void init_set_crtc_timing(struct bios_parser *bp)
 			set_crtc_using_dtd_timing_v3;
 		break;
 	default:
-		dm_output_to_console("Don't have set_crtc_timing for v%d\n", dtd_version);
 		bp->cmd_tbl.set_crtc_timing = NULL;
 		break;
 	}
@@ -604,8 +599,6 @@ static void init_enable_crtc(struct bios_parser *bp)
 		bp->cmd_tbl.enable_crtc = enable_crtc_v1;
 		break;
 	default:
-		dm_output_to_console("Don't have enable_crtc for v%d\n",
-			 BIOS_CMD_TABLE_PARA_REVISION(enablecrtc));
 		bp->cmd_tbl.enable_crtc = NULL;
 		break;
 	}
@@ -799,8 +792,6 @@ static void init_set_dce_clock(struct bios_parser *bp)
 		bp->cmd_tbl.set_dce_clock = set_dce_clock_v2_1;
 		break;
 	default:
-		dm_output_to_console("Don't have set_dce_clock for v%d\n",
-			 BIOS_CMD_TABLE_PARA_REVISION(setdceclock));
 		bp->cmd_tbl.set_dce_clock = NULL;
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 74c498b6774d1..26c87962570bf 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -80,8 +80,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 #endif
 
 	default:
-		/* Unsupported DCE */
-		BREAK_TO_DEBUGGER();
+		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return false;
 	}
 }
-- 
2.39.5


