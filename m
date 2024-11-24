Return-Path: <stable+bounces-95099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F939D7340
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CB51649D5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3255721C18E;
	Sun, 24 Nov 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBVCgXWT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B761A9B5D;
	Sun, 24 Nov 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456014; cv=none; b=DS7yPPETi2E6f3tIXn4EcBIsXSEvTXiNc7S6YFU/p/AxO6ypB7eVF+ZhXhCo/kZVExkut4ZYL16fwlIFDHgJ0rYO8fTZ/ZW1KBv+vOUyo/M3NeziTOTGU6wtYbbYTgvpMiTELVO/W6pGW4hjceDlxEoRr5BOGEPDOvk/MMdKVQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456014; c=relaxed/simple;
	bh=eO3m00Z3UyT2yYPSOrZkiKbUamp6g9UCUDM1OHjpmHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEWnsTrjCBJ/OXulWBE58i1L0O2RWl0Ws6uOemr8EA3z64med4fhWM2yKE5xp1RPyu75Ov0WEqgp9/Z3iL+Cx01ujeM7sW3S0rST8US1PFAdOYhAq1T4O2LOKti7Yk5Ksnm6zS9rRfbNq4jEHhzu9f3ngnzcDhDKC5uceOkQEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBVCgXWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFFDC4CED9;
	Sun, 24 Nov 2024 13:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456013;
	bh=eO3m00Z3UyT2yYPSOrZkiKbUamp6g9UCUDM1OHjpmHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBVCgXWT0ML16jHm2gjndE+JP2w+JK7f8TwoZ8sUPMLDpH017cap09IiUR4xeQkJt
	 Z08dObR/XrC4j6A92QgRhzqs5kXPvLX7uNXYWtpCNW6bUDL5btnUrZ6btUK8BHC6UC
	 a01DdwPibSOxgYxCRgxNLJvr+JW7dtH3Q+f/p2xCw053qFpaWfW4Yr9u7ls7aVou0t
	 MoqIJRVdfFUmz9SLRDJ+Pv9mSn0O3W2O3lQ9vrYd18tJ3AUn8JstTTlu/axVTMbgA6
	 vRWuB3fR5DzhQ1F7pD2GbLNAchXn5RZ1dgHQJ0qNd27yd4Pm/8m6PiI6yjqGWGg3HH
	 c8ihJVh8EluPA==
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
Subject: [PATCH AUTOSEL 6.6 09/61] drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()
Date: Sun, 24 Nov 2024 08:44:44 -0500
Message-ID: <20241124134637.3346391-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 6cf54a747749d..780352f794e91 100644
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


