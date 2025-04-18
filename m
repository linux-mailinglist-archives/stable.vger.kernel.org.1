Return-Path: <stable+bounces-134536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034DA934AA
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 10:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6947B3AC9
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 08:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABC526B2C7;
	Fri, 18 Apr 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="Zlm/WRwQ"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB611FF1A6;
	Fri, 18 Apr 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965105; cv=none; b=uFhLHWi4Z3YU+AyPNNwvI0BbEVks4Loe9zY1sTeB6ltvauko8kFS4ykr9ptbogPPTtTrCZQtqN3FbuydzhpKrLvI9YHYYD0Kdl/ZL7G9IRNWRXWu0SJxijb+IKcUMYSrnU9DGVKBvE8K5bpjUfgyIqKPGYkx8CXeqwK+wrzWmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965105; c=relaxed/simple;
	bh=qgRPG664md7WzPIJokBTw0TpvU/BTuBy3s7oOPxiohk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kAe5bQFj98Z4gqojTBOTernA5M70nVvB2mjrmxS4driEEnu4bIl5lXGwddeZQ8dICh2dxHmySUI1hMBskD18jdxNcZFKoRrYpeEsiA+eLEBXiBWUeMsFAW9OWMLnNxF+PpMZMn9eXxphgU0sc7Kke/k1ZzcnfghNl7TYBW5HVtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=Zlm/WRwQ; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1744965090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Fkkq5isjGMmYO0XquNBWOmOM8h/DO8YafFqbHxC1G8=;
	b=Zlm/WRwQZgiQoeAvLcqEuRclvt0sHh5uh1ff0FcCW1gt3wshdcWkDH373Y/SOJM65upjvy
	aUho3Bb8UsT3uPJjALO/f5wHORbP48iGKaYd+p13s+jA4BX4iYGXAn69S7cakwkC5qohHy
	xok9Lp/LgYjLM/Q53dce59tKgagRVzs=
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
Subject: [PATCH v2] drm/amdgpu: check a user-provided number of BOs in list
Date: Fri, 18 Apr 2025 11:31:27 +0300
Message-ID: <20250418083129.9739-1-arefev@swemel.ru>
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
V1 -> V2:
Set a reasonable limit 'USHRT_MAX' for 'bo_number' it as Christian König <christian.koenig@amd.com> suggested

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 702f6610d024..85f7ee1e085d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -189,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	struct drm_amdgpu_bo_list_entry *info;
 	int r;
 
+	if (!in->bo_number || in->bo_number > USHRT_MAX)
+		return -EINVAL;
+
 	info = kvmalloc_array(in->bo_number, info_size, GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.43.0


