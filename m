Return-Path: <stable+bounces-62147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A2A93E605
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C02B1F2160C
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F525EE8D;
	Sun, 28 Jul 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foz7om77"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F856B81;
	Sun, 28 Jul 2024 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181369; cv=none; b=K+js3WolyEkN684ucZStSI9XrxF221yWKYL/dPIsXLIUdvlLV9IoAdhawp2ig+5r97lswxUxb5O5ZkxL1l6oTVh0rEjUp5kdX8qS4cShnNjUxI2f9EWcanHcWCLUr8BYdC/EhcHotGO04cuFtzGlNita25X+buQAfzW5qSHKOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181369; c=relaxed/simple;
	bh=/GMImu/c3UprN9lt97DNSfEOJk3uLmniRfTXNmI7eK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RV+ZWaLSwyKS7JkEfyTaGglW0Zqd607UU+XkAZ0CKjDLduxYkx/rgWSIgZH5+Cs6czEoiBXbTONWob4jj9+5546V5x6VWEcPl+J1qEoAPb+klUn+ycUuURi9K/N1NXJEqqZxS3HnpCL+YiJNDC9THfhwcgJGXZIReqsdkT2q9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foz7om77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839F3C116B1;
	Sun, 28 Jul 2024 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181368;
	bh=/GMImu/c3UprN9lt97DNSfEOJk3uLmniRfTXNmI7eK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=foz7om77pXcBcLjg7tVcQp4clgfsX6bQ7okBUJRwFqxlNz2o7NPIo6svpjMZcEVeL
	 Yip0zUj/UkLG85pdl+f9ggY0agnYEIQgd9XlKQxUMh3YQANasV70Oj2PiUTYiu5nxL
	 hsQe69d88zITV9PCAWIgYqst1+xA8Q9ChAnuwoIdyeA5eqhTiQzsiLFRGpmf7muT02
	 HEvQHDw8nsW6A+SdB34i6YApw50PukM97GakiDnTC4FWvAZ7ipkaKzQ+f7gHE4x3SR
	 afvTmfOexBr5zGakruRFc9KIhAMZXKjSYrkJO9H5l3mArsCxQj79uxxSiOzYqIbW5e
	 qhOcvLPuuE7eQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Strauss <michael.strauss@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
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
	hansen.dsouza@amd.com,
	stylon.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 03/34] drm/amd/display: Add delay to improve LTTPR UHBR interop
Date: Sun, 28 Jul 2024 11:40:27 -0400
Message-ID: <20240728154230.2046786-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
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

From: Michael Strauss <michael.strauss@amd.com>

[ Upstream commit 10839ee6a977ed1f7d0f4deb29f2d7e5d1f2a9dd ]

[WHY]
Avoid race condition which puts LTTPR into bad state during UHBR LT.

[HOW]
Delay 30ms between starting UHBR TPS1 PHY output and sending TPS1 via DPCD.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
index 3e6c7be7e2786..5302d2c9c7607 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
@@ -165,7 +165,12 @@ static void set_hpo_fixed_vs_pe_retimer_dp_link_test_pattern(struct dc_link *lin
 		link_res->hpo_dp_link_enc->funcs->set_link_test_pattern(
 				link_res->hpo_dp_link_enc, tp_params);
 	}
+
 	link->dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
+
+	// Give retimer extra time to lock before updating DP_TRAINING_PATTERN_SET to TPS1
+	if (tp_params->dp_phy_pattern == DP_TEST_PATTERN_128b_132b_TPS1_TRAINING_MODE)
+		msleep(30);
 }
 
 static void set_hpo_fixed_vs_pe_retimer_dp_lane_settings(struct dc_link *link,
-- 
2.43.0


