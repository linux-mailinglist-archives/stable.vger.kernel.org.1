Return-Path: <stable+bounces-43224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9728BF046
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3741F23A3E
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4612A17B;
	Tue,  7 May 2024 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV0sa3NC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D080BFE;
	Tue,  7 May 2024 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122689; cv=none; b=oHQViU466fpbuhoNPDt13Nu1KU0aiJUsCLJf4Z0VKCUaywjsUDTcxBguuqE5Oy8HvV+ifX/RiKFchApL4ob4JxaAfe6j1bzv1m5+IB3zGsEmFinzIEkUS/NAcFMSySJHKSVGg9HQz38RvLvFRGoYPAWNl6Wq64bhJQvLHVnTKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122689; c=relaxed/simple;
	bh=3VRBPRhE5+WRPO2oQI6YrZLGCiA9w3eag9jxGj1zYE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9e1DqwI6nx7kOZ91iTrlnZs0KvtAbK+/wuPRu9BGRJ9XWVYjZTGo4pYVX1B3dxPtZf3slsgyHaYaA6Pa6Xf2TUer4N5Ytm41QT7wAnYIHTjdRoNUtjrYf/H5zYUSzqmPYYcoZi+YuQVptciOp7OL9yUjAmn+dSD3ewraVlF96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV0sa3NC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3BAC2BBFC;
	Tue,  7 May 2024 22:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122689;
	bh=3VRBPRhE5+WRPO2oQI6YrZLGCiA9w3eag9jxGj1zYE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qV0sa3NCgyrX2E6dZIlT7Z8Zjq56Decdnw8aIQntkedWViTcwxWkQbo5GydmGrrKV
	 FMzTzTM8RgStWgs3A2wNPmDK3WFxWnV9VFfn7IhACMQX6pt6AfWYOneJBpXs3gO2cj
	 Zl835KnRGM7ru5MxWtHn5ezql+kU84XJTgtHkYljj7DsFJdOn3A1rD8UXvs2S46WVj
	 MJzWGEbSlZstqVmOc2oPaepjZ9KCUPXVx6hHJX8oE88fiByjOyxkGhODT65IZV63F4
	 s3OjwZI2pQzPWATPR24+412uMowbbNGzkS/lCmFzjo69gXP2qclw+2LoawoAv4eeAM
	 LAib9nXANiwMg==
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
	shaoyun.liu@amd.com,
	jonathan.kim@amd.com,
	guchun.chen@amd.com,
	shashank.sharma@amd.com,
	Tim.Huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 14/23] drm/amdgpu/mes: fix use-after-free issue
Date: Tue,  7 May 2024 18:56:40 -0400
Message-ID: <20240507225725.390306-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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
index da48b6da01072..420e5bc44e306 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1129,6 +1129,7 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 		return;
 
 	amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
+	del_timer_sync(&ring->fence_drv.fallback_timer);
 	amdgpu_ring_fini(ring);
 	kfree(ring);
 }
-- 
2.43.0


