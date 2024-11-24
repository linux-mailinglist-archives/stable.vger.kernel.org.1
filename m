Return-Path: <stable+bounces-95271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13AB9D74C4
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE73167ABE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAAB1E7C15;
	Sun, 24 Nov 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPTpUWbC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D381E7C07;
	Sun, 24 Nov 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456556; cv=none; b=GVAYGi8UTlAU33vF19/2C67YBjcrEsyi/FK7EPLUHoiksrunHgyUOTXNI289wBQ4NuvK8vd2c0t45TDL6zHkgQd+WzZHuOKwbr5XhjsSVEh2oSD53IxpmKw2k7Xf23zEBDA0S5WyTH1O9vPS0mrEEu+FJbJPX5fuOLik2SJt3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456556; c=relaxed/simple;
	bh=7XnminQKspFjqUEAhBkobrwD5CFlJGvk3Frp9FRnbE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzyQlQF7Z2D3XMKrWEdCgMg7tVVXSxCzUz4g22L3HlHmDYECYfIXUdw2lO9Nq6t9QURxEXTKs4rwkwdHmV6tcGmO7UbVu5UV6dnqkTwkXu1D44Hif2hssi7ePBUwjwFrQ6p9x4o8mdUQtNhSQ0M+V6gwW4E05Z4TXv61POtdu90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPTpUWbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC0DC4CECC;
	Sun, 24 Nov 2024 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456555;
	bh=7XnminQKspFjqUEAhBkobrwD5CFlJGvk3Frp9FRnbE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPTpUWbCZHsqCsydA53oBJCsMQi+MTFV1hV7HcmIMLpZJD8Am6ofa5AHHcQBgIaCW
	 ZHB3B6QGm0hN+D3ephS4UUvIWW0rdWgAC5WIo66KmED70JKuIl21B72aU3KIe47kYx
	 6ebjvChbFA/QA/Xc8uykMigeZNv+vHjNWRKShLM3hB5Zbudke1OdOYChN884srGBEv
	 rNzooDjKm3H51MtD0tGfMyhTTFJIFk8CQNNU+rckawT++l1ieSWz1VrQ1WZpHkFDpW
	 s0nHckh9HSJbeqVgg3YX6iJAszOZbhe6OZqUkhuhVCgTTo5ra7gdSgZtQ8K22VCTHm
	 v7MqcPiE40qZA==
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
Subject: [PATCH AUTOSEL 5.4 03/28] drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()
Date: Sun, 24 Nov 2024 08:55:03 -0500
Message-ID: <20241124135549.3350700-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index 19c9e86b2aafe..a85470213b27f 100644
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


