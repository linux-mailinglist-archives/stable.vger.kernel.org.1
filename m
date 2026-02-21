Return-Path: <stable+bounces-217619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAtNLVMqmWk6RQMAu9opvQ
	(envelope-from <stable+bounces-217619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 04:45:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3302016C11F
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 04:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8B393047525
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 03:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A8932939C;
	Sat, 21 Feb 2026 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKcl84+V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE662E8B83
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771645466; cv=none; b=TaNJeZ0Qe0KF4+ArvP1IP11Zme9PdmW0DplXqW8BKGuTh52q0ozFbDSPPcZldDqJafEs6Ux6h3TjPoWKjRF8OQfJ83rEJC6dp4AnMv5DqOU+BlOJ5f8G3cpxmU9vAsRtDzC1+8jy/pEFMqcKDxmS/w7/wwrWSjwvCfTsjT/CL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771645466; c=relaxed/simple;
	bh=szFkTr5OZJGdedtsZIzGuBxUq+XZC1VNS8vDJTaTxNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ez35j7g5a6X/9k3rwH+GDDwEhUZ5m28B1P+lDybh2hSpXWG/Ztno0+bRpdZ7Lt9XTQosDbbjlMsWOQfMsnqfLl93yREqy2LRwuxld0Ee/F9DRTNZUPDFeT800a0XPlAIL74f8DrcTUTKCxO0JTJC9Fa4TRqYpQkO2VNWK1sZW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKcl84+V; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82418b0178cso1603709b3a.1
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 19:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771645464; x=1772250264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8mQ/6om80WOoxF8Tb2IxdKJHO+VtjTLYYsstxqzSHM=;
        b=RKcl84+V/WGg+nltbnqh0uvgSCZROhUbQdKYiQnS1xSEWvaI7VAARmhp5oqhEa8Uah
         0SlVNRVrY7VGxMASgtNcdB9JbTgxWeXdNXtpxRwGzTBXW4sko2F/lNluxyiPN+hSPwkJ
         ByyWLs3gWG02AU79cTYJlQo1aGjfMe8wzsE2t75p433BCg+DxZfrDhOXHmjcde3gd4BU
         K2lywhTi96BCbYq782XY5nv7ydpAOxzFW9DoBG87FYcej7EHmSweYFbKrzcSXHyHOJ4J
         z38s0DdXRqpzDYdya1jckiuPMuyRlRJCd7ru8xzVj/q4kc61P4kO0gPJmqUXDH502Xis
         3wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771645464; x=1772250264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8mQ/6om80WOoxF8Tb2IxdKJHO+VtjTLYYsstxqzSHM=;
        b=OB9GE96bMxz7v6+DZ7V9CFIeOLnkwKoy4NeTVNnd/C/g1EHuQhC+XIX9I8KBFhMb6a
         gTj2d8ShzQ+dukrrmFNkl2CQM4YGiNl7K6qdr2UNGUMBkcK50dyh2QnXkTB4ggY1iYI7
         RZQvCQTqZEptIBYvWMKf9D98tS8dtZ8YHTn0TXnCDrsKAGs2Ql4ky+fIhGg65UrXDMuX
         kc1np3HDQWwlN43UbL74/+28p1jyerSCT5d0yYx52lnm3Hrr/npj7FcX4KuezNgL9cvI
         Em/nuzeZjseKVZPnT3ALkHLqvleXRTrX8wFHiyt/FsS+q7M5ZOY9zM3oOMZuQM/BKPqK
         woYw==
X-Gm-Message-State: AOJu0Yw6ZfhosIwA9B4gbc3TdLxcf2SSLdZRiJP/9JRdstZi7sTa8VD+
	9rK5ijb+ZhpoSEbxDt0JrbrfwJcIT0fKzJ/YRiFJysPetQn3jeEOrnNwejYSmg4N
X-Gm-Gg: AZuq6aIP/d2uWNKDFm3l0qDVHCihV5GvnR6PKOwoBPUe2Fx5R1MypIZ97FGss09X4Je
	F8ayQcdftmx/h8BHMe0lLOKlMeiNbzYiljEqHwi6klY5GGvNv78ooGAYOuu3bykpQ8uzjFf+FFi
	+UDQyiZ+ZWHl9k5gF3qkn5BShGDBc0XKiWnrfnmCFv7xZEsz3mrusVTtEAV5ZaQHcc8e6XTjly5
	uSXpkyXRLtcE9Mh79/ncJQ85UaaGKq/M1O7Y0KisZ+swdMMmpsbYKzi2KWupYDm0D1b9jkZSsgZ
	wFHglkbk5HdgAr99+kMm3rmWku9e/VSnd7JYJT8LiwVmnDGLDzzT41lFg34JxRO1h/mbvL2fgNW
	AdOJJiHb+5WWeVC4oc2R9zW4uyrtgD+rnHBbGANwSNL9r7lyPJabF2++WEF52quG+pjNU
X-Received: by 2002:a05:6a00:392a:b0:81f:2b25:ca73 with SMTP id d2e1a72fcca58-826daa021c5mr1721717b3a.38.1771645463914;
        Fri, 20 Feb 2026 19:44:23 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ba11bsm714951b3a.50.2026.02.20.19.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 19:44:23 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org (open list:AMD POWERPLAY AND SWSMU),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] Revert "drm/amd/pm: Disable SCLK switching on Oland with high pixel clocks (v3)"
