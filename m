Return-Path: <stable+bounces-220042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sICTHRZ1omk+3QQAu9opvQ
	(envelope-from <stable+bounces-220042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 05:54:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE141C05ED
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 05:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40A9E3067B13
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 04:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054822D7DD9;
	Sat, 28 Feb 2026 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0HtHqi9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4202E1C7C
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772254468; cv=none; b=VU6uqft1mN8l32R3uKStPj7f7hxfqJg5W6lVv0qwslv7VoHpU1KeiHiN33CcqAbTq6utUrHKAtzCT8nWkOsNAPryZfBV7khb88ondAB3be/FacOxgeEOWBWW6JSvZIZH7gWx+UXmuCwR2I0ao8PExquT4OJ6c4Cj0pbld4kXd98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772254468; c=relaxed/simple;
	bh=61DeDI1eXO8X1Rsni0kFMe4u1MK5md6qMLvjVwD8akA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7PDCiq0fR7Om9ooREH1QeXyD1vNRyM6ZVwdQiuhclzpNzLgYkf5rnk2YWNyt12EepPkblIX2ktp6Zekdf/u/ta5SS0Kg/hxnDSIXKu7Kq9jCssyHk+jgExxfxi4vtAv0fk/R00jUYaj9wfnFzC2JMZeylRL7QEY4seVlvN1SY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0HtHqi9; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-793fdbb8d3aso32407657b3.3
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 20:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772254466; x=1772859266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtZILg1UfPbIs6Qetp2wD7SekLL2E2Ax5WmC10z0J5E=;
        b=X0HtHqi9u5Wi2/nbaK13/O9uccibRny/LZnVM5saqSaz3F5kPoa+2ntNovGPum48sX
         NZH8BBxnfrx9CdB5hRRT+qcxP61HaOhkcKr8VLMx/xOfmyxawkNSGJg61B3lsyE5RWSo
         k+y6bOhNSWYzukKETInmlsdzvxo04j88yZsc667sMiAZDakiuzGiQ1l6YHdI8UP/+ydi
         h6zzOzVGlHQ5gMDjSKLEWnzJkIgDjqQ6i5EkMqx5XPYJVRxO/aKKr42s35ALlEAj1+L2
         pOQ0ljdTlBtfcUWsBJ7CIQnAV/t6AIgMkreK8p1BOeWFO6bbI5BPciy1peBAjcjK+zW7
         IC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772254466; x=1772859266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LtZILg1UfPbIs6Qetp2wD7SekLL2E2Ax5WmC10z0J5E=;
        b=xU3COkaFrEyYOXhBKDW8odzQtmG+qsh90Q14PHpNJHOcigQPtUHZ9JXEvKCRVDAdQp
         l2kllNnuDTxf2aUV6ydDfE1ec7uw9TcOjZKAhWpBi5mk8wCh+G4TkM23plfQs4upvhRU
         EMR5pFe3CvcG1KFXYysjT2FPePVd5dQac2tBHyXG46JQAILm2KvhyROEzu1nKFJKn7gv
         e0w8eWI9RdMavKrstLpvOi4pB93+p7RjZTUxTg+V4saEtnYwB1lsZKjl+g3fjNTwZFg9
         kMW5LDLF3ZKz/h5qUrrVSd+8TDIjCBKzPj9qJPVFoBgEoMcKxTxSd5ZU2V8tcguoMQKN
         lQKw==
X-Gm-Message-State: AOJu0YwRJRaiIEhYRQOGiPgEBTqgLe5nloFVNC0TyTvwPqDZt83O7k7k
	d1kpEKTFQopHozyme0NNM9V6J0uxEWKtk8ygBp5U/fotwScnvCCXZ5TO+vo/50jWgWQTLQ==
X-Gm-Gg: ATEYQzwyaam77EBjOL3b9friZ/Kk1GxhvwoZMzDxcdOiDi1uxTxiDNRoJWA0yYk9OWs
	42XoYj9XX+VrfncHzaJaZ1kzhmhJLx984foZUUXXs+3tK1kDPhgU0p6igFDVYOBAGRC2MyQCAhT
	eXVx40EOTScYE3U8TnLC8g6DFU+VGE2AT3P9lszDFuXuGqN6M6k2+7hgwpW+ujPMuEiep9+Vbni
	1OhmlZDnm5l28wfiMXzjqQ1XgRX6/CgIA7lU55JvBTLKtQ3QDOPr5NY13QoO3LMcLSec5Lny1q5
	9LytWY/1LC99ZDOsOALS0TvCh2eVJeL1PGeqI0uRRYVw5xJT7NgvRF1BBG6gGs3PVn8Zq3vGGQB
	rcUSWj88rpWJqvF4XFEK63sUxqbR0XgcCUM6zQv2fttM3IFdevBpiU6MAq6BpYhRjI/crDCOILZ
	ZxaZ0Bz7qcOFjg80tv7CXEERyS1Eo9VGlyxQiZJTJoJ6SR9EEYCRQaY/4IXgPnWEtn
X-Received: by 2002:a05:690c:60c2:b0:798:65eb:aff0 with SMTP id 00721157ae682-798854e24a9mr50867397b3.14.1772254465800;
        Fri, 27 Feb 2026 20:54:25 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876bf8103sm29865967b3.27.2026.02.27.20.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 20:54:24 -0800 (PST)
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
Subject: [PATCHv2 for 6.112 and 6.6 2/2] drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)
Date: Fri, 27 Feb 2026 20:53:56 -0800
Message-ID: <20260228045356.3561-3-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,linuxfoundation.org,rudorff.com,kernel.org,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-220042-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBE141C05ED
X-Rspamd-Action: no action

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 9d73b107a61b73e7101d4b728ddac3d2c77db111 ]

