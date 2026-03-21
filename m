Return-Path: <stable+bounces-227660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNS7NcwwvmmqIwMAu9opvQ
	(envelope-from <stable+bounces-227660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:46:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF02E376A
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C518F304E819
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 05:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E180F364E8E;
	Sat, 21 Mar 2026 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gupGfsZU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7163F28688C
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774071920; cv=none; b=d56Ijf+kJewYDnfR4qGy5P5nW76JIWGcSi9PVF+HFcK/PQd/360XtZqtVoTJdrKuhka85LN8BXqcCJrrjMrQt13sc1OOwglcV2Pibh/NWcEJ7sneHI7BDNLrUoy0DI8+01qrYm7FWpeDMjNAxU3lOvJ85YOtW+HNFogXev8/eoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774071920; c=relaxed/simple;
	bh=OTEGbLxfG/+JbD147AvwQimPpqoFOw6uqccG8cJ2Ut0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uy8+81QHTU7CaAecxasZwdpuQ8zGom51PVRTEcHN3Y1RmRq0udCDA4USISCXP4nhuyy7rde0k/SW6Stf3NIaE6Exg1R7ptTfewt9WsXJYr6BI5zbl/9unbHPOfcIs3fP6bBejADm07g+9wTZLl1jHQMXfvgiO4Ej0W5CmLitFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gupGfsZU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1022414a12.3
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 22:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774071918; x=1774676718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1e3VlB8M6gxe/ov0H5wYQTMPrywihYmSqb8em+k4zw=;
        b=gupGfsZUr3DeIfBMVhfRA+03mHymDIamsPLtxJ2He0Sel1PcQ/y7qteZuDYGepbCzt
         pQS3Jqp41oQZAFCT5s4nzhx8AZN8IvtaM4soszc/Ujku0dYV+40K23Q1Pavilm+2q/T5
         OCwS5pb+qy8p42Ij+4JSR0cxzhuEzKhWI+2u0t/tj2QWai4NVdwoXUvw8MvcNiSx78nv
         yFh6gScw/VQgvOQAFYvxFZosia4qltIAda8ym6GDAziEiLznnQ7ouOgXjgWRpWPSPW0K
         QhVKTlCnlGg+Izx114vf86XziEV7J8Usla9s+zHKTw77g/weGXvEKvND3fwCND2nO0yp
         AYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774071918; x=1774676718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o1e3VlB8M6gxe/ov0H5wYQTMPrywihYmSqb8em+k4zw=;
        b=TvwVXam1DWC+caJ2TvFusLeEficEkqcxab1Kbqfq7OD0jLS/O+HPQas+uhMefUstvG
         daYCnEOyzCts+3quF7fM5gXjndNIDRSJ1yVLTrDmgHHCLNDWkMhDJpdAvq6wTDG1v7q1
         G4Aaf/dR7anJGBjY0AiQxDtfsFvesCp0spAcnvcp4dcG9Ry6OCE8DYKhqkG81/pg6J/A
         EC+Gsrkdjb6+V7p8y5dfoWFscb1W0IcVbjIypx1+RC5RA7GXMRnAkzORa+6KpS4AIJJP
         3yEVZHMeY6gzpikyJUneDIL/EfW6XmKWmcVlYP7+6RNaQqXItfnNABAmCcx6SMBIDo4K
         iSoQ==
X-Gm-Message-State: AOJu0YyThTXdk+VVS7VwWh0h3+8tKfRMMpqz+afuTRuq0EXkHAu+CPMY
	ZmxrGSAOHtl2o5iLeGyUQ6NvqD8AG52Gcg2hphhr7Kp9OvTtaH4aS8pDMh7fZWI3
X-Gm-Gg: ATEYQzypYYcVKdMNEO7CxTCURt9MhiZgiVh+nhlV1pL/G/igvdFlhKxVqMycczJtVuL
	/5qaCoN77GrEm3VUp34vgblA3MLcETVC8H2B4vvErplD413bptFfz+LqAWBTAsIFwH1d6QeEdqy
	wMA/qoa8dkRFbIonRY9+tLZ2zQtyv6QPfdd8QraI/+1jlRSyAZ1XIT9DS106lZepXhit3dIXbKt
	9gvh4IR/fNukGW7c1jAX1rzb5G4ZOfOKkU4nWIG3ZLHNJgPZPmqHDeHkrLp8BdOKs2o1l7PUWh8
	X6XstqEFXHTfaawS9FxLQtr+LYrcH1sR1Df17MU62CJ0YruL0Zo0ycphZ6o9YZTQVaFSsqjw/sa
	mBdJiFisA1qgPHQozhE39CWleKuhALLZxXWYqqX/kOqR0pzDnl/TN4TvQWkGWyXm9eAHpbE5x2j
	hcVxm5tu6bYivlZcRT7p3Y4ViS+c+n6S3YLbOHco2V6ndFHT20RwKlDCw=
X-Received: by 2002:a05:6a21:6d99:b0:398:7357:bb81 with SMTP id adf61e73a8af0-39bce9f0d74mr5250717637.15.1774071918403;
        Fri, 20 Mar 2026 22:45:18 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm4338783b3a.37.2026.03.20.22.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:45:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Evan Quan <evan.quan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Rosen Penev <rosenp@gmail.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Ma Jun <Jun.Ma2@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Zhigang Luo <Zhigang.Luo@amd.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	decce6 <decce6@proton.me>,
	Wentao Liang <vulab@iscas.ac.cn>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 for 6.1 3/4] drm/amd/display: Add pixel_clock to amd_pp_display_configuration
