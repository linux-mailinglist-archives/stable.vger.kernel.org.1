Return-Path: <stable+bounces-77249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6E9985AEE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF29C2855CA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36013190073;
	Wed, 25 Sep 2024 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzHp9P5h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A1186E39;
	Wed, 25 Sep 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264779; cv=none; b=n3ugkvVwhDC23rtSfcIgGQiKbECG90dF5NxuF0k/DyrWhKLzZa1gNclYoPVIH2hsr6Y7G46ObRh/OuyJWkh1PCxR69qLymzsfvSjYYXK/lssyRLjI8mENUNd87dUWl8WPHI4VoV0SXN/eSkZMnnqU1iwkw2Kwf5a/ZUb3GbB7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264779; c=relaxed/simple;
	bh=JytCpwE5SrfXmnVBZL4CFtCh/V2KHj1wRYRjKSzfJQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnxQp8Vzc4jz4bBQK+4Aj5Y1tr/PX2YGJcYrrkZKuSsbANkVnRFyF2Ta16TtyaG2xz+0atVMt81fdyzPEig5Bdu4jNhv0SwL+M0JpF1a+vXJU3Q6Pbyo2Zn77bva65m+4cUWeggcnUZIpfs+kpEBVZmHv+zRsuYyJDFbb1jQNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzHp9P5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188B0C4CECD;
	Wed, 25 Sep 2024 11:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264778;
	bh=JytCpwE5SrfXmnVBZL4CFtCh/V2KHj1wRYRjKSzfJQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZzHp9P5hAM0c/++OlIhD16nEZO0qhI0Ry1ubzTgcd6YwFGsp7G3/vJBAxV6vPcbvy
	 dOt32ewnNfbWA8QtyOIIx95xIpZhEFKNUQZ/zWqHbU3ME1rDTvte5Q6TsyJyOX0X3N
	 IC0N7wWARXfquWwj7NNr4WG/OTxSS9HhXyPc7Q1r2bOo+1KjKlNlAWMlFfR8jE1miv
	 Uuiu3FiYKvBnYkpqAAImYbIga4PzKOyahqOqWMrw9qnpsiuCky/xTz3Gj4bx8SX81h
	 s1cbLtVUIvCmqKHXXFIl3af0zLXEn3ldiowy9dPGMQ5gF7/91oAJrG93Ljf/OkZ7/6
	 cx3biL61FUbyw==
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
Subject: [PATCH AUTOSEL 6.11 151/244] drm/amd/display: Handle null 'stream_status' in 'planes_changed_for_existing_stream'
Date: Wed, 25 Sep 2024 07:26:12 -0400
Message-ID: <20240925113641.1297102-151-sashal@kernel.org>
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
index bcb5267b5a6bc..67794497457d3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3771,8 +3771,10 @@ static bool planes_changed_for_existing_stream(struct dc_state *context,
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


