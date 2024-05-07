Return-Path: <stable+bounces-43245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776098BF087
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF4D1F22084
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BB4133414;
	Tue,  7 May 2024 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG00HOiK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556B84DE6;
	Tue,  7 May 2024 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122789; cv=none; b=uSjGR7dMzOuIJEbf+RIGYQSy2w47G23Mv68cW6KhiREHxqChRtmdWJ7jrZO+yg6CeH+jbpXNgducT2MgO6PFioJKW2Nk+NVDbRL6NNEVlfmEkTaO7iHz66xXbEP2wWjkDv2Co4Ix9qYm3EKIk8kbtPWzRcFoFZX9FTo6E7I+OHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122789; c=relaxed/simple;
	bh=994JsZ2ORzzOrr4b8OJfnVZPQBB+pIp7mQm6ehsC1N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZM4BmDgYNN+1bkR9k7ZqPFld4y0LJe4tc9s27Y/QPMmEoJICfk2yZlmU0B+xgHRaGrYW00xeHQo5zJIVI4ebU5HCT773PqgZcv2ztOPVTVonRXsFpgGLJ5K0ug6Dk7MFTVLRF/A9JVI+4/C+J1UUd8yxy8waXbyRSR4GwK2MVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG00HOiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4224C2BBFC;
	Tue,  7 May 2024 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122789;
	bh=994JsZ2ORzzOrr4b8OJfnVZPQBB+pIp7mQm6ehsC1N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hG00HOiKx/xNJm0RU2eZTSdy5bBCrL1Z+pZlsG76OWOe7KpDPllmmRE5p6lQPPjCa
	 aZ8c3XEcRLN+Lkwgs3W5whOKRPCbBJU4BV/w95myBqOhFlT0obPja7lYdwqn0hnmeb
	 nwVMX+l3NL8mNAnRm1l82vvLAHb/7sgf88T5wLnXHu4p7Z1jdRxzklfRS3MHCrM2+R
	 /NhDKMCw9DPZR2T0yUe5bKl2F6tQ/4TvtaXohTpljBoQ/cWHgnj5k7F2Q7QksaJ2ye
	 qA1BlZCZ1q5TFjelVC+FPsawRg2eHsBVvlPD/21ZB87GJ2/4somjYK/LZ2r1pTQarP
	 lFcmXcDFBd4+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Xiao <Jack.Xiao@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Felix.Kuehling@amd.com,
	jonathan.kim@amd.com,
	shaoyun.liu@amd.com,
	guchun.chen@amd.com,
	shashank.sharma@amd.com,
	Tim.Huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 12/19] drm/amdgpu/mes: fix use-after-free issue
Date: Tue,  7 May 2024 18:58:34 -0400
Message-ID: <20240507225910.390914-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Jack Xiao <Jack.Xiao@amd.com>

[ Upstream commit 948255282074d9367e01908b3f5dcf8c10fc9c3d ]

Delete fence fallback timer to fix the ramdom
use-after-free issue.

v2: move to amdgpu_mes.c

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 15c67fa404ff9..c5c55e132af21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1098,6 +1098,7 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 		return;
 
 	amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
+	del_timer_sync(&ring->fence_drv.fallback_timer);
 	amdgpu_ring_fini(ring);
 	kfree(ring);
 }
-- 
2.43.0


