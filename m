Return-Path: <stable+bounces-64847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AB9943AC3
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796301F21079
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21DA15253D;
	Thu,  1 Aug 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2ubTel3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90813B5AC;
	Thu,  1 Aug 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471035; cv=none; b=exRJd4tFtjkHfx1AxJ5e8ua3tobPHdymTasTRvJjFcL1bIU9LTLqqUlvfgbk/TRFD5Llf7NCLmnM7odgHG66QANee89rxUdjmFqM+7R640aDocy7QAQtaiBxpfX7KyklO1rO/f+wKdFvSNicGcXgxGT5phI6Odc1OOXZamHC5ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471035; c=relaxed/simple;
	bh=hes1imbb/7ZEb00qn4wTtORoNzvDmesteaytUKscRSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPDC8JFpxi4HBoh7JcqeE5aIZlSNKctui72SZIPUd9yWC2MHfoRneOd4hoqP5TQ9MMkIbyPC/XNgqDXhYUv1utIs3H//4A0perpWm9rj27DxnHkGK/5aoQLC4VaGUZeTR2Pxc9zvOqTx6QNAjQQAEWxCeqlqBE+ZUFpOY8st2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2ubTel3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AD4C4AF0C;
	Thu,  1 Aug 2024 00:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471035;
	bh=hes1imbb/7ZEb00qn4wTtORoNzvDmesteaytUKscRSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2ubTel3/THn5GmKuf2zSKNvXmaMMKSUkUuk3k2G+8lELm7rxVW0/Zytir79wihTj
	 e97ML5fU9jG0a176fHiyRfHZD6w/B4OCki5kZ80YdodNGBkPLWsejWIBuu96zKWBfc
	 +gUOYu+Rj/vZNdYQpXzue2/21njnWdM8k2X0doEsbbZZELsBUOf3mFMGctAqRGEd3Z
	 xYaCwQIUJuOjL6c03i2UA9oDKYlTnhdqYFMYkt6+X6xP+8e6+ALTnG782umV5DgTtE
	 LlLJeiovlJNecpB0Vv92lyKlmyPpmU0+Vu/OC2QHNeefnGo+7FX2NGCJUpOPr1p8GV
	 Z5gbJN+Jf5jpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	aric.cyr@amd.com,
	meenakshikumar.somasundaram@amd.com,
	Bhawanpreet.Lakha@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 022/121] drm/amd/display: Check link_index before accessing dc->links[]
Date: Wed, 31 Jul 2024 19:59:20 -0400
Message-ID: <20240801000834.3930818-22-sashal@kernel.org>
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 8aa2864044b9d13e95fe224f32e808afbf79ecdf ]

[WHY & HOW]
dc->links[] has max size of MAX_LINKS and NULL is return when trying to
access with out-of-bound index.

This fixes 3 OVERRUN and 1 RESOURCE_LEAK issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index c6c35037bdb8b..dfdfe22d9e851 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -37,6 +37,9 @@
 #include "dce/dce_i2c.h"
 struct dc_link *dc_get_link_at_index(struct dc *dc, uint32_t link_index)
 {
+	if (link_index >= MAX_LINKS)
+		return NULL;
+
 	return dc->links[link_index];
 }
 
-- 
2.43.0