This commit is necessary for DC to function well with chips
that use the legacy power management code, ie. SI and KV.
Communicate display information from DC to the legacy PM code.

Currently DC uses pm_display_cfg to communicate power management
requirements from the display code to the DPM code.
However, the legacy (non-DC) code path used different fields
and therefore could not take into account anything from DC.

Change the legacy display code to fill the same pm_display_cfg
struct as DC and use the same in the legacy DPM code.

To ease review and reduce churn, this commit does not yet
delete the now unneeded code, that is done in the next commit.

v2:
Rebase.
Fix single_display in amdgpu_dpm_pick_power_state.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 67 +++++++++++++++++++
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  2 +
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 65 ++++++------------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 11 +--
 6 files changed, 97 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
index 2d2d2d5e6763..9ef965e4a92e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
@@ -100,3 +100,70 @@ u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)

 	return vrefresh;
 }
+
+void amdgpu_dpm_get_display_cfg(struct amdgpu_device *adev)
+{
+	struct drm_device *ddev = adev_to_drm(adev);
+	struct amd_pp_display_configuration *cfg = &adev->pm.pm_display_cfg;
+	struct single_display_configuration *display_cfg;
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_connector *conn;
+	int num_crtcs = 0;
+	int vrefresh;
+	u32 vblank_in_pixels, vblank_time_us;
+
+	cfg->min_vblank_time = 0xffffffff; /* if the displays are off, vblank time is max */
+
+	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
+		list_for_each_entry(crtc, &ddev->mode_config.crtc_list, head) {
+			amdgpu_crtc = to_amdgpu_crtc(crtc);
+
+			/* The array should only contain active displays. */
+			if (!amdgpu_crtc->enabled)
+				continue;
+
+			conn = to_amdgpu_connector(amdgpu_crtc->connector);
+			display_cfg = &adev->pm.pm_display_cfg.displays[num_crtcs++];
+
+			if (amdgpu_crtc->hw_mode.clock) {
+				vrefresh = drm_mode_vrefresh(&amdgpu_crtc->hw_mode);
+
+				vblank_in_pixels =
+					amdgpu_crtc->hw_mode.crtc_htotal *
+					(amdgpu_crtc->hw_mode.crtc_vblank_end -
+					amdgpu_crtc->hw_mode.crtc_vdisplay +
+					(amdgpu_crtc->v_border * 2));
+
+				vblank_time_us =
+					vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
+
+				/* The legacy (non-DC) code has issues with mclk switching
+				 * with refresh rates over 120 Hz. Disable mclk switching.
+				 */
+				if (vrefresh > 120)
+					vblank_time_us = 0;
+
+				/* Find minimum vblank time. */
+				if (vblank_time_us < cfg->min_vblank_time)
+					cfg->min_vblank_time = vblank_time_us;
+
+				/* Find vertical refresh rate of first active display. */
+				if (!cfg->vrefresh)
+					cfg->vrefresh = vrefresh;
+			}
+
+			if (amdgpu_crtc->crtc_id < cfg->crtc_index) {
+				/* Find first active CRTC and its line time. */
+				cfg->crtc_index = amdgpu_crtc->crtc_id;
+				cfg->line_time_in_us = amdgpu_crtc->line_time;
+			}
+
+			display_cfg->controller_id = amdgpu_crtc->crtc_id;
+			display_cfg->pixel_clock = conn->pixelclock_for_modeset;
+		}
+	}
+
+	cfg->display_clk = adev->clock.default_dispclk;
+	cfg->num_display = num_crtcs;
+}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
index 5c2a89f0d5d5..8be11510cd92 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
@@ -29,4 +29,6 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);

 u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev);

