Return-Path: <stable+bounces-230546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDLRHPzFxWmgBgUAu9opvQ
	(envelope-from <stable+bounces-230546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:49:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E06DC33D3C7
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7468E305A894
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1501F359A87;
	Thu, 26 Mar 2026 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPdGROls"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954CA303C83
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568861; cv=none; b=i1sWl4dwhscOebVBkSQsRLlILWuUQL8+dzeOENGHNd/IJwhEMPtF7DoiWp4eYfQSss3A6FFK7BISsmXIzbNs8xZojI6vviGKfRA/bT0Fee+cQlHXUj4fl+bLMDwVtCH0QxJ5AEsl12cwDhlXyNIPpxxvyeiL1o3HkpTiyxkosuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568861; c=relaxed/simple;
	bh=xoYVdTk23TPn6JIaf7yY0qqI000iCFBtQjQUAdfGGDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4q1trxTlSaWEVD11xCt6waBQbRw2QM28fBi1AZXxkJw9UGFgDmP6/fLwKRbh8TzplWaGctFUwsdZGL64vENrQMbJrH4EDJ+JNWKHfBucIYcL0MYAXFsEaK8aExe+HyFkejSPYtDyNN5V7HdJl6L9MqyaW6R/1EyQVKD3DGAb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPdGROls; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so921893b3a.1
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568859; x=1775173659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
        b=KPdGROlsexr77/+/oBXv2kXTVBjYRg7L0KUiLnQ4MkILHxgsqkIaRSuxnZdcG/rbpH
         gCXd+kqbqoQo19rvggGCbvcXFewdWvGc8pyd0Z/BVi8ctMc3JXDIwPHzo+s7XMX/Ykzf
         XrXpL8jQpLgb/lN/ZT44hT1LTSypruAI3KbRE2f49bWtwkGmA2yu3jRff8YEAVmM/b2O
         EAwvfSjNpho4uEtKsJfxFbZZWt8jBrSVDcdM1BjqlMRDVnocRrhbewHPHFPGJDkMj/Mt
         xH3BzISUxSHdIPkanK10mhjjxw7xiwn9Hfom5ci2mvpMwaTMLhJy3yS5L1wk9tKombBq
         RdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568859; x=1775173659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
        b=NblsTGgwmcJeh8ohBDmeWqb42DpBpXO5gL9fdSBsjuQetxII8UPSqpuCvVaE7MNNzV
         6Bgksk+ShPaBYr+K6uacoOWwEWpikS8QbANsUi3BVKcE/J9ou/gFYuUQ7syF1HYf3IWc
         6UvW5C42d0TpwC50LoJLSMsnEZzmsXMsmcY29ppe9rFKbA/rMlrIxZaY6qhRoUVSefBE
         OjWAy9fkqv/CM0GBveG0XS2rny+6dMY9DJkK/QbqaWoD0sM0HaX3el0fbZ5wcYyEXh5o
         CZTd7bAprLi1QAQmSQyN5SuyyhxexGU1QPYrcgjSXGVVwrv6ywwTmM56vcnBHoG4PbYs
         TRng==
X-Gm-Message-State: AOJu0YzRQ+L3gx5h2jo2jq+VlfE5kAECUai2rJ5dEbfV1pitYcDYK5H3
	zbZk4IRe99h275ULiG4a+ifn/OtUjjACEgfiS5UvMvhNuPqdU/wdh8wzpYsb994d
X-Gm-Gg: ATEYQzz0XiJZdV2KFJ+yMT/a0zGYGmEehoplznGRgkgOEUHQRVPbnQzgtAOwaG7+kFx
	F4Ls69Tp6PaQow/CFmULKB7FXK2kLgHpt5HiClgZvnJAIfcZiwVcqfzmbSTF/n4u3+7AeegRHnd
	ZQufOgiSqS+6WngfOkI+J4qCxOZUO977a9rNxYheduo+skizy9lIuS522MYdHYE7SGfR9AfI7Fs
	YtwGX/bRog6/42oXglM6LysqBJw0sZaBx4BuPPAK+f7n8i7VspEGZtD4VIh09V8OJyyfEGkZLAr
	NdQS9rhz/HNyObUBe3QQ0Dp+RH9FlKL+oC40QlQooa1L09FXHYGYG7UJkmZT2nrzncuLaAUEV6j
	7kOCQs3FEIQsEtCGveB7ledO+t032ESykP9cGmIfzAPG3Fge9x38YhHggkTttVHr3CZ61qwgScW
	e39Blk7vUVG8kAICRqjuv87EhNKgkgWXE5+ZJ2R+HDX3JzFeY9NaAvf08=
X-Received: by 2002:a05:6a21:3287:b0:398:9ae9:7112 with SMTP id adf61e73a8af0-39c8781ff90mr479262637.1.1774568859447;
        Thu, 26 Mar 2026 16:47:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:47:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bin Lan <bin.lan.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Eric Yang <Eric.Yang2@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Mauro Rossi <issor.oruam@gmail.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 2/9] drm/amd/amdgpu: disable ASPM in some situations
Date: Thu, 26 Mar 2026 16:47:09 -0700
Message-ID: <20260326234716.16723-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,linux.ie,ffwll.ch,linuxfoundation.org,windriver.com,igalia.com,gmail.com,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-230546-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: E06DC33D3C7
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


