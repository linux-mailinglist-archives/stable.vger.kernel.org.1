Return-Path: <stable+bounces-77473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61B5985D97
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209B21C24F54
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84620125C;
	Wed, 25 Sep 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV1MlJZx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E81B372F;
	Wed, 25 Sep 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265932; cv=none; b=op0fyErzzSi2ssXlLDWDgdkgPrt7UOjVksRgf7llq3gJGWqrJlSxl0Ed0qNTSLuwzIq3e4eZeFvpJoPmk32pQJeBZa72iYV7ogksjqo48XLcq39NOjyjMi3dSXBM4wvGvkser5wXWyRaMZkx74d+8i9xLFPDTZaYABWL1OFPVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265932; c=relaxed/simple;
	bh=XVabsCaCrABStV1BWTRUpEMJT3/7Ga5YyME1c1So2I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9+0E+Xebyall2gMfKSpIPT4tezTh0QTODb1Q4QfANBANdZomdbBHrJrn0dzMuMiUeTQOPFLa45fZRdMujFgHHzLVu02pDTpTArf719+G6TsRwG7a6zEFvqc/Ui/BXvxGQfpuEMS/8KFqu0ASVU+bWTx12uUFF29+KYpoXipOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV1MlJZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB68BC4CECD;
	Wed, 25 Sep 2024 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265931;
	bh=XVabsCaCrABStV1BWTRUpEMJT3/7Ga5YyME1c1So2I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WV1MlJZxzwfxYvaxfDPytMBgGYTJ5BktEs+JZVQszcpp4mgmiDvm7WBjSrsuM9Huk
	 803nrJqr/V6epXcpBiS18j5uKj+XP8fjff1iLr3zDpcwSjeYtLTIZvEVkqEJWvTYdx
	 obxSDfrclYa0amOOyHXx00nzv2+l9A1gYHYKCbQs19fTa7ep3xEagTGYLeXCbpZRe3
	 0TOVTa4+ht093S0tA1vAu0hKKBCeOcLoKZWpKQcmoHauMESYJ2mf/T1Qy+M73AiVfZ
	 nLkh34EX1lGg1Q3dJZ/IkmjBlr9pnKVsaOpf9NqJNOm3EYvDLdpeS5bgslLsqhcMJH
	 kuPNCioXh429Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	alvin.lee2@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com,
	gabe.teeger@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 128/197] drm/amd/display: Handle null 'stream_status' in 'planes_changed_for_existing_stream'
Date: Wed, 25 Sep 2024 07:52:27 -0400
Message-ID: <20240925115823.1303019-128-sashal@kernel.org>
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 8141f21b941710ecebe49220b69822cab3abd23d ]

This commit adds a null check for 'stream_status' in the function
'planes_changed_for_existing_stream'. Previously, the code assumed
'stream_status' could be null, but did not handle the case where it was
actually null. This could lead to a null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:3784 planes_changed_for_existing_stream() error: we previously assumed 'stream_status' could be null (see line 3774)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 786b56e96a816..7462c34793799 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3662,8 +3662,10 @@ static bool planes_changed_for_existing_stream(struct dc_state *context,
 		}
 	}
 
-	if (!stream_status)
+	if (!stream_status) {
 		ASSERT(0);
+		return false;
+	}
 
 	for (i = 0; i < set_count; i++)
 		if (set[i].stream == stream)
-- 
2.43.0


