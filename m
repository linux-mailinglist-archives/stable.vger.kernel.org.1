Return-Path: <stable+bounces-140632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DA8AAAA36
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B197B5D6F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F5338750A;
	Mon,  5 May 2025 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhTAXk/A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749E2D269C;
	Mon,  5 May 2025 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485527; cv=none; b=goUPobQFQjWOWf3KEX/1yb0OcpmWY8b+B0Mvy9i3NzrdiGxuHFERAoecyGzjntKqoblv0UO9re6oSrY1Ex3P5gtPapcV+F7Ly0mf2Fjow96DMpk+zMz+VxiPDj4mg3TXewndwvpdLnv5wrAx5vpr03fEMd8VxLp/+hbw7dAo9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485527; c=relaxed/simple;
	bh=jYdGDVam+OJmLiRGsR9CWE9SnmZCxqmKRO8I+z9Lg8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxZTbaSiBHq+7rFuh3J6A0fZGTONHwxkYdeZKrJ07JNrvrhIEZuuRJTbN8Cd1ffs51NBJUpkeRxwzWW+EvvBsGoU8Nk0TIEMQCuKjdOR7j9u6oVRi1/2phLat2TrV92WHYnu29637Dbh/lIH2vaKDTIxJjzIqHRtnhY5M3/6kbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhTAXk/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6685BC4CEEE;
	Mon,  5 May 2025 22:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485526;
	bh=jYdGDVam+OJmLiRGsR9CWE9SnmZCxqmKRO8I+z9Lg8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhTAXk/AlZ+u9z+5/BufavFXIb2nK7JkJjHVq/ucQJpAS7HuKkXCL9+JmANU5aXlp
	 uugNLcSnGO7TTMQkYUeGEIzphjc5fPyi+G8aG6OiqzNck0xcO17uZ0OZZb3HKXMy2g
	 RIQQcsKTEDT+wyK1oDTTxnffRAMjalgNHSg9KdU5fvZ5ldqu6txuaKQ3ETS4PW5b/d
	 5cVcbOoAP1GTK/T/jjpugWZzJGTo35SPrZSXjkTKm54xs1J58UzCUf6hC2VFkwGEkS
	 FgYgJnVRCf5HFXgO+herO72IjOik3ZJm5TFB1RabV7C/FZ50Y438TPFLzV4iujsYrJ
	 uOGcqw8rxxYcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@gmail.com,
	simona@ffwll.ch,
	Jack.Xiao@amd.com,
	sunil.khatri@amd.com,
	Hawking.Zhang@amd.com,
	shaoyun.liu@amd.com,
	Jiadong.Zhu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 360/486] drm/amdgpu/mes11: fix set_hw_resources_1 calculation
Date: Mon,  5 May 2025 18:37:16 -0400
Message-Id: <20250505223922.2682012-360-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 7a773fcd7752c..49113df8baefd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -690,7 +690,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 
 static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 {
-	int size = 128 * PAGE_SIZE;
+	int size = 128 * AMDGPU_GPU_PAGE_SIZE;
 	int ret = 0;
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
-- 
2.39.5


