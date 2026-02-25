Return-Path: <stable+bounces-219733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBPMEZSKn2nYcgQAu9opvQ
	(envelope-from <stable+bounces-219733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:49:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E30119F18E
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 512E8301455B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBBE3859C2;
	Wed, 25 Feb 2026 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYrXeu5v"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D808385525
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063377; cv=none; b=g5cXrxa2tiibQ9AoLLe/XpLi515qhlo6OQuqf5EH8anhOrZMirF3TvypOdugHdKdJdKx4UwkgOKHzOIYgf9K0VjWAAxPhTmQ8LkN/QQOB1zxC96pAhsm9eMIzSNW0glBYduAHeJ7i8Xhv8bw9yjx6Qa2GCmJh+37SSEiJ59r4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063377; c=relaxed/simple;
	bh=d51HuoOmpWeVvzeALE+lMavxmqBiRdAp6WylD8/LF7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=POZPGpPQ1fuVSGBX8cn1wFBgR0BeBAylFHI/ENqqiNwB1veSaw0mivG24eHTsO+wwXFYU4cqEI7yjSvc3LNhqfoOjzFySuSal54Wh03ajRsttg1UZi5Ra4rwDLWuihtltnrZLEcyZJ3x2fzlcAczXkFvRZ2SVKQ4pPcwmSL0wao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYrXeu5v; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-899b2b6ab42so3031586d6.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 15:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772063375; x=1772668175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+BkblkEJs+X0mWovyrEaETuHy2IBYlQP27IPZgkim9E=;
        b=NYrXeu5vE2ReS9Lqz+z0YyqLBbm1S4HUiR3WmpfkT8HjYx0QKWucA+H4eVMmX6Qrpm
         8k8wzdMdl/igUKur/MXIYiShsMnANzgb1zZNGxFSjJ9mvF7lhPgybO7c4IS5CFxgKdWJ
         WchHgbJ2+PcOEiCQyIftBmeO0/Hd/NCa2yoBvGEGe+PO1i1S/9u1mK8t1xVQSpdmLGO1
         R5vWvzGo0iLB+DDCRyb4/LiI+kt2N9z/HVG9RutFaOAhOSOoqql7hsaCLKJFgXEWkXpB
         vdbxhSpEY7IXxGkzrsRI3Eb2Tf+pGygD4y7APriNmw0J5ns+E0LBpTQGvE/iA0VvJR3a
         ZhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063375; x=1772668175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BkblkEJs+X0mWovyrEaETuHy2IBYlQP27IPZgkim9E=;
        b=t5Na6Wy+7gPOrPC4B3CCXD+aecQJE2DyRbQXUQ0sFuandJnTgQp5DmiO7RfpAcw9JD
         AAfr18lCM0Az7YzRRwKfBJ4aOxGLy/UF85cl6sBvQ+qx+0dKLJ+Pk0+ZPryR4TQeBCnN
         GPdQdkZc/dt9FEoWPJ/o0DaWvekDYOkspvhYExgzA4/4LmqOMdc30pWKc2ijEjOEvXsc
         7v7gliJk+udOUjZn3SfcHWSsvURi6w73p4ntakBzOOO1afT5StQDpxAwYezpOF9dhZGb
         lYGQeN+psA6RKRpKRwoPszLRkM5/b4SNKvaqVDpjwx5iXYJ5rtA0C6rGqiZSxgSo9Szs
         DVkQ==
X-Gm-Message-State: AOJu0YxVRrF2qP2Jx4VTt9T+6xJ/g40uK+StpDOyRKmm85yAcTBfJixs
	N8jqEfEpG9f3al1W77SiO/gt+r5P54wtoAm9yXBqY3kwwEoJLJ2asNrQpSMlQ5BOg+0=
X-Gm-Gg: ATEYQzxHj/r3/SmMfsr8/32GzsRpVSoz4Qu1VdTLgFqH5MwtdkAxRTGOsjpdIa7hp+W
	LqhVhZ9Wgo98vC6ZEAlw2TBYN/6a2bWG9BDLMA470II08vC7XrXva5eIrGcO2UqKy8vGD0YasP+
	Cz+52G03leEM2M8w0E6Tuww9ODKraAY7htJzDCi2AajHkeDaGjhqs3wCMh8Tv2r9eJCGilsfFek
	Lg61NcVwGMwkddUwdwwe8CZbJ0kd5xo/KcY9wiBA2WANUbP5GGF43s2f8T5F8tBNYEouVyt5FVX
	yWEN8bivne9zSL8lE6/kAF62OsA7EMReGYKjUzm65t8WwgOAEMDwomnI+HtGQcJczYMSPkG5WY5
	RUMbucKEmffGaW3SGlqnDdCrmvvm1aL0lXy4mGPLN/sOjCIQePhXkc0Nxu3oS9ZFwY2nqkNUJc7
	DKx+IIWJ4yU8CbnzBGWFNZ+4LLvbVeon7tvhNn13Y/+SQlKNTfbjjGDg==
X-Received: by 2002:a05:6a00:3d16:b0:823:9e5:855e with SMTP id d2e1a72fcca58-8273ba1d7cbmr73184b3a.0.1772056703193;
        Wed, 25 Feb 2026 13:58:23 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db3ab8sm229151b3a.27.2026.02.25.13.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:58:22 -0800 (PST)
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
	Alex Hung <alex.hung@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lijo Lazar <lijo.lazar@amd.com>,
	"chr[]" <chris@rudorff.com>,
	Sasha Levin <sashal@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 and 6.6 1/2] drm/amd/display: Add pixel_clock to amd_pp_display_configuration
Date: Wed, 25 Feb 2026 13:58:03 -0800
Message-ID: <20260225215804.11398-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	TAGGED_FROM(0.00)[bounces-219733-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 9E30119F18E
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


