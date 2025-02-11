Return-Path: <stable+bounces-114759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0F6A30041
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F5D7A155A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E41EA7C1;
	Tue, 11 Feb 2025 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfMrsQe7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51001D5ACE;
	Tue, 11 Feb 2025 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237431; cv=none; b=qn3Jv7Wpb1V5tfrSQLk0B4iPa3h3xU0oVxhKtlrlKKQ2+VvemrhlG25JhXv78/mBdulRZ4PtU3MxHmW/qhQPqE0dCy1ziekxSM4HSF5ka6Hasfhhglq6KKZATz7k563YdHNIB6VQss5KNbRi2a9xRaddxQUr1gnxnuIIGmRgqT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237431; c=relaxed/simple;
	bh=CldXpmG6Dc3d/Ou2AorcC3lzQ+3tHThCMCZH/1f+pAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dmd/ENx7WspXL4tNnb4S3QVt4YAw7rNErXZgDA9Bxwf25aeZwAjRID5wY5IwqPahJpUawtAfSpJUmKkbfVEhSgoBaDnZ9ejCZQfhKmqAo8ow9WeTwqrokLPhPNiWutq6EN6QHDGOtRSaK93m4cUM3Uhcd3smC5xaqWglxMY60Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfMrsQe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FEBC4CED1;
	Tue, 11 Feb 2025 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237431;
	bh=CldXpmG6Dc3d/Ou2AorcC3lzQ+3tHThCMCZH/1f+pAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SfMrsQe7E+2kLHUYayfZjB4/RnRqDkws308XePs5db/EYZRqkzXJvDzgIUEGGI4d4
	 +6AZHGsWO29DD3BfHHPDA4TUthLQUiqHPi1x3/DwKJVmqgWRG6ehDmHVVPclUfD2wB
	 vTGwlcMO3228aAdpwI3SDx3ExFg3//AU7ye2w/RZJg+w8X5Wwfqbo4dpt0BlcyBieh
	 eQJsN3BaRIyC3aTrbHqapWhfzv/pzaYUQ/D5CfmD0D+Qmxzc3Sbe98A9K1VJAC3EH5
	 ZvUPTURghDpFyq971kBdCjLhLSGVwW3jXWXY8KkezIaFJmqjLxTis8KpsboJz0kSXq
	 foB7VFvn89umA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tom Chung <chiahsuan.chung@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	robin.chen@amd.com,
	martin.tsai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 15/21] Revert "drm/amd/display: Use HW lock mgr for PSR1"
Date: Mon, 10 Feb 2025 20:29:48 -0500
Message-Id: <20250211012954.4096433-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211012954.4096433-1-sashal@kernel.org>
References: <20250211012954.4096433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
Content-Transfer-Encoding: 8bit

From: Tom Chung <chiahsuan.chung@amd.com>

[ Upstream commit f245b400a223a71d6d5f4c72a2cb9b573a7fc2b6 ]

This reverts commit
a2b5a9956269 ("drm/amd/display: Use HW lock mgr for PSR1")

Because it may cause system hang while connect with two edp panel.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 5bb8b78bf250a..bf636b28e3e16 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -63,8 +63,7 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 
 bool should_use_dmub_lock(struct dc_link *link)
 {
-	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 ||
-	    link->psr_settings.psr_version == DC_PSR_VERSION_1)
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
 
 	if (link->replay_settings.replay_feature_enabled)
-- 
2.39.5


