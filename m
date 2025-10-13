Return-Path: <stable+bounces-184681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CB0BD4A71
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1457C4F4AFC
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5D03115B1;
	Mon, 13 Oct 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XKSKSQGm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378552FE58D;
	Mon, 13 Oct 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368136; cv=none; b=M+HWb/zf6v3LZlBuKLZdJsBTSP6djAH11EH8uLPWExnOYHCR8cLJ9S3gWZXnpZFiXpsESyvfPsXRRLogAgE+II56jtTV194lPnTvSlrNP0pkV1LYzPz5rawaf6qTYo3ggeKgeTGfKCEBIhtQ575FWbY2K4tQerKVEOrCx+a4RqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368136; c=relaxed/simple;
	bh=EsFeKI4TYwHJ39eL+IVgW4cwCflY4Vu6C3ErGuD6VVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1MkQpbSH8tc8gZBGJo0OOlKdkgg6nBfO2ecA2MoQZ9G1OuTBo836hxOfkdKFzD4jYFKSJcdwZyr3OT9Zee2qPObsiZr1dfErVQsx66lwBya3DG17frw73etallGQG1jMq/GZh9RLQCSZdbZeh3UPMDD3BDTlvo6RAUknpx/wJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XKSKSQGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17EDC4CEE7;
	Mon, 13 Oct 2025 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368136;
	bh=EsFeKI4TYwHJ39eL+IVgW4cwCflY4Vu6C3ErGuD6VVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKSKSQGmCJ+An05ARL4z2Cc5RhHH9n+COU0wrPXMhhTTSdnIJ2xiS57U/LN8Lj57a
	 0P+9+A1XC007BTCt9jZRYtwxZ38p4CDOM7+bQGgYDEsDcnmdJOfs0YgFDPTN911d61
	 Q5149drp9XO3O1VldEq5/k55ZUFGyTazho+dN+wQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roger Lu <roger.lu@mediatek.com>,
	Johan Hovold <johan@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 056/262] soc: mediatek: mtk-svs: fix device leaks on mt8183 probe failure
Date: Mon, 13 Oct 2025 16:43:18 +0200
Message-ID: <20251013144328.146780012@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 6ab4f79ea92324f7f2eb22692054a34bbba7cf35 ]

Make sure to drop the references taken by of_find_device_by_node() when
looking up the thermal sensor and opp devices during probe on probe
failure (e.g. probe deferral) and on driver unbind.

Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
Cc: Roger Lu <roger.lu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20250909095651.5530-2-johan@kernel.org
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/mediatek/mtk-svs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 9a91298c12539..cf9f5e6af6472 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2167,6 +2167,13 @@ static struct device *svs_add_device_link(struct svs_platform *svsp,
 	return dev;
 }
 
+static void svs_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 {
 	struct device *dev;
@@ -2218,11 +2225,13 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 {
 	struct device *dev;
 	u32 idx;
+	int ret;
 
 	dev = svs_add_device_link(svsp, "thermal-sensor");
 	if (IS_ERR(dev))
 		return dev_err_probe(svsp->dev, PTR_ERR(dev),
 				     "failed to get thermal device\n");
+	put_device(dev);
 
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		struct svs_bank *svsb = &svsp->banks[idx];
@@ -2232,6 +2241,7 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 		case SVSB_SWID_CPU_LITTLE:
 		case SVSB_SWID_CPU_BIG:
 			svsb->opp_dev = get_cpu_device(bdata->cpu_id);
+			get_device(svsb->opp_dev);
 			break;
 		case SVSB_SWID_CCI:
 			svsb->opp_dev = svs_add_device_link(svsp, "cci");
@@ -2248,6 +2258,11 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),
 					     "failed to get OPP device for bank %d\n",
 					     idx);
+
+		ret = devm_add_action_or_reset(svsp->dev, svs_put_device,
+					       svsb->opp_dev);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.51.0




