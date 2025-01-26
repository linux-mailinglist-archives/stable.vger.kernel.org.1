Return-Path: <stable+bounces-110443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D547AA1C676
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 07:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF0D3A7620
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 06:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A358634A;
	Sun, 26 Jan 2025 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDW/yY3n"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288B7080E;
	Sun, 26 Jan 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737873918; cv=none; b=jJdI/hAnJEVIl8ie/ZlksqjpX0EfYlJslZts7+mfhv1+CENotK8lVqQDi2//kIwB24JK1D6jgh2zBGpvAczVPyyrxSjYAUeH3p/e8iGkbxvJTSuClcMjo72tT2gKGWNXcDLeO++KV0jZ4I8NCAChDPkPfpw3UcV2w8JhAZ5A8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737873918; c=relaxed/simple;
	bh=acnt/doy/5XHj70XEGLItNmI0Vgak6ftbZKRvMcrXTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErxTldtSyOPtLsbUeMRXKgCuPOUzSp/JkeaiIC4z6HjgXjOvggRwiJ5AXY/DjW+tnbYWH0if+FTTNztXlF7P4ip733Mv1yBLNxFh357uiwljme4zbwv+ouEglPU0bmqnYj2xoTqBn8L3tBz097lGxMeUNjzqMlRUU2ZMXl5/sZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDW/yY3n; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2efded08c79so4828436a91.0;
        Sat, 25 Jan 2025 22:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737873914; x=1738478714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FqNaVZFEEca3E3wz8Ju8ZljshuiNP61cQ6d6L0AnGGM=;
        b=JDW/yY3nfatfmNPJTYfZFz2MhdAHwkaPq9SuALNm2B6fxAi9f2/2R+sA8ptdITLQk5
         WD8g4Y4aah8XIRC3dVJKl0Tq+icsJdOb5pbaTbPgI156elh/m0BqQFFiqWkZGYwH+NrN
         TUz0dxZYtnovRcjvR7eEKgx0VFSzbEl5LYDe2mtnOF2bu3rNT/iVzhf4AZ2TvRarDGIt
         htBgfNhWheZlkmYlg73+akN1iT3//3eOwbhG+79FKSaq33oDjGBTNirszw6jGVJX/80o
         zBqJDD4xvSwzYkH9FztHSXcvhxXUGAbId1+GuGpjwQKps1mcbjoMf39UaBdqY11WN+YF
         pofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737873914; x=1738478714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqNaVZFEEca3E3wz8Ju8ZljshuiNP61cQ6d6L0AnGGM=;
        b=piO4mQeGaYLq6Tn5yUlMupDpHs9nhpKTvIytJhYFk7gxwy3wXU6mcg6iRlxYrxzDr8
         tu+FqtwHVTj60Akwfsnl4b+b5Sj2W3n3y2fgoa54B8vPmdHoUeFqZvFDR/RTfGdg/Jy+
         nQtRXOANgQ5+kqorHAqG28hlnTmqKB/Da1o7FkNDB6MBQ+YUlnZaKsVsAl58KuhmwKJl
         rigTJpU6pXrSxjAgrUgZ1wkVKcyz3GmKajUAqdi1DD4NioUqGJhdu3Be4KwrwO7uGrSO
         1zFWuMcD9G1Cgg7F0Dp0sjixlJLdbSCQtzC1LmaCgqN+fSbpphuXKdwa6wZXKqqTkYyS
         m6+g==
X-Forwarded-Encrypted: i=1; AJvYcCUk8f/Ooogpg9Uzs7k3hO7VgVvr9IuC29Wj2Er7lYXyDS52OnBVyfWpVh2DxkfzQG9BnanCu4EnmIKD8+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmfSZur7M8nn+ZzS79rXsUFBbLvJwsAv2uZqYWnpKgwrXN25h
	JVYZZrc+l03Ej/WTH8HJpbVqNRpQwKweALpJl/TiCga/qCcZAIWmkL1+ImpW
