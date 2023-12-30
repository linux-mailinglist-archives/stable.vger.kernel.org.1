Return-Path: <stable+bounces-8982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0549D8205B4
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379EF1C21171
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF9779EF;
	Sat, 30 Dec 2023 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AeSLEY8d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915079DD;
	Sat, 30 Dec 2023 12:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59B9C433C7;
	Sat, 30 Dec 2023 12:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938267;
	bh=cEPO1RLfmyotuxMxXczLX8c4c43vQwWiEYCXCKriXec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AeSLEY8d7vjtUB5kYtkUgwbUWMTFvhPb5Zrr0IO5CaKukcLePpu339PWVi9BoAsAW
	 kOGeYX99Iek+C97tLm2aK3/xNLnbqJoEaxLbAlK0rQhGJW/8S+9QVWtmGiaszGJcui
	 sFlOuNCX4+J7uKuV5y5xhAJFhfDjqXFDqAvCfN5k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aric Cyr <aric.cyr@amd.com>,
	Qingqing Zhuo <qingqing.zhuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 091/112] Revert "drm/amd/display: Do not set DRR on pipe commit"
Date: Sat, 30 Dec 2023 12:00:04 +0000
Message-ID: <20231230115809.737659773@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aric Cyr <aric.cyr@amd.com>

[ Upstream commit 36951fc9460fce96bafd131ceb0f343cae6d3cb9 ]

This reverts commit 4f1b5e739dfd1edde33329e3f376733a131fb1ff.

[Why & How]
Original change causes a regression. Revert
until fix is available.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 53262f6bc40b0..72bec33e371f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -994,5 +994,8 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
+
+	dc_dmub_srv_p_state_delegate(dc,
+		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching, context);
 }
 
-- 
2.43.0




