Return-Path: <stable+bounces-201190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 220F6CC21B1
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA8F3302FA20
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DF7265CAD;
	Tue, 16 Dec 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AvkVMGs1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F08207A38;
	Tue, 16 Dec 2025 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883826; cv=none; b=fvkXguAOY0F2dqmqn2BGQp6Iiv4cO9EtxSHy4npL7KGZ3wTE27TWofH3vWB+yS4KOHlZWIj0A7ONdrH7aFoai9K6U4apDRBhHOx3FX24EwGEtwCo/PgEL9a8nieV+ITXcCG3Cq8jD/P5mxdI9J6WsOOXrZRfEjC8zS+oXVunnHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883826; c=relaxed/simple;
	bh=RZc+ukwhLowLmt0HOkVi8d7H3Ire/UByjKeOKI7D5Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbzZtnmI+jHdB2LHRc+QwITnlTqRK3bQw6JluXS8clIiwnA/J9Kmj6GT0hP0mlQBUtEsCt7t5Irbl1oOJKHiE3SMVrnAx78zD2qnVFLlKBlZ7OeDL/GOa0whSXhhYmeLP9gMx1cDFbgZMILdlqHASl3jaz//RnjNEKY2gQMRvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AvkVMGs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D87C4CEF1;
	Tue, 16 Dec 2025 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765883825;
	bh=RZc+ukwhLowLmt0HOkVi8d7H3Ire/UByjKeOKI7D5Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvkVMGs1/OhKddK3W+RZ8Yf+rhX+nN/0+VFFjpvkZEF5vBfLtOIZ9ZYWrxH2+k6t2
	 6KTng9IuvNIYqr3muC0RCNbkhDlk+kba6pFOG+V2y4V+ip9DIf5UOku1II8TVdznoR
	 n5ErE/g2eVa0xTjYMNixJFkE4+NXwfeDyBdc4D7U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 011/354] drm/panel: visionox-rm69299: Dont clear all mode flags
Date: Tue, 16 Dec 2025 12:09:38 +0100
Message-ID: <20251216111321.316407757@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
References: <20251216111320.896758933@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guido Günther <agx@sigxcpu.org>

[ Upstream commit 39144b611e9cd4f5814f4098c891b545dd70c536 ]

Don't clear all mode flags. We only want to maek sure we use HS mode
during unprepare.

Fixes: c7f66d32dd431 ("drm/panel: add support for rm69299 visionox panel")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250910-shift6mq-panel-v3-2-a7729911afb9@sigxcpu.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 272490b9565bb..f06dca12febe4 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -62,7 +62,7 @@ static int visionox_rm69299_unprepare(struct drm_panel *panel)
 	struct visionox_rm69299 *ctx = panel_to_ctx(panel);
 	int ret;
 
-	ctx->dsi->mode_flags = 0;
+	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
 	ret = mipi_dsi_dcs_write(ctx->dsi, MIPI_DCS_SET_DISPLAY_OFF, NULL, 0);
 	if (ret < 0)
-- 
2.51.0




