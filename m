Return-Path: <stable+bounces-64857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0D943AE9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F99028301C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5FF154429;
	Thu,  1 Aug 2024 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCXSM2hR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDBF50F;
	Thu,  1 Aug 2024 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471147; cv=none; b=dDev+KobRIxbLrlkzO8YVHpcEJxg25AEfY/ztM6AR4P/mhT/FQ/T4zDnluiNdvj0dKOxk+4K6zr2UsbQXkiDgezX9fdZeczfOlu+5iI3ndU2r1zlr8SiE7HSkV7lBnBggtLyImgmu4DZuqWAqhgO/LXax8y1GWrNNPDnseDj+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471147; c=relaxed/simple;
	bh=VNAIyaghLV63LnBCKHJSd9+z8UdUamQ4dVNnI/tG89E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUWNfxg49HOqJ1CIJmJAmDkPPDz0YsSTOT6GCibMPlqV/G0rIdYSAe5CajjbkNUArC/ccIqVkmQH6P147hH/6/6bq5C3LSlyi8e/YAOnGvPcdtozOnYqY/hR6N8Rfx8mYOVknGsqU5oMT1iWRdew/EkQGzThC905ArxLrLLUMvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCXSM2hR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E40C4AF0C;
	Thu,  1 Aug 2024 00:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471147;
	bh=VNAIyaghLV63LnBCKHJSd9+z8UdUamQ4dVNnI/tG89E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCXSM2hRfm3s+xAXrUDvI4hF6yaeoztWPM/hOB4l1l75Uw83eNDXdBzvKSEEK181h
	 CARa8jQQBv0scpBYySHEawjUqE5lpbrj3P6f96RlKkZbvnIceb+wrouvTEPkOSDtZa
	 TOokDcAiTMhZs3Y46D4D/+WFu2lePRH/ZiyUes2mLSmsQYswDVNr64y2kY2KGsENXb
	 o5vrKhvx4ixADgqQldB/HAvonMor5/UQiweK6hS38nXDoyGYGtcHCyx8aK43sJCRH7
	 QU0OaMd8YblX40z3O/kMxr9guHtlZv2hxm7IRUbUfUVYrrRORcCMG9yTQa9mu7Np+d
	 evMjqPoPcoXXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hannes@cmpxchg.org,
	andrealmeid@igalia.com,
	friedrich.vock@gmx.de,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 032/121] drm/amdgpu: Fix out-of-bounds write warning
Date: Wed, 31 Jul 2024 19:59:30 -0400
Message-ID: <20240801000834.3930818-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit be1684930f5262a622d40ce7a6f1423530d87f89 ]

Check the ring type value to fix the out-of-bounds
write warning

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 15c2406564700..ad49cecb20b8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -352,7 +352,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->max_dw = max_dw;
 	ring->hw_prio = hw_prio;
 
-	if (!ring->no_scheduler) {
+	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
-- 
2.43.0


