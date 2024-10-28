Return-Path: <stable+bounces-88268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAC99B2489
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC9A1C21162
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 05:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E9218C92F;
	Mon, 28 Oct 2024 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaNqX7AR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2218C350
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094180; cv=none; b=S4nBNyGPhK5eSpa3VrLC5KG8pnbyjmypzfRtKFAUrOUk4A0bh2aZ0SVyPmApjpirs2Yc7KQzFh+I/JKYg/HEV5diGKrNtzmmqbLdCBe6BpLKYIdXG+v1spSQ2+RjU/X8hamYYaRX1z4ggcNIa6MsLpwq+vPT8YtVJ2Y68HC2+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094180; c=relaxed/simple;
	bh=74d4N95sj2T/XoWX9vIlcTtSjwi0Hb+K3U9pU5LCDcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rO3J5LvDvZBvDkKU6zIVcwa/ifDt2RldLaRN3WO1iwP4sSAkh4dvH80tHzg3BproTGIHh2WSLF8wXUWTAa0FMgSUhFDChGIZKhDnXVq5W4uld+sJxgFZSgcVQNEbXCCCzRfH6waypsj3vFYAooe1t40UNrCdN4PAPowLMBnS+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaNqX7AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D09FBC4CEC3;
	Mon, 28 Oct 2024 05:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730094179;
	bh=74d4N95sj2T/XoWX9vIlcTtSjwi0Hb+K3U9pU5LCDcw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qaNqX7ARdr32r30Ty4xP6LZdDbwJK/3E7MPoRR3exNMNfX1zdygVcLMwUcz2bLlRl
	 znui1XS5z2l/o6MvYhywNAIZeWAfv5Q1zKMp7S3z0nIR8Bw0bSfxJ/gLbV72RWPXem
	 6374inscryOAJqsR3BrdCtyRpA/5wTLDZoUUIDwxoFPpHZQ2h108OaD2kEsA6WY+cl
	 BxW6eBW4rrq4R6lH7/oJ08A11JzAw03CryaB3v8iIrQopXvRZlh/74mIsK+w+U0TpG
	 SYbwtU7d9bxOZPjM4b7ACHPi5iv3CV1HhcvadlG/dARBnBJ2o2Brj69+XWt3sAFXSb
	 qjNk9ru7d4iPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA919D1358C;
	Mon, 28 Oct 2024 05:42:59 +0000 (UTC)
From: "Jason-JH.Lin via B4 Relay" <devnull+jason-jh.lin.mediatek.com@kernel.org>
Date: Mon, 28 Oct 2024 13:42:49 +0800
Subject: [PATCH v2] Revert "drm/mipi-dsi: Set the fwnode for
 mipi_dsi_device"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-fixup-5-15-v2-1-40216f0fe383@mediatek.com>
X-B4-Tracking: v=1; b=H4sIAFgkH2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxNDINZNy6woLdA11TU01TVNS0kxs0hJTDU3MFcCaigoSgXKgg2Ljq2tBQD
 YM+NdXAAAAA==
To: stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>, 
 Greg KH <gregkh@linuxfoundation.org>
Cc: Seiya Wang <seiya.wang@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
 Singo Chang <singo.chang@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730094178; l=1663;
 i=jason-jh.lin@mediatek.com; s=20240718; h=from:subject:message-id;
 bh=8ojWfopcwKup0laonpHcvKr5CiOjB346s5EoLYHs1DY=;
 b=5G5P3Yj1R/AQV7XiUAhveRxNe04tFWOZ3YTvRakAKWohbP+GuzP8ihOdNdb8/zDmsAHIAzcTI
 EfqxdQk3UHpB1+jJMCgJShZLo+hJC9RSp8eoNTbS3FsiosUhxHRktn4
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



