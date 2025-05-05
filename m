Return-Path: <stable+bounces-140785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF32AAAF06
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 084057AECF5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E3272E5A;
	Mon,  5 May 2025 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS569LMC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1975B2E62AF;
	Mon,  5 May 2025 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486255; cv=none; b=Rn4AEV8NqPtubQBKGfPeRysxM15Z5bEccwEQ49QVihfyBWiN60Y6a/2nqt7fkbbkCPmv4WZ8c/v4TYM5XtAAwl9XITbyAwtrPmUGCNkhkNnpSTl5I9wMoolMWj2aSNgSgxOlRFxG3xP/K3coqDwsf/7EOvlSFKBg+xDoeASXvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486255; c=relaxed/simple;
	bh=5SH9z7E0pUu71VPldN4zBz2v3j28Q0uIE5HONI70PM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRpJrb0zxWNCqBAPWW7RGpeXB67cgEX9JGiODOIIj5I7jpAjJnHZnrrL2sTC2gdQgodstqD6fZZKw7sGUsl3KRS2lIB/qcbi6ZprFt/5wmMCAFWEv9rEve5i3RpjLLlHtXwrHylwI0mgFKd1oMQGtIW8PV+90dPZKxUUrzXjo6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS569LMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EDCC4CEE4;
	Mon,  5 May 2025 23:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486253;
	bh=5SH9z7E0pUu71VPldN4zBz2v3j28Q0uIE5HONI70PM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OS569LMCkC03GKoyolnuOOQNBEHIWtk5aTZ8BWZLzydW9wiQCtJh6yXuZ/DnpHXvG
	 xvm8bH4GO/pQVA9ohCQ978Fd8V/xTKcu0hNeQFjb2hwtFCmxUn8B0ZD6ogsaFoN4GO
	 UbvIW7Qwcesm77vyMjnZ7fCSyfzlxGCBGCkLQgrJzx+mSF/UldOUs87OQvElGTJosY
	 mtUWe2BiJFfOLS6HyL1kFl46OrMcw11krqaEk1i5+OwbWaUORy9dHU3UEuc/T0hYSU
	 XCq8avARj8Bp6dd63d3QZz+PTBc1Jse4/c7Vtw5xq2Kmjt0ii5dUj6vHiQS3s3kMU/
	 tsbLY+Ifs9n5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tom Chung <chiahsuan.chung@amd.com>,
	Roman Li <roman.li@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	alex.hung@amd.com,
	alvin.lee2@amd.com,
	aurabindo.pillai@amd.com,
	Austin.Zheng@amd.com,
	Ilya.Bakoulin@amd.com,
	mario.limonciello@amd.com,
	Wayne.Lin@amd.com,
	Josip.Pavic@amd.com,
	dillon.varone@amd.com,
	wenjing.liu@amd.com,
	linux@treblig.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 226/294] drm/amd/display: Initial psr_version with correct setting
Date: Mon,  5 May 2025 18:55:26 -0400
Message-Id: <20250505225634.2688578-226-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Tom Chung <chiahsuan.chung@amd.com>

[ Upstream commit d8c782cac5007e68e7484d420168f12d3490def6 ]

[Why & How]
The initial setting for psr_version is not correct while
create a virtual link.

The default psr_version should be DC_PSR_VERSION_UNSUPPORTED.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c2efe18ceacd0..640d010b52bec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -266,6 +266,7 @@ static bool create_links(
 		link->link_id.type = OBJECT_TYPE_CONNECTOR;
 		link->link_id.id = CONNECTOR_ID_VIRTUAL;
 		link->link_id.enum_id = ENUM_ID_1;
+		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 		link->link_enc = kzalloc(sizeof(*link->link_enc), GFP_KERNEL);
 
 		if (!link->link_enc) {
-- 
2.39.5


