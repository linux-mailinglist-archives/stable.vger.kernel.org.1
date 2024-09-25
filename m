Return-Path: <stable+bounces-77291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A26985B7C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FEE1C23F10
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0FE1993AF;
	Wed, 25 Sep 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iszu7F+E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF860199937;
	Wed, 25 Sep 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265007; cv=none; b=G5a2+d4PNB65vE9/zzGW3zxUFhDAHL3CuUJywk+8TOVhDlqNQfU/Ml/GajW1Tx4vNb1x5S/+ZzreRQPecxFNtAxrnhB/uZ3k0NNWL8TfW43sf+/poFuNp8dvxM9so8GFpKetVq2CG35R7HJdEpjUAIXoinWtiXpZ3VT0BgjYOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265007; c=relaxed/simple;
	bh=VJBmzmVZjguK9yZxJVmRm4Om2UlXipfP5VwcfOCKubQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHjReMhb3sERzVslHTGbljC/vqfKstqpQlglDtNaBSCKPVL/fXW0GVjvPJlnbu360FiS6s6fEy3NBd085fSA7pcwh/J6hBmSMF90lyb4fXw15zGtYcgDgfHx9f7m+vzQ48yjzJMk4ICgjYqoKaql8cMS2iiJE9gfzXaxS4VbzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iszu7F+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F23C4CEC3;
	Wed, 25 Sep 2024 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265007;
	bh=VJBmzmVZjguK9yZxJVmRm4Om2UlXipfP5VwcfOCKubQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iszu7F+E9Kj2LV+ozRPIoGfJV9gVIYDqewFlDYCGwXR5w6a8ScIs7yMZgEqX1Mun+
	 CMX55XdOtl8AuhOpGjCHen0uQejqGsyK3S4eH2j8KpwPsM01glFQ5aCSW1KW1wTDlr
	 d6TNWCJhbsBJcxAlX8tptzoqzB+HoU+Dh5bqxjFfKNCx84Xee4SsrL9mx3d2KmAkIs
	 +M/3BtQJM5csFGgE9xpI2WeU/Rycd9paDDoCYiCADHvcEBk4P3DmSdJW3ZHWHtVAYM
	 IpAbS4uAn75AFfvF5ujJh8isHevTFKb1MeZlWeaYxLlZAEGjdepHySPKyV8/Uyh4Ki
	 LuRv93GiP9yqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	wenjing.liu@amd.com,
	sungjoon.kim@amd.com,
	aurabindo.pillai@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 193/244] drm/amd/display: Check stream_status before it is used
Date: Wed, 25 Sep 2024 07:26:54 -0400
Message-ID: <20240925113641.1297102-193-sashal@kernel.org>
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 58a8ee96f84d2c21abb85ad8c22d2bbdf59bd7a9 ]

[WHAT & HOW]
dc_state_get_stream_status can return null, and therefore null must be
checked before stream_status is used.

This fixes 1 NULL_RETURNS issue reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 81fab62ef38eb..9e05d77453ac3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3739,7 +3739,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 				surface_count,
 				stream,
 				context);
-	} else {
+	} else if (stream_status) {
 		build_dmub_cmd_list(dc,
 				srf_updates,
 				surface_count,
-- 
2.43.0


