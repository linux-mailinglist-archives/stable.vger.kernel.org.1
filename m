Return-Path: <stable+bounces-156520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B741AE4FDD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9743917F70C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B218E377;
	Mon, 23 Jun 2025 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ndWtwsuU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0E2C9D;
	Mon, 23 Jun 2025 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713614; cv=none; b=sL+4zY3CKRiQwu+4vG2+NL5Hm567omv1Ey6EbvRxjhNY+aSzmqc/2yH9X4LNzoIRlWX2bY1dhGaMgRpeB5s2PJ+zC4PxMwQXPc71YUxYJXk+BesZ21v6lamXQOmNIK3F4baMlwCdspE03R6jMLDvfRCKG//L/d1np97MAE+vmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713614; c=relaxed/simple;
	bh=KnaFQf4nE/8Zkg4qb/s6+/2LEfugjPor9AKIKJuy9Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tq59EbBrCsdvl79psd6AsU2VKn7B7pKrWHwx/p9feflDa7UphLe7it1gwQR10h5oLzJL3W0F/fH/VSTpLt5TaoT9AE8AAmO1OHFC5ZZj+5Ob3KImJNgowlKFsFUJfX9h11j1idTaNrcZ8cWnZnLXxAErASgW9GOf22LzXpWQsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ndWtwsuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E487DC4CEEA;
	Mon, 23 Jun 2025 21:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713614;
	bh=KnaFQf4nE/8Zkg4qb/s6+/2LEfugjPor9AKIKJuy9Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndWtwsuUZAOXUri8HoAPc2a3sozTB3SN2lOTCMn+3cvIQGAaahFJkQdgsihLbftsp
	 Dyc2PJrxZKuRyFreNOlCOsI8ryE8Hu/W7TIrFXbtG2Qlz+jDbDdAAZUS5pvZWbSoML
	 b+HKbBWnylDuYr+M/xiSCRZ4Ur65H2ih7AYgjCEA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julien Massot <julien.massot@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 113/508] arm64: dts: mt6359: Add missing compatible property to regulators node
Date: Mon, 23 Jun 2025 15:02:38 +0200
Message-ID: <20250623130648.076746636@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Julien Massot <julien.massot@collabora.com>

[ Upstream commit 1fe38d2a19950fa6dbc384ee8967c057aef9faf4 ]

The 'compatible' property is required by the
'mfd/mediatek,mt6397.yaml' binding. Add it to fix the following
dtb-check error:
mediatek/mt8395-radxa-nio-12l.dtb: pmic: regulators:
'compatible' is a required property

Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
Link: https://lore.kernel.org/r/20250505-mt8395-dtb-errors-v1-3-9c4714dcdcdb@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index df3e822232d34..ef6ab90b99f93 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -13,6 +13,8 @@
 		};
 
 		regulators {
+			compatible = "mediatek,mt6359-regulator";
+
 			mt6359_vs1_buck_reg: buck_vs1 {
 				regulator-name = "vs1";
 				regulator-min-microvolt = <800000>;
-- 
2.39.5




