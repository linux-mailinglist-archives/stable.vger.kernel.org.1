Return-Path: <stable+bounces-183648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9E0BC730B
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 04:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CDE3A29FB
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 02:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A6B13957E;
	Thu,  9 Oct 2025 02:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn9uRrKC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922A182D0
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759976299; cv=none; b=dylN+proRDFJ1G+Hpv+9W88MMlKt6+MWq0QEuV7OzMinzskgoqXbaYro+d1owycIxpma/+C3pyqbGqxqJdOISvVAahICWACXjoEai8AjqNx11m+ghdow9uz3OTIbst+tWJ3t+j4LEvQ4/y+8EiP02OGFosV59JW8yXuzy8a5Mjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759976299; c=relaxed/simple;
	bh=yoPP0zAn7en2oS/pwpGca6/EWuK42KOvhHg7GivmrWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1EcjMFIltZSEY/9lEacaVkJWZCNwzXRxnDUwikvFo4eE6VXUj4dyzEyisjl8tErTCEl7mUpjn7q8BgYr83IoGrefsoWd0WHl9Mg1wmXgwGml+PTF7Ddya9dJrF6NSUvwoYdrXftkoPDXLEpCkrlPwECr27wofWTiO4qdN3G4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn9uRrKC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3fa528f127fso377012f8f.1
        for <stable@vger.kernel.org>; Wed, 08 Oct 2025 19:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759976296; x=1760581096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJfaOf0LMlbdtGGDx/Ijf4csp3yPAQB4jZH4m4DLONE=;
        b=Fn9uRrKC9l5gb8iJqXTrBE0Z7JD8cvFf2UMCFH84f5Lg5RD5Ez3LIbikNkYlosid6K
         h4CM5DLr3une2sLGbjyefnu7PyplYDoTewXvoQmJzhvXCa3kAXP/MfznypnRU+OcJ6Ga
         LvWGj8GdXboJPXnSs7DE3SJqRxoft4NKPNHviglRkYOA13EjSRBL47eQCkBI9GhrHfGn
         8kjsOphvBW4Nl4bwIvGJ9ckKB/W8ITBMLPckbzq1hzpd3JFBOwDS1PWavqkpMMKbWrMp
         OwA7V5gQIcL05YMe8eQUU+QaeZ6SdoIGAeet3Xc26VS9rdxX5GKvhHF0EVbAmrwUU69z
         N7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759976296; x=1760581096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJfaOf0LMlbdtGGDx/Ijf4csp3yPAQB4jZH4m4DLONE=;
        b=ZYsbTdM8u+FXevf9h12yU0qhdpNV2u6hGlT8/FtvO/cDQMxEAZQnKfh8fvRMkQ3xpV
         EvHkjYTiDqXez6m9ksTsDVNrQNXd1oUYb+uMXmUM7tnpRJZqKJ6Yx7AEtyy18u1gpD/W
         k53KB7NA5DNJa31Z0rpWretl79O+Y0xOWgF4ru/VSpdXjjMqtBSwGSrqFtcCwVeSPm0j
         fYLWQmdipyUe7cqBNFTBDmMTCBpe45JEKEEfz6Ib4AvBC/T4tUpvgHNzoweQQ6ixKMVy
         cjNK+4y5C8fpzeuIzCDl1EenQhvM4zoy5jnP6tsFAm6RCx/fk/JHVxo1tlqIgbwQLbYM
         oBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvJhYM/2t9+PBSDGZ+JW7MyZxF8PqRpMPn8hkMVvwzwdI97wY9kF1iSaJtR18o8ZZjry9aXUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzubwL5c7uEmTPlLkf9Un2xbtLPqn3nkeEZoK8y4MRbMvtkIHr6
	Ns/D0MeMHodECbnZ7DB8YodO7efzWiRTiUqipobkylaM7BNNSuJIhBAC
X-Gm-Gg: ASbGnctB/o2ba2geCj76oIHPrx6ZH0FzDwaBujFo8TYkL+k+GFzKKGROiHEb6o4THLe
	Ppqo2eV+Y5dWG+YutAxLTGYe4zMyzvw7UQ667NzioQ96D4953kdik3YM4yplIkLLKWts3cDj5u4
	aPC79EkgyLUCqosN9JvbH61EVx3F/RnSBiZPqq+EpRRYZHwhZYV99Y7iO04q/GZp4QHAznWP2RO
	U2DI0Z8Q28WBMk0p6dkz0Qvy8cmIgdMJ6+HVAbWSQZ3XmdX0hEWj2yxCNUx2G8DlcvwAYkdEg/Z
	ZHyKRQI9pUuEkESD/fDeIMTwiLInicxbHr2rrnOjv2zii8vhXJNaRd+IpUdi0WgsSTUWEUs/rlk
	3t2mBYM05cqADBMJpzXHZnCJqIkKfbaYFKEjnPstql7Fuf79fhCGDb3IJjxhtp9Q=
X-Google-Smtp-Source: AGHT+IFDWwCsyIH3udntapEMeZKsjzc8YDWsB8IzrNKOcKADqGXbJI8EsYvL5lJPVkIkMFPSMByYZw==
X-Received: by 2002:a5d:5d13:0:b0:3e9:4ae9:9f1 with SMTP id ffacd0b85a97d-42582a058bfmr6587708f8f.31.1759976296131;
        Wed, 08 Oct 2025 19:18:16 -0700 (PDT)
Received: from ekhafagy-ROG-Strix.. ([41.37.1.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d7f91esm60094215e9.20.2025.10.08.19.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 19:18:15 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@linux.ie,
	daniel@ffwll.ch,
	mario.kleiner.de@gmail.com,
	hersenxs.wu@amd.com,
	Igor.A.Artemiev@mcst.ru,
	nikola.cornij@amd.com,
	srinivasan.shanmugam@amd.com,
	roman.li@amd.com,
	amd-gfx@lists.freedesktop.org,
	eslam.medhat1993@gmail.com,
	Lang Yu <Lang.Yu@amd.com>,
	Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
	Qingqing Zhuo <qingqing.zhuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 5.10.y 1/2] drm/amd/display: Remove redundant safeguards for dmub-srv destroy()
Date: Thu,  9 Oct 2025 05:17:11 +0300
Message-ID: <40a1a37aab140b0b0f444f8435b17dee5eae31f2.1759974167.git.eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1759974167.git.eslam.medhat1993@gmail.com>
References: <cover.1759974167.git.eslam.medhat1993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Li <roman.li@amd.com>

[ Upstream commit 3beac533b8daa18358dabbe5059c417d192b2a93 ]

[Why]
dc_dmub_srv_destroy() has internal null-check and null assignment.
No need to duplicate them externally.

[How]
Remove redundant safeguards.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 45420968e5f1..b698d652d41f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1141,10 +1141,8 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	if (adev->dm.dc)
 		dc_deinit_callbacks(adev->dm.dc);
 #endif
-	if (adev->dm.dc->ctx->dmub_srv) {
-		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
-		adev->dm.dc->ctx->dmub_srv = NULL;
-	}
+
+	dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
 
 	if (adev->dm.dmub_bo)
 		amdgpu_bo_free_kernel(&adev->dm.dmub_bo,
-- 
2.43.0


