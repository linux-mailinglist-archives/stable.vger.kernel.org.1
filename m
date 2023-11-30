Return-Path: <stable+bounces-3481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D677FF5DA
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957C81C2118C
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72F03AC1A;
	Thu, 30 Nov 2023 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L2y3lcJq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA883D382;
	Thu, 30 Nov 2023 16:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DE8C433C8;
	Thu, 30 Nov 2023 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361941;
	bh=1osSwHthi+SM9O6yiy/I6LhLoEfFnxfweyGDJ0xwZu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2y3lcJqw1TYzXBvxBfbj+J37ElTUso48ZWNnMKpp0UouRh5tggK3e8M/7q0B92D1
	 xZt0CrLKWduDdLuFvZ08xXwIZAZjzvusci/9IZp649akb4NXsRqSesmvciwbLmSGPa
	 +yZ5GhOMm+QxeWf9B0rsZ8W0a1S1e4WhwWvIw14o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@denx.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 05/69] drm/panel: simple: Fix Innolux G101ICE-L01 bus flags
Date: Thu, 30 Nov 2023 16:22:02 +0000
Message-ID: <20231130162133.235046108@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
References: <20231130162133.035359406@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit 06fc41b09cfbc02977acd9189473593a37d82d9b ]

Add missing .bus_flags = DRM_BUS_FLAG_DE_HIGH to this panel description,
ones which match both the datasheet and the panel display_timing flags .

Fixes: 1e29b840af9f ("drm/panel: simple: Add Innolux G101ICE-L01 panel")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231008223315.279215-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e58eb93e9bc9e..28d1e661f99b1 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2555,6 +2555,7 @@ static const struct panel_desc innolux_g101ice_l01 = {
 		.disable = 200,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
-- 
2.42.0




