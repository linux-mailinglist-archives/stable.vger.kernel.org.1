Return-Path: <stable+bounces-94914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499F69D70A5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07933161D39
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E711B3929;
	Sun, 24 Nov 2024 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq4nHtfw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1791B3925;
	Sun, 24 Nov 2024 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455220; cv=none; b=AvvQQIDZWVTwN6/tfcynmJkRbMsfr+fhPL5ws4ZU2lwkGQZ+7c9FflzXX1e8NvZN6Ft388o0BEDkVz8nNXe5IbZ5dB+hqGjbvlXhSKljJggFi6HTf+CkweitoiieBQ9Pe/HVBWMm7n3E/GY7PY7/Q4GdS/upzln0ExWq5i9w7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455220; c=relaxed/simple;
	bh=pUR7LS8rtvBrcO5otHl1s5R7MoMWIs36PNQumxhIOks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oz+rZlEFO8K4gYcocIzPo/1DZdemPi4X6wkxAXEw9GdCuZKCUlNH9nnpFB97kxvk64tytkuPyDMvuXw5zoKGNJ+kRQ/4KOuusyMGolZTzK2pqYsfQ6eiVJes+baOWF3HXFrz5Iw3Gn6MtAb4lP4xmUDj/ukfZvoRVDcLMrPg+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hq4nHtfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9F2C4CECC;
	Sun, 24 Nov 2024 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455220;
	bh=pUR7LS8rtvBrcO5otHl1s5R7MoMWIs36PNQumxhIOks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hq4nHtfwchALs+BgfTkwgwBkuouIoar8Pu4yjVvCQg1jfwOTAuHw0h+usBQtYnLDS
	 nYA3HuA7i7X6E+MT6ofhic7LW8WNLH6hzKSKtlv0FvDGtgBEK0wLOlBvDCIlNtLdQA
	 0JtCFhoQFLlkP7sVz5XOpLXYdbfBMv4Wgi5OTn/yWWvpEn9ATjMI6te8gu22+36nZ8
	 AeWHtjN+STHRfBzPXBfgqLK7zMLtxvIVR3LHHcBUo3kwG38YSKJkw2d+vXwejiVLp3
	 SLNziSh48+GQ8ae3fLh8R7ecD+aAPauDZs3TTKS6YkFrcWSO3jBBgeq69VaVXGRPiJ
	 ZWK2N0ksELXGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 018/107] drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()
Date: Sun, 24 Nov 2024 08:28:38 -0500
Message-ID: <20241124133301.3341829-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

[ Upstream commit a1e2da6a5072f8abe5b0feaa91a5bcd9dc544a04 ]

It is possible, although unlikely, that an integer overflow will occur
when the result of radeon_get_ib_value() is shifted to the left.

Avoid it by casting one of the operands to larger data type (u64).

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/r600_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index 1b2d31c4d77ca..ac77d1246b945 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -2104,7 +2104,7 @@ static int r600_packet3_check(struct radeon_cs_parser *p,
 				return -EINVAL;
 			}
 
-			offset = radeon_get_ib_value(p, idx+1) << 8;
+			offset = (u64)radeon_get_ib_value(p, idx+1) << 8;
 			if (offset != track->vgt_strmout_bo_offset[idx_value]) {
 				DRM_ERROR("bad STRMOUT_BASE_UPDATE, bo offset does not match: 0x%llx, 0x%x\n",
 					  offset, track->vgt_strmout_bo_offset[idx_value]);
-- 
2.43.0


