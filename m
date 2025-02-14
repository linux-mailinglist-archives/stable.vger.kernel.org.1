Return-Path: <stable+bounces-116384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48380A35953
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 09:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0653A4C0E
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA52E227BA6;
	Fri, 14 Feb 2025 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AKsbYQM3"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04379275401;
	Fri, 14 Feb 2025 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523010; cv=none; b=dmeyWP8N7RwvigG8JgUDeHAxwyM8j/alGZjqFw/sqPfESWVctj6FOD29Z4Ru6AdfG51IFKjKDmal6Rvru/qnWTqQaAAu6Ybm/+/SgVNJaYILk0N88MfJyXzejJZ8Ub5JoDhSMx3ZEgOODEx3dBilaIA59GkmsAB+yiO4W4LEano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523010; c=relaxed/simple;
	bh=eHsbsd/eFKbVVaYr4omsL/Cx88B0Q51hlfhaRwPY0RA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WXo9o4MXBkVyE7juKHi/FQxwgCcKEnEj1cB0pid75TXuq5eUpxYBjv/QLzPnHPJ/Kd5Vb3505OYucxe+S0lqD9fkQbieGKzuH7KuQHKxWfR8hxX08Vz0P3Sqr2/Gm0rvbX7FMd5IQMH6+T0BBjc6LOEx2HIxsUGxDWmA93cxQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AKsbYQM3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ae86e8d2eab011efb8f9918b5fc74e19-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=SZTKFrboegu1pyLSyq2HcY2eKZBWe3hXG4JUqZ8ZU0c=;
	b=AKsbYQM3lxBAVEii1KIMqewju/FjqyPgdG/pUaVAs7cOTyqevlueh+KQSCI65TLtIhivjCOOuuzUYdB5d+5fHVu5MrdzQY51KAsAfzY7rg+H8OEMPZ3FVdQaFKBqB4WJBRLHBpz4doIJZ9XpXOu4jh5I2K5mizdJqbIUPbMtixQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:46e23ee0-5498-40be-8e8a-c3aa7291560b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:fcecbf24-96bd-4ac5-8f2e-15aa1ef9defa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ae86e8d2eab011efb8f9918b5fc74e19-20250214
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 94671838; Fri, 14 Feb 2025 16:50:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 16:50:02 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 16:50:02 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Sen Chu <sen.chu@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-usb@vger.kernel.org>, <stable@vger.kernel.org>, Chris-qj chen
	<chris-qj.chen@mediatek.com>
Subject: [PATCH v3] arm64: dts: mediatek: mt6359: fix dtbs_check error for RTC and regulators
Date: Fri, 14 Feb 2025 16:49:54 +0800
Message-ID: <20250214084954.1181435-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This patch fixes the following dtbs_check errors:
1. 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
 - Update 'mt6359rtc' in 'mt6359.dtsi' with a generic device name 'rtc'
2. 'pmic: regulators: 'compatible' is a required property'
 - Add 'mediatek,mt6359-regulator' to compatible property.

Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Changes for v2:
 - No change.

Changes for v3:
 - Add "Reviewed-by:" tag, Thanks!

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 150ad84d5d2b..3d97ca4e2098 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -19,6 +19,8 @@ mt6359codec: mt6359codec {
 		};
 
 		regulators {
+			compatible = "mediatek,mt6359-regulator";
+
 			mt6359_vs1_buck_reg: buck_vs1 {
 				regulator-name = "vs1";
 				regulator-min-microvolt = <800000>;
@@ -297,7 +299,7 @@ mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshub {
 			};
 		};
 
-		mt6359rtc: mt6359rtc {
+		mt6359_rtc: rtc {
 			compatible = "mediatek,mt6358-rtc";
 		};
 	};
-- 
2.45.2


