Return-Path: <stable+bounces-114795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CACA300A5
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C921886A07
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4361FAC53;
	Tue, 11 Feb 2025 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJlhwGW7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822A1FA165;
	Tue, 11 Feb 2025 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237518; cv=none; b=AhQPp6rhsJJZrjtQznLY9yUHUeHrZSBdv8IKzniZAXn78FrZrN+ut9iQ3bLkdCE+FjnyDSuix0A3s4l5XXFxQu0pVG2H/P6LI7jIdFW9Nk4voP2XUl+4eXtlR4jkdSOKk0RMKBALTmR/7bEtZ5JA8zgf9ru4ghLdCr5ZT124Alk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237518; c=relaxed/simple;
	bh=9xbyoiiCrVaAK6nAs5sT0F6NPRxlRa3Hr5Y2YELtFug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4iaQS2tybSnT2j0MCCgEClnRKzBYmP5AdTP0CjmTmXaDdaakzcfw9AoKsg68kUIPdKnCmCf7d+wc+Aly5kzPf7weSBjTgUXccGF0XJglXnDqlIZHknIm8GmHTn62BUnQ0ClRtWC4l3xOFtnE2V28fW4m1e6v/DKV6KAuN/PLe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJlhwGW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460C9C4CEE5;
	Tue, 11 Feb 2025 01:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237516;
	bh=9xbyoiiCrVaAK6nAs5sT0F6NPRxlRa3Hr5Y2YELtFug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJlhwGW7KXwjdG4rLkI6mgYGMOWoHKfULV+MTwgRjQuVprQQXo20VoV8taLGT/F6H
	 0TLJbGSrfQUavLLRrt1J/UYg1DAtrDPitSG3AEkW4E1w9AgghbfihrEYGZuyMyfj0H
	 4qHGjVTT9OxybqOt5Q9Cgxl5xfDC1sLbwxwsiFhtQFctBwTdWY7JCIgZhgYSPYSBxI
	 9bfqjM6dqBKhmniSVWMEAULgeS7bziLhAwH1dTyMMg38ymRIYvELLGG4KgbC8LyYaT
	 jfP/oB37xBB3mlSKd+KEDfJMTVQ0Jon7IGFW0wsJyGM4CZtyIPbsTiWUCW7ZesJ2sa
	 xGoDJEf3CM4dA==
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
	martin.tsai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 11/15] Revert "drm/amd/display: Use HW lock mgr for PSR1"
Date: Mon, 10 Feb 2025 20:31:31 -0500
Message-Id: <20250211013136.4098219-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013136.4098219-1-sashal@kernel.org>
References: <20250211013136.4098219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.76
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
index f11b071a896f5..2aa0e01a6891b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -63,8 +63,7 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 
 bool should_use_dmub_lock(struct dc_link *link)
 {
-	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 ||
-	    link->psr_settings.psr_version == DC_PSR_VERSION_1)
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
 	return false;
 }
-- 
2.39.5