+void amdgpu_dpm_get_display_cfg(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 6b34a33d788f..8cf7e517da84 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -2299,7 +2299,7 @@ static void kv_apply_state_adjust_rules(struct amdgpu_device *adev,

 		if (pi->sys_info.nb_dpm_enable) {
 			force_high = (mclk >= pi->sys_info.nbp_memory_clock[3]) ||
-				pi->video_start || (adev->pm.dpm.new_active_crtc_count >= 3) ||
+				pi->video_start || (adev->pm.pm_display_cfg.num_display >= 3) ||
 				pi->disable_nb_ps3_in_battery;
 			ps->dpm0_pg_nb_ps_lo = force_high ? 0x2 : 0x3;
 			ps->dpm0_pg_nb_ps_hi = 0x2;
@@ -2358,7 +2358,7 @@ static int kv_calculate_nbps_level_settings(struct amdgpu_device *adev)
 			return 0;

 		force_high = ((mclk >= pi->sys_info.nbp_memory_clock[3]) ||
-			      (adev->pm.dpm.new_active_crtc_count >= 3) || pi->video_start);
+			      (adev->pm.pm_display_cfg.num_display >= 3) || pi->video_start);

 		if (force_high) {
 			for (i = pi->lowest_valid; i <= pi->highest_valid; i++)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index c7518b13e787..8eb121db2ce4 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -797,8 +797,7 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
 	int i;
 	struct amdgpu_ps *ps;
 	u32 ui_class;
-	bool single_display = (adev->pm.dpm.new_active_crtc_count < 2) ?
-		true : false;
+	bool single_display = adev->pm.pm_display_cfg.num_display < 2;

 	/* check if the vblank period is too short to adjust the mclk */
 	if (single_display && adev->powerplay.pp_funcs->vblank_too_short) {
@@ -994,7 +993,8 @@ void amdgpu_legacy_dpm_compute_clocks(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;

-	amdgpu_dpm_get_active_displays(adev);
+	if (!adev->dc_enabled)
+		amdgpu_dpm_get_display_cfg(adev);

 	amdgpu_dpm_change_power_state_locked(adev);
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 29cecfab0704..7ea310601ff5 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3058,7 +3058,7 @@ static int si_get_vce_clock_voltage(struct amdgpu_device *adev,
 static bool si_dpm_vblank_too_short(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 vblank_time = amdgpu_dpm_get_vblank_time(adev);
+	u32 vblank_time = adev->pm.pm_display_cfg.min_vblank_time;
 	/* we never hit the non-gddr5 limit so disable it */
 	u32 switch_limit = adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 0;

@@ -3424,9 +3424,10 @@ static void rv770_get_engine_memory_ss(struct amdgpu_device *adev)
 static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 					struct amdgpu_ps *rps)
 {
+	const struct amd_pp_display_configuration *display_cfg =
+		&adev->pm.pm_display_cfg;
 	struct  si_ps *ps = si_get_ps(rps);
 	struct amdgpu_clock_and_voltage_limits *max_limits;
-	struct amdgpu_connector *conn;
 	bool disable_mclk_switching = false;
 	bool disable_sclk_switching = false;
 	u32 mclk, sclk;
@@ -3470,14 +3471,9 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 	 * For example, 4K 60Hz and 1080p 144Hz fall into this category.
 	 * Find number of such displays connected.
 	 */
-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		if (!(adev->pm.dpm.new_active_crtcs & (1 << i)) ||
-			!adev->mode_info.crtcs[i]->enabled)
-			continue;
-
-		conn = to_amdgpu_connector(adev->mode_info.crtcs[i]->connector);
-
-		if (conn->pixelclock_for_modeset > 297000)
+	for (i = 0; i < display_cfg->num_display; i++) {
+		/* The array only contains active displays. */
+		if (display_cfg->displays[i].pixel_clock > 297000)
 			high_pixelclock_count++;
 	}

@@ -3510,7 +3506,7 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 		rps->ecclk = 0;
 	}

-	if ((adev->pm.dpm.new_active_crtc_count > 1) ||
+	if ((adev->pm.pm_display_cfg.num_display > 1) ||
 	    si_dpm_vblank_too_short(adev))
 		disable_mclk_switching = true;

@@ -3658,7 +3654,7 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 						   ps->performance_levels[i].mclk,
 						   max_limits->vddc,  &ps->performance_levels[i].vddc);
 		btc_apply_voltage_dependency_rules(&adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk,
-						   adev->clock.current_dispclk,
+						   display_cfg->display_clk,
 						   max_limits->vddc,  &ps->performance_levels[i].vddc);
 	}

@@ -4183,16 +4179,16 @@ static void si_program_ds_registers(struct amdgpu_device *adev)

 static void si_program_display_gap(struct amdgpu_device *adev)
 {
+	const struct amd_pp_display_configuration *cfg = &adev->pm.pm_display_cfg;
 	u32 tmp, pipe;
-	int i;

 	tmp = RREG32(CG_DISPLAY_GAP_CNTL) & ~(DISP1_GAP_MASK | DISP2_GAP_MASK);
-	if (adev->pm.dpm.new_active_crtc_count > 0)
+	if (cfg->num_display > 0)
 		tmp |= DISP1_GAP(R600_PM_DISPLAY_GAP_VBLANK_OR_WM);
 	else
 		tmp |= DISP1_GAP(R600_PM_DISPLAY_GAP_IGNORE);

-	if (adev->pm.dpm.new_active_crtc_count > 1)
+	if (cfg->num_display > 1)
 		tmp |= DISP2_GAP(R600_PM_DISPLAY_GAP_VBLANK_OR_WM);
 	else
 		tmp |= DISP2_GAP(R600_PM_DISPLAY_GAP_IGNORE);
@@ -4202,17 +4198,8 @@ static void si_program_display_gap(struct amdgpu_device *adev)
 	tmp = RREG32(DCCG_DISP_SLOW_SELECT_REG);
 	pipe = (tmp & DCCG_DISP1_SLOW_SELECT_MASK) >> DCCG_DISP1_SLOW_SELECT_SHIFT;

-	if ((adev->pm.dpm.new_active_crtc_count > 0) &&
-	    (!(adev->pm.dpm.new_active_crtcs & (1 << pipe)))) {
-		/* find the first active crtc */
-		for (i = 0; i < adev->mode_info.num_crtc; i++) {
-			if (adev->pm.dpm.new_active_crtcs & (1 << i))
-				break;
-		}
-		if (i == adev->mode_info.num_crtc)
-			pipe = 0;
-		else
-			pipe = i;
+	if (cfg->num_display > 0 && pipe != cfg->crtc_index) {
+		pipe = cfg->crtc_index;

 		tmp &= ~DCCG_DISP1_SLOW_SELECT_MASK;
 		tmp |= DCCG_DISP1_SLOW_SELECT(pipe);
@@ -4223,7 +4210,7 @@ static void si_program_display_gap(struct amdgpu_device *adev)
 	 * This can be a problem on PowerXpress systems or if you want to use the card
 	 * for offscreen rendering or compute if there are no crtcs enabled.
 	 */
-	si_notify_smc_display_change(adev, adev->pm.dpm.new_active_crtc_count > 0);
+	si_notify_smc_display_change(adev, cfg->num_display > 0);
 }

 static void si_enable_spread_spectrum(struct amdgpu_device *adev, bool enable)
@@ -5527,7 +5514,7 @@ static int si_convert_power_level_to_smc(struct amdgpu_device *adev,
 	    (pl->mclk <= pi->mclk_stutter_mode_threshold) &&
 	    !eg_pi->uvd_enabled &&
 	    (RREG32(DPG_PIPE_STUTTER_CONTROL) & STUTTER_ENABLE) &&
-	    (adev->pm.dpm.new_active_crtc_count <= 2)) {
+	    (adev->pm.pm_display_cfg.num_display <= 2)) {
 		level->mcFlags |= SISLANDS_SMC_MC_STUTTER_EN;
 	}

@@ -5676,7 +5663,7 @@ static bool si_is_state_ulv_compatible(struct amdgpu_device *adev,
 	/* XXX validate against display requirements! */

 	for (i = 0; i < adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count; i++) {
-		if (adev->clock.current_dispclk <=
+		if (adev->pm.pm_display_cfg.display_clk <=
 		    adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[i].clk) {
 			if (ulv->pl.vddc <
 			    adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[i].v)
@@ -5830,30 +5817,22 @@ static int si_upload_ulv_state(struct amdgpu_device *adev)

 static int si_upload_smc_data(struct amdgpu_device *adev)
 {
-	struct amdgpu_crtc *amdgpu_crtc = NULL;
-	int i;
+	const struct amd_pp_display_configuration *cfg = &adev->pm.pm_display_cfg;
 	u32 crtc_index = 0;
 	u32 mclk_change_block_cp_min = 0;
 	u32 mclk_change_block_cp_max = 0;

-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		if (adev->pm.dpm.new_active_crtcs & (1 << i)) {
-			amdgpu_crtc = adev->mode_info.crtcs[i];
-			break;
-		}
-	}
-
 	/* When a display is plugged in, program these so that the SMC
 	 * performs MCLK switching when it doesn't cause flickering.
 	 * When no display is plugged in, there is no need to restrict
 	 * MCLK switching, so program them to zero.
 	 */
-	if (adev->pm.dpm.new_active_crtc_count && amdgpu_crtc) {
-		crtc_index = amdgpu_crtc->crtc_id;
+	if (cfg->num_display) {
+		crtc_index = cfg->crtc_index;

-		if (amdgpu_crtc->line_time) {
-			mclk_change_block_cp_min = 200 / amdgpu_crtc->line_time;
-			mclk_change_block_cp_max = 100 / amdgpu_crtc->line_time;
+		if (cfg->line_time_in_us) {
+			mclk_change_block_cp_min = 200 / cfg->line_time_in_us;
+			mclk_change_block_cp_max = 100 / cfg->line_time_in_us;
 		}
 	}

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 0115d26b5af9..24b25cddf0c1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1569,16 +1569,7 @@ static void pp_pm_compute_clocks(void *handle)
 	struct amdgpu_device *adev = hwmgr->adev;

 	if (!adev->dc_enabled) {
-		amdgpu_dpm_get_active_displays(adev);
-		adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
-		adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
-		adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
-		/* we have issues with mclk switching with
-		 * refresh rates over 120 hz on the non-DC code.
-		 */
-		if (adev->pm.pm_display_cfg.vrefresh > 120)
-			adev->pm.pm_display_cfg.min_vblank_time = 0;
-
+		amdgpu_dpm_get_display_cfg(adev);
 		pp_display_configuration_change(handle,
 						&adev->pm.pm_display_cfg);
 	}
--
2.53.0


