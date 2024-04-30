Return-Path: <stable+bounces-41866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A65A8B7015
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7701C2190A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD212C47F;
	Tue, 30 Apr 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxLvKjps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCBE129E81;
	Tue, 30 Apr 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473797; cv=none; b=T+k0KgjqkFuwB7PK5waQhgtgKkH71Id+LsWgN3G7OtqbJwh9ymu29ofomn54VoRJyddcpis/bDZE+JeQV8PrxlvqjtX4TI76eVm6P2gCBgloIPbPIKAAKv9ey4letF69+Q7S15uFJp40y0kG41mo+rx8sp0MlBkeWoMIy7ATnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473797; c=relaxed/simple;
	bh=obNSzvf1cauLVXRFG3l194vqs/ZWn0rNgOLErzpEDGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mI/nbFE2I/CErLwwl5b8cLuRhl64WlowgEB8nieJ2ZariXTGpiaK7Hkqik3qLFejTv6P9j5cyZI8Vn1cww0hheNbi2eVFZJ/VpXrFoe89snAymTx5yxlwavvtojeL7i7wt0kCuFvNzMfkKKG+RcCYF8xB+4Fd845MHePSbFms/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxLvKjps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897EAC4AF14;
	Tue, 30 Apr 2024 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714473797;
	bh=obNSzvf1cauLVXRFG3l194vqs/ZWn0rNgOLErzpEDGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxLvKjpsIXUXbce7JD+H+aFVGEJffK7dluJf7tVgvC0DLEt/QB8A4Tj9VrsOS3voI
	 OYnNimTPsHQuZtmfAikrS9MscbZBORXBu4kGHKoxO2LLi9k15YnQ7yjVFzsWkIs7tM
	 gGBrH5riqe25TBU/raTxfL5UN13HoJikOqzijlnE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 41/77] arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
Date: Tue, 30 Apr 2024 12:39:20 +0200
Message-ID: <20240430103042.346775363@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>
References: <20240430103041.111219002@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 208add29ce5b7291f6c466e4dfd9cbf61c72888e ]

Fix following validation error:
arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: ethernet@1b100000: compatible: ['mediatek,mt7622-eth', 'mediatek,mt2701-eth', 'syscon'] is too long
        from schema $id: http://devicetree.org/schemas/net/mediatek,net.yaml#
(and other complains about wrong clocks).

Fixes: 5f599b3a0bb8 ("arm64: dts: mt7622: add ethernet device nodes")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240317221050.18595-4-zajec5@gmail.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 5c12e9dad9167..76297dac2d459 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -846,9 +846,7 @@
 	};
 
 	eth: ethernet@1b100000 {
-		compatible = "mediatek,mt7622-eth",
-			     "mediatek,mt2701-eth",
-			     "syscon";
+		compatible = "mediatek,mt7622-eth";
 		reg = <0 0x1b100000 0 0x20000>;
 		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 224 IRQ_TYPE_LEVEL_LOW>,
-- 
2.43.0




