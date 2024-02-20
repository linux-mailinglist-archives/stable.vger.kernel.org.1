Return-Path: <stable+bounces-21183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394C385C784
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8A51C21D1D
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4341F1509BF;
	Tue, 20 Feb 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EG3j6/I9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1C612D7
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463616; cv=none; b=TwBj+RpAUgusbFnmfHGFQ/LYbWI6l8qxZUwUFN1U/AUAsRdbT4cX2DncBBKqcKc6pv2uzdrE40LJytAoJ5JC3Mp1in3k5tP0nMeYRv4ASKak0QEskG/9Jc6jQ8FQyx5vuJ4YLdSTs0EoHFgFjNdhYFCr6LOEwE7p77nKd6hyR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463616; c=relaxed/simple;
	bh=mWs5E7X9FqqKixvWnOWdMsVW4SYoh7sLP2BfN7RgoR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qs0U7LBdRczrKJxEMnj18IcUVQp1bAz1Mic0txlQtvEr9z4I+HD42mUthHWLMX8TAud0nTaRr++mNJs6W0i+TXm+0DCOC6QsC2OXG+8dyTBDu4Oi+s0jqxG0EqTXDFb+f6HLR+v9kdT+t3aO8UQArwOJBH9x/7gTbSXisrqsudU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EG3j6/I9; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-785bdb57dfaso555549685a.1
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 13:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708463613; x=1709068413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFUM0XDK0ZVTj4kCTskFg/BdpgZIKaoWZSjy/zINkgc=;
        b=EG3j6/I9Z5Jm4bWXTV2g1jHigwYYQROjjcSxntOaQrErUExWYCS98lGNVOdmw4Gy0J
         qoPO4LFT5w7rG3NiXbY4eNmlYtuCM34XJmsIQyEUspvbY16fST2ppN5We/PnJEDaBhqc
         uVpveO1qD3KjD64uzp+411zJcD+yP6qGXwCDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463613; x=1709068413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFUM0XDK0ZVTj4kCTskFg/BdpgZIKaoWZSjy/zINkgc=;
        b=OMEc0ThmmJHjRZXfAW8CuoYyCIC4wpXyJS3zGjuKcqB4kpSXyKG+RbgsmIFmai78bz
         iHPNa2qLMm5L9/fimmkWgUoBhrPoO16QcIVHt6vfvDHZ1orbTAv8fKuEjJCoCDmlsSqT
         goeMpkMfmG9CefHyfSDMIXnHSKu3OYfpf2vu/5SHEC1qgP3wfOnxJOhC2RRbI4NXW3AI
         YACTvBR47VHBf1V6ZP2LfKRyMjjy6nZO7QbVwZHNlHbiZ6hH0WPpPoMSdcUCIn9ljBNP
         4N2MOMtXJR8tXEupscqzsz/G01Wd1VkEbTYYJUGn1kvgCsXl2vrUCLQm6pH5Dyg8RkuP
         IPlg==
X-Forwarded-Encrypted: i=1; AJvYcCXcAae+HeWbtgifMWDpOfCBZ3uXA2SALCY2RUJ3EKjHTJfejPapJSCCZ3NPp9mnnSkToD3Dk/VfxkPidrWa3jiMVCqknXcb
X-Gm-Message-State: AOJu0YwOahQ8GgdvmbVdQIXTxMpRB06eRIL8/VY8n2g95sNZ9Ev7T8aI
	Kg81q2h95IuiVG1BcQ/Aw7irh9WV5MIr7VbGbT4tfZe6eich/d5vUtMeWdZTjA==
X-Google-Smtp-Source: AGHT+IGb3TRgQ5pvEKeyUOQD9tS5jn+SqfoEY02pd04BL8Wl35Z1DguYO4ZJspag7M1nm0GQDt/d2Q==
X-Received: by 2002:a05:620a:e8b:b0:787:38a4:7bdd with SMTP id w11-20020a05620a0e8b00b0078738a47bddmr22892813qkm.2.1708463613174;
        Tue, 20 Feb 2024 13:13:33 -0800 (PST)