Date: Fri, 20 Mar 2026 22:44:52 -0700
Message-ID: <20260321054453.19683-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321054453.19683-1-rosenp@gmail.com>
References: <20260321054453.19683-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,kernel.org,linuxfoundation.org,web.de,proton.me,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-227660-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CEF02E376A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit b515dcb0dc4e85d8254f5459cfb32fce88dacbfb ]

This commit adds the pixel_clock field to the display config
struct so that power management (DPM) can use it.

We currently don't have a proper bandwidth calculation on old
GPUs with DCE 6-10 because dce_calcs only supports DCE 11+.
So the power management (DPM) on these GPUs may need to make
ad-hoc decisions for display based on the pixel clock.

Also rename sym_clock to pixel_clock in dm_pp_single_disp_config
to avoid confusion with other code where the sym_clock refers to
the DisplayPort symbol clock.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c       | 1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dm_services_types.h             | 2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h                  | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 75284e2cec74..c4e7d9212cd4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -97,6 +97,7 @@ bool dm_pp_apply_display_requirements(
 			const struct dm_pp_single_disp_config *dc_cfg =
 						&pp_display_cfg->disp_configs[i];
 			adev->pm.pm_display_cfg.displays[i].controller_id = dc_cfg->pipe_idx + 1;
+			adev->pm.pm_display_cfg.displays[i].pixel_clock = dc_cfg->pixel_clock;
 		}

 		amdgpu_dpm_display_configuration_change(adev, &adev->pm.pm_display_cfg);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index fb2f154f4fda..bce53ab36f3e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -164,7 +164,7 @@ void dce110_fill_display_configs(
 			stream->link->cur_link_settings.link_rate;
 		cfg->link_settings.link_spread =
 			stream->link->cur_link_settings.link_spread;
-		cfg->sym_clock = stream->phy_pix_clk;
+		cfg->pixel_clock = stream->phy_pix_clk;
 		/* Round v_refresh*/
 		cfg->v_refresh = stream->timing.pix_clk_100hz * 100;
 		cfg->v_refresh /= stream->timing.h_total;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
index b52ba6ffabe1..954b3aa65adb 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
@@ -127,7 +127,7 @@ struct dm_pp_single_disp_config {
 	uint32_t src_height;
 	uint32_t src_width;
 	uint32_t v_refresh;
-	uint32_t sym_clock; /* HDMI only */
+	uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: normalized) */
 	struct dc_link_settings link_settings; /* DP only */
 };

diff --git a/drivers/gpu/drm/amd/include/dm_pp_interface.h b/drivers/gpu/drm/amd/include/dm_pp_interface.h
index 1d93a0c574c9..ee4212cc93d1 100644
--- a/drivers/gpu/drm/amd/include/dm_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/dm_pp_interface.h
@@ -66,6 +66,7 @@ struct single_display_configuration
 	uint32_t view_resolution_cy;
 	enum amd_pp_display_config_type displayconfigtype;
 	uint32_t vertical_refresh; /* for active display */
+	uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: normalized) */
 };

 #define MAX_NUM_DISPLAY 32
--
2.53.0


