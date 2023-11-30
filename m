Return-Path: <stable+bounces-3395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91D97FF56B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C351C20E07
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6A54F90;
	Thu, 30 Nov 2023 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0u8PKtz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC0524C2;
	Thu, 30 Nov 2023 16:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65065C433C8;
	Thu, 30 Nov 2023 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361723;
	bh=UMi+JtAGivaPX6ttX8MgboiPqsSbguOF3H+PqMWMDh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0u8PKtzv11S+VV1Y0haPN1TtkXc+nfOrl8wHWAhcEOx/sc1YUgyxBcIV6mPjFw3Z
	 FqJ1DCyB9Yj+pWTcw4+4cMKBdLS/Ne3pINJe4gJv7hW0W+HFI1CWcvsFDTQsPGIdza
	 JmLWT1MPazOFwBQwtU7Seg3LhTj95WEUy1SG5wcQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 04/82] drm/panel: auo,b101uan08.3: Fine tune the panel power sequence
Date: Thu, 30 Nov 2023 16:21:35 +0000
Message-ID: <20231130162136.113274440@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
References: <20231130162135.977485944@linuxfoundation.org>
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

From: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>

[ Upstream commit 6965809e526917b73c8f9178173184dcf13cec4b ]

For "auo,b101uan08.3" this panel, it is stipulated in the panel spec that
MIPI needs to keep the LP11 state before the lcm_reset pin is pulled high.

Fixes: 56ad624b4cb5 ("drm/panel: support for auo, b101uan08.3 wuxga dsi video mode panel")
Signed-off-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231114044205.613421-1-xuxinxiong@huaqin.corp-partner.google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 733e28a2536a4..1c008bd9102ff 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1473,6 +1473,7 @@ static const struct panel_desc auo_b101uan08_3_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_MODE_LPM,
 	.init_cmds = auo_b101uan08_3_init_cmd,
+	.lp11_before_reset = true,
 };
 
 static const struct drm_display_mode boe_tv105wum_nw0_default_mode = {
-- 
2.42.0




