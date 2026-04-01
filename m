Return-Path: <stable+bounces-232621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA3WBP1pzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:42:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 694423733B4
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF0FC306174E
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6E91D0DEE;
	Wed,  1 Apr 2026 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxeAPEN7"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF651E47C5
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003974; cv=none; b=r0RNY3As7ApfIBWwPJVg+AxADg1z3tPhgGFX8t6HfEp6uDSDIon2XEHxxk3kKLwGic59y0Sv8Yl6VmB9Emy5xoP8njhnNZEaBBwJEeqOB+TUlQwxZE/iwP9BJjBDud9PlLaoNGAVFIxNBzrb+XFqKy66tVMtOSz3EEkmY/6Tlek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003974; c=relaxed/simple;
	bh=xoYVdTk23TPn6JIaf7yY0qqI000iCFBtQjQUAdfGGDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed5/4Eyt8jOi1cdj50MgleXjLCPAsyZ8b7ii4jJ9xF8l9SNWjNwFu+6HL4iD1/3DW+q4l4vN4VyW41UjPftFYbqb4qYvwI5lV3098IaL2qWC3NV93CgJp2IV8s7O8U4rMVLw5HLA7DKEl9UEGk4eM3P2E8h157UVER7umr+aEwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxeAPEN7; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c56aa62931so3207553eec.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 17:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775003972; x=1775608772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
        b=SxeAPEN7m0UUHHtG0MX5fxi86LFmaL+RIC5yEwq7Gd1M9bqWjYg1TSReKkx/+bh/IQ
         7ZBGl2zPHMyQn3QGsF5d/UjguBjyTn6Ow1fuUP1gLsubJrfx0KyAP9o1Lt/MNTWWqMyo
         zi7GxcTx1lYha1dVqpNtyzTRkwEg53XWZZOUAhARvsrkvggi+Ihj2qyWh6PHXXPN6jMR
         urVKZaeGEJPlxsg7zfa1hVBSdm8QlrrNcX/ghLp2bxoy1CGPCzVq/pGUH9whcH5tiYCR
         yYIRpnKKSpfFmodJo1k9NWsgiKQZRtNrQfIUMevwFfUUG+jFRQZI++KXWAdzr1NvcBYs
         VD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003972; x=1775608772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
        b=B9c6qBZVrEZpW5KjHaL2UdefYrE9Y+0d0tC2mNAvcHsTaSdFWllOrmajZBenBcb5HH
         R19ty8+Cj+FS4XtzJVsV8UKoNIsDlyt9Rj+WXrlXGPUadP3YjkmC+QJG51sbk5nv5h8y
         3iC46TQVv/F/ZuUi7dFTm50YI+mYpFjfSNwqAgZImlgP28ptad8UEsD0MSb5vlXxDSE5
         SDv/nJNOGxNdaniXHe4qncQ0Ez6JWaB90MG4L1mZ/RbaS1uo225Jw3C4fclfACCw9d8J
         O8c2YgaRyP2LttWYfEYXZg4jm1cNrVUbLVhJR3NiZcZQwq7WRrNCVIa+eM7bQoWfDbLr
         nGgg==
X-Gm-Message-State: AOJu0YyzTf7/3qZmPPbXxw1w0lv/PdazPNl/VPseUQOqQ1G337csjqoC
	IQ5LvVIlGOHJdJk8kWwYihSK5ggU0LMNBX42XwMXrcXlD4BZz13BHm01NoFWIGSb
X-Gm-Gg: ATEYQzzHwqD3VARYFMuuG5oZXf2hdFGuFvhQd5GDgucR+qhUj+Q+jDhk2tVdzDq7NQN
	HWMRE6mGvu7kP5UijCblzgc0viF/dgscAQcpD2ULioy5uRsyhBiqeoDtS7X9tsFmg/A7FvaV5H1
	IlnJuQaEPYQcOXazMuJh9THGzH6tGzS+al28h8DExZMV8CvgDChtJP/LMbi6rxTCzOvJ+6xaCWs
	mc5ynMmjGpDhcw1/mwUk+bYe4hnZ7YU+kUqKVZugib7BwnoUPQenQ644O2uiIryZYeRG0+ThGKZ
	8TxlS7rjvwtxtRaWaEsbAbfAS1Sx9bidikZgHZOBisFON6DAJYTZ9yvZarpRbOHC8sZMtzuM9l2
	kwkeOWpgJPjaCzuqwzlkpAOZP6aE6rauJPTEXggywM9xL2pRQpaec/5aSdlUoLJ7oRc88USjiNc
	waZYYEXpjcfWMCr25V3z1RulbvR+4P4b6K4WiMpBJ8/tpcJrRabWvxauw=
X-Received: by 2002:a05:7300:3205:b0:2be:837d:cc4d with SMTP id 5a478bee46e88-2c9309851dfmr1044767eec.5.1775003972186;
        Tue, 31 Mar 2026 17:39:32 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:39:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Eric Yang <Eric.Yang2@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Mauro Rossi <issor.oruam@gmail.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 02/10] drm/amd/amdgpu: disable ASPM in some situations
Date: Tue, 31 Mar 2026 17:39:00 -0700
Message-ID: <20260401003908.3438-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232621-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 694423733B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit c770ef19673fb1defcbde2ee2b91c3c89bfcf164 ]

disable ASPM with some ASICs on some specific platforms.
required from PCIe controller owner.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dbee43c58741..eb3c6bfe2e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -84,6 +84,7 @@
 
 #if IS_ENABLED(CONFIG_X86)
 #include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #endif
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
@@ -1758,6 +1759,35 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
 	return true;
 }
 
+static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 0) ||
+		  amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 1)))
+		return false;
+
+	if (c->x86 == 6 &&
+		adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5) {
+		switch (c->x86_model) {
+		case VFM_MODEL(INTEL_ALDERLAKE):
+		case VFM_MODEL(INTEL_ALDERLAKE_L):
+		case VFM_MODEL(INTEL_RAPTORLAKE):
+		case VFM_MODEL(INTEL_RAPTORLAKE_P):
+		case VFM_MODEL(INTEL_RAPTORLAKE_S):
+			return true;
+		default:
+			return false;
+		}
+	} else {
+		return false;
+	}
+#else
+	return false;
+#endif
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1782,6 +1812,8 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	}
 	if (adev->flags & AMD_IS_APU)
 		return false;
+	if (amdgpu_device_aspm_support_quirk(adev))
+		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-- 
2.53.0


