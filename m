Return-Path: <stable+bounces-88376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEED9B25AD
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DD41F21A4A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193D18E03A;
	Mon, 28 Oct 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBJX3+mx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099A18E36D
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097191; cv=none; b=kKJcx3oYFS2cf6H1Rd1nM0UuboZSdL3S/2FZBokhU6URhcsckBB2h0LA/veYc8k31l+QtrAMNH32FE0UXHUfWso5rNyvjndGPpTVldjYY6skMSquzotBTv3oHiKP7POs+C5FT2smMOn+9LyMuOXq+fFPDnS+lVwRTWwZsTtjdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097191; c=relaxed/simple;
	bh=omPMivH93RtmE3bO75pNuWdCaAMLWsLaATHZQK7Ib+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VQI8J99GJGEmMe+EUqBIFdmVTI85qOQVFpJl8rxg8Vir02jBGbF4QBYUTVfPMK4zw6bMTaeYtvj4nPCusaSGaJmTFv4N+d1D9sb3Q/5jWOmbtHBJzewG02LQNCxIk6R2UefNOtEeXMfBRuFw1u1uAp2SUOGD6uAFiZNyamIBb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBJX3+mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44AC1C4CECD;
	Mon, 28 Oct 2024 06:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730097191;
	bh=omPMivH93RtmE3bO75pNuWdCaAMLWsLaATHZQK7Ib+4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZBJX3+mxn6tKThTs8ubjj4+ynu5u3wqedNeVxf6F6I2GkjBvBhYCSQpBIyuxwLbIQ
	 F9fhGoZtgn6YmtaYF+fek56Sm9JOHXqZvxrG1s8nKkmuqdvuPDQCrDeC+RI6YvEH4w
	 i5ejGRbTwBy59+J0FUDvKoHtR7ZmU6Yw4RXNzwt4eel3UKF4zGzBVcikhvljLxNfVS
	 Tdz51FJX6KFXtAn5CtJdtg6KeTa3olWQvGX37o2lLEPRCi0YcfoXALm9FLjwG2neju
	 ydnWAGUrv58Ab/wnulzrkwy/+PYRlLUbwBrh/ZAba5eorhdfNI3D3HizlA/HIcY3p9
	 LAPvWWnMsDAmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3458CD13588;
	Mon, 28 Oct 2024 06:33:11 +0000 (UTC)
From: "Jason-JH.Lin via B4 Relay" <devnull+jason-jh.lin.mediatek.com@kernel.org>
Date: Mon, 28 Oct 2024 14:32:57 +0800
Subject: [PATCH v3] Revert "drm/mipi-dsi: Set the fwnode for
 mipi_dsi_device"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-fixup-5-15-v3-1-078531a8d70a@mediatek.com>
X-B4-Tracking: v=1; b=H4sIABgwH2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxNDINZNy6woLdA11TU01TVNS0kxs0hJTDU3MFcCaigoSgXKgg2Ljq2tBQD
 6q944XAAAAA==
To: stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>, 
 Greg KH <gregkh@linuxfoundation.org>
Cc: Seiya Wang <seiya.wang@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
 Singo Chang <singo.chang@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730097189; l=1740;
 i=jason-jh.lin@mediatek.com; s=20240718; h=from:subject:message-id;
 bh=bVfIERPhq4e+ukiO8o0skwuih9+HfNbAYOSnExc291I=;
 b=R9T6v7Mh2aggvu3SLI17HuZXMvi8oJcQCA11sGkuGiH6bPVywawm1FAPjRngRojjRdUG1uffy
 CeTd1oY7rqRA2vPsr9JB7Okyzvl/Bx6qFUO5JWvIaOfkmGwiqCpEUAo
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



