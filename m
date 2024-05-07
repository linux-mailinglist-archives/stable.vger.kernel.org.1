Return-Path: <stable+bounces-43260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AA58BF0F5
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64817B25581
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310613A410;
	Tue,  7 May 2024 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC51onZh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247D86647;
	Tue,  7 May 2024 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122851; cv=none; b=lFUd+PWAm6Hwsnql4N0VI4dCibgYEUnjK1UTkaaaN7YZ7BQ95F1t/OefsgN2cOsn3MflgI4aHT4GThrS+OeaYDGBpoXLqjmSgy2addSbYMUkKgPyTsFw+xa16OPrpioJ5cKvo+wbnzO+mIZpo7GhxYnVYQguYyIZE2rLVMoEU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122851; c=relaxed/simple;
	bh=gT6vzBSmQvR8Ll0RTNNxv+i6F8qd6iJAI3Dt1+JjuTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doY7ubrzJhZijm/1OQd1G5c/iZv1Qq20LKZt1vF1LeVl4mox0exiJJAcYX3fl4/kR6QRex7OAhfl1ZyZf7RBm72OJPd/+7uhrljHQ8fXWdnueDWC73jxTZo+8NsF4sKHeJdheXXSY6x51XIAAvgQFupfo1TDwrDvNzDLOIniwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC51onZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D6BC4AF17;
	Tue,  7 May 2024 23:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122850;
	bh=gT6vzBSmQvR8Ll0RTNNxv+i6F8qd6iJAI3Dt1+JjuTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VC51onZhbs2X7oeHCmfplte639WuEEZYS0gzp7+rYTMj5334oahDehQrtBSXQ/V9j
	 7PRWt9n4zhQCHg1UzUfk90UNGSrakruH+EM1xnkoJN2CXDj2CbckxseshAeZBxBhy3
	 49HYsZCLImdizwJK0EiZyOs+UnQ6fwfCC2j7UrHVq1ZlQxn7ZKr1/faxNwnfx5L9xn
	 6mBXelc2knOkPo5eyaZc+r6ww9cFkX2GB0lI4ErhlpI0bNRt78vSiXAY49Lit+3SDa
	 s/5tpKm3YTJezQ9SyXejBhA0bh0SI+yc2+27Tk+GPvNIKi1S09gJCZbrIp+bkAckCb
	 0vUzni9aCEG0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Kuehling <felix.kuehling@amd.com>,
	Mukul Joshi <mukul.joshi@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Philip.Yang@amd.com,
	Hongkun.Zhang@amd.com,
	Arunpravin.PaneerSelvam@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	Jun.Ma2@amd.com,
	Wang.Beyond@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 07/12] drm/amdgpu: Update BO eviction priorities
Date: Tue,  7 May 2024 19:00:09 -0400
Message-ID: <20240507230031.391436-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230031.391436-1-sashal@kernel.org>
References: <20240507230031.391436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Felix Kuehling <felix.kuehling@amd.com>

[ Upstream commit b0b13d532105e0e682d95214933bb8483a063184 ]

Make SVM BOs more likely to get evicted than other BOs. These BOs
opportunistically use available VRAM, but can fall back relatively
seamlessly to system memory. It also avoids SVM migrations evicting
other, more important BOs as they will evict other SVM allocations
first.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Acked-by: Mukul Joshi <mukul.joshi@amd.com>
Tested-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index cde2fd2f71171..a5adae8b43d47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -585,6 +585,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	else
 		amdgpu_bo_placement_from_domain(bo, bp->domain);
 	if (bp->type == ttm_bo_type_kernel)
+		bo->tbo.priority = 2;
+	else if (!(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE))
 		bo->tbo.priority = 1;
 
 	if (!bp->destroy)
-- 
2.43.0