X-Gm-Gg: ASbGncvJy/IWoumAXF+7WyZoCoKy1cBBU+SqtWgKua9ncltokmb9APmN1U5l6W3xEuj
	S8rUjfs4Ak2eznnRJa7euYln8G7u13MFnpFHhJId7U+bQn9CNTEq0bnYM2nSUjs43FQTmgZ9vWK
	T0ROeD3AwQYMi0REaSCskqqOy+n+mHIvvqRqJBjxQeZQyE4GkMjck2SX8ZAz02FvGouCNWo2GsP
	QOm7pSBz9cbkj1fyUPPX/7Pjr4QskAXBnzgvw5MMJy9EVYbIz2xMBBd9sNafY207/FjBIRUZ8gD
	vN7GmLxIlsi5IZ/19NsN9xnqhenI
X-Google-Smtp-Source: AGHT+IFg7WVPs9aNmjLP+b1xdMjOuirhgOPLzTaNKIBZZkbsCXo6bvei5V5jnc7lQvWmvL9tsG/2Tg==
X-Received: by 2002:a05:6a00:4505:b0:728:927b:7de2 with SMTP id d2e1a72fcca58-72daf9eba1bmr60305593b3a.8.1737873914435;
        Sat, 25 Jan 2025 22:45:14 -0800 (PST)
Received: from jren-d3.localdomain ([221.222.59.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a761134sm4680916b3a.115.2025.01.25.22.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 22:45:14 -0800 (PST)
From: Imkanmod Khan <imkanmodkhan@gmail.com>
To: stable@vger.kernel.org
Cc: patches@lists.linux.dev,
	n.zhandarovich@fintech.ru,
	alexander.deucher@amd.com,
	wayne.lin@amd.com,
	gregkh@linuxfoundation.org,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Jerry.Zuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	sashal@kernel.org,
	alex.hung@amd.com,
	mario.limonciello@amd.com,
	chiahsuan.chung@amd.com,
	hersenxs.wu@amd.com,
	shenshih@amd.com,
	Nicholas.Kazlauskas@amd.com,
	hanghong.ma@amd.com,
	Imkanmod Khan <imkanmodkhan@gmail.com>
Subject: [PATCH 6.1.y] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Sun, 26 Jan 2025 14:44:58 +0800
Message-ID: <20250126064459.7897-1-imkanmodkhan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 2a3cfb9a24a28da9cc13d2c525a76548865e182c ]

Since 'adev->dm.dc' in amdgpu_dm_fini() might turn out to be NULL
before the call to dc_enable_dmub_notifications(), check
beforehand to ensure there will not be a possible NULL-ptr-deref
there.

Also, since commit 1e88eb1b2c25 ("drm/amd/display: Drop
CONFIG_DRM_AMD_DC_HDCP") there are two separate checks for NULL in
'adev->dm.dc' before dc_deinit_callbacks() and dc_dmub_srv_destroy().
Clean up by combining them all under one 'if'.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 81927e2808be ("drm/amd/display: Support for DMUB AUX")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ To fix CVE-2024-27041, I fix the merge conflict by still using macro
 CONFIG_DRM_AMD_DC_HDCP in the first adev->dm.dc check. ]
Signed-off-by: Imkanmod Khan <imkanmodkhan@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8dc0f70df24f..7b4d44dcb343 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1882,14 +1882,14 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		dc_deinit_callbacks(adev->dm.dc);
 #endif
 
-	if (adev->dm.dc)
+	if (adev->dm.dc) {
 		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
-
-	if (dc_enable_dmub_notifications(adev->dm.dc)) {
-		kfree(adev->dm.dmub_notify);
-		adev->dm.dmub_notify = NULL;
-		destroy_workqueue(adev->dm.delayed_hpd_wq);
-		adev->dm.delayed_hpd_wq = NULL;
+		if (dc_enable_dmub_notifications(adev->dm.dc)) {
+			kfree(adev->dm.dmub_notify);
+			adev->dm.dmub_notify = NULL;
+			destroy_workqueue(adev->dm.delayed_hpd_wq);
+			adev->dm.delayed_hpd_wq = NULL;
+		}
 	}
 
 	if (adev->dm.dmub_bo)
-- 
2.25.1


