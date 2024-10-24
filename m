Return-Path: <stable+bounces-88028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7619AE286
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 12:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2FA1C213D9
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 10:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743D81B392A;
	Thu, 24 Oct 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA7PO5ab"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0314B946
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765827; cv=none; b=iwiQi6OtFms6akHBR4hQIEkl7IlmDuF3c9GyZuvmY8S97ZvryGevxmJDRMpU4/rbcImyoiosfrG/cjb6e+yf9gFeBqFNtfhSHg+CPXif8B2aXeJ9wZ9dRSNBjngjV3n4wWjEl38+K6MeI3I+Z5l/xFdLkV/pc8hanWiF7NG306g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765827; c=relaxed/simple;
	bh=74d4N95sj2T/XoWX9vIlcTtSjwi0Hb+K3U9pU5LCDcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RgK6GgDp4HfD58tglO7OeIz1bGoEmb7c4AAL09Qs/oSrRQgZBDPGOAvHb83tiq3SvdqKIBmK31Hb1A+RE9cTo2QKFhVJPk7HBIK/a6YUVFhzs8dVvcxx0dYKyzspmUA1S4V1mj1fp15j8BGsMaUrz/0QfN0e9Ye5p3IyeGEgH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA7PO5ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C93CDC4CEC7;
	Thu, 24 Oct 2024 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729765826;
	bh=74d4N95sj2T/XoWX9vIlcTtSjwi0Hb+K3U9pU5LCDcw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AA7PO5ab80NKY4KB5U4tL63+4UBzxobFBHI2ujtlSwbCxLCBL01lQEL0zWMaIDuvm
	 x+blZDE0+9o8W3gaRQ3MDHW6gZayFF3JhU3T6OzTadrKdqMTsidgQjrU72jh0HdxRl
	 Zqo/qhhAXL/KKTyCzIjGF/RlGVprBTVe8fDS9NWBVLj/Fz+EaVy96FkUsiL0UeUQhv
	 6YqmjVNHbpV/zj5L82KgsoSEwwgoYf7wcByqcr0TyAlAWVTVY24XqLHikKkjfZDjiQ
	 8x38vq/5Guo1L/+0AagQLM2lSnhIpW/Feouwspsj22WaUEG8kTM4l9M1ecLiZh4JKl
	 EucsVJJ8IbeBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C67D0BB7A;
	Thu, 24 Oct 2024 10:30:26 +0000 (UTC)
From: "Jason-JH.Lin via B4 Relay" <devnull+jason-jh.lin.mediatek.com@kernel.org>
Date: Thu, 24 Oct 2024 18:30:01 +0800
Subject: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-fixup-5-15-v1-1-62f21a32b5a5@mediatek.com>
X-B4-Tracking: v=1; b=H4sIAKghGmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDINZNy6woLdA11TU01TVNS0kxs0hJTDU3MFcCaigoSgXKgg2Ljq2tBQC
 +m6XyXAAAAA==
To: stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
 Seiya Wang <seiya.wang@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
 Singo Chang <singo.chang@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729765825; l=1663;
 i=jason-jh.lin@mediatek.com; s=20240718; h=from:subject:message-id;
 bh=8ojWfopcwKup0laonpHcvKr5CiOjB346s5EoLYHs1DY=;
 b=78uPs8dIh0Y+kRKnDp4pFGRm7Ym3IYjRmcCb95SheqtFTJPlTaHxCLprxsjIhwqKTCqScWfkS
 t6Y7S6WBIDCBAG+IQvNJTBKsdWcPY7F3f4aRlquRgVQ1bMvKXxW9tNJ
X-Developer-Key: i=jason-jh.lin@mediatek.com; a=ed25519;
 pk=7Hn+BnFBlPrluT5ks5tKVWb3f7O/bMBs6qEemVJwqOo=
X-Endpoint-Received: by B4 Relay for jason-jh.lin@mediatek.com/20240718
 with auth_id=187
X-Original-From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Reply-To: jason-jh.lin@mediatek.com

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

This reverts commit ac88a1f41f93499df6f50fd18ea835e6ff4f3200.

Reason for revert:
1. The commit [1] does not land on linux-5.15, so this patch does not
fix anything.

2. Since the fw_device improvements series [2] does not land on
linux-5.15, using device_set_fwnode() causes the panel to flash during
bootup.

Incorrect link management may lead to incorrect device initialization,
affecting firmware node links and consumer relationships.
The fwnode setting of panel to the DSI device would cause a DSI
initialization error without series[2], so this patch was reverted to
avoid using the incomplete fw_devlink functionality.

[1] commit 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more robust")
[2] Link: https://lore.kernel.org/all/20230207014207.1678715-1-saravanak@google.com

Cc: stable@vger.kernel.org # 5.15.169
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 24606b632009..468a3a7cb6a5 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -221,7 +221,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 		return dsi;
 	}
 
-	device_set_node(&dsi->dev, of_fwnode_handle(info->node));
+	dsi->dev.of_node = info->node;
 	dsi->channel = info->channel;
 	strlcpy(dsi->name, info->type, sizeof(dsi->name));
 

---
base-commit: 74cdd62cb4706515b454ce5bacb73b566c1d1bcf
change-id: 20241024-fixup-5-15-5fdd68dae707

Best regards,
-- 
Jason-JH.Lin <jason-jh.lin@mediatek.com>



