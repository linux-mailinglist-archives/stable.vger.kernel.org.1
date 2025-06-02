Return-Path: <stable+bounces-149950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2EACB516
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D611F4A6692
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCBF22A1E6;
	Mon,  2 Jun 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PurdLmeI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B722A804;
	Mon,  2 Jun 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875555; cv=none; b=fHlNh9xCmIjyuyqNLosiaJa+Gr6Pqiu4E7Am5ng9a/H4aXHz2q66lMry2/4Gxg22Rws5NCxxJzqU4PygEt+SlkBGEvpCXsX2mC9RCdLIuVyTu+KZVUxEPR0BYuN3SwMfGCMNeczs5unFetzecDC9+a+XTIyT66BSEy48vRpA3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875555; c=relaxed/simple;
	bh=eZSrehT6+kcw6vRLjHmpLKU+XB3I56Xp7jQBcAsbNVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQX5UfdrBpOiWrczocREHh2ULIct7a03crL4Z53rZsjjMhSSZ/y9Tk5hh8tjpgcjTIU//efYiYEz9cJdb1fS6CoUnTaTPp+AA1nFtYTyyk1IcgOi/v/BP+fxndkt+GaA/huR9DJGyn+1V2uceqwTgpSshQlHtFSowZPFHQw76dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PurdLmeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432A9C4CEEB;
	Mon,  2 Jun 2025 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875555;
	bh=eZSrehT6+kcw6vRLjHmpLKU+XB3I56Xp7jQBcAsbNVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PurdLmeIhh+TYTdLgJ8480cXbwpFl4ZzYNpnp+oZuSgXyUUd45SaygSAugnzED2Vs
	 Dol9TcvMZPKinGtgwz9lagVz6bF3KPAysiOl26H6Oq6P9nUE4fw0IrQLDFUsd5y6A1
	 xm8dAdP02ZgWSSXIKP6v4cAHj1nBy4qiw8K7tPgY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	CK Hu <ck.hu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 172/270] drm/mediatek: mtk_dpi: Add checks for reg_h_fre_con existence
Date: Mon,  2 Jun 2025 15:47:37 +0200
Message-ID: <20250602134314.249868418@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ac75c10aed2f6..3a58d3dfd558f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -340,12 +340,13 @@ static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
 
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




