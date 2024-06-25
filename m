Return-Path: <stable+bounces-55320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00591631A
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E127B27460
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F304D14A4DA;
	Tue, 25 Jun 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CGmlG/mm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B014A4D2;
	Tue, 25 Jun 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308559; cv=none; b=iXYPojeEL/UJvZtoGxdzMv0S8mXYgXjXB0k2QfGFRePQ+p2voLESo4v/3Y/ZJgpHkdyFlQ5bK78QG7on85ugauXu9wIdDurNJoWLrJv06PFuUzUnPAiv4BI4xrnQfQLU0uneEQxRis0lmuhKXzWuX7asoSTm82Oz68Mj49wsR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308559; c=relaxed/simple;
	bh=xc3lbaWnUUdCA0btTAm1DXOC1/00mPmR/J3pxNxDFmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wbeu4K9Wrc66i+2RtT+A11d6Ykp0axRJ2iRXi1jpsa1hQ6LpfsW2fHFCTgRpMWDmhkGuvTUEmTo3DFbZ16rgY/It3DEqFRayRZmCU4UY2zzdSF+JhqwE8t81CtJwZ5Yb2NoWVjwFU0L3xdHkOwqJZpmycjPFve6v8UeuaoOF7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CGmlG/mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D12C32781;
	Tue, 25 Jun 2024 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308559;
	bh=xc3lbaWnUUdCA0btTAm1DXOC1/00mPmR/J3pxNxDFmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CGmlG/mmYLoyq/snnCdjx5K95HvRLVxuTvdCJpbn/YV6sasdRncReZELn16g/Ka8D
	 UABMu5oCwM7kWmVwczPFZTFtOxjZ1pdh2w3Rt/vrjD2HiNjmjchQGPIhvJAUS9RatH
	 yyiy47/YLaVRO/gIzEGVpWhWJ+HATfUztFEFp4qE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liu Ying <victor.liu@nxp.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 161/250] arm: dts: imx53-qsb-hdmi: Disable panel instead of deleting node
Date: Tue, 25 Jun 2024 11:31:59 +0200
Message-ID: <20240625085554.240360222@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Ying <victor.liu@nxp.com>

[ Upstream commit bcdea3e81ea51c9e89e3b11aac2612e1b4330bee ]

We cannot use /delete-node/ directive to delete a node in a DT
overlay.  The node won't be deleted effectively.  Instead, set
the node's status property to "disabled" to achieve something
similar.

Fixes: eeb403df953f ("ARM: dts: imx53-qsb: add support for the HDMI expander")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso   | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi
index d804404464737..05d7a462ea25a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi
@@ -85,7 +85,7 @@
 		};
 	};
 
-	panel {
+	panel_dpi: panel {
 		compatible = "sii,43wvf1g";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_display_power>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso b/arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso
index c84e9b0525276..151e9cee3c87e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso
+++ b/arch/arm/boot/dts/nxp/imx/imx53-qsb-hdmi.dtso
@@ -10,8 +10,6 @@
 /plugin/;
 
 &{/} {
-	/delete-node/ panel;
-
 	hdmi: connector-hdmi {
 		compatible = "hdmi-connector";
 		label = "hdmi";
@@ -82,6 +80,10 @@
 	};
 };
 
+&panel_dpi {
+	status = "disabled";
+};
+
 &tve {
 	status = "disabled";
 };
-- 
2.43.0




