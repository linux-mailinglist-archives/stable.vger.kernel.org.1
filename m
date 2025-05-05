Return-Path: <stable+bounces-141029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC65DAAAD8C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D73F9A076D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA9630870C;
	Mon,  5 May 2025 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUzB3ejo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93A3B5193;
	Mon,  5 May 2025 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487274; cv=none; b=VQgUmQ01bGEl2hGbu8kcvdqHACAkSgMQDxtZT3mfeFAhhJjKKQqnXcmhMHTQEB7SQzjEhk7kznGRGHYTmlwLTHJp1R62hZoBBLRtU2o5VRUhHcgvzWDNrIqZvTbp/+7RHsZKw6OWVsAYA5tXUhKlpK3Wopu1T9KB4rEJV5OO3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487274; c=relaxed/simple;
	bh=mKK+kMo3FhCUx8xJOzm4dRs6kr/fdph59QCeOBR1W14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBg83vt+TzlyRECr2mnC9B9l9tcZqGJW4JwJGkGWdgStd3VuJ7OQb/+VFHCt8L/2dB9kDDbF3bn3bQkhtwDhRSZNgLehxCPbUkKpY51R3TwPBtVbWB4wroASuz5BhWyvJ5rWO+TmDw0OXVwpB4TTmiOcjwIT6otp9pB4sucfk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUzB3ejo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB77C4CEE4;
	Mon,  5 May 2025 23:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487273;
	bh=mKK+kMo3FhCUx8xJOzm4dRs6kr/fdph59QCeOBR1W14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUzB3ejoeske7VrfczZYMEow3Q9w1rFg1CgNhlWHSbk17t5BjuvWDG30e8O/Szzet
	 ScgNX2Dp5X9J7wSgVrI+anbZBrRKSjSF6LY6sGNwWmXez6+mVvf1d9myyQcJMsZ/mw
	 RkUFoMIAY0NKN74QFVUxXz5zNgSxwtLam5+rWRU28V5tqaOgugGOyofKWpduuD8qwk
	 hL2UUjxz2iKDXASVivDpbHhvJeV5GSZaoeDD3GA9/adC5kpQY025XFnjA8QO+Li73y
	 f4mB/N//e/y6XQl2jjqbS9J38gL2lVwzwx7B9Hb6sIRMgck1iDOXn1FZqGYZ9PChlX
	 jWGx2P8l9Iv2w==
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
Subject: [PATCH AUTOSEL 5.10 092/114] drm/amd/display: Initial psr_version with correct setting
Date: Mon,  5 May 2025 19:17:55 -0400
Message-Id: <20250505231817.2697367-92-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 84fb1377ec934..88a9473ccf531 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -228,6 +228,7 @@ static bool create_links(
 		link->link_id.type = OBJECT_TYPE_CONNECTOR;
 		link->link_id.id = CONNECTOR_ID_VIRTUAL;
 		link->link_id.enum_id = ENUM_ID_1;
+		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 		link->link_enc = kzalloc(sizeof(*link->link_enc), GFP_KERNEL);
 
 		if (!link->link_enc) {
-- 
2.39.5


