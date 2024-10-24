Return-Path: <stable+bounces-88021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D59AE12A
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 11:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0F2281D2C
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1441CF5C6;
	Thu, 24 Oct 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoF1ns3a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247231CF2A7;
	Thu, 24 Oct 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762689; cv=none; b=ay7XXcroXvSMjbVe/H1kz64gWcTK0STlsHUSu8RU3qujiN1WQmK53ZFCqaJCahOX/XfMfp9FNMN1x3oNS7rECHvHVQVVaLEwSqdN86IO598sfmZLTzzAfslU9VFbq5wxtD7uYg3uEy/hS3VuCyRiyqXdF6qt/lI1le7IGiFazMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762689; c=relaxed/simple;
	bh=o6MMr9N2UT/BsFYwemm9ougD47xRLpWhszG7XioZcCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RvfNrTqJ89w+6aj/IKZegD6dXmgCjKaDkTR7L5sQpjt4ThX3GIKaIMbGx0RRSYSttXd80ncgldw7SCbG1qodhE/dfVLObrvImRcYcXhDM0mvNlu2+2cNce7xwkPx1ym659Fa5HoflV42MGYavrNyACSmSDzzoCdR+L0aDWadSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoF1ns3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE5A9C4CEC7;
	Thu, 24 Oct 2024 09:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729762689;
	bh=o6MMr9N2UT/BsFYwemm9ougD47xRLpWhszG7XioZcCc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hoF1ns3aFMzXpuWCAA/cOasgDikOFCILMHY3kwsU+LIhMJsvRjj43/3FSWJ0BGPix
	 Pc+I3i0UQjvgX6X4N6fE9iUv5oj0R5TBCVKgXLKJ0hIV2cLvDw2CxAlcSIvZaZ0p6L
	 lFgHtllhoUzzUtAcDTbX5lMPpNNKmkgB61mGyRWKIEaV4aSEkUcmB4Qw0uehT+3oLV
	 FY1GmT6Zl6Yqs7ye5G3jkqiyNhCGYtgGOKFyth3dJLALvvVHawCCqdkkGsMdpSMTEx
	 FPGMAQfghKAOg80oEr9LEnJN3uRB/LmnlFdAzeFPak/70Oei+d4JdmKC/SkllyM5vf
	 RlIttqiGZ0sQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D486ECDDE69;
	Thu, 24 Oct 2024 09:38:08 +0000 (UTC)
From: "Jason-JH.Lin via B4 Relay" <devnull+jason-jh.lin.mediatek.com@kernel.org>
Date: Thu, 24 Oct 2024 17:37:13 +0800
Subject: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-fixup-5-15-v1-1-74d360bd3002@mediatek.com>
X-B4-Tracking: v=1; b=H4sIAEgVGmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDINZNy6woLdA11TU01TVNS0kxs0hJTDU3MFcCaigoSgXKgg2Ljq2tBQC
 +m6XyXAAAAA==
To: Saravana Kannan <saravanak@google.com>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Seiya Wang <seiya.wang@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
 Singo Chang <singo.chang@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729762687; l=1624;
 i=jason-jh.lin@mediatek.com; s=20240718; h=from:subject:message-id;
 bh=3qI4cofzJIOGhAuMDl/AeKoCQ8rIiQm9bD4C+nDQrco=;
 b=tWMrCFbt5wPfKwkMYwLI7hkKkGBc6Sh8AtNZumboECYDQdFTreparCIMo6Q/UQ6yp/498m11C
 Z33NXD5fIkCC/hI5XfJ0qG6ep7GNw6F2Z9hC3nSz3lZBaVbIfj5SGNq
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



