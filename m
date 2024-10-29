Return-Path: <stable+bounces-89149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC339B3FB9
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 02:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2945D1C21E58
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 01:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA0C38FB0;
	Tue, 29 Oct 2024 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPMc0Nuc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790617C79
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165102; cv=none; b=VtKadyEURwWackYWg7EneJLCUXsX1Ex1gCJMOZlrA5LAR/iNsqINz3SCwtJLSPiF9/SS2fvTQeA4uW+hq+85hkvhSVFYg9pVWJFxPRmxyrDAF0Fw47TzpR83/bcWn+y51s5OtWsZTtt4XjMj+QZ6TOtsInN+hmdEZ3GjlldYjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165102; c=relaxed/simple;
	bh=cdK00fhpS92qePm+Y2i9sKeUWZWsgREaTk46hv/tAwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pDKwQA8X8wEDnMEMWFa1egvhWZdb9fpj58r0VMux/piCBHVA447IwOanqItNSZgxR1gjXud3NY8sSc+y2X4z6J8Tkmdvx5eUafKDNVp+iupWZ/8TThEvuxhznY5zShfW4MhQtYxhkuMX9EKkKUIRBZenNqgofZxc1Pk4d78Lw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPMc0Nuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFC65C4CEC3;
	Tue, 29 Oct 2024 01:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730165101;
	bh=cdK00fhpS92qePm+Y2i9sKeUWZWsgREaTk46hv/tAwc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=XPMc0NucLopUdxpoHdgl2RcXMyDGwyn60rYlSQvmY1SZe+q2lgQ3dBSaoXuNI0HDR
	 AHIH+scXVOQfZCJIgFm9tpgHTO0/xssboVYZl8SsuNyFp/+sIoQVHpvi48NGUgAv8G
	 22b/YzriIUJC8VLZUTrQAL5UtccSsh2CTC7J3oRWfdUK2XfgO0teRJO7px/LImKBYE
	 YDAk++BnkscCxtnpspbanWCQDgVstUmuuCCMmTuzasBKuNXdJR+l/5WsAgHA4ZAeht
	 CYmaNbheL62klS4RoayUtYQe6ytN3HrZGOolP7Qkzu7pZ5qmlmVkatu+FUl1VUksps
	 yapCzz0MxGkCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B17D5B840;
	Tue, 29 Oct 2024 01:25:01 +0000 (UTC)
From: "Jason-JH.Lin via B4 Relay" <devnull+jason-jh.lin.mediatek.com@kernel.org>
Date: Tue, 29 Oct 2024 09:24:53 +0800
Subject: [PATCH v4] Revert "drm/mipi-dsi: Set the fwnode for
 mipi_dsi_device"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-fixup-5-15-v4-1-a61fab4fd6b4@mediatek.com>
X-B4-Tracking: v=1; b=H4sIAGQ5IGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIxNDINZNy6woLdA11TU01TVNS0kxs0hJTDU3MFcCaigoSgXKgg2Ljq2tBQB
 VZR/YXAAAAA==
To: stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>, 
 Greg KH <gregkh@linuxfoundation.org>
Cc: Seiya Wang <seiya.wang@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
 Singo Chang <singo.chang@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730165099; l=1741;
 i=jason-jh.lin@mediatek.com; s=20240718; h=from:subject:message-id;
 bh=uhbpFJp5IT10j6SMA6dRBLS+yXfRfWjo3zjGXUrkvXI=;
 b=vqZ0TfXJbYAfinkJsqvBxX6BcwerguR0FY0iuUZkCz9/rYCJi452dm5joq0T9vcy/x3S2KpFy
 55oXc7/rKQ7DH6XzhNssL4xUvADE5yAfLy5j50wvrfeOXnOHQIikbwP
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

2. Since the fw_devlink improvements series [2] does not land on
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
Cc: stable@vger.kernel.org # 5.10.228
Cc: stable@vger.kernel.org # 5.4.284
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



