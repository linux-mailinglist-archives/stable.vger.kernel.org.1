Return-Path: <stable+bounces-62179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE2C93E6A5
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922B81F2302C
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2EC57CB1;
	Sun, 28 Jul 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TN5WD+D1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C501E487;
	Sun, 28 Jul 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181569; cv=none; b=JkZvwVW6MRZdSnOXTN4LRkymb5qlrY678KF39v1RGzLzHwzYCghWxhMwVvUI59mQaFp0P91jHwNlVkl/sXfW+Cf7FGGosXJ13jBArK5StYHPeSAjON6iA3nKPrXGu4TEhDfqfXbOjlw7y+uQ9eDJiEFgNFJ3oWaRBRs2la1hsho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181569; c=relaxed/simple;
	bh=1tqp+nHZwq+qAriXubdvFO4dlxKzItGsCHYebadlLso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XV6aJ4W8lYz4K4+8HSf+c49TP9WOTAau35izbQHUKz3vtXzM8Kg4/fR/0GHejXuJeHrKBIxK/yPUhLJysqErCY+VbE4b0BinavswnzLOETKwvSiCTl58TuevXNs14jj+4Mn9xzDW6Ep0QlR4XkOk+1OkLdgQzOCTkfFfGyTQhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TN5WD+D1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A84CC116B1;
	Sun, 28 Jul 2024 15:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181569;
	bh=1tqp+nHZwq+qAriXubdvFO4dlxKzItGsCHYebadlLso=;
	h=From:To:Cc:Subject:Date:From;
	b=TN5WD+D1VgNrjYz8/ckw6q7HWgnH8BSfub7wWxsPFMA9+k6ObkqJ8ji1MGFQZDNJc
	 oJgyXF0YOnMR7T1B/Dpfgj+4hpfZE7qcHKl2xdt16MX9ViE7ATT5dzZKHSIXa0Mbp/
	 v+oAncPxnb1i5qs99QnfcW7DU/s40AgFs3uZVPAUsQYlCoqTqQEWPXgVl/k2aRR6uc
	 oLZPduOdKc7Ri/XVZFEjo/JrK5U7FAQADTx6SCWqHVM27Lcx0r6CLa+I06SfskwXVM
	 jISa7uwawzj+OPe0sOwQwDRkENMfSSKcx17uVaKpCpSxd5mcqqLtPqJBl0gpJWCQJw
	 XZqiPiMQxFNkQ==
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
	stylon.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 01/20] drm/amd/display: Add delay to improve LTTPR UHBR interop
Date: Sun, 28 Jul 2024 11:44:59 -0400
Message-ID: <20240728154605.2048490-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index b621b97711b61..a7f5b0f6272ce 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
@@ -162,7 +162,12 @@ static void set_hpo_fixed_vs_pe_retimer_dp_link_test_pattern(struct dc_link *lin
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


