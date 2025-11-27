Return-Path: <stable+bounces-197076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC32C8D74E
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 10:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6BCB4E6BAE
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10F4326D62;
	Thu, 27 Nov 2025 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M8GMUYoB"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD35F32693C;
	Thu, 27 Nov 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234841; cv=none; b=QRSQXyTxWdNb4vJygJ7rTQMKBTowsYzZy02ntcf99ZdKjeS6TwgqjmtWj4jKS91O38k/rIIXmL0nMokQkCUw9ixZAWSEr9EcrAXdq+vxNzkl9eWnupVLCG2XmRbmNIFMb7kwZkFSawnYzL3z3udP0JsaeiFAmFvaHk0Ih9jiWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234841; c=relaxed/simple;
	bh=i1yo2t54coFzK3rbZvyf0Jb3hljZY56To9lo5lRmA/0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bz4lJihN8ER8YnpnG/i97hYI2YwwWKwm2UJ3E9uXSKUc2W3S+KDVPJH2fHeVcBnL5DgG9eB9mNk5zObiMU5essPyQiHfQoXO6VYJ09RsK09srNni96aVHNRWeEsRYIlPASsMTcOOeltZhZ2CNT9W/ZIrYg+BQ1mSMUrQxpmsYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=M8GMUYoB; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 61fd7a56cb7111f0b33aeb1e7f16c2b6-20251127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FFpEL9NcSyNwFOdBNUyHmSYnBxBxO+PAWBfQ2Qv2ozs=;
	b=M8GMUYoBKDmecaoHHy7ky4zWU8CjUCtPxVE1rFnde6OJSyqRXOxG+tn766mTROaD63CtY5R07G421hj+yZiAj/V5PEiOInUet1Yyz3ld83rRMYhP1tB7dVgwHMHy2giZXyRw1xbwe7VpapWX5IhGco324mUhzkGSUXtvA2Y1ggs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:beb50bd6-8bbf-4285-b9c8-b34c6d43fdd9,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:15c85b58-17e4-43d2-bf73-55337eed999a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61fd7a56cb7111f0b33aeb1e7f16c2b6-20251127
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1845173089; Thu, 27 Nov 2025 17:13:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 27 Nov 2025 17:13:46 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 27 Nov 2025 17:13:46 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Macpaul Lin" <macpaul.lin@mediatek.com>, "Garmin . Chang"
	<Garmin.Chang@mediatek.com>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Jian Hui Lee <jianhui.lee@canonical.com>, "Andy . Hsieh"
	<andy.hsieh@mediatek.com>, Zoran Zhan <zoran.zhan@mediatek.com>, Cyril Chao
	<Cyril.Chao@mediatek.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>, "Bear
 Wang" <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, Ramax Lo
	<ramax.lo@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, "MediaTek
 Chromebook Upstream" <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<Stable@vger.kernel.org>
Subject: [PATCH] clk: mediatek: set CLK_IGNORE_UNUSED to clock mt8188 adsp audio26m
Date: Thu, 27 Nov 2025 17:13:21 +0800
Message-ID: <20251127091321.2853940-1-macpaul.lin@mediatek.com>
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


