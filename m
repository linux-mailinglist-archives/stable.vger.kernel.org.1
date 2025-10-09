Return-Path: <stable+bounces-183649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD877BC730E
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 04:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF44C19E3C63
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 02:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51826195B1A;
	Thu,  9 Oct 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHX5RDfi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318E2182D0
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759976303; cv=none; b=hgD2yA0aI3xb09v5wNKVq41GAyWeop3Hnnp/yCt7uhUxTeFlqLerN3fAp894EMoDq+NB4Sn80IOaccu2r02sGQ9S9Qwp8Vqhcmy7noyuec4rTnL9QBMn96ISMD2n4x8LeYuhXDnfd6NFVXvLevAjZ8YTBlR1yn1JHhTHAm28S7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759976303; c=relaxed/simple;
	bh=fwl4SXcRQ0Iebk1UH3j//gtZfAQmuRT1usIr3DpjXlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgJHyRikOgX4nxOp5bPMGq3AoAzFEFXVrxBaC3AySANNyWWBEtNE79XB/YiLGbGeZp5yhS/VIZq/RGhvLkaEnZX7nU2QlFxjmtgR8t0IIebR1tXyaDImVn0EicF5ef4+fUGLi3Amo89yzuk9QJ7R+dYpHDyOkVnCZa/HDcqAJm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHX5RDfi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso282175f8f.0
        for <stable@vger.kernel.org>; Wed, 08 Oct 2025 19:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759976299; x=1760581099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqgyYd4Mgcg6Fw8yS9ue0bFgfT1RMe7FZ2RNvXUjHH8=;
        b=HHX5RDfiaou7FtOWwfJHjtbykJli/Vm9ZXFikzY1Y9iBY1WQlfUcurB10pNxUmB7IP
         O25CDK4DDSTL6P9AG6ZvCIHYrifWj+Gcx3PZ972gW+xzXptDJDB14hGI8CNFhukrdB/j
         8BVSAkgxlvlYwruW1J4v+JBaKE/7I+e4SeazHz7B1iKs0VLoMiNnGQReDFr4NoIYh7GY
         IRh3jmF/QK8Z5T+HnV/aGHd4kAHu4US1DGqITluWolSYOLKA5G/1Ix7VZtGbAB4JyWrb
         Ysqr5akTRIRe0BwdRIwsStuiT49aGsDV3H0QctF+z3aVAl8URn2k68s1HJeJL2CwmVO1
         hGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759976299; x=1760581099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqgyYd4Mgcg6Fw8yS9ue0bFgfT1RMe7FZ2RNvXUjHH8=;
        b=Wv8NGWJgak78h/LWhdhI7wEZmQHy/VRsAxTOqiCFimJg6vMZUtCIGWl+3P+aPlZGWo
         OA+QPuiB56WW5jf3fEdZ07b0gVim+M50iLY/oo7Fx97o8ze/K7h9MRP7HeHOzxpfov8d
         zuIbLvdFU3WSTBWLWrKKJuJswH6UlKSo3En9QQOG9XA3vZdRNuq332QT+KKhXo65ON5i
         /VLPGKWiq2USR2GisULkDjm0PsvwyTZIT/JukxB0TJYIn76nptY/Ufh5anPRFgMRyviW
         Wz+bDgZGt25SlX+SPcy99eJtXGl+bEpo0G7llbGL3TWWZAH7a0YX/e1obh78XqsHKdT8
         b/fg==
X-Forwarded-Encrypted: i=1; AJvYcCUeEY7H6JH9Qjj3SNcMhgTBeSMIFqPkYqSXpLYZPAqAck8NdmjP1m4ts8JluAuQc2nCM/0+Czc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYT52ppXEgVJmg9HqMj4sOOCkEfcvMwA8o0QOJT7ore1CeUMD2
	0HwiYYBBcBXt54BwIC4cPY9w+SjWjPkeog6pqeno7j8tCh9VO72e01xd
X-Gm-Gg: ASbGncsiIyDTwXcNH4kRQUsWNhbwstS14FmLSKC6tjGHFz/hysMZht/dwDGU9eGSXGU
	jm1MdGNTVHtQVa5+0j/m7IXi6z1amSmIR1jmhCYCz6o0QfCrD0VhaMkF5z2ekYxyUBqahpj5wOo
	p4XDYGV4rLWPYtQ7hEfhNuBOZd+vzlQ0rljzWpBxmfPvkpmL8lJ0RWVp+f1O+qAueXHA3srXPK+
	fBbzk5mFxz/vWKNecXu2DMR3Wb11S79iXNl5SmSrn6alLubKqB/rkZ3hwpPpLykQVeNRU3YeJ4B
	LOTEJSLnPnk6XhU7E1pRVOrhLNOiR45INZW7/RC492ja2xcOymKDmM6OrBxISGOCWK7ltQ/H264
	L5QehQ5QEpj9rYEi3rHneyypFQNqNKh9UJEm8mOO72oZbmAHATHdMmHuN+KBdAog=
X-Google-Smtp-Source: AGHT+IEm5kdnFG09dYVzwvY+GYBWGh2ZZck+203z4lbF02DASvHUzeCJVzSdR5m2k47thehYE31uPA==
X-Received: by 2002:a05:6000:26cc:b0:3dc:1a8c:e878 with SMTP id ffacd0b85a97d-42667177b8emr2951904f8f.18.1759976299330;
        Wed, 08 Oct 2025 19:18:19 -0700 (PDT)
Received: from ekhafagy-ROG-Strix.. ([41.37.1.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d7f91esm60094215e9.20.2025.10.08.19.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 19:18:18 -0700 (PDT)
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
	Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 5.10.y 2/2] drm/amd/display: Fix potential null dereference
Date: Thu,  9 Oct 2025 05:17:12 +0300
Message-ID: <1c15fc3dd25c509faa95cf8805a64c30b62529b2.1759974167.git.eslam.medhat1993@gmail.com>
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

From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

[ Upstream commit 52f1783ff4146344342422c1cd94fcb4ce39b6fe ]

The adev->dm.dc pointer can be NULL and dereferenced in amdgpu_dm_fini()
without checking.

Add a NULL pointer check before calling dc_dmub_srv_destroy().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9a71c7d31734 ("drm/amd/display: Register DMUB service with DC")
Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b698d652d41f..0aa681939b7e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1142,7 +1142,8 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		dc_deinit_callbacks(adev->dm.dc);
 #endif
 
-	dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
+	if (adev->dm.dc)
+		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
 
 	if (adev->dm.dmub_bo)
 		amdgpu_bo_free_kernel(&adev->dm.dmub_bo,
-- 
2.43.0


