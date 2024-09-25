Return-Path: <stable+bounces-77280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6F1985B65
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE581C23CFE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078A193073;
	Wed, 25 Sep 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD4+pg7F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CAF155742;
	Wed, 25 Sep 2024 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264929; cv=none; b=hDpr2L+YRDWhGOdLPoZcmB4JqgQYd1HGXj1QoLqFpx6L+o+sbv+p+GQhgxmFq+M+jV4X411JE5x2Sxay9RpFD/4viBGXo04Je59+vd1JoRlP35rrhAVIVe+vdIHRuIcrBvIBEDbBuZP/2F16c0LEoRqKLTzoTKwrm2YgG6XMOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264929; c=relaxed/simple;
	bh=55nMLxx/UZJ2uaNMpAgm4Di+rgIcbZp2i9kYD6oDQ3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvjmdwaD9LTtNtl1+2EFLg6xdlDfXBzM4+NYNVNyLk7h+uviKC6nHQwDhWyZfb1RRDqe3nMpotjR/Lh6EY3Slgz+Id2DpU9/0Lb7nhkFJzFv7dK8yMSUqLeUhVVGu/5pHXqp50LME5UWF42wmtIkFt+srgCIU9jlMxqb4EqVKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD4+pg7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8ECC4CEC3;
	Wed, 25 Sep 2024 11:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264929;
	bh=55nMLxx/UZJ2uaNMpAgm4Di+rgIcbZp2i9kYD6oDQ3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XD4+pg7Fw3lAke4Jp4uzydrMd/YLGikvynzPOGGNFwiI5lYQ8Dpr41JWoqpPC8ql1
	 zPOAQ4j/G2tCiXa4Zqx3jKZnaTC40Pd+f1qoyeoVVep6lVP30hxB/9Bo28dWZ6b92d
	 WmfupR/zinjkUPvzvYOrLoGcrzfmqHQoJqQvBksgy+K1DpMQTXaAZCC2bqAxy+Aeow
	 AqqTuasEQgXD2dxdcW/WXnQiRCpANFhNZl2/Vc/hbi5Oz7JQ7mN3eQP1vVkEE0JeO/
	 ZT9GbmCckA9YmVRI1LJ7Ii2tghAjFC59y+ycPDyyau8e9ITyxSbjN4E9qLjMVk+fJi
	 7M6TYBtKayQmQ==
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
Subject: [PATCH AUTOSEL 6.11 182/244] drm/amd/display: Check stream before comparing them
Date: Wed, 25 Sep 2024 07:26:43 -0400
Message-ID: <20240925113641.1297102-182-sashal@kernel.org>
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
index 67794497457d3..913adca531fc4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3241,6 +3241,8 @@ static bool are_stream_backends_same(
 bool dc_is_stream_unchanged(
 	struct dc_stream_state *old_stream, struct dc_stream_state *stream)
 {
+	if (!old_stream || !stream)
+		return false;
 
 	if (!are_stream_backends_same(old_stream, stream))
 		return false;
-- 
2.43.0


