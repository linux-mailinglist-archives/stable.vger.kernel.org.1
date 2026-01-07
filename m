Return-Path: <stable+bounces-206123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83722CFD663
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 12:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B61430469A5
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA1B30F543;
	Wed,  7 Jan 2026 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t7B8QgSm"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CDA30276A;
	Wed,  7 Jan 2026 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767785368; cv=none; b=ETzwbRSlLsFeWfoHfSiqEk5DHunfpLD+jSD6yMSUR6/kK/ZjdM2Wbn7Cpm89/OdzUd947LbHFvn478giEAD2xxO1IKQchimmSkf1gdfL1SViPI5W0dQOY0kX8+NHLIz33vNW4Cp3Fq5NXgvmjWa1IjC/GPN0ZNgHrvO5hLBTlgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767785368; c=relaxed/simple;
	bh=i1yo2t54coFzK3rbZvyf0Jb3hljZY56To9lo5lRmA/0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RPEHaVgvks2keFJ/iTN2H1iHwaMjGBCNHHPhxYAGkYQpad4x3C8OfHQGXu7L60CXvIJqWhUkCZYm2EFE7pByUzp699x/yc9TsJxEUqiaQApEi1Jt9BT0HF5Z8KN+LCRSGDVHahajdBMdFt8GvCnggl8iD9719rSkxcbomeGSTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=t7B8QgSm; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1c6e8e56ebbc11f0942a039f3f28ce95-20260107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FFpEL9NcSyNwFOdBNUyHmSYnBxBxO+PAWBfQ2Qv2ozs=;
	b=t7B8QgSmgoAeQx87QOqBVhGzN4bRJIy88/WK/5DJA5Ydr0SFX4U/ax1U5XkQJ+bCwTkEjV1yLsWfWz7AYrvqZPxLLc22A+J4WRmGHXwagN8ZEZ6W+cU+VAVVyb+dBykVM2+QD9GHpIXObcsYxkyuTPVIbDnigbireQHci3I9ojI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.9,REQID:815aec23-fa90-4a52-a056-a6b17772bbfd,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:5047765,CLOUDID:69617c26-5093-468b-b7e7-d8195251fc6e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1c6e8e56ebbc11f0942a039f3f28ce95-20260107
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1712382546; Wed, 07 Jan 2026 19:29:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 19:29:19 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 19:29:19 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Macpaul
 Lin <macpaul.lin@mediatek.com>, "Garmin . Chang" <Garmin.Chang@mediatek.com>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: Jian Hui Lee <jianhui.lee@canonical.com>, "Andy . Hsieh"
	<andy.hsieh@mediatek.com>, Zoran Zhan <zoran.zhan@mediatek.com>, Cyril Chao
	<Cyril.Chao@mediatek.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>, Ann
 Cheng <ann.cheng@arm.com>, Bear Wang <bear.wang@mediatek.com>, Pablo Sun
	<pablo.sun@mediatek.com>, Ramax Lo <ramax.lo@mediatek.com>, Macpaul Lin
	<macpaul@gmail.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, <Stable@vger.kernel.org>
Subject: [PATCH RESEND] clk: mediatek: set CLK_IGNORE_UNUSED to clock mt8188 adsp audio26m
Date: Wed, 7 Jan 2026 19:29:02 +0800
Message-ID: <20260107112902.3080554-1-macpaul.lin@mediatek.com>
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

Set CLK_IGNORE_UNUSED flag to clock adsp audio26m to prevent disabling
this clock during early boot, as turning it off causes other modules
to fail probing and leads to boot failures in ARM SystemReady test cases
and the EFI boot process (on Linux Distributions, for example, debian,
openSuse, etc.). Without this flag, disabling unused clocks cannot
complete properly after adsp_audio26m is turned off.

Fixes: 0d2f2cefba64 ("clk: mediatek: Add MT8188 adsp clock support")
Cc: Stable@vger.kernel.org
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c b/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
index dcde2187d24a..b9fe66ef4f2e 100644
--- a/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
+++ b/drivers/clk/mediatek/clk-mt8188-adsp_audio26m.c
@@ -20,8 +20,8 @@ static const struct mtk_gate_regs adsp_audio26m_cg_regs = {
 };
 
 #define GATE_ADSP_FLAGS(_id, _name, _parent, _shift)		\
-	GATE_MTK(_id, _name, _parent, &adsp_audio26m_cg_regs, _shift,		\
-		&mtk_clk_gate_ops_no_setclr)
+	GATE_MTK_FLAGS(_id, _name, _parent, &adsp_audio26m_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_no_setclr, CLK_IGNORE_UNUSED)
 
 static const struct mtk_gate adsp_audio26m_clks[] = {
 	GATE_ADSP_FLAGS(CLK_AUDIODSP_AUDIO26M, "audiodsp_audio26m", "clk26m", 3),
-- 
2.45.2


