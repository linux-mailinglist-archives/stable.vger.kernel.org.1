Return-Path: <stable+bounces-77234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CB4985AB3
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9C91F21F35
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3633E18E37B;
	Wed, 25 Sep 2024 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIbDcN+l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889117CA14;
	Wed, 25 Sep 2024 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264679; cv=none; b=F98IKc45U8DpGcNTQeqOdfogeV6QepA5Y8p8qHcfkC83SjAb+BLXqzsIBOH+KEpQ1Nc5q1m1nC+z6z7ucvDMDh+pIPhdlytyOiOiIh1qmur8+jqB69HZgzx70ql1wLajZUORp+QItmd1l/VDJ+ZUTXUWhCvbU/Fix7bN8cmknrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264679; c=relaxed/simple;
	bh=tT+SETXuWCvT9G3VOFgOlJSrYHQQBx0uL7dHDqZmRtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgN2c9fwKLDxkXycjOAspdjxOU39ojWyI6SHAeUGquIZCMIpqp44lm8Y/eT1YIbUt3l7l6RPEZDQXZsHkzPjoYnfXxK9W50U6BZD0PNrsNryUlr9PdY7ilaR1u85AuEA4mlfeO1cnbx3lPo1Ev3d1Drkpv5Tdws4z6eHFxHlSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIbDcN+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F06CC4CEC3;
	Wed, 25 Sep 2024 11:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264678;
	bh=tT+SETXuWCvT9G3VOFgOlJSrYHQQBx0uL7dHDqZmRtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIbDcN+lVjbHqp+xGeCnEIzLg5c1P8+wBBbO2PVymJWJHpfRIPQ6cHeSDuJkaO+mi
	 VtsfmptbF5ui9+n7kqLGllr65SkCTsTIjeIn2eKDAekgaOoGHDxTt/D7nlkhElmdFK
	 NAdIpkmGKD4Pte8GIkBTLg9J6kZIihCXEKW7bq80as687QmGSTJgYdlPdwU/5ur/Yq
	 bGE3TSC5bsZE3G1B5SOMGXv6PJ8TSLYAWyQvsJMGAYcpQY5n6HMq/K7Zpedtw4SjOs
	 zazDaBW7I0tpDcHsIVH3R+i6xo91FSioxxPX3sWbHxTVr1Mz/12w3XbXRZBrt27Fmp
	 QBy/MrqTdzW9A==
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
	moadhuri@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 136/244] drm/amd/display: Add null check for head_pipe in dcn201_acquire_free_pipe_for_layer
Date: Wed, 25 Sep 2024 07:25:57 -0400
Message-ID: <20240925113641.1297102-136-sashal@kernel.org>
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

[ Upstream commit f22f4754aaa47d8c59f166ba3042182859e5dff7 ]

This commit addresses a potential null pointer dereference issue in the
`dcn201_acquire_free_pipe_for_layer` function. The issue could occur
when `head_pipe` is null.

The fix adds a check to ensure `head_pipe` is not null before asserting
it. If `head_pipe` is null, the function returns NULL to prevent a
potential null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn201/dcn201_resource.c:1016 dcn201_acquire_free_pipe_for_layer() error: we previously assumed 'head_pipe' could be null (see line 1010)

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
 .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 131d98025bd47..fc54483b91047 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -1007,8 +1007,10 @@ static struct pipe_ctx *dcn201_acquire_free_pipe_for_layer(
 	struct pipe_ctx *head_pipe = resource_get_otg_master_for_stream(res_ctx, opp_head_pipe->stream);
 	struct pipe_ctx *idle_pipe = resource_find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
-	if (!head_pipe)
+	if (!head_pipe) {
 		ASSERT(0);
+		return NULL;
+	}
 
 	if (!idle_pipe)
 		return NULL;
-- 
2.43.0


