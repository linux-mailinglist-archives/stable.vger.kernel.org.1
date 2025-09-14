Return-Path: <stable+bounces-179565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FC0B5681E
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6070D16343B
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 11:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D5D1DDC08;
	Sun, 14 Sep 2025 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYysgjyL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538431D432D
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850503; cv=none; b=hv3PP6rD3fSYgY0Q5DOPEk8xR9oKr2Q9ft0mc5qv6hwBXa6tvi9mqL1ZddWM+GG0LrbNyXbynLwWMinpQZ1QcoH+BB2LlETu3CWSDu5vYCG7QPt4x8qPibt6DHehtV4eK+F3N8OoN+a0lQdZmP7BL0attNTBx7pv2u8XGvlRQt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850503; c=relaxed/simple;
	bh=PoWsTtHf+01SomzmoJYUvL2uP+tv9MtLOlEncYAYX/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/X6myZIGz7B6vRgy2+Bu5EKIp3ZW2ahAtLsxSIYo5nCHb/CnCynZWwC5qTI/iY+tsj2/jGz+luS9E4qyvCpwz/rj5DJ7kbmZnIJlx9iNR4UgFVqt57eXXWXJrFGHVHYeg4Rhs9iCniri7ZKBn9AV5B9Zo32f/p3StFERTZKQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYysgjyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EEBC4CEFB;
	Sun, 14 Sep 2025 11:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757850502;
	bh=PoWsTtHf+01SomzmoJYUvL2uP+tv9MtLOlEncYAYX/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYysgjyLd1K0xsUDLdq5N3IfILV3BknBQQpUNM0wb2e7g1VCh0Q9P7G4DBrkqL0Mr
	 RfZgCi3R28X2FbEKdK/4oms66E037XcCvNCWggj7bRg+vFVxgT9XZK9KydrESjr2zL
	 7qmwDcemrvfL8325Uc0FtJCJmR391zhivjZqBSH+XV7vC9spG7hFc5D6YpLaYssUQP
	 hekTSgOoHTn2nEQAXOpyvr3zUkxAU2zSWOOA86BthRslaaiOuODZKMFgFbrnVAXiYN
	 qEOjR0DJ7WgC7QavlJohalCuBFNxlWBNjopGDqYAAWqTnpxKaB2VkGoF391aSGG9Bx
	 8boW87wievOXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mario Limonciello (AMD)" <mario.limonciello@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	=?UTF-8?q?Przemys=C5=82aw=20Kopa?= <prz.kopa@gmail.com>,
	Kalvin <hikaph+oss@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/2] drm/amd/display: Drop dm_prepare_suspend() and dm_complete()
Date: Sun, 14 Sep 2025 07:48:18 -0400
Message-ID: <20250914114818.12813-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250914114818.12813-1-sashal@kernel.org>
References: <2025091312-armful-thus-2400@gregkh>
 <20250914114818.12813-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Mario Limonciello (AMD)" <mario.limonciello@amd.com>

[ Upstream commit 60f71f0db7b12f303789ef59949e38ee5838ee8b ]

[Why]
dm_prepare_suspend() was added in commit 50e0bae34fa6b
("drm/amd/display: Add and use new dm_prepare_suspend() callback")
to allow display to turn off earlier in the suspend sequence.

This caused a regression that HDMI audio sometimes didn't work
properly after resume unless audio was playing during suspend.

[How]
Drop dm_prepare_suspend() callback. All code in it will still run
during dm_suspend(). Also drop unnecessary dm_complete() callback.
dm_complete() was used for failed prepare and also for any case
of successful resume.  The code in it already runs in dm_resume().

This change will introduce more time that the display is turned on
during suspend sequence. The compositor can turn it off sooner if
desired.

Cc: Harry Wentland <harry.wentland@amd.com>
Reported-by: Przemysław Kopa <prz.kopa@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/1cea0d56-7739-4ad9-bf8e-c9330faea2bb@kernel.org/T/#m383d9c08397043a271b36c32b64bb80e524e4b0f
Reported-by: Kalvin <hikaph+oss@gmail.com>
Closes: https://github.com/alsa-project/alsa-lib/issues/465
Closes: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4809
Fixes: 50e0bae34fa6b ("drm/amd/display: Add and use new dm_prepare_suspend() callback")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 2fd653b9bb5aacec5d4c421ab290905898fe85a2)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0eaa1574ff288..dd207ef76843f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3124,25 +3124,6 @@ static void dm_destroy_cached_state(struct amdgpu_device *adev)
 	dm->cached_state = NULL;
 }
 
-static void dm_complete(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	dm_destroy_cached_state(adev);
-}
-
-static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (amdgpu_in_reset(adev))
-		return 0;
-
-	WARN_ON(adev->dm.cached_state);
-
-	return dm_cache_state(adev);
-}
-
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3568,10 +3549,8 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.early_fini = amdgpu_dm_early_fini,
 	.hw_init = dm_hw_init,
 	.hw_fini = dm_hw_fini,
-	.prepare_suspend = dm_prepare_suspend,
 	.suspend = dm_suspend,
 	.resume = dm_resume,
-	.complete = dm_complete,
 	.is_idle = dm_is_idle,
 	.wait_for_idle = dm_wait_for_idle,
 	.check_soft_reset = dm_check_soft_reset,
-- 
2.51.0


