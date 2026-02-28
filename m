Return-Path: <stable+bounces-220041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK4tARp1omk+3QQAu9opvQ
	(envelope-from <stable+bounces-220041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 05:54:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B08E1C05F4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 05:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5237830789E8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 04:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193502D7DD9;
	Sat, 28 Feb 2026 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAvejhzh"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1422566F5
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 04:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772254464; cv=none; b=WRDeT9sOMOy5sMcZcMb/+atiMAgEkr9p2ZtjT6m/mJY2ZN4ctEk6Bl4Bd+W5wj80hmq2FLWK0rtHyDiPsAVMj5mqlVdy7hmyouGTOgGuPdIOJi7vzC4W73hNn1Oe6yZZ9/ARqSrZ/CvucOISPARbcbr8u4gnCFFTiqMBqfYG07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772254464; c=relaxed/simple;
	bh=nE5oIObzj+Uyy8TybgEbCVDHQd1E5+Y8Zz8eBjqVNwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkdSRT/YWaknKxbyucIZtUnydCsMY+DlaWCh2UjL9PGNW06cDB9fRNVqyDyxPXud44r+sFrQxO4RcPTUbqdbcNimVmoUITNJQD5xGl9AfXMpLH5Qah7XMuNQaQocRRR356rbxC+3sdIqFKA6qD4QIic16R+Rz+MeRQffcShW+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAvejhzh; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79885f4a900so10891827b3.2
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 20:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772254462; x=1772859262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmSz6Ee1J0Z/MD/2JF/g5iVQIYrLtpWsPv+WCazK24Q=;
        b=RAvejhzheE90R+QT4L2EOF9FiCnE3U1l/oGwEogreY1pGZ/Z72pW7GnVSn9Uya83n7
         L+KQaFY/P92j5pSgDvChcA24cKzDN9S1+zVRcYvJbgbYTBrfa8hciI0EqSpelIbmCyw6
         EloCzNxsexVz5TE58wG1PI7Oy38yT4oA2pLZGAbwJN6afpu2NqYMK43oZrppd2HNR6jg
         5BTMoH24dpZpGk0f4VsnqLUePIZSrutWXWDP8l8u0r85oRPpRa/GAPQ18g2+TlbHuLTa
         oShzoG4Z//qNgHRiLwi2dwAyp+MRoVQ8rz5B7BnLRdj5NOgu0eyz4qVKPhgpC0ByRWmI
         iPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772254462; x=1772859262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EmSz6Ee1J0Z/MD/2JF/g5iVQIYrLtpWsPv+WCazK24Q=;
        b=L00tAwZKPw26dxnyDuZ7iqZURVq3LOCmpWocc2LkSBAdbJakWkKRpMuh3bfdL2jPvz
         BWOLEGNj90YetAnb3ZkwsQnU2EEfx+ancF5eeHgoGsBb9nAxqwBHvweI7gogJSTBjPoO
         46iWU8bUVGHVNZFhq/vYWp4kR9oQXvdwH+DTLHGpNoK+Zv3StQPIaxX06V8o3eS+5rkb
         Nffu8HglP8MtLGUqJnF59hoP3dNSiq6pnhsh4klTl0mW81WHZgBExEbxr+lC2pCBRwHc
         LUPU5WVv+3J3oJjnRblG0tui2NH/bzmYNf0c0NjXcLHuWaQ/GYdr1mmZEiPU7QXUDSGc
         M9FA==
X-Gm-Message-State: AOJu0YwGL6Fzr+40H8vG5QYC7KJlzqb2Ehn+TRtydF/VBEqb0UC+aMjf
	xDf4j1yMrxfWFF9xm4wiE1+pIdDh3cmpVGX3jmeE4RDL+rCE7KaRfVKqqCogsDgFNG10sg==
X-Gm-Gg: ATEYQzxHCIuHtlB5chAHmaeHbqVE6LnQBGQvL/u+e9JeA1z03g+p0U7rzCsWUqUgRa9
	olV+0qdWswsdyniC3Fhk98clbP1x7SvZa8MZl124BHImhz5tSMelctcvOmzM/kszFQxUFlNcHw4
	qbVY24wOLXT/rkOFfKu1U+R9JVTL77bAHh+mpvx+Felte3U5m72yq333eroDOicrN3D4rLLN40e
	I8p3ahYhxrSCR0Ide2wZGob3LnA+LedwPxzIp5XNa9WaSIJ/2ajbIDCulvd0jgJaiWn6J8LxCcf
	GYf1YG3xVJSgQLwQURBVFtkXOllpvs8+tG9F/J6hY8uM5GgA3cRN/43pF65ib+BzxbAbl9CEy0z
	WYBEaV/OXVOuQ8/T/2adhphCHjr+KdNGgdeCLcvRL3/YTVseSsHpwiyqrRnSEX0xZouO98DuC+x
	hDi4199CSfDoTidFVMrxzK9sUU0CmvxeY0ehCEZzvEBfk01lhk1chBaw==
X-Received: by 2002:a05:690c:ed6:b0:798:6561:2a5e with SMTP id 00721157ae682-7988549d803mr48648597b3.19.1772254461949;
        Fri, 27 Feb 2026 20:54:21 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876bf8103sm29865967b3.27.2026.02.27.20.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 20:54:20 -0800 (PST)
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
Subject: [PATCHv2 for 6.112 and 6.6 1/2] drm/amd/display: Add pixel_clock to amd_pp_display_configuration
Date: Fri, 27 Feb 2026 20:53:55 -0800
Message-ID: <20260228045356.3561-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228045356.3561-1-rosenp@gmail.com>
References: <20260228045356.3561-1-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-220041-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B08E1C05F4
X-Rspamd-Action: no action

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