Date: Fri, 20 Feb 2026 19:44:02 -0800
Message-ID: <20260221034402.69537-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221034402.69537-1-rosenp@gmail.com>
References: <20260221034402.69537-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217619-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 3302016C11F
X-Rspamd-Action: no action

This reverts commit 0bb91bed82d414447f2e56030d918def6383c026.

This commit breaks stable kernels older than 6.18 that are booted with
radeon.si_support=0 amdgpu.si_support=1 amdgpu.dc=1

In 6.17, threre are further commits that are needed to get the DC
codepath in amdgpu for Southern Islands GPUs working but they seem to be
too much of a hastle to backport cleanly. The simplest solution is to
revert this problematic commit

Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 31 ----------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 05eaa06dfa34..c4386c86153b 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3426,14 +3426,12 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 {
 	struct  si_ps *ps = si_get_ps(rps);
 	struct amdgpu_clock_and_voltage_limits *max_limits;
-	struct amdgpu_connector *conn;
 	bool disable_mclk_switching = false;
 	bool disable_sclk_switching = false;
 	u32 mclk, sclk;
 	u16 vddc, vddci, min_vce_voltage = 0;
 	u32 max_sclk_vddc, max_mclk_vddci, max_mclk_vddc;
 	u32 max_sclk = 0, max_mclk = 0;
-	u32 high_pixelclock_count = 0;
 	int i;
 
 	if (adev->asic_type == CHIP_HAINAN) {
@@ -3466,35 +3464,6 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 		}
 	}
 
-	/* We define "high pixelclock" for SI as higher than necessary for 4K 30Hz.
-	 * For example, 4K 60Hz and 1080p 144Hz fall into this category.
-	 * Find number of such displays connected.
-	 */
-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		if (!(adev->pm.dpm.new_active_crtcs & (1 << i)) ||
-			!adev->mode_info.crtcs[i]->enabled)
-			continue;
-
-		conn = to_amdgpu_connector(adev->mode_info.crtcs[i]->connector);
-
-		if (conn->pixelclock_for_modeset > 297000)
-			high_pixelclock_count++;
-	}
-
-	/* These are some ad-hoc fixes to some issues observed with SI GPUs.
-	 * They are necessary because we don't have something like dce_calcs
-	 * for these GPUs to calculate bandwidth requirements.
-	 */
-	if (high_pixelclock_count) {
-		/* On Oland, we observe some flickering when two 4K 60Hz
-		 * displays are connected, possibly because voltage is too low.
-		 * Raise the voltage by requiring a higher SCLK.
-		 * (Voltage cannot be adjusted independently without also SCLK.)
-		 */
-		if (high_pixelclock_count > 1 && adev->asic_type == CHIP_OLAND)
-			disable_sclk_switching = true;
-	}
-
 	if (rps->vce_active) {
 		rps->evclk = adev->pm.dpm.vce_states[adev->pm.dpm.vce_level].evclk;
 		rps->ecclk = adev->pm.dpm.vce_states[adev->pm.dpm.vce_level].ecclk;
-- 
2.53.0