Received: from kramasub2.cros.corp.google.com ([100.107.108.189])
        by smtp.gmail.com with ESMTPSA id c1-20020a05620a134100b0078726621376sm3701207qkl.118.2024.02.20.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:13:32 -0800 (PST)
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH v1] drivers/i915/intel_bios: Fix parsing backlight BDB data
Date: Tue, 20 Feb 2024 14:12:57 -0700
Message-ID: <20240220141256.v1.1.I0690aa3e96a83a43b3fc33f50395d334b2981826@changeid>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Starting BDB version 239, hdr_dpcd_refresh_timeout is introduced to
backlight BDB data. Commit 700034566d68 ("drm/i915/bios: Define more BDB
contents") updated the backlight BDB data accordingly. This broke the
parsing of backlight BDB data in VBT for versions 236 - 238 (both
inclusive) and hence the backlight controls are not responding on units
with the concerned BDB version.

backlight_control information has been present in backlight BDB data
from at least BDB version 191 onwards, if not before. Hence this patch
extracts the backlight_control information if the block size of
backlight BDB is >= version 191 backlight BDB block size.
Tested on Chromebooks using Jasperlake SoC (reports bdb->version = 236).
Tested on Chromebooks using Raptorlake SoC (reports bdb->version = 251).

Fixes: 700034566d68 ("drm/i915/bios: Define more BDB contents")
Cc: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
---

 drivers/gpu/drm/i915/display/intel_bios.c     | 22 +++++--------------
 drivers/gpu/drm/i915/display/intel_vbt_defs.h |  2 --
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index aa169b0055e97..4ec50903b9e64 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -1041,23 +1041,13 @@ parse_lfp_backlight(struct drm_i915_private *i915,
 
 	panel->vbt.backlight.type = INTEL_BACKLIGHT_DISPLAY_DDI;
 	panel->vbt.backlight.controller = 0;
-	if (i915->display.vbt.version >= 191) {
-		size_t exp_size;
+	if (i915->display.vbt.version >= 191 &&
+	    get_blocksize(backlight_data) >= EXP_BDB_LFP_BL_DATA_SIZE_REV_191) {
+		const struct lfp_backlight_control_method *method;
 
-		if (i915->display.vbt.version >= 236)
-			exp_size = sizeof(struct bdb_lfp_backlight_data);
-		else if (i915->display.vbt.version >= 234)
-			exp_size = EXP_BDB_LFP_BL_DATA_SIZE_REV_234;
-		else
-			exp_size = EXP_BDB_LFP_BL_DATA_SIZE_REV_191;
-
-		if (get_blocksize(backlight_data) >= exp_size) {
-			const struct lfp_backlight_control_method *method;
-
-			method = &backlight_data->backlight_control[panel_type];
-			panel->vbt.backlight.type = method->type;
-			panel->vbt.backlight.controller = method->controller;
-		}
+		method = &backlight_data->backlight_control[panel_type];
+		panel->vbt.backlight.type = method->type;
+		panel->vbt.backlight.controller = method->controller;
 	}
 
 	panel->vbt.backlight.pwm_freq_hz = entry->pwm_freq_hz;
diff --git a/drivers/gpu/drm/i915/display/intel_vbt_defs.h b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
index a9f44abfc9fc2..aeea5635a37ff 100644
--- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
+++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
@@ -899,8 +899,6 @@ struct lfp_brightness_level {
 
 #define EXP_BDB_LFP_BL_DATA_SIZE_REV_191 \
 	offsetof(struct bdb_lfp_backlight_data, brightness_level)
-#define EXP_BDB_LFP_BL_DATA_SIZE_REV_234 \
-	offsetof(struct bdb_lfp_backlight_data, brightness_precision_bits)
 
 struct bdb_lfp_backlight_data {
 	u8 entry_size;
-- 
2.44.0.rc0.258.g7320e95886-goog


