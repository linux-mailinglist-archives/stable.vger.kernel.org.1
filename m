Return-Path: <stable+bounces-1895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3021B7F81E3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFE62836EE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A076233CC2;
	Fri, 24 Nov 2023 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LsduAAir"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581492D787;
	Fri, 24 Nov 2023 19:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808F5C433C7;
	Fri, 24 Nov 2023 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852538;
	bh=6ptLY6vGwLjV9f3xE4TvCPGIUDDzA0YXx8jCMhgT0dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsduAAirUf+jMGbFfoUVtLHAhzXRKRlVsHMuJBwPKQGs2dUQFlh4mhNkIGJx8S1VY
	 qd5ySVBW00uijphROo6cPomeGFYrGL1MTq9Ru0yQNVP02f2enRblIEobX/2LRUrXQ1
	 U4x17KSgB5NJshwXLLCn2Cw4IXXq07Y+e7f6CS+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make_ruc2021@163.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 023/193] drm/panel/panel-tpo-tpg110: fix a possible null pointer dereference
Date: Fri, 24 Nov 2023 17:52:30 +0000
Message-ID: <20231124171948.118237160@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit f22def5970c423ea7f87d5247bd0ef91416b0658 ]

In tpg110_get_modes(), the return value of drm_mode_duplicate() is
assigned to mode, which will lead to a NULL pointer dereference on
failure of drm_mode_duplicate(). Add a check to avoid npd.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20231009090446.4043798-1-make_ruc2021@163.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231009090446.4043798-1-make_ruc2021@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-tpo-tpg110.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-tpo-tpg110.c b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
index d57ed75a977c3..494cec50a682b 100644
--- a/drivers/gpu/drm/panel/panel-tpo-tpg110.c
+++ b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
@@ -378,6 +378,8 @@ static int tpg110_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = tpg->panel_mode->bus_flags;
 
 	mode = drm_mode_duplicate(connector->dev, &tpg->panel_mode->mode);
+	if (!mode)
+		return -ENOMEM;
 	drm_mode_set_name(mode);
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 
-- 
2.42.0




