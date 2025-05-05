Return-Path: <stable+bounces-140883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5184AAAC62
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F403A55C9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554273C272F;
	Mon,  5 May 2025 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8qtR0Bl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B62F15E7;
	Mon,  5 May 2025 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486725; cv=none; b=QPzmUz74yAOSaoDzmWzdOmZa9jAe50U+V56373BH/ChCxWV+7LvTf+8QpplmyICbN5aW965my+ouGsWh0k/BFy0QLG7q5YlDUuch6xo5ajtS/WRljXap54NBC3/TXnSrOHafi7aR8YzeexKNlInkJ4sA3+k1wkLJQD0RDHM7DB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486725; c=relaxed/simple;
	bh=AMwLWthvcdugZ3TXGjcMNadjnyvWlIX+BQB+Vy2/rJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNy0Qs7UKvwpL0llwGZIL3FkB40CCczjPZtujDyH0NpsW3PoKoy3Z2gC3HIW8uado2WAcqbItJxF0XRWiznR0gkBENMAod5krJxOsQZBkRlqvSTgKdJ6KEZ/g85p5EG9Hk8Gef7FnkJqzcv5AlNfOIGkwAJzkz5NdVUF0hIb6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8qtR0Bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2FEC4CEE4;
	Mon,  5 May 2025 23:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486723;
	bh=AMwLWthvcdugZ3TXGjcMNadjnyvWlIX+BQB+Vy2/rJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8qtR0Bl1t2hee7hLUAWAW1O00ZyBtafB33BQFPJ98tQyWFoX0bFJ7E4pebPZRwnY
	 j47xcAUYiABYlLwT3uTwH2hytKRNmuwbEQSP+IjxdFpa2+Vb6bI6PyItf9ScEduecU
	 bznFBhRrAgePh/vni/gPOcDswgLVZ+CO4nYEpFCc7P30T6366YM8g1iNSTVPbTCj3y
	 d4yJrizmUQW/TH/lf3dpE2etr/0TZxuT59S+bXV9Zzuwjx8cqFZ/7qpumFFwPbCfsi
	 DcmFzhwAOGlMoZWsZNrFiDIehJiZtPYqaQoVKwADK+ykWBtone4ofzTA9+1lCfoANM
	 Cz2nKkdrQdcZg==
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
Subject: [PATCH AUTOSEL 6.1 171/212] drm/amd/display: Initial psr_version with correct setting
Date: Mon,  5 May 2025 19:05:43 -0400
Message-Id: <20250505230624.2692522-171-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 2721842af8067..10672bb90a029 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -267,6 +267,7 @@ static bool create_links(
 		link->link_id.type = OBJECT_TYPE_CONNECTOR;
 		link->link_id.id = CONNECTOR_ID_VIRTUAL;
 		link->link_id.enum_id = ENUM_ID_1;
+		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 		link->link_enc = kzalloc(sizeof(*link->link_enc), GFP_KERNEL);
 
 		if (!link->link_enc) {
-- 
2.39.5


