Return-Path: <stable+bounces-64839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA2943AA9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049562837CA
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FDDDDDC;
	Thu,  1 Aug 2024 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+DNoyIB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E128F3;
	Thu,  1 Aug 2024 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470993; cv=none; b=OfieX7VcFK+oZd4ZHPz/iUO9XmW3pfPkdlch4rIk4+w+4zWahSKhHJ/g4+TYWT8tPfoxTEN+PkHShKKzdDLZCtG8d8N/Ditp+CVM9/Q08Y4/YAa0VCYuOtIlpKPJMXj1XZfaAO0jn5670+MU5XUUvAf3iB987QnnPimxJ4MVlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470993; c=relaxed/simple;
	bh=urbdiKoWp4k0BQdRumoDWifT/RyLXzMSIUSYLtqW5UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAhzVix9YO/ww8OVhO4yp+Pb1BV1cSljtnRRnG8ui9EwU3jNAtDr+iJbdE2m8WQJG48lGslEDOP17Vb2PBFF2G7igkHuDVageG16Tyr9TZxycMQsfDdyrf5ChTq9+o93dL8VXpYyNVfdOlIdWJ1MvZ7zEsGFstkvt4FkiuREnak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+DNoyIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E16C116B1;
	Thu,  1 Aug 2024 00:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470993;
	bh=urbdiKoWp4k0BQdRumoDWifT/RyLXzMSIUSYLtqW5UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+DNoyIBXzjWf1vMtqklud+dbk3Wetw9MtjwNhcZKXjBdJzHWyWtKMyAWKUzmSmaX
	 Y9xRTRBFBtdDGcVaH/4Z7EeNH5GQdJkr8750ZxJ0QpcAmBxGho0mR0mtCjtBIhdgam
	 smTatUZBiss88OMPQoReXPvWeHD5i0Bb8AXDrRXaFPNPFx5bM0enLzlwTYe+SZaIh1
	 nQJ227E+PmW2OgFmdMRV8NTLF3p/xE5CDBfE+yd/DlIImE4S1qCQuyncoSKi1v0r2C
	 ipWcZPrp7+jYeEUv/AEL4BTQyubZwAvWBjqgqTn6K/MfNee2OPr38hcv7qKX06qMeJ
	 FGuf9KzRIYkTw==
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
	daniel.miess@amd.com,
	charlene.liu@amd.com,
	nicholas.kazlauskas@amd.com,
	wayne.lin@amd.com,
	yi-lchen@amd.com,
	harikrishna.revalla@amd.com,
	ahmed.ahmed@amd.com,
	Qingqing.Zhuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 014/121] drm/amd/display: Fix incorrect size calculation for loop
Date: Wed, 31 Jul 2024 19:59:12 -0400
Message-ID: <20240801000834.3930818-14-sashal@kernel.org>
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

[ Upstream commit 3941a3aa4b653b69876d894d08f3fff1cc965267 ]

[WHY]
fe_clk_en has size of 5 but sizeof(fe_clk_en) has byte size 20 which is
lager than the array size.

[HOW]
Divide byte size 20 by its element size.

This fixes 2 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 024dcf3057a05..f2379709dd941 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -895,7 +895,7 @@ static uint8_t dccg35_get_other_enabled_symclk_fe(struct dccg *dccg, uint32_t st
 	/* for DPMST, this backend could be used by multiple front end.
 	only disable the backend if this stream_enc_ins is the last active stream enc connected to this back_end*/
 		uint8_t i;
-		for (i = 0; i != link_enc_inst && i < sizeof(fe_clk_en); i++) {
+		for (i = 0; i != link_enc_inst && i < ARRAY_SIZE(fe_clk_en); i++) {
 			if (fe_clk_en[i] && be_clk_sel[i] == link_enc_inst)
 				num_enabled_symclk_fe++;
 		}
-- 
2.43.0


