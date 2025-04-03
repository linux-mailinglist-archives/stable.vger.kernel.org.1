Return-Path: <stable+bounces-127992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F7A7ADF1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683F01890500
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796DA296C14;
	Thu,  3 Apr 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwJD2XMx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430325E825;
	Thu,  3 Apr 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707698; cv=none; b=qP2OH5EL9pWgPKN3R+OIFVxVDComOBjgWdgR/JsTHFT8C8yUwZpHboK/0bSAaMdZFeBk3eARxIH6aDQ9uAwFPXh7vQ8TCbhDGbDzWoEfDA1rVW6UpKN8BNzPNSOMOBwfXbd1qzWEGmYBfs36eGX1t+olITJfneRcpQtCq0GfbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707698; c=relaxed/simple;
	bh=kaRu9WvREo0g3PGur8HUiN9Nxn15RedJRMDDs3epyfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfie0tBfHIfM75pk3onfEctSUvNRcmEdYJ5ans6kGFKrWAcoCpZU/HgTjBFkJzLkqSaHszInzCKNzlpZN8M/7ugplTD37GrhzPa5OhGBYo16jJ2k6ukBC07XxTY9vxGUvTmmFnielPDo09s9l9uQ4JAcgBjFkDnm7wFQWDP2oiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwJD2XMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FD5C4CEE9;
	Thu,  3 Apr 2025 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707698;
	bh=kaRu9WvREo0g3PGur8HUiN9Nxn15RedJRMDDs3epyfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwJD2XMxd/hXiONDOXk7ek3P5kT+v6kRxkH3uQ3kFudDBYEZwart4Mv+9pzW1GQW2
	 hCemSLfSKe44G3uapm7av0kvbuyLO2V4MW2wlQUnty7/aEfDnjYPUje+oHX+XyuS7G
	 FZtRbZUgq/BOqp8XDALUn5eXgtu4JfzjtosoBQDFyqDdJ3R7IV6N9djG46LFwqr+6s
	 qDZ9JxXPz5zDaEQSXIF94EwYglIx2LA6QimiGFT8WCEmJ41B7jx/GPApKy5G2320Xm
	 RYfnZDA6wPjF67+Uik98SHDHaBo//6fc3gYC/+FOo+AS+dC6GDMsP4I2qwBvbBZQ21
	 BSk0jkys65jKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@gmail.com,
	simona@ffwll.ch,
	lijo.lazar@amd.com,
	sunil.khatri@amd.com,
	Hawking.Zhang@amd.com,
	Jun.Ma2@amd.com,
	Yunxiang.Li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 37/44] drm/amdgpu: grab an additional reference on the gang fence v2
Date: Thu,  3 Apr 2025 15:13:06 -0400
Message-Id: <20250403191313.2679091-37-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 0d9a95099dcb05b5f4719c830d15bf4fdcad0dc2 ]

We keep the gang submission fence around in adev, make sure that it
stays alive.

v2: fix memory leak on retry

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 018dfccd771ba..fe40bbead6222 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6851,18 +6851,26 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 {
 	struct dma_fence *old = NULL;
 
+	dma_fence_get(gang);
 	do {
 		dma_fence_put(old);
 		old = amdgpu_device_get_gang(adev);
 		if (old == gang)
 			break;
 
-		if (!dma_fence_is_signaled(old))
+		if (!dma_fence_is_signaled(old)) {
+			dma_fence_put(gang);
 			return old;
+		}
 
 	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
 			 old, gang) != old);
 
+	/*
+	 * Drop it once for the exchanged reference in adev and once for the
+	 * thread local reference acquired in amdgpu_device_get_gang().
+	 */
+	dma_fence_put(old);
 	dma_fence_put(old);
 	return NULL;
 }
-- 
2.39.5


