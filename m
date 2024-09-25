Return-Path: <stable+bounces-77654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9541B985F8C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D9328C0E2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D9422666A;
	Wed, 25 Sep 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWBFzfsC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA121226640;
	Wed, 25 Sep 2024 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266593; cv=none; b=KJQu1K7Of2ddBpKZzjjVJ/eM/cputv4XPAAmNJZbI41J9Ug/JxSpRnrNz65D6Q9X6xfSQ03RRVRo3sriaGZs8MjIgGuqI7BQyQ+hfDi9sQA3o1t7MGy6FrqNgR2jIT1Znw3PAPdq7woRoqb5WjBLZGuBCV2hADKiI0sXYD6tGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266593; c=relaxed/simple;
	bh=cf9qDgdEYk/R/ji+NoOr2WJVrb+zuFPdv1zpKszURKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4CtgxSnuHRW2dr6IlEKzT9tixbPMbFZbRA986nP/No5fH7YueSfVWprToGGrVoHc/ghjjne7rs++LjErHCxgE/wuGqEbYUiHqbS5Aie8C1U6f+Eq4L72Lq3fPsotekV667MriGb5WoCX8RFnFT5yYsfKLbO4MtmeLihJM+JdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWBFzfsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2E9C4CEC3;
	Wed, 25 Sep 2024 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266593;
	bh=cf9qDgdEYk/R/ji+NoOr2WJVrb+zuFPdv1zpKszURKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWBFzfsCc1uVUvZazrAcJbNNwH5OsoD3Zf7zl8mRHpb6AnYEUdU8nTeaWdys+B/yl
	 i7d48bLGSvhcY1K4X9KMJz3Q5v1QckUjFbz3KFDOQsMaqEglRZZ+9yzMHvIGr37Fzx
	 A8SH8Uwj4bv8vskHdb4CaCN8e2jAtxcErp7icvekGqht0rUWPiIPUBfN36hTbI0RBi
	 g1ieS+sFCEYv650kJSmE/ttBS+anqkTEKCOJcxCKM4J15UiDtjaX2Ex7xU5SJ1r3WU
	 OxnySsImxlTndW+5bB9wqlmGiTboI/H8qNP4M83b70WFLWMRiuXrM8aDVK/+wC59Y2
	 dxW+cZQbStmbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
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
	wenjing.liu@amd.com,
	alvin.lee2@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com,
	aurabindo.pillai@amd.com,
	gabe.teeger@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 107/139] drm/amd/display: Check stream before comparing them
Date: Wed, 25 Sep 2024 08:08:47 -0400
Message-ID: <20240925121137.1307574-107-sashal@kernel.org>
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 35ff747c86767937ee1e0ca987545b7eed7a0810 ]

[WHAT & HOW]
amdgpu_dm can pass a null stream to dc_is_stream_unchanged. It is
necessary to check for null before dereferencing them.

This fixes 1 FORWARD_NULL issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 4b34bc9d4e4be..99fcd39bb15e0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2154,6 +2154,8 @@ static bool are_stream_backends_same(
 bool dc_is_stream_unchanged(
 	struct dc_stream_state *old_stream, struct dc_stream_state *stream)
 {
+	if (!old_stream || !stream)
+		return false;
 
 	if (!are_stream_backends_same(old_stream, stream))
 		return false;
-- 
2.43.0


