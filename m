Return-Path: <stable+bounces-135609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C4A98ED9
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352757AEBF5
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0BF1A23B0;
	Wed, 23 Apr 2025 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r042y6nk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D2C1EFFB9;
	Wed, 23 Apr 2025 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420374; cv=none; b=pjxLkcHBqnxEppdDFKRmCa5iNkUaxX7E33xLltDbSyYRNv67+XePyaPOl8oeb/UfnD8dkflbgwg6NvsB9tv7tC+09gU1r+YLu/YMmjm2vTkj+Mu2Cbv84T4/FzI0boj5PB1HlM/9EztV8jGAAu762vcEVcT2E8Norp5JHv/e4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420374; c=relaxed/simple;
	bh=/sJY6dMCNdaXutJlAm1UIpKspKBLn265esQEtbDrEAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGLGsKWKfasovVQexu7UvrEVbHfsg7WTxFYp7Kf+C5NbNSS0MRlSCe+oot3MlK7Gf25aDALh1RtpfSFH4WNsX1NmxP37XY3FjVHImMeEvyiCEKIqG4WpS2c4rbW1ZfQwO0fKQqHlGtpcq9H6YDUuyLYpEHXwX4kyW3iMaZvnMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r042y6nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD92CC4CEE2;
	Wed, 23 Apr 2025 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420374;
	bh=/sJY6dMCNdaXutJlAm1UIpKspKBLn265esQEtbDrEAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r042y6nkmRHLNsGo7nNUTyFKWwGbK2bB/3zRH1MBSZr6DRZd+C6gR6hCUDOP2nUqT
	 vZ4RmSBq5YTwAnEUE0+Jz+6uKxoqX1eAjpFMDKMVmsbM48qskHqlQ93038unar9HzY
	 QI/JY6kNnB+kFhJomGxOJvghR08+R0GBSEadr6oM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 086/241] net: ethernet: mtk_eth_soc: revise QDMA packet scheduler settings
Date: Wed, 23 Apr 2025 16:42:30 +0200
Message-ID: <20250423142624.097462374@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>

[ Upstream commit 1b66124135f5f8640bd540fadda4b20cdd23114b ]

The QDMA packet scheduler suffers from a performance issue.
Fix this by picking up changes from MediaTek's SDK which change to use
Token Bucket instead of Leaky Bucket and fix the SPEED_1000 configuration.

Fixes: 160d3a9b1929 ("net: ethernet: mtk_eth_soc: introduce MTK_NETSYS_V2 support")
Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://patch.msgid.link/18040f60f9e2f5855036b75b28c4332a2d2ebdd8.1744764277.git.daniel@makrotopia.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 6a34ad6483a14..0cd1ecacfd29f 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -762,8 +762,8 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
 			break;
 		case SPEED_1000:
 			val |= MTK_QTX_SCH_MAX_RATE_EN |
-			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 10) |
-			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5) |
+			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 1) |
+			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 6) |
 			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 10);
 			break;
 		default:
@@ -3274,7 +3274,7 @@ static int mtk_start_dma(struct mtk_eth *eth)
 		if (mtk_is_netsys_v2_or_greater(eth))
 			val |= MTK_MUTLI_CNT | MTK_RESV_BUF |
 			       MTK_WCOMP_EN | MTK_DMAD_WR_WDONE |
-			       MTK_CHK_DDONE_EN | MTK_LEAKY_BUCKET_EN;
+			       MTK_CHK_DDONE_EN;
 		else
 			val |= MTK_RX_BT_32DWORDS;
 		mtk_w32(eth, val, reg_map->qdma.glo_cfg);
-- 
2.39.5




