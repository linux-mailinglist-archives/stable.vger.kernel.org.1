Return-Path: <stable+bounces-64851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5788943ACD
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEB4283AC6
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC8EEAE;
	Thu,  1 Aug 2024 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1Y0O0ep"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BFBF50F;
	Thu,  1 Aug 2024 00:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471107; cv=none; b=j0eN3ZOcDdOyvaZ42u1/BlIXg8gJJ0j3WOSAhMhJUb8Ts5ZmnojQxt8CEsw4Lopet1lxnHCTiZz8AKnmEcDlF0epl7k8zPy0Gtz+NB3jp86fsf0mtqgHyXkJDKTrYetYsG8Ua7Glmd86JBm2NWhYpIQjBBytp5ae5ToPBT0rLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471107; c=relaxed/simple;
	bh=UhPUGOWV4cC+AFWhzXaxUNo0S/bf7kD05SXEQVu0oTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIkZ6Zmk2aA377Z6DCh7RjQlvc7cTqBcSHTk5/vKik0usUj9z2RbN/JnDoerw/1gm8XXjEgPKjCsusUUdTg08yLOwIk+o9EFWcwjooAczqXBw/gUsIQOb+IC7pjwnmUVTLN4t+U9GL44BG9J/XMtlJm/0lnRUYQih9awLKQTru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1Y0O0ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2178BC116B1;
	Thu,  1 Aug 2024 00:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471105;
	bh=UhPUGOWV4cC+AFWhzXaxUNo0S/bf7kD05SXEQVu0oTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1Y0O0ep5I2ECO93eK9mW0kkjPHF7+AtrhDyokKibsWaEgwF5u9/8Zi26cliNI49K
	 FKH9TYPQKnZ3Y1pdT9rdHxL2z56MByHymq/awaNgdKdsST4yFQrR0kb738/jPIV9sv
	 QPngS72atSCgdLUnppYCX+Cq+1Gw9kcmPAAnTqPCIoeCPg9qrn6SkWyJNzWeoKdv25
	 kmbEUBp+jYbuZjhp+S48VNjfzzCfXR1vva7gf6HvcUYFuNo3vsIhx65eYquUCjThCO
	 4MhZuwAgPBLRMHlTPj+fncIdbTM0GC2UNIndJ7O6MpOLogaiu6pIy23ziF7gjyVq92
	 a4jvfFwlQJVsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	martin.leung@amd.com,
	moadhuri@amd.com,
	wayne.lin@amd.com,
	Bhawanpreet.Lakha@amd.com,
	wenjing.liu@amd.com,
	hamza.mahfooz@amd.com,
	mghaddar@amd.com,
	max.tseng@amd.com,
	nicholas.kazlauskas@amd.com,
	charlene.liu@amd.com,
	Qingqing.Zhuo@amd.com,
	ahmed.ahmed@amd.com,
	daniel.miess@amd.com,
	sungkim@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 026/121] drm/amd/display: Release clck_src memory if clk_src_construct fails
Date: Wed, 31 Jul 2024 19:59:24 -0400
Message-ID: <20240801000834.3930818-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 674704a5dabe4a434645fdd11e35437f4e06dfc4 ]

[Why]
Coverity reports RESOURCE_LEAK for some implemenations
of clock_source_create. Do not release memory of clk_src
if contructor fails.

[How]
Free clk_src if contructor fails.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c    | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c    | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c  | 4 ++--
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 1 +
 5 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 56ee45e12b461..a73d3c6ef4258 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -1538,6 +1538,7 @@ struct resource_pool *dce83_create_resource_pool(
 	if (dce83_construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index d4c3e2754f516..5d1801dce2730 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1864,6 +1864,7 @@ static struct clock_source *dcn30_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index ff50f43e4c000..da73e842c55c8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1660,8 +1660,8 @@ static struct clock_source *dcn31_clock_source_create(
 		return &clk_src->base;
 	}
 
-	BREAK_TO_DEBUGGER();
 	kfree(clk_src);
+	BREAK_TO_DEBUGGER();
 	return NULL;
 }
 
@@ -1821,8 +1821,8 @@ static struct clock_source *dcn30_clock_source_create(
 		return &clk_src->base;
 	}
 
-	BREAK_TO_DEBUGGER();
 	kfree(clk_src);
+	BREAK_TO_DEBUGGER();
 	return NULL;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 2df8a742516c8..28c4599076989 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1716,6 +1716,7 @@ static struct clock_source *dcn35_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index ddf9560ab7722..b7bd0f36125a4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1696,6 +1696,7 @@ static struct clock_source *dcn35_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
-- 
2.43.0


