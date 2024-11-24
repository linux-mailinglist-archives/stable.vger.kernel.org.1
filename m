Return-Path: <stable+bounces-95159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A700A9D75CA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1302AC03790
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A2122C5DA;
	Sun, 24 Nov 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF1DU/OU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795522C5D5;
	Sun, 24 Nov 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456206; cv=none; b=a7zZLNoAEozeNzK63L1rUv4HDIsgbnXshYwfT7/Orm7q4x7Sl/prTuWARTnjPcmxMUs7J0zyFSrRqcjyNxeSstkNWNbdhC0VErj5p9709YqlzYRZUhrC9IIZxpcBRkGL6Ll4TppMwRFiqHvBiA0XByCwoTY+bNBfiVTG6acbZ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456206; c=relaxed/simple;
	bh=eO3m00Z3UyT2yYPSOrZkiKbUamp6g9UCUDM1OHjpmHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heJbViVGJ8TvMb0erQeMe/wirhXZqJCGXKWfoqibxBZsc1eqGjI0zpxV6gpAjE0dTOm0DpKqP62bLHZTgikCBVyjG3T6uKkc+XUPiPQkZe1EIEK14Nwfm6wfgOdNvipC+h0E4QX+xCcuVtZq0Gb/RcfJVaJ5STLk+WzEG+DLp9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF1DU/OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DB0C4CED1;
	Sun, 24 Nov 2024 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456205;
	bh=eO3m00Z3UyT2yYPSOrZkiKbUamp6g9UCUDM1OHjpmHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oF1DU/OUp2kovKtxurS+br+BJfP5SSIVa9x/YWFIBZMCnbcjSl84gQbvAKBqMu69w
	 ISgCZ6RiHLhQfX7kn86Kbq+YRWbaN9ElXgFCkn2j6I/esWgi4oj9G2fEjYWIKOD+SL
	 nmfBxSmvo3nYzkgTE6L9eHz9GGQ9hrzvWsXkdSmX5PxESe5hI+MKA4XZL7O7kG/Tlu
	 EJlw0RmjYZuOO5P4pAjJ+jLxTxkIU4cMIYG1NEBOEdfzWWP7cEFPRyFXWuR6A5k9hV
	 2/CiBl76bqPn+b9yX7d6ey63fRh/i9pmpKFmRI+ezLoDwYaWZWUsi72jeCEgJHl6Un
	 R+mPiqjCUR0Bg==
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
Subject: [PATCH AUTOSEL 6.1 08/48] drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()
Date: Sun, 24 Nov 2024 08:48:31 -0500
Message-ID: <20241124134950.3348099-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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


