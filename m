Return-Path: <stable+bounces-64900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4698943BEB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFF5B2393A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB42214A4DE;
	Thu,  1 Aug 2024 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHf3qrqS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F614A4C6;
	Thu,  1 Aug 2024 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471333; cv=none; b=a5CTE0QcjNLo9CX7iNA9ye4SQxUzyvv94ezfMSDUAgp9jjggFTt+IZLze1M2poPVSD3v8GvIJHZxJRRvMdf1h6zp6CRu1rCSoyZKUVPI1Lr2chVgIk+fq0BFvVapoHG2jL04Ii5ouKjv6GC7IN+DKW8gR6DiTl+863YzGzZOh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471333; c=relaxed/simple;
	bh=0TpNNrACWqa3bM5QaUsBF25tZ8stxMvvMpx22jGLU38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/QSwxHvEWJXoGLPPmmVvLim3500a8I+5LWoN5jfERCAe0rjmJZdG/EbExdeIH2NFvQ08MKIF4rXXsBK/Mz2R6Ief9jV7zLp7qTSnoi2Et0oZV2IV4dAvRNzfZeyuVCQkxd+Ehu4UALU5oq/2X5WWj3SqNZ4qeEN/J4N04kagU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHf3qrqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8160C32786;
	Thu,  1 Aug 2024 00:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471333;
	bh=0TpNNrACWqa3bM5QaUsBF25tZ8stxMvvMpx22jGLU38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHf3qrqSn7hz+UxO/Isqw8Fb5hKhyXCHQ3TFlR917bk6qdTtOQJECBggWq4T+/Xvl
	 3XWauJS1Mx3Ff23lfT5H8o+hpyhFAhTvaWt+/1rr4PXvigurMxQOza+FpU4/OAVDgT
	 pmQdr9ofwr8OA9Nc2/cTIP520NkwDlRMf+4Xlwhg5XU/W5f0ZZw1BSWS1OqMLdZIQf
	 ePWFyVIfTXqP/YaNclW9bGiBYIhhOHfjomzf01z4ZfD/2b5L+dpEuYU2gBkSvfJW3k
	 4xP5gViySxh5UXVN9H+uS6ijgf8bI/Qr9NRi0catKPquaY+2SBRXGb2l78fzyzNvdi
	 ontIc1HKp9Fuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wayne Lin <wayne.lin@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
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
	alex.hung@amd.com,
	mwen@igalia.com,
	joshua@froggi.es,
	Roman.Li@amd.com,
	mario.limonciello@amd.com,
	Bhawanpreet.Lakha@amd.com,
	rdunlap@infradead.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 075/121] drm/amd/display: Correct the defined value for AMDGPU_DMUB_NOTIFICATION_MAX
Date: Wed, 31 Jul 2024 20:00:13 -0400
Message-ID: <20240801000834.3930818-75-sashal@kernel.org>
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

From: Wayne Lin <wayne.lin@amd.com>

[ Upstream commit ad28d7c3d989fc5689581664653879d664da76f0 ]

[Why & How]
It actually exposes '6' types in enum dmub_notification_type. Not 5. Using smaller
number to create array dmub_callback & dmub_thread_offload has potential to access
item out of array bound. Fix it.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 09519b7abf67b..5c9d32dff8538 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -50,7 +50,7 @@
 
 #define AMDGPU_DM_MAX_NUM_EDP 2
 
-#define AMDGPU_DMUB_NOTIFICATION_MAX 5
+#define AMDGPU_DMUB_NOTIFICATION_MAX 6
 
 #define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID 0x00001A
 #define AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE 0x40
-- 
2.43.0


