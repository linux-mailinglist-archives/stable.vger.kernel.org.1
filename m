Return-Path: <stable+bounces-77251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5696F985AFD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9796B1F24FD6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D418A95D;
	Wed, 25 Sep 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUnlj7LE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AA189F3C;
	Wed, 25 Sep 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264800; cv=none; b=p9ojjax5EwIVZWlEgw3OJdj4v4UVRKfK1q07QsRY1/g5f226Nm8uLXYvbH5et9H+HwyKaUFrrlXDiVTNbdIJEalkYZ6C0fj17juSi9CHa0vc/khU+n2QMJN6HRAaLwJ/M62vo7Sf8uuMHKHNWpJfUxZd3KHUtiYJqXb/h2zrStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264800; c=relaxed/simple;
	bh=htlTeJszNSBr+txgmM6ukJitel0z8NzZi/OUCseFMHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGCQRUtjPI5zRKCGE2N9+JtrhzVjgvH0tmLgThPIJZqABAAGDgaObVIyHqytJcfeKT4uUyci9yykl4VLpnH7QrnmBSzNr6CtYaumHRn2l0vXtr4TJAdgP4vtWW5uQS+yZikOliKM8y4clvP043H/0ok9HQJ1Fbb+qBnSbcwdrjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUnlj7LE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBA9C4CEC3;
	Wed, 25 Sep 2024 11:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264800;
	bh=htlTeJszNSBr+txgmM6ukJitel0z8NzZi/OUCseFMHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUnlj7LE84VP8tm2LCtTzKNOa68Es1j5wvZ42EnZIlNtFsSh9PnEWu7WDXkrkIJNY
	 81VHFQv2a+wcSGMuh3xn+x99D4hP26Askmd6PT14H69Rvk6E2opVT+QrY3ItkDD1ig
	 dotCo6zR43TaEAeo4Msy6lcvdSyFlKKNgzMZkbFG1u2AQY7Zo073zokqTOZIELBUBC
	 QUi8t6T/yOLpoCHWOle6OoiiVr8F5DaQtu8YTnJiFb7n7MyJKM2PVmioi55ydTqZFC
	 rPQ5JZ5CF70wBu/BueqbcG3Afpl8xuN2c2m/+1b5dp+CCX5ieg0hIJ0T7IaeetfiMd
	 2AI+2LsZ5Q4Vg==
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
	sarvinde@amd.com,
	wenjing.liu@amd.com,
	nevenko.stupar@amd.com,
	alvin.lee2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 153/244] drm/amd/display: Add NULL check for function pointer in dcn401_set_output_transfer_func
Date: Wed, 25 Sep 2024 07:26:14 -0400
Message-ID: <20240925113641.1297102-153-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit dd340acd42c24a3f28dd22fae6bf38662334264c ]

This commit adds a null check for the set_output_gamma function pointer
in the dcn401_set_output_transfer_func function. Previously,
set_output_gamma was being checked for null, but then it was being
dereferenced without any null check. This could lead to a null pointer
dereference if set_output_gamma is null.

To fix this, we now ensure that set_output_gamma is not null before
dereferencing it. We do this by adding a null check for set_output_gamma
before the call to set_output_gamma.

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
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 537a24ec74c85..7c724cf682840 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -748,7 +748,9 @@ bool dcn401_set_output_transfer_func(struct dc *dc,
 		}
 	}
 
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+
 	return ret;
 }
 
-- 
2.43.0


