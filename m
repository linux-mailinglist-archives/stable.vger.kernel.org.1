Return-Path: <stable+bounces-95020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A59D724B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E925164A4C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E062E1F76BD;
	Sun, 24 Nov 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgdEGJ6l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1A1F76B6;
	Sun, 24 Nov 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455701; cv=none; b=qwvZlA+VD9gEP8x9r6z3lwvVG0J3dRkwGbLakk4BuKl4sNjEtaiAyG+zGcho5oYXVm5r9BS3oP9rOeQQ4bVxABecTvLWJzrQQjOGs11DM7khGFvCYHM+Ho+7SWjMUNRwZl3RUARdKirrNfDqLL3KAspQzkWGMqMhTduVR/33d/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455701; c=relaxed/simple;
	bh=eO3m00Z3UyT2yYPSOrZkiKbUamp6g9UCUDM1OHjpmHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYXB3NiJ+9NqdIh7sPrhf5YbhYFyGOofZMJLTb/MYU0xwLCTePG42HLpf2ld9MWogObke277fJ7zovN3o6oHn/L+c0Jzv4m06l2nfvbkK+uzpa09sc0KdHvd16vPyxqgDhNFfll8HAIF1xbGRF8pjhgJ/+gt+ozy+svREV/kSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgdEGJ6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D63C4CECC;
	Sun, 24 Nov 2024 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455701;
	bh=eO3m00Z3UyT2yYPSOrZkiKbUamp6g9UCUDM1OHjpmHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgdEGJ6lE7v7cJYWfhSdpd8819D5AAOvWFGkRFKlYYZg6Kln1zFlT6gH4/myiUpDp
	 NBJyzCAz2SooRlV1f4TTzpu86jpVDGSbLTzWoTc2L9MEvoHC2I16EbkKhRW2c0OhkB
	 GxTbn24mxXnO3CeO82nG3qEUo298/exkoMOJnmMvwb6PtBuiIWrnnC7mLGPWCaH3g/
	 IF6cCql+Tz8wCASGQlS6ze2W6aBUwuv8PThg/Z82nIpQwucmxTDF4GsTOPAyD1u4S+
	 MWxw6bAjndfP9LT6B3hN3uwEfqI7fhHqFFY2EIE+9W0hFdAlfBIoMos/HQzhATKAHQ
	 P5t17PJssZK4A==
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
Subject: [PATCH AUTOSEL 6.11 17/87] drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()
Date: Sun, 24 Nov 2024 08:37:55 -0500
Message-ID: <20241124134102.3344326-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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


