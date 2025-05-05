Return-Path: <stable+bounces-140034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BB3AAA42C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952001884ECF
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F492FB2C1;
	Mon,  5 May 2025 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjnPRbis"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9DB2857FD;
	Mon,  5 May 2025 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483953; cv=none; b=RGAR3PtYQK/GOtfMNTssRtEfIceKDIvgPwZAvJAcl31rx/FxtYH7iou0jloSOnJYTiQLtE1o1Bd0FgXtlj3yMOB1nkihncYhD1Vqtmf9Q7nI1iPRfZtPBC0QThVtOza3bCr/u6lWRgRkj/fFEP4FTN5cTtEaZpNjcv2C22Mvx9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483953; c=relaxed/simple;
	bh=GmF2brKbp0Nd/zkG5DqvnEuCzDunhIeoyGa4sNPEb4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQFxD2YZZYfC1ZafJSWNo/Foq/xAAcytq/2g7k+0iSbl1w7sVNBAcBaNk2cbFChXKGI5Esy3zr35OKhmdd/xmQmuPhhqW3WacVCkVxg6cqQQlNleOxPFrpI/qOBPr5Yq13il97RdwUzjVEMuMQFdagCs27G2J+Dcr8ubseESatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjnPRbis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6528C4CEEE;
	Mon,  5 May 2025 22:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483953;
	bh=GmF2brKbp0Nd/zkG5DqvnEuCzDunhIeoyGa4sNPEb4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KjnPRbisFRcJsFELiuNq/dx1zaWZuKhRKU6+R5sf/dJtUcilaTJC0eVgFwUbfyFCI
	 c7Bv3R7yz29RzYtnkKLFC0YaO7DNlfxBCSrHs4d7x/oga6fQw4OSd+5eHY3ljHu/cL
	 wBBiEF2uXODU5NebMELxHtTTBAjtXfvHo+IIZ1wmmK6FhZ86owYzBBUtfjgZtoiTBL
	 er5g1EXTCfXWGo/mSdkWIB1fyfmPqh3KORbLBnALnwvQqnlYuGNsP4eWIEZW9NrQ+a
	 cW/ovJGiug18DEqtGkfQHvYz3b1c7xKT80usMWXkjJecJZHWA2lc4Vjx8MvlJaNAPz
	 wc7cgesIyCjFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 287/642] drm/mediatek: mtk_dpi: Add checks for reg_h_fre_con existence
Date: Mon,  5 May 2025 18:08:23 -0400
Message-Id: <20250505221419.2672473-287-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 8c9da7cd0bbcc90ab444454fecf535320456a312 ]

In preparation for adding support for newer DPI instances which
do support direct-pin but do not have any H_FRE_CON register,
like the one found in MT8195 and MT8188, add a branch to check
if the reg_h_fre_con variable was declared in the mtk_dpi_conf
structure for the probed SoC DPI version.

As a note, this is useful specifically only for cases in which
the support_direct_pin variable is true, so mt8195-dpintf is
not affected by any issue.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250217154836.108895-6-angelogioacchino.delregno@collabora.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index a12ef24c77423..b7d90574df9a6 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -410,12 +410,13 @@ static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
 
 static void mtk_dpi_config_2n_h_fre(struct mtk_dpi *dpi)
 {
-	mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
+	if (dpi->conf->reg_h_fre_con)
+		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
 }
 
 static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
 {
-	if (dpi->conf->edge_sel_en)
+	if (dpi->conf->edge_sel_en && dpi->conf->reg_h_fre_con)
 		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
 }
 
-- 
2.39.5


