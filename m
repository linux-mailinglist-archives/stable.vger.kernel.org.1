Return-Path: <stable+bounces-63178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D799417CA
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841E31C23167
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964441A4B4D;
	Tue, 30 Jul 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MR9s0rmS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391F1A6193;
	Tue, 30 Jul 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355923; cv=none; b=o0b6PwsGZDgLDs8j3T4VZhUSpChEujje57TBIs1PCIb3eqLNzIyE3CkNvV+Gp9ksVxwYqM+7eMJ+uTBvPZvmeyq0afO7YszTAO9517ChgkVdfVr4tL2sRcmDeCbShVoUHn1IB8tiII3H5V80ftffo9rfPKiLxbUTRw1ify5w71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355923; c=relaxed/simple;
	bh=VuadzWiVaRZGhw+uEb1ObGysKiG1QtHCb3BGDspfBRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfsWh3Ns9d+qVQyMZbRofHDyW+f0h0Zsw5kAJLz9R0yejWgXUbdZ1JrTj0UANme6PpphumXgXw5ic0cEqEpT8ocDcKipSVIvLycEXOdorcp6keqMeP0wL2RUg+cDDuRrhKKxO1hnMEHILd39sCwIfpirbBtB0meRO0bgOtUCf04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MR9s0rmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0084C32782;
	Tue, 30 Jul 2024 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355923;
	bh=VuadzWiVaRZGhw+uEb1ObGysKiG1QtHCb3BGDspfBRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MR9s0rmSngkRG3gd519obcFaMbngU/JkLiiMDTJnXa9Af2/xI0rAGGvLJaW7Q5yya
	 4NVX3oBVebG71hslM3hy8jOeWl6PYxvnRjXPjefXMlMkWnvaRg9ti7IGHRsmigvG9x
	 GaUhgzSAaYEVBKfMiaRcm4dsFWYBu+FXYpCkK658=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 105/809] arm64: dts: mediatek: mt7622: fix "emmc" pinctrl mux
Date: Tue, 30 Jul 2024 17:39:41 +0200
Message-ID: <20240730151728.774539225@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit aebba1030a5766cdf894ed4ab0cac7aed5aee9c1 ]

Value "emmc_rst" is a group name and should be part of the "groups"
property.

This fixes:
arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: pinctrl@10211000: emmc-pins-default:mux:function: ['emmc', 'emmc_rst'] is too long
        from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt7622-pinctrl.yaml#
arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dtb: pinctrl@10211000: emmc-pins-default:mux:function: ['emmc', 'emmc_rst'] is too long
        from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt7622-pinctrl.yaml#

Fixes: 3725ba3f5574 ("arm64: dts: mt7622: add pinctrl related device nodes")
Fixes: 0b6286dd96c0 ("arm64: dts: mt7622: add bananapi BPI-R64 board")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240604074916.7929-1-zajec5@gmail.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 224bb289660c0..2791de5b28f6a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -329,8 +329,8 @@ asm_sel {
 	/* eMMC is shared pin with parallel NAND */
 	emmc_pins_default: emmc-pins-default {
 		mux {
-			function = "emmc", "emmc_rst";
-			groups = "emmc";
+			function = "emmc";
+			groups = "emmc", "emmc_rst";
 		};
 
 		/* "NDL0","NDL1","NDL2","NDL3","NDL4","NDL5","NDL6","NDL7",
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 41629769bdc85..8c3e2e2578bce 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -268,8 +268,8 @@ &pio {
 	/* eMMC is shared pin with parallel NAND */
 	emmc_pins_default: emmc-pins-default {
 		mux {
-			function = "emmc", "emmc_rst";
-			groups = "emmc";
+			function = "emmc";
+			groups = "emmc", "emmc_rst";
 		};
 
 		/* "NDL0","NDL1","NDL2","NDL3","NDL4","NDL5","NDL6","NDL7",
-- 
2.43.0




