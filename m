Return-Path: <stable+bounces-226032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDZhL5VouWmZDwIAu9opvQ
	(envelope-from <stable+bounces-226032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:43:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3336E2AC30B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CD91308768F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7633E5575;
	Tue, 17 Mar 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjMHgwEV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E003E5572
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757731; cv=none; b=FXN/8O3I9G0yzNUfq0l/oJpADct2/2vq7d5nXTBp43DYCwM/7IzBwDEofIFkoQLh1ZRGAn4+YxiuexhCZug0wEtiZn2Xqcew6uRXZuqQx1jVrQFacys4Vractg7QewYaBNjtc2gh5nYh+5wo9xq9nwszojsGL026XvRnbkOyBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757731; c=relaxed/simple;
	bh=895+2vzoayLBYOwkjVqteEhT6tIqpxSDJkvRfyDeqy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYsyuyhdn9P7rcOMSTKm6nHdoSI3FaV9EiM5l+ahrfpTWlSKcveBGR856EA83pBpcp6wYezyBcZj808yA7zsCfMtJmG48rJ7wkVw+dgHHIsEqEI6sU9Z5oPtoeXJuw8gK7j88yU0fERtnU+suQlspjOU/ugWPgTQZVOSm4sdtSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjMHgwEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71738C19424;
	Tue, 17 Mar 2026 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773757731;
	bh=895+2vzoayLBYOwkjVqteEhT6tIqpxSDJkvRfyDeqy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjMHgwEVgRVJzb27Q5JXhO/cEygsGclu0zTOGOP0W8m9NxYsaJlWPi2Ct0YTMGwKr
	 fmrTx5joY+rxNYqfKsSnSdth4GHKwkyfmy41J94ziVRyzG7WZo3lrN0ZhYdqxH1heu
	 f4R09SCoiUavEwWK7zxB+y0pG1DXIEUIukaMW/uNpa5dv8CICcG7cKqeu00IeyqCxl
	 BF6yGigzU3M5lbuiKXRKGag6a0ukgSLQ7LT/rvI+0Nbu8mK9WjlIgnsThAQ+2PJvG8
	 Bn5y6qyrFPKlokcJZUPfIkj68WmPMjy9Hv2hsiD6uEAOYi0Vmqx/c8eCrRq3FOC0jF
	 Mj9rwV4/O/d2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shenghao Yang <me@shenghaoyang.info>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ruben Wauters <rubenru09@aol.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] drm/gud: fix NULL crtc dereference on display disable
Date: Tue, 17 Mar 2026 10:28:47 -0400
Message-ID: <20260317142847.165695-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317142847.165695-1-sashal@kernel.org>
References: <2026031703-footpad-unpaved-0a7a@gregkh>
 <20260317142847.165695-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[shenghaoyang.info,intel.com,linaro.org,suse.de,aol.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226032-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,suse.de:email,msgid.link:url,linaro.org:email]
X-Rspamd-Queue-Id: 3336E2AC30B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shenghao Yang <me@shenghaoyang.info>

[ Upstream commit 7149be786da012afc6bae293d38f8c1fff1fb90d ]

gud_plane_atomic_update() currently handles both crtc state and
framebuffer updates - the complexity has led to a few accidental
NULL pointer dereferences.

