Return-Path: <stable+bounces-77638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39894985FDB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A8E3B28B58
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2D817E00C;
	Wed, 25 Sep 2024 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLPHCyDH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A74223F0F;
	Wed, 25 Sep 2024 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266543; cv=none; b=BTeV9sm+W9es/40Yg6N4PRsdpYY3werMplfbKu1EfDQVzZy6foCWQDU+ivrBHb+KI8cb9JRFoh+EqCMuMznghn7HgoE4SWfpVsu+ATUnKyTA9ydUxo3Od9BtvrQf6hFv+w4+ZzyLGGB1a6H37LGS8TBfidT/x3XUgVER4Sy0aq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266543; c=relaxed/simple;
	bh=+xT6rDDVtNf1Vv0lcTbElWaZT4Ymn1b56abe/VjLz5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGmDIUxX46bS+bPlRY3prxlbZQ3IRjuROGs9R8NPBDR5hfDpoElTzVwT2b8Nge2DnpQHsOtayf5ImS29LGQMdBJaYvaVPn9nuNF3FSzBOslKwJUxDnbBKIVQDscr0mV28CHDaXHjI7hznGqRQ+EAUmR3GXMob7s0TaMCLzVL9AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLPHCyDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E128C4CEC7;
	Wed, 25 Sep 2024 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266543;
	bh=+xT6rDDVtNf1Vv0lcTbElWaZT4Ymn1b56abe/VjLz5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLPHCyDH6KWypDMvRqZzk0L0ss3LOeDWpH9dysl/zz1XPDHuz/d3F2ivIlioYWXiN
	 3N+QeNXo3JDI6pghqiCioYb26H+464DcIC7TYkEeuZm1ABHM3b8+EH5pT7hH3ZDg+u
	 J++a2EcPILKLxgbabyqG9p4xL8EsfIL736HEqnDKAIul4ufItWzcM4nSgQnn5CgPkO
	 awLbE8L0G5CN1nXExf4vuTke5VCEBWZoMdeD7px1NPDq6nEtseewPaJRxTqWgAAMyZ
	 IoJo7rcJxARt5ok/WcOGa3smCq7+aSeePpBKa11c7pBTA3g3iO6MLh0u4FDJ8ElP/U
	 eGSLM/gee+1jw==
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
Subject: [PATCH AUTOSEL 6.6 091/139] drm/amd/display: Handle null 'stream_status' in 'planes_changed_for_existing_stream'
Date: Wed, 25 Sep 2024 08:08:31 -0400
Message-ID: <20240925121137.1307574-91-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 733e445331ea5..4b34bc9d4e4be 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2877,8 +2877,10 @@ static bool planes_changed_for_existing_stream(struct dc_state *context,
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


