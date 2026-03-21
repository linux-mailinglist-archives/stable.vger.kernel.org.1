Return-Path: <stable+bounces-227658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMl1KIwwvmmqIwMAu9opvQ
	(envelope-from <stable+bounces-227658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:45:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E22E3753
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0802303DD21
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 05:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEBF36654B;
	Sat, 21 Mar 2026 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtOFOYQB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89E364934
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774071916; cv=none; b=dnNbFCWi7o2n1R7ow3BF47XD+c73jOG/a5l8Gu0G5XvIvySSny2eKXQsbZ9RlrY5/vA/5fJeSrcRykS6V3Op3bGLO5uPNFtu2qFv/5Mzm8CqTdeAz3MrfGwUBfo5dUIKGy3j6nnX1QWtPc+pNa118QW2IuVRTJLKs39sYTnDQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774071916; c=relaxed/simple;
	bh=i7nQ2WIpVHkGr58Dz5ea9MVfRGb+mu/aUFRQk/jxX/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNsJmiAWLxY7uNVMa14rD3UfCb9onf3DOAe3g1O3D6a5qKY4zAJHAJO/Fh+sVdEFuP27y/3e1JdfqN50pmQYWUpMs0qEba+YTduzVWCCRBEzvmKOuWLis17yfxaGv00cTihaHBQWEfV/jjxSfhCxpmX9QRo+xbRReOLRzvsik4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtOFOYQB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70c112cb61so1784907a12.0
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 22:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774071914; x=1774676714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+adMGPlhVk0bbFqFiUYYCeP0eNPb1PCXZHc4YqFFXSQ=;
        b=PtOFOYQBqPllLweqqvRgJvYYrEgzytUmksnJwKFEi3GXuWkp/nyLDwsHN/f1HyEMp2
         NY41rbRY3XJwP4Ed0/ZBdDD5VXey15TI3he1Hk/61QYhrfAoWXwRH+8uyS7L7Mbz0nKZ
         fJTIK4VE+D0r1Nrha5EpDSy1JrBc7G8EYhtWBxmZdoFWTUAwmhMyBTOngzKvsIrxM8LM
         jHkCwLQ60APIfO+ipe+R6gXzb7URWg1BE/7m4U6KlIs/mBSqaT34HT0FAAc29XrzJO3T
         gDHq3IKRUYRijl5y2aEOWDxVHk0SNOlk4vOt+mdapC6o1amyQHTJeMlQkbgO1ePJb5Ec
         9Qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774071914; x=1774676714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+adMGPlhVk0bbFqFiUYYCeP0eNPb1PCXZHc4YqFFXSQ=;
        b=qUm/jEGec9IkaSP7gw0Pjny1fyIidl9Pmh7hEO67EQWHMn5/NqLSmXf7WICYlXAdmz
         5xLuEzMER8JJeoqbiZ+if0z2DJIrIQP0V4lH6QrpXZ/iDtYzQxMzeOrN2KkJZXTMm/Qe
         +Gc+7PNj0oEeUvL98cNTDmdlE8syQg6owhImmFHMtVuRdPnihMtATOsnEzWZ/1X0QW05
         YrCs+FogoDNQ+9qR6pUcG9C/ahL2dOK7Y/tISMHIZFuZQurh8a1aET0XEaZKzjTG9Xxn
         JxyEnNsW3vgGkh04BclPBJyeKluABK9W1R3zGjuPII6nNcn4kAfUMSMl4tICc3tqNyZF
         STRg==
X-Gm-Message-State: AOJu0Yys7mnffX/HVal1W89Jsjx65Q26WE8dm/feZTCJPPPWNtSJu2hr
	m6RN9k2suQUujrhRSxShDk2OMfXXoD4m0ZWwP8EbrkqmxfMEdlqUPT03Xpph9aRw
X-Gm-Gg: ATEYQzzPIaIwJKlV4BVr6MlzjGQqaeJEDMjM35FSRMjrLcUSGIqZCPgg2W74vr7c1gR
	KimULSA3j3ra6qF8cLkwTjrezYAfS1nV+ye/43bmV0EtTtZ/cDkWrC27mQPAnupIEcvzYbBiRPj
	ImIOv04jJYLCc8lTOJqwphZMx71yWzyJkO06gMut8O1sgb8PJKBtzw4MBJpFDAWtz8V8AZTeEv8
	u2xiJlZYgFnGhyfe+g7ox16TaXSN3BN7DTM6qPLigSkinrYC5IXLbH27XBLkK0peEpJm+HklOb/
	3/B5d9eCGolYCnW5QqMQRtNPs+4yEpohjmO/PnngGO4wS9lZZnXcIkM/Pp0jX+NQXAU/QN3W+rM
	12iY4woLImy8utgFJWPqUmjneeZmkHILtChhF5WeunX3MgzwjvtMYIATiLUoyCrZbh08Nb+qqIM
	JT5VBM/N3Y9M5WEjAsdN3y794oHYDYpIEEszjWrA8Kv2hiyJDiCeb6FQQ=
X-Received: by 2002:a05:6a20:9146:b0:398:8bd7:4f80 with SMTP id adf61e73a8af0-39bcec0692amr4985522637.46.1774071914235;
        Fri, 20 Mar 2026 22:45:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm4338783b3a.37.2026.03.20.22.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:45:13 -0700 (PDT)
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
Subject: [PATCHv3 for 6.1 1/4] drm/amdgpu: use proper DC check in amdgpu_display_supported_domains()
Date: Fri, 20 Mar 2026 22:44:50 -0700
Message-ID: <20260321054453.19683-2-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-227658-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 0F1E22E3753
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 96ce96f8773da4814622fd97e5226915a2c30706 ]

amdgpu_device_asic_has_dc_support() just checks the asic itself.
amdgpu_device_has_dc_support() is a runtime check which not
only checks the asic, but also other things in the driver
like whether virtual display is enabled.  We want the latter
here.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index cd0bccc95205..98cce09684f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -534,7 +534,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type) &&
+	    amdgpu_device_has_dc_support(adev) &&
 	    adev->mode_info.gpu_vm_support)
 		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif
--
2.53.0


