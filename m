Return-Path: <stable+bounces-219730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEHkOCCIn2mmcgQAu9opvQ
	(envelope-from <stable+bounces-219730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:39:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E819EE35
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6DA5303D33D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866913806B2;
	Wed, 25 Feb 2026 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDP1BIrr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B653806D1
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772062749; cv=none; b=jEbcZUPRdUobyuu8ubFrrs8w8ktLMgMU6+3mu1B355K1CUda5pRIFVo+JRWNvKp5uYJ99pAhxOs/NOF1pawo8Pr7AqXodgLnbKwyfNX862KBsTaIWQ+yQWRMyJzJCnBGR1z4ruFoXtk7RRXMNny+wIZ3W8K0zt7WY6sKZ+1Ep5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772062749; c=relaxed/simple;
	bh=w5JLlPp5DtJ+0fjD5VF7oOVj9E43/90YKWj18tw5o4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEhI8CTNEhty1t1ihawMK0SMbaHz4bUTZqKkhWPve5zgzQuGY5F0ZWAf8ZwV9OmpMgXS82EH86hBL/FEQNh8UwPNxIyzf7FI0GDSaYUZEsNxUKpXE8nh6j7WSpsM94sI1sSgNP48Gt5bVI5oTW2jdZNpk9UX6WziDB2F+vzjbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDP1BIrr; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-89549b2f538so5076916d6.2
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 15:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772062747; x=1772667547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BkblkEJs+X0mWovyrEaETuHy2IBYlQP27IPZgkim9E=;
        b=VDP1BIrrYWDJm4d6zeV090h2GGqvB6aeVTIHI19LCgD6L9IcmRca/sK+rCTsvDXfaK
         +oI3AIki1/nj8J40w5TwMLJksWyfIUQGUYpnfHjlCv8/WPSMYZOe/u66pFrAPOp/jWyK
         LC3bHqjqdl/F++JOrt1o/DxVkqPpVzZHBVDJa/1zPSTi6sQCggg+mAj4t7OV2ZRXFihl
         kdlEyyLpX4uNA2ODGn9/ttPxNSzm5WQ/+cJAC3zcNfmFtzC7GKaw4Ucn1SKsztqlLGad
         teUgu/25tmk4qfkK66BfsJUJXUC6wnQ0uRYNQ3nVXAkH0CEHae4VaTXggy710DOTyI00
         X3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772062747; x=1772667547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+BkblkEJs+X0mWovyrEaETuHy2IBYlQP27IPZgkim9E=;
        b=mYTUT0MJ1xhJOw4dQ1XvpRZwzfX2c4ztDZjhwmHMFHV5Yys0hB5vFk4qzC2Uz9qW62
         I1iEI8tu6h27EKwC8X5kWwCh9pw/OwktR+PxIVgYxOG51F+DhuDrQAvwSkvlTkf8d3wB
         ODPMaYlZdv5fYuGv5FZe8/NScWsaYS5jIROzvmgCp3ggEqdXUCKPSkYrXkpNGIrKOIvP
         5qhKHIDM8we1rebs8A4m0UR39xfCVUvF8UvSXyjp7TZ2mcTXqQKiPsUGWI7dX2ZMSjS5
         M2pr28J37m1LDV7l6QlH10uhUZ+2UiHz0WUmIFl3d0f1wRljnx3Es7sl+XlL+Dnp2sM7
         qy/Q==
X-Gm-Message-State: AOJu0YyaH0a8hclYCTVqKEqCpC7cmF21ZLQpKGGHaq0s+SeXkVLVHVy2
	0tgxrbxLdDemVOK7OcjjczO2tLnDmFO4IJhJ0wr9Tkl1DwQ/bAdQqAkbY/9UqwveMZI=
X-Gm-Gg: ATEYQzzJ5pHcPl5bIcs10Amu9HYFLEOMQgMbSu9bJArIU9s9pHGl77a7msjYzn3PcOu
	TAQe0ZscDWmekmI/xvJnTfuvgCeppVVvNTAbvuOprxUtFkKf+8XFxtTUv+g0kCaCJqdKfT5mNeG
	INo4X+me5ald+1OQDv45jRIYF45+mSmcitED5USZB8aIxIw8xVUZbzhXTf6rLYTpJlgTYwcsBl7
	9lLnhFXNvKY9BGMTdeaKxGvcRueWhpDaHtJ/dPMVXLQ/MXdDgjEv74EeY1xEZa5raJ9uHsIWTnz
	sfqnaY5fQwEFA+6N0VHyDCw0vqgBDqhEZOW0UXGFfUh2Sz35nxYLhGo8Eq3g45QOS87ZdVJ43zo
	54ay2nVyXCZ7V4fkII2f7ug+kDEChhA9xgX8WGcvMzhl8cBJ23Vxf7GXW5xVNRY+CD46+w82j+9
	sUb8lZXyNc0pITwAwt+JZnVZYdWUdVas3qs1DqNkZcVDibeFOvSeoV1Q==
X-Received: by 2002:a05:6a20:6a15:b0:394:a026:4c60 with SMTP id adf61e73a8af0-395ad0f204fmr1569006637.32.1772056234431;
        Wed, 25 Feb 2026 13:50:34 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8059bcsm11990a12.18.2026.02.25.13.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:50:33 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kenneth Feng <kenneth.feng@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Hung <alex.hung@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	"chr[]" <chris@rudorff.com>,
	Sasha Levin <sashal@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/amd/display: Add pixel_clock to amd_pp_display_configuration
Date: Wed, 25 Feb 2026 13:50:12 -0800
Message-ID: <20260225215013.11224-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225215013.11224-1-rosenp@gmail.com>
References: <20260225215013.11224-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,linuxfoundation.org,rudorff.com,kernel.org,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-219730-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 578E819EE35
X-Rspamd-Action: no action

From: Timur Kristóf <timur.kristof@gmail.com>

commit b515dcb0dc4e85d8254f5459cfb32fce88dacbfb upstream.

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
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c       | 1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dm_services_types.h             | 2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h                  | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 848c5b4bb301..016230896d0e 100644
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
index 13cf415e38e5..d50b9440210e 100644
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
index facf269c4326..b4eefe3ce7c7 100644
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
index acd1cef61b7c..349544504c93 100644
--- a/drivers/gpu/drm/amd/include/dm_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/dm_pp_interface.h
@@ -65,6 +65,7 @@ struct single_display_configuration {
 	uint32_t view_resolution_cy;
 	enum amd_pp_display_config_type displayconfigtype;
 	uint32_t vertical_refresh; /* for active display */
+	uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: normalized) */
 };
 
 #define MAX_NUM_DISPLAY 32
-- 
2.53.0


