Return-Path: <stable+bounces-230414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAcdDFWjxGle1wQAu9opvQ
	(envelope-from <stable+bounces-230414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 04:09:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2F332E9FF
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 04:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 805AE300D171
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 03:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D45F2F7462;
	Thu, 26 Mar 2026 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gmKO2qkA"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC72E401;
	Thu, 26 Mar 2026 03:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774494537; cv=none; b=TKDdnIe6n88uIjAYeakhL8mSpXQPYQJhpUsgIAMfbG5/oZhp5oj0RehEM2GXUp4H8z3Jr2X17kBtyfPEt+faLJx2Y5vgUWRL8gx15/7PqhwR69P3YaLaSTXUA4YdJ17lcEjmnkMP0815+Ee650V1TKP4yxNPBm7xurU8cqFiuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774494537; c=relaxed/simple;
	bh=83YvLfMANW2ji64rgtXjIkJg/JIR7LORLHkgw7KfigU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A9gCqJk0ambLVIKvWtVqstcZj+J+CBe6zxIaxpxLRU5nT0hJUrXNeeuSzt0JLw4pKqFstV2tbsgzeAOoZ7NErWXk5jlnfP8RvU2VTC/g0pQeSsjASYccEELNnY/ooBi68Wov3Kx4L6uwmJN1VP3FuL/dxSx7AazDyZBU/vNlc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gmKO2qkA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1bf569d028c111f1a02d4725871ece0b-20260326
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gc1Cfkcgv/5lPuvFF53M/UC0jd9eXEdjF+510NK63+E=;
	b=gmKO2qkAAxrmjzTqBw4aLC8P41r4tut1eZ8bTxm1h4+9Aw4KefYdSR3vJGbGSqSV0IwbO4QIMP93huCuG9cxPuxly9hiqXZV35/h2BqMt/2kBybsQemuqqOC21Yv+7bxsDHpHM1l5Gy+eBcmLRJsxM7VEcos1a01PH7/FznFfqQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:05713f7b-68cd-4266-8aa1-5a87b7f92221,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:5ab124d5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1bf569d028c111f1a02d4725871ece0b-20260326
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ot_cathy.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2012159227; Thu, 26 Mar 2026 11:08:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 26 Mar 2026 11:08:47 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 26 Mar 2026 11:08:46 +0800
From: Cathy Xu <ot_cathy.xu@mediatek.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Mengqi Zhang <Mengqi.Zhang@mediatek.com>, Wenbin Mei
	<Wenbin.Mei@mediatek.com>, Andy-ld Lu <Andy-ld.Lu@mediatek.com>, Axe Yang
	<Axe.Yang@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, Cathy Xu
	<ot_cathy.xu@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH RESEND] mmc: mtk-sd: disable new_tx/rx and modify related settings for mt8189
Date: Thu, 26 Mar 2026 11:05:16 +0800
Message-ID: <20260326030759.8107-1-ot_cathy.xu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-230414-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[mediatek.com,linaro.org,gmail.com,collabora.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ot_cathy.xu@mediatek.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: 9A2F332E9FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Disable new_tx/rx to avoid data transmission instability, and adjust
.data_tune, .stop_dly_sel, and .pop_en_cnt to fit the overall
configuration after disabling new_tx/rx, making it more compatible
with mt8189.

Fixes: 846a3a2fdff5 ("mmc: mtk-sd: add support for MT8189 SoC")
Cc: stable@vger.kernel.org
Tested-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Signed-off-by: Cathy Xu <ot_cathy.xu@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 302ac8529c4f..b2680cc054bd 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -682,15 +682,15 @@ static const struct mtk_mmc_compatible mt8189_compat = {
 	.needs_top_base = true,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
-	.data_tune = true,
+	.data_tune = false,
 	.busy_check = true,
 	.stop_clk_fix = true,
-	.stop_dly_sel = 1,
-	.pop_en_cnt = 2,
+	.stop_dly_sel = 3,
+	.pop_en_cnt = 8,
 	.enhance_rx = true,
 	.support_64g = true,
-	.support_new_tx = true,
-	.support_new_rx = true,
+	.support_new_tx = false,
+	.support_new_rx = false,
 	.support_spm_res_release = true,
 };
 
-- 
2.45.2


