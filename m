Return-Path: <stable+bounces-6144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F408480D909
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31ED41C2165C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CAE51C37;
	Mon, 11 Dec 2023 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wc5sNuvC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D725102A;
	Mon, 11 Dec 2023 18:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0BFC433C7;
	Mon, 11 Dec 2023 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320631;
	bh=6SvAPZVXp78nwYoih8/G5YHLei8ew2jFhlh1sH6X/u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wc5sNuvCGXyGw1YAcW7p3PSuXoyz3V2H9/iHdOl1snzlYrsdZusI0maZ4T+KnsDo4
	 cy9SfGW+5Pak54vzJie/nugKGaWzrjiUW5DF/ghCdXyldzy7OFI87bwBNkAyH/38Bl
	 t60Ty21GSbI+PbNHZJlu5BR+228AInV1Dt4wEfNE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 6.1 132/194] arm64: dts: mediatek: mt8183: Fix unit address for scp reserved memory
Date: Mon, 11 Dec 2023 19:22:02 +0100
Message-ID: <20231211182042.426065086@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

commit 19cba9a6c071db57888dc6b2ec1d9bf8996ea681 upstream.

The reserved memory for scp had node name "scp_mem_region" and also
without unit-address: change the name to "memory@(address)".
This fixes a unit_address_vs_reg warning.

Cc: stable@vger.kernel.org
Fixes: 1652dbf7363a ("arm64: dts: mt8183: add scp node")
Link: https://lore.kernel.org/r/20231025093816.44327-6-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts    |    2 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -30,7 +30,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		scp_mem_reserved: scp_mem_region {
+		scp_mem_reserved: memory@50000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x50000000 0 0x2900000>;
 			no-map;
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -108,7 +108,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		scp_mem_reserved: scp_mem_region {
+		scp_mem_reserved: memory@50000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x50000000 0 0x2900000>;
 			no-map;



