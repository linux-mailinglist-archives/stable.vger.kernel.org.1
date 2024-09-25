Return-Path: <stable+bounces-77522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBFA985E0A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084221C23FF0
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D620AACD;
	Wed, 25 Sep 2024 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NajnH/+J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98A20AAA2;
	Wed, 25 Sep 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266108; cv=none; b=dfYI/NkmnXXiOl+BJCZQbx09W4TUcGdYkIRDFyoCCklhqQz1SbY4qvuVAwtvJih8E6zwiya4FIxBEMk8XQJ88/tI+QyRkQQhGAQoKkUBeZCJ/dCCTesVR11lAQKo8ZVKA785Ggb4uY7drAgZU1gqYgm5JMatUEWhd4NqPnFQl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266108; c=relaxed/simple;
	bh=OB6NENlvZSwTU8nlAMQ/WpdGI0kcmwA0lqhEFOvXgMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7v8lpZYN1CtMB2+V/aoD7LuUHa3Hn78T2kCYOPtHayTOq0/q7s7zUy+X0J2j3t4Tq8AIJH0F7pk0DSbfhynUP4+kMu59EjUESUZoUg/NRtM8lFoI7tCmeQJckexy5PVeEYhIlzOTpMmXJekPjSr1qWZgZC5sLyJftIwEKPCuAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NajnH/+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEFCC4CECE;
	Wed, 25 Sep 2024 12:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266107;
	bh=OB6NENlvZSwTU8nlAMQ/WpdGI0kcmwA0lqhEFOvXgMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NajnH/+JmiBMy5VAgdgw6FXMxUQOkc11CxvDTp0KpPrQbtzIFPNO7i4E5mhaCIlnf
	 8G6Ky593bWXciP1lknTZy8P4g5cbe0myym7NmrPIvhhTVlbloE8L7RQ9CukW8Xp3KR
	 /oZ+PHFDGa1DTgrYvTp/qLuf1xKus0IOP7kzuCgPf4m5oRYCU5H5wpBotaDhFiI652
	 F/38t+9NPMjJEC4PHed+AYn3Rdeo7LUnc4rCquH7TqWRAzexK9v7cue9SpBFyyFIcQ
	 etxIZfBIZVjvgoVGAGTRQDVEVm9Hu3GHtQNBuacovhG3B2uk4eSCUR918rJi/q5jyx
	 2q6hFRK3B+Zlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <tim.huang@amd.com>,
	Jesse Zhang <jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	kevinyang.wang@amd.com,
	Jun.Ma2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 174/197] drm/amd/pm: ensure the fw_info is not null before using it
Date: Wed, 25 Sep 2024 07:53:13 -0400
Message-ID: <20240925115823.1303019-174-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Tim Huang <tim.huang@amd.com>

[ Upstream commit 186fb12e7a7b038c2710ceb2fb74068f1b5d55a4 ]

This resolves the dereference null return value warning
reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 5794b64507bf9..56a2257525806 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1185,6 +1185,8 @@ static int init_overdrive_limits(struct pp_hwmgr *hwmgr,
 	fw_info = smu_atom_get_data_table(hwmgr->adev,
 			 GetIndexIntoMasterTable(DATA, FirmwareInfo),
 			 &size, &frev, &crev);
+	PP_ASSERT_WITH_CODE(fw_info != NULL,
+			    "Missing firmware info!", return -EINVAL);
 
 	if ((fw_info->ucTableFormatRevision == 1)
 	    && (le16_to_cpu(fw_info->usStructureSize) >= sizeof(ATOM_FIRMWARE_INFO_V1_4)))
-- 
2.43.0