Commit dc2d5ddb193e ("drm/gud: fix NULL fb and crtc dereferences
on USB disconnect") [1] fixed an earlier dereference but planes
can also be disabled in non-hotplug paths (e.g. display disables
via the desktop environment). The drm_dev_enter() call would not
cause an early return in those and subsequently oops on
dereferencing crtc:

BUG: kernel NULL pointer dereference, address: 00000000000005c8
CPU: 6 UID: 1000 PID: 3473 Comm: kwin_wayland Not tainted 6.18.2-200.vanilla.gud.fc42.x86_64 #1 PREEMPT(lazy)
RIP: 0010:gud_plane_atomic_update+0x148/0x470 [gud]
 <TASK>
 drm_atomic_helper_commit_planes+0x28e/0x310
 drm_atomic_helper_commit_tail+0x2a/0x70
 commit_tail+0xf1/0x150
 drm_atomic_helper_commit+0x13c/0x180
 drm_atomic_commit+0xb1/0xe0
info ? __pfx___drm_printfn_info+0x10/0x10
 drm_mode_atomic_ioctl+0x70f/0x7c0
 ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
 drm_ioctl_kernel+0xae/0x100
 drm_ioctl+0x2a8/0x550
 ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
 __x64_sys_ioctl+0x97/0xe0
 do_syscall_64+0x7e/0x7f0
 ? __ct_user_enter+0x56/0xd0
 ? do_syscall_64+0x158/0x7f0
 ? __ct_user_enter+0x56/0xd0
 ? do_syscall_64+0x158/0x7f0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Split out crtc handling from gud_plane_atomic_update() into
atomic_enable() and atomic_disable() functions to delegate
crtc state transitioning work to the DRM helpers.

To preserve the gud state commit sequence [2], switch to
the runtime PM version of drm_atomic_helper_commit_tail() which
ensures that crtcs are enabled (hence sending the
GUD_REQ_SET_CONTROLLER_ENABLE and GUD_REQ_SET_DISPLAY_ENABLE
requests) before a framebuffer update is sent.

[1] https://lore.kernel.org/all/20251231055039.44266-1-me@shenghaoyang.info/
[2] https://github.com/notro/gud/wiki/GUD-Protocol#display-state

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202601142159.0v8ilfVs-lkp@intel.com/
Fixes: 73cfd166e045 ("drm/gud: Replace simple display pipe with DRM atomic helpers")
Cc: <stable@vger.kernel.org> # 6.19.x
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Ruben Wauters <rubenru09@aol.com>
Signed-off-by: Ruben Wauters <rubenru09@aol.com>
Link: https://patch.msgid.link/20260222054551.80864-1-me@shenghaoyang.info
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/gud/gud_drv.c      |  9 ++++-
 drivers/gpu/drm/gud/gud_internal.h |  4 +++
 drivers/gpu/drm/gud/gud_pipe.c     | 54 ++++++++++++++++++++----------
 3 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 42135a48d92ef..a2000991ecbe4 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -339,7 +339,9 @@ static int gud_stats_debugfs(struct seq_file *m, void *data)
 }
 
 static const struct drm_crtc_helper_funcs gud_crtc_helper_funcs = {
-	.atomic_check = drm_crtc_helper_atomic_check
+	.atomic_check = drm_crtc_helper_atomic_check,
+	.atomic_enable = gud_crtc_atomic_enable,
+	.atomic_disable = gud_crtc_atomic_disable,
 };
 
 static const struct drm_crtc_funcs gud_crtc_funcs = {
@@ -364,6 +366,10 @@ static const struct drm_plane_funcs gud_plane_funcs = {
 	DRM_GEM_SHADOW_PLANE_FUNCS,
 };
 
+static const struct drm_mode_config_helper_funcs gud_mode_config_helpers = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
 static const struct drm_mode_config_funcs gud_mode_config_funcs = {
 	.fb_create = drm_gem_fb_create_with_dirty,
 	.atomic_check = drm_atomic_helper_check,
@@ -499,6 +505,7 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	drm->mode_config.min_height = le32_to_cpu(desc.min_height);
 	drm->mode_config.max_height = le32_to_cpu(desc.max_height);
 	drm->mode_config.funcs = &gud_mode_config_funcs;
+	drm->mode_config.helper_private = &gud_mode_config_helpers;
 
 	/* Format init */
 	formats_dev = devm_kmalloc(dev, GUD_FORMATS_MAX_NUM, GFP_KERNEL);
diff --git a/drivers/gpu/drm/gud/gud_internal.h b/drivers/gpu/drm/gud/gud_internal.h
index d27c31648341c..8eec8335f5f90 100644
--- a/drivers/gpu/drm/gud/gud_internal.h
+++ b/drivers/gpu/drm/gud/gud_internal.h
@@ -62,6 +62,10 @@ int gud_usb_set_u8(struct gud_device *gdrm, u8 request, u8 val);
 
 void gud_clear_damage(struct gud_device *gdrm);
 void gud_flush_work(struct work_struct *work);
+void gud_crtc_atomic_enable(struct drm_crtc *crtc,
+			    struct drm_atomic_state *state);
+void gud_crtc_atomic_disable(struct drm_crtc *crtc,
+			     struct drm_atomic_state *state);
 int gud_plane_atomic_check(struct drm_plane *plane,
 			   struct drm_atomic_state *state);
 void gud_plane_atomic_update(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index cfd66c879ae40..0d38eecd152da 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -580,6 +580,39 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	return ret;
 }
 
+void gud_crtc_atomic_enable(struct drm_crtc *crtc,
+			    struct drm_atomic_state *state)
+{
+	struct drm_device *drm = crtc->dev;
+	struct gud_device *gdrm = to_gud_device(drm);
+	int idx;
+
+	if (!drm_dev_enter(drm, &idx))
+		return;
+
+	gud_usb_set_u8(gdrm, GUD_REQ_SET_CONTROLLER_ENABLE, 1);
+	gud_usb_set(gdrm, GUD_REQ_SET_STATE_COMMIT, 0, NULL, 0);
+	gud_usb_set_u8(gdrm, GUD_REQ_SET_DISPLAY_ENABLE, 1);
+
+	drm_dev_exit(idx);
+}
+
+void gud_crtc_atomic_disable(struct drm_crtc *crtc,
+			     struct drm_atomic_state *state)
+{
+	struct drm_device *drm = crtc->dev;
+	struct gud_device *gdrm = to_gud_device(drm);
+	int idx;
+
+	if (!drm_dev_enter(drm, &idx))
+		return;
+
+	gud_usb_set_u8(gdrm, GUD_REQ_SET_DISPLAY_ENABLE, 0);
+	gud_usb_set_u8(gdrm, GUD_REQ_SET_CONTROLLER_ENABLE, 0);
+
+	drm_dev_exit(idx);
+}
+
 void gud_plane_atomic_update(struct drm_plane *plane,
 			     struct drm_atomic_state *atomic_state)
 {
@@ -607,24 +640,12 @@ void gud_plane_atomic_update(struct drm_plane *plane,
 		mutex_unlock(&gdrm->damage_lock);
 	}
 
-	if (!drm_dev_enter(drm, &idx))
+	if (!crtc || !drm_dev_enter(drm, &idx))
 		return;
 
-	if (!old_state->fb)
-		gud_usb_set_u8(gdrm, GUD_REQ_SET_CONTROLLER_ENABLE, 1);
-
-	if (fb && (crtc->state->mode_changed || crtc->state->connectors_changed))
-		gud_usb_set(gdrm, GUD_REQ_SET_STATE_COMMIT, 0, NULL, 0);
-
-	if (crtc->state->active_changed)
-		gud_usb_set_u8(gdrm, GUD_REQ_SET_DISPLAY_ENABLE, crtc->state->active);
-
-	if (!fb)
-		goto ctrl_disable;
-
 	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
 	if (ret)
-		goto ctrl_disable;
+		goto out;
 
 	drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage)
@@ -632,9 +653,6 @@ void gud_plane_atomic_update(struct drm_plane *plane,
 
 	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
 
-ctrl_disable:
-	if (!crtc->state->enable)
-		gud_usb_set_u8(gdrm, GUD_REQ_SET_CONTROLLER_ENABLE, 0);
-
+out:
 	drm_dev_exit(idx);
 }
-- 
2.51.0


