Return-Path: <stable+bounces-140206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3820BAAA61E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8F716B9C6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E84A28EA6B;
	Mon,  5 May 2025 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/uLCjoX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF928EA63;
	Mon,  5 May 2025 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484338; cv=none; b=d46OcitOaiq/f/8sY6dnPwTnMcPO8iWokXKzXRD8ANAYHpannVQPKJPPOJ3mMZrKh9VyiB0MxKG5Ca8yKstI2CYLFvPdQ1T1Fa0jdvH92oRZJCDv7yHWQvcWrTfteVnaoJAoVFFQ/cd2XbFnTA865T4s7AKArjEHQ03HGeNNBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484338; c=relaxed/simple;
	bh=esuW//bFiVJG0otYdfajTGOZfCOzsvAkrpYLsTeDXAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZBw4MkSQIERUVpgLgefg/T3o5RgLL+u/3ZL2fQ5PvuOl4vD1qcaxzh2vYMf44Nill3nH/oq0nxVyT25OJbOSIyYa+7ARolRZ1KeHQRYAzHl358EWi+MvjPSUAzNrLnKdIO6zFwLvaELPbin0beV+zmStQcHP/Iqh5oez+OEW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/uLCjoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4D0C4CEEE;
	Mon,  5 May 2025 22:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484338;
	bh=esuW//bFiVJG0otYdfajTGOZfCOzsvAkrpYLsTeDXAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/uLCjoXf5y2fbOhRRpxkvOD2WOlQmhjs0r0TT3/chqzMIJ29J3fVn9o1FSV7JFfH
	 cso+UTvYA/ZdNhF5SHcBuhavs9q/5i+EmDQRqJ/961gjal+9HYvamROe3Dr23hm7lO
	 Ej9hjX3V6IwQLY6iXxmQYs32kxtVqH/tBULSxaDTizPpUyazqnVeRWsjzkhkdt+wN2
	 GikIgmg6JI1N2zMSsn09up8+/su8t7tkmOxx9F5NSzAg+eXMn537l3hHgnoaQpeh/G
	 /9hUWKWyDvadb1G2fceNt2+7nWPi50lnZVYYFzwY5xcQxB61d41gftqC53u+KNzb9F
	 XfUdj9ooxnWGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	Jack.Xiao@amd.com,
	Hawking.Zhang@amd.com,
	shaoyun.liu@amd.com,
	Jiadong.Zhu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 458/642] drm/amdgpu/mes11: fix set_hw_resources_1 calculation
Date: Mon,  5 May 2025 18:11:14 -0400
Message-Id: <20250505221419.2672473-458-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 1350dd3691b5f757a948e5b9895d62c422baeb90 ]

It's GPU page size not CPU page size.  In most cases they
are the same, but not always.  This can lead to overallocation
on systems with larger pages.

Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 0f808ffcab943..68bb334393bb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -730,7 +730,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 
 static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 {
-	int size = 128 * PAGE_SIZE;
+	int size = 128 * AMDGPU_GPU_PAGE_SIZE;
 	int ret = 0;
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
-- 
2.39.5


