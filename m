Return-Path: <stable+bounces-64899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E461943BE8
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD0A1C20F49
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4059F14A4C3;
	Thu,  1 Aug 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGybhEmw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6514A4C6;
	Thu,  1 Aug 2024 00:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471328; cv=none; b=DUnJ/1IKoCJ96uaIBfZzkbAK/TVfxaxRW7LNnYbIxv0chmZkhcIWhxscWpQ+KePuE19J19qIFEAQDdYKkEkn1cyydRdrkIvIiA4lgArvK75LBD7JSCf73kLP13X/owZxgqyoVZ0Orw/yg8JZ8nbPv6py6a99gsWJZYuxlJosDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471328; c=relaxed/simple;
	bh=vN/0+PCnxw4RkndSR3E8Lcq/Mu7ZWGdNEZe89/ZZz1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eeewc60ZaBnubZv23lV/jut7DrKd1mqAjIShduZ0FGP/I4GNzre0EFT5GjygT5b2/3VqwMRMxhpORhO4rVuSKwjiSqWaKSpovyokAqp2xGXZt6ZANRvP7QmbA4d6YWS2pzskXn6abfDzVto8A9vGCVOzP7UQAuIUYt++AOL6r54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGybhEmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C503C32786;
	Thu,  1 Aug 2024 00:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471327;
	bh=vN/0+PCnxw4RkndSR3E8Lcq/Mu7ZWGdNEZe89/ZZz1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qGybhEmwWiuzKn/BCSl/O25Sruaqp8u8/6+40OruK37ozzhNkOOexbffD2pTppS7d
	 IoezFyb8Nv+o1OavF+ybiJXD8l9ThAMIeLgNGAGCA0rjhb6rLM4b8HFi3ar6aa90Fr
	 AOrFoSomeTBRssntU27nx04AszfBCSLM6GeA8C7vKpgFi3shFchCc4qXpQQ3zn10H3
	 7uW5X3wHy0VPWGKA32Qrsw09iQ4ZvgOfrdWK9shyOzmmXcPxCyEcYzkSQLKJEa6QnD
	 E6rJSyGLZcu8BUY4NcgK2Z6xlXr0kVswea8QJzY5ZmCBTX/o8oEoxJdEwyOP13MaYp
	 tyn7gi9o/xmVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: winstang <winstang@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
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
	wenjing.liu@amd.com,
	alex.hung@amd.com,
	jun.lei@amd.com,
	hamza.mahfooz@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 074/121] drm/amd/display: added NULL check at start of dc_validate_stream
Date: Wed, 31 Jul 2024 20:00:12 -0400
Message-ID: <20240801000834.3930818-74-sashal@kernel.org>
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

From: winstang <winstang@amd.com>

[ Upstream commit 26c56049cc4f1705b498df013949427692a4b0d5 ]

[Why]
prevent invalid memory access

[How]
check if dc and stream are NULL

Co-authored-by: winstang <winstang@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: winstang <winstang@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 76a8e90da0d56..dffc663fd1a10 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4656,6 +4656,9 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 
 enum dc_status dc_validate_stream(struct dc *dc, struct dc_stream_state *stream)
 {
+	if (dc == NULL || stream == NULL)
+		return DC_ERROR_UNEXPECTED;
+
 	struct dc_link *link = stream->link;
 	struct timing_generator *tg = dc->res_pool->timing_generators[0];
 	enum dc_status res = DC_OK;
-- 
2.43.0


