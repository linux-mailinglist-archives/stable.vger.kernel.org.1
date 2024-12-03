Return-Path: <stable+bounces-96657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814FF9E20F6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9CC168628
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3C1F7540;
	Tue,  3 Dec 2024 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YA/ZbPfy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85CA1F669E;
	Tue,  3 Dec 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238215; cv=none; b=sxaKdvlOKooS59dJi4QZiPgwE29vzhYqp3bffhD6tt96sOp9NLlo3tH+jr0GPOKlUyAwObvUHMIXbpkNT0Ou8uKM/znXkghryaDj+W7VepE/SC23oHPRkb6YuA7wDMPHjnNqlUe+odoTMLgZzInWrzQxP46T8wB3LlhErI+n/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238215; c=relaxed/simple;
	bh=HX7pvQdd0+YWorPtAHHuPT8YsUEFh110bDn3LnzKqVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+SCrvqpfCpxgGoZsosRuR7D6Ww2XX1tGAR5NUs/RkQqv4Dxrlc1E/X/Q8bfuWdHuLulIBQHj4mLJBzAnW/ru6vyFvDVXgZDzQTEpaNyZATTgjT+oUQ3iHsR0qyD65PbJB3zU+KBrMq7AfjlGxps/xH/jrNQJ9KT47+fSC5kkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YA/ZbPfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531B6C4CECF;
	Tue,  3 Dec 2024 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238215;
	bh=HX7pvQdd0+YWorPtAHHuPT8YsUEFh110bDn3LnzKqVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YA/ZbPfyALtsBcnHr2g7/XJkcMwBDs+4AobINB0tICsqzHBVqUsKfEnjIG7vqYpWq
	 3RHw06rMQM4lY2XufqJEJH1+l4YtFo5fUCAe/LKqrE9/rMuyNPtobmJCDhpBxHJyRv
	 cWaOg5vFSC6aJxvCst2pt5sz5Lzhe3IDuJKCvaKE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 200/817] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add supplies for fixed regulators
Date: Tue,  3 Dec 2024 15:36:12 +0100
Message-ID: <20241203144003.548656623@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit aaecb1da58a72bfbd2c35d4aadc43caa02f11862 ]

When the fixed regulators for the LCD panel and DP bridge were added,
their supplies were not modeled in. These, except for the 1.0V supply,
are just load switches, and need and have a supply.

Add the supplies for each of the fixed regulators.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/20241030070224.1006331-4-wenst@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 4a11e480ed2b5..930e2ee83333a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -20,6 +20,7 @@ pp1000_mipibrdg: pp1000-mipibrdg {
 		regulator-boot-on;
 
 		gpio = <&pio 54 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp1800_alw>;
 	};
 
 	pp1800_mipibrdg: pp1800-mipibrdg {
@@ -32,6 +33,7 @@ pp1800_mipibrdg: pp1800-mipibrdg {
 		regulator-boot-on;
 
 		gpio = <&pio 36 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp1800_alw>;
 	};
 
 	pp3300_panel: pp3300-panel {
@@ -46,6 +48,7 @@ pp3300_panel: pp3300-panel {
 		regulator-boot-on;
 
 		gpio = <&pio 35 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_alw>;
 	};
 
 	pp3300_mipibrdg: pp3300-mipibrdg {
@@ -58,6 +61,7 @@ pp3300_mipibrdg: pp3300-mipibrdg {
 		regulator-boot-on;
 
 		gpio = <&pio 37 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_alw>;
 	};
 
 	volume_buttons: volume-buttons {
-- 
2.43.0




