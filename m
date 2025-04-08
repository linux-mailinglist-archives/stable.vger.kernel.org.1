Return-Path: <stable+bounces-128862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16353A7F93C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731933ACB08
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5026463C;
	Tue,  8 Apr 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="moaCAWWZ"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA1029D0E;
	Tue,  8 Apr 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103883; cv=none; b=ImjvwEQzZfJIBLvvYvy9cq6YjaeWI9WGw+Cuv2jAny49TDaFaC3wY13QywrLTdTesPg5Aoiw011iPBbjxY+Re5WEhZ5uJH6emoMLg8bzDivcW90XYpVKbJbaZGqwiFnSYux369URD8PGas1oQ2GQzhQGHpyFVfDGGv3AEgcszSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103883; c=relaxed/simple;
	bh=u/xVhUL2P1TIaTkTj6MgSg+nNmISj1VFr25RxwIletE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=asmvutHsH0kluFp+m6+iA54XAeVWM3Gh+Ds6IhypkTlBe9TirpCYfs/DDJDH+Do0rvaKD3ooY3/YXFO1S5kJhDB2YPh7YS3+JKc3edrYkA/SVBL7bQ4xmxNEvukX4Sp42esZVZ6tL1l33qSeLjJX42QzhRoP6B6eA+UpqWg8mI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=moaCAWWZ; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1744103875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1FLiFT+T5gQcR7Vpti1w2BgNdDvjvH7axHcj6poLqfw=;
	b=moaCAWWZ18pXziwG8oX+TkII9D5Ads52zgtbWvMZzDuX39fTOmjHt1GkoXlh4B6BG9OqwM
	p6o3vkxR0o29TanFoIgXefyWW+280xeadbOdDlOFzLYuuzGecmd7yDtWHwwrUs8YxEpDMM
	YaBH8aWZ71hdODC+SzmYFAlLdpdYvTU=
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
	Chunming Zhou <david1.zhou@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: check a user-provided number of BOs in list
Date: Tue,  8 Apr 2025 12:17:53 +0300
Message-ID: <20250408091755.10074-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The user can set any value to the variable ‘bo_number’, via the ioctl
command DRM_IOCTL_AMDGPU_BO_LIST. This will affect the arithmetic
expression ‘in->bo_number * in->bo_info_size’, which is prone to
overflow. Add a valid value check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 964d0fbf6301 ("drm/amdgpu: Allow to create BO lists in CS ioctl v3")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 702f6610d024..dd30d2426ff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -189,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	struct drm_amdgpu_bo_list_entry *info;
 	int r;
 
+	if (!in->bo_number || in->bo_number > UINT_MAX / info_size)
+		return -EINVAL;
+
 	info = kvmalloc_array(in->bo_number, info_size, GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.43.0


