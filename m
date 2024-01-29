Return-Path: <stable+bounces-16819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD1A840E8C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8001C227FE
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4615FB18;
	Mon, 29 Jan 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kcn+QpRP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4CE15A4A4;
	Mon, 29 Jan 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548302; cv=none; b=AbemaOjK2fqZavihZ0ImWjpmC2sJ4O6iIGG9UO/9CvhmHKaT6/nQjM21ioyzq8PzJnLxK6AxHTJ9/P+dVz44sX1hDWtjZZjfmx3A22bTp/W7BkMLARgZc5jkF6pAHkijCySTOho/zJ1nSD/xDM+r1eCwW48+XalYKYilJ4eiGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548302; c=relaxed/simple;
	bh=A7jJcdJvmrbzCyeM4ZHlGj3DTy0pZM8ti1weh8uq4mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRYQopnkDPUF4CFS/N1RK5yBbudQGR2SQYthBugzv77tHzsMUUx4YIybJVYiADIgQc4AqyKZKiAnxPT6Jzw2s+giuflhkvAuflAJWRWyGuQfiuGbGWnwUW4ivJPulZorrs3mnEjH8FiDrIOvvq+0pIdBZLQr2CgG26RfdixYs4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kcn+QpRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467EBC433F1;
	Mon, 29 Jan 2024 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548302;
	bh=A7jJcdJvmrbzCyeM4ZHlGj3DTy0pZM8ti1weh8uq4mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcn+QpRPAClDO4Z52t/PV3urYK5AsZMhDNBSoB7G1eJZyi8zYlDf9ORHHqW2zCfmH
	 BwyHPMmDjSICxPH1mop1fqB6tUd7PVEeTLlO2jam3WqIeEvSeyct4jCyDSwYOOs5/h
	 AjGV3wsrLsFTuv7eLrNQot+edYPDX1Z/HgVF1xWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Artur Weber <aweber.kernel@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 308/346] drm/panel: samsung-s6d7aa0: drop DRM_BUS_FLAG_DE_HIGH for lsl080al02
Date: Mon, 29 Jan 2024 09:05:39 -0800
Message-ID: <20240129170025.529068501@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artur Weber <aweber.kernel@gmail.com>

[ Upstream commit 62b143b5ec4a14e1ae0dede5aabaf1832e3b0073 ]

It turns out that I had misconfigured the device I was using the panel
with; the bus data polarity is not high for this panel, I had to change
the config on the display controller's side.

Fix the panel config to properly reflect its accurate settings.

Fixes: 6810bb390282 ("drm/panel: Add Samsung S6D7AA0 panel controller driver")
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
Link: https://lore.kernel.org/r/20240105-tab3-display-fixes-v2-2-904d1207bf6f@gmail.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240105-tab3-display-fixes-v2-2-904d1207bf6f@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
index ea5a85779382..f23d8832a1ad 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
@@ -309,7 +309,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl080al02_desc = {
 	.off_func = s6d7aa0_lsl080al02_off,
 	.drm_mode = &s6d7aa0_lsl080al02_mode,
 	.mode_flags = MIPI_DSI_MODE_VSYNC_FLUSH | MIPI_DSI_MODE_VIDEO_NO_HFP,
-	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.bus_flags = 0,
 
 	.has_backlight = false,
 	.use_passwd3 = false,
-- 
2.43.0




