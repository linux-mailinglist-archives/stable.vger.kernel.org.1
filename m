Return-Path: <stable+bounces-6079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDAC80D8A2
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625BA281AB8
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E9F51C2B;
	Mon, 11 Dec 2023 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zVx0KYHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD035102A;
	Mon, 11 Dec 2023 18:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282FEC433C8;
	Mon, 11 Dec 2023 18:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320454;
	bh=g8YwpqgTp5XhCD+VhsjxKWYee9oldiGLRl1FUczGzmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zVx0KYHIOFicShoF+jFMfmZxC4U4T2sgqgdUhy4yBLibFD7obYz5I5DzCioEUGRXd
	 sO1ThfPBz7CYMncr3xFFWTaUHU2baeNq36fRXWXDgz98aPqlooXVBc2jp+NXYJR0RZ
	 TJwWEd0r4NKHwe7+8wONAL07kvX9UQ7oVmIfKTOk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Karlman <jonas@kwiboo.se>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 067/194] arm64: dts: rockchip: Expand reg size of vdec node for RK3328
Date: Mon, 11 Dec 2023 19:20:57 +0100
Message-ID: <20231211182039.485674259@linuxfoundation.org>
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

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit 0b6240d697a96eaa45a2a5503a274ebb4f162fa3 ]

Expand the reg size for the vdec node to include cache/performance
registers the rkvdec driver writes to.

Fixes: 17408c9b119d ("arm64: dts: rockchip: Add vdec support for RK3328")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20231105233630.3927502-9-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 49ae15708a0b6..905a50aa5dc38 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -666,7 +666,7 @@
 
 	vdec: video-codec@ff360000 {
 		compatible = "rockchip,rk3328-vdec", "rockchip,rk3399-vdec";
-		reg = <0x0 0xff360000 0x0 0x400>;
+		reg = <0x0 0xff360000 0x0 0x480>;
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>,
 			 <&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>;
-- 
2.42.0




