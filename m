Return-Path: <stable+bounces-140211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230ABAAA64F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625CC3B8223
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A08B289FCF;
	Mon,  5 May 2025 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3eXXpsb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBA128F519;
	Mon,  5 May 2025 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484357; cv=none; b=CA0+EQRq0dQZH9HXn3cotli7pHzXa6d92Scc0dqEVbZ0CIXEDUKtAjITmNYEMRvLlu/jvVsmBqI0G8qwUaYz8St+G9O0Wl8iq4Lp0QjIhnn5KUFf3y5shsJ4TV51w3GUKH51kYhtXXLE9DHdn5V1zF5nn9vXpUDx/3FD9sCv474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484357; c=relaxed/simple;
	bh=5xFZxXsa3z2FbEwTNIIJcagFR1fve397uQSS9+L3Qsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbHh6oQ9P2NQ2wOizso+FHskZizYW6bpkKnvwP7Y61j5i3CACzZ6qjF0x8DE89jZ68L+KbrTgrtPmGDUB9RGpfHwT2hM4PKCs6JrwQoaW6Fvl7xPCE+e/QoTPCdSw1mDoJ2mQDMJkg7Ap0kWJ9D9oTDk7h59NHj/RiLu7PEEzlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3eXXpsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CA8C4CEE4;
	Mon,  5 May 2025 22:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484357;
	bh=5xFZxXsa3z2FbEwTNIIJcagFR1fve397uQSS9+L3Qsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3eXXpsbyLLQ0CafWYhAPK/fdIb6fIAk3VfbrIyOH/HpKfxn4y3MgS5/PiwvczTwV
	 GLrl3UeRWox6txsGWS0R9ESL6+kNftXDXRAAhGO1vNEaAR9BAxcVjDxWxC2ayB/av2
	 qHnJMHNdxgOyx9UOPrnYTJdmvzzaUGrQoVamhy6vtfCz3nQhBW8ExOa7JhyFc7wpuG
	 wCQPN7X+q524chINUedT44m/lw37YhOunN564PxTbRhJVwciyk8A7FguSUZW2GYlih
	 9VIC0nFe4wiOw0Thys5TGfnnlJIt0AslUWhQ5gGR7ZnOb6OkaIv9Tft0G92D0+dNbr
	 H3ympe16a0K6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	chiahsuan.chung@amd.com,
	meenakshikumar.somasundaram@amd.com,
	michael.strauss@amd.com,
	PeiChen.Huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 463/642] drm/amd/display: Don't try AUX transactions on disconnected link
Date: Mon,  5 May 2025 18:11:19 -0400
Message-Id: <20250505221419.2672473-463-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[ Upstream commit e8bffa52e0253cfd689813a620e64521256bc712 ]

[Why]
Setting link DPMS off in response to HPD disconnect creates AUX
transactions on a link that is supposed to be disconnected. This can
cause issues in some cases when the sink re-asserts HPD and expects
source to re-enable the link.

[How]
Avoid AUX transactions on disconnected link.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 2c73ac87cd665..c27ffec5d84fb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -75,7 +75,8 @@ void dp_disable_link_phy(struct dc_link *link,
 	struct dc  *dc = link->ctx->dc;
 
 	if (!link->wa_flags.dp_keep_receiver_powered &&
-		!link->skip_implict_edp_power_control)
+			!link->skip_implict_edp_power_control &&
+			link->type != dc_connection_none)
 		dpcd_write_rx_power_ctrl(link, false);
 
 	dc->hwss.disable_link_output(link, link_res, signal);
@@ -163,8 +164,9 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource
 	} else {
 		if (link->fec_state == dc_link_fec_ready) {
 			fec_config = 0;
-			core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
-				&fec_config, sizeof(fec_config));
+			if (link->type != dc_connection_none)
+				core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
+					&fec_config, sizeof(fec_config));
 
 			link_enc->funcs->fec_set_ready(link_enc, false);
 			link->fec_state = dc_link_fec_not_ready;
-- 
2.39.5


