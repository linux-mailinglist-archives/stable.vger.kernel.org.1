Return-Path: <stable+bounces-141116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB864AAB5EF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4A37B690D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD1531FA8A;
	Tue,  6 May 2025 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR+VqgbM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D6299ABC;
	Mon,  5 May 2025 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485157; cv=none; b=Izd6H793N5KGL475nhm8qoi8ZhuXY5lT+L1vCvCFPlYcNclnxXaEe+pqKUGZuzi7PkVu8yCQi82Nb4KJmzjMDTScbBKBfp2nVShTWstrL+If0XV53nSuxSRjDEBQ9byeh+Np0LZk0aHHLK7mAId6CYsyHytMKmcGu+IsQY4NxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485157; c=relaxed/simple;
	bh=BGOI489bdY00iXxdONJ68NPbmk9zDk85Z0+dGBRltEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LwLX6L6si1n9pV8e4/m6cDE/BgLhZM9kWS7BEWvl9C0l1rAjNFmqQ1AYuoNl1MlktXHyY9NYpm7uVVEH0RfiRHTv1kmWM9bCQOIg5NfOcvwEX8h2/Xf7iIDkiRfZwnQppSELpVMzAcWVh0B3YXonI6Ib2JW+auMrZto3NIpwTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR+VqgbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA434C4CEF1;
	Mon,  5 May 2025 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485156;
	bh=BGOI489bdY00iXxdONJ68NPbmk9zDk85Z0+dGBRltEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hR+VqgbMMedWHzMIG7brGj6BJD0e/2YTyVs29NTzCxrg/EQp/koCMT6bmukPJ6geV
	 7x5CXOOicjN0ec6oWFBInk2OX66WgL8Ddhnx3MVoLDeOhqc6ekgmeXuNoZUgkIOn4M
	 Ujlv8p/L1prJRmxDBEd2C+wZcmkLNpl57QXoe5FjZsVtJfw/f63pduuqraQBuGAqEF
	 8B4ytN+onLyOwmXkEJxWc6GWgTBqxs+9CuAlCC2J2ASVydKmlPEdcV2ODp/dkeGOQo
	 oDRjemhGy+7iLvEDru5h92m0PSgLYZKpqmJZ6i/x7X17YMsEvdiDUMG03Mio/zMtoP
	 B//2DTUvAVW8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 190/486] soc: mediatek: mtk-mutex: Add DPI1 SOF/EOF to MT8188 mutex tables
Date: Mon,  5 May 2025 18:34:26 -0400
Message-Id: <20250505223922.2682012-190-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 694e0b7c1747603243da874de9cbbf8cb806ca44 ]

MT8188 uses DPI1 to output to the HDMI controller: add the
Start of Frame and End of Frame configuration for the DPI1
IP to the tables to unblock generation and sending of these
signals to the GCE.

Link: https://lore.kernel.org/r/20250212100012.33001-2-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/mediatek/mtk-mutex.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 5250c1d702eb9..aaa965d4b050a 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -155,6 +155,7 @@
 #define MT8188_MUTEX_MOD_DISP1_VPP_MERGE3	23
 #define MT8188_MUTEX_MOD_DISP1_VPP_MERGE4	24
 #define MT8188_MUTEX_MOD_DISP1_DISP_MIXER	30
+#define MT8188_MUTEX_MOD_DISP1_DPI1		38
 #define MT8188_MUTEX_MOD_DISP1_DP_INTF1		39
 
 #define MT8195_MUTEX_MOD_DISP_OVL0		0
@@ -289,6 +290,7 @@
 #define MT8188_MUTEX_SOF_DSI0			1
 #define MT8188_MUTEX_SOF_DP_INTF0		3
 #define MT8188_MUTEX_SOF_DP_INTF1		4
+#define MT8188_MUTEX_SOF_DPI1			5
 #define MT8195_MUTEX_SOF_DSI0			1
 #define MT8195_MUTEX_SOF_DSI1			2
 #define MT8195_MUTEX_SOF_DP_INTF0		3
@@ -301,6 +303,7 @@
 #define MT8188_MUTEX_EOF_DSI0			(MT8188_MUTEX_SOF_DSI0 << 7)
 #define MT8188_MUTEX_EOF_DP_INTF0		(MT8188_MUTEX_SOF_DP_INTF0 << 7)
 #define MT8188_MUTEX_EOF_DP_INTF1		(MT8188_MUTEX_SOF_DP_INTF1 << 7)
+#define MT8188_MUTEX_EOF_DPI1			(MT8188_MUTEX_SOF_DPI1 << 7)
 #define MT8195_MUTEX_EOF_DSI0			(MT8195_MUTEX_SOF_DSI0 << 7)
 #define MT8195_MUTEX_EOF_DSI1			(MT8195_MUTEX_SOF_DSI1 << 7)
 #define MT8195_MUTEX_EOF_DP_INTF0		(MT8195_MUTEX_SOF_DP_INTF0 << 7)
@@ -472,6 +475,7 @@ static const u8 mt8188_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_PWM0] = MT8188_MUTEX_MOD2_DISP_PWM0,
 	[DDP_COMPONENT_DP_INTF0] = MT8188_MUTEX_MOD_DISP_DP_INTF0,
 	[DDP_COMPONENT_DP_INTF1] = MT8188_MUTEX_MOD_DISP1_DP_INTF1,
+	[DDP_COMPONENT_DPI1] = MT8188_MUTEX_MOD_DISP1_DPI1,
 	[DDP_COMPONENT_ETHDR_MIXER] = MT8188_MUTEX_MOD_DISP1_DISP_MIXER,
 	[DDP_COMPONENT_MDP_RDMA0] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA0,
 	[DDP_COMPONENT_MDP_RDMA1] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA1,
@@ -686,6 +690,8 @@ static const u16 mt8188_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] =
 		MT8188_MUTEX_SOF_DSI0 | MT8188_MUTEX_EOF_DSI0,
+	[MUTEX_SOF_DPI1] =
+		MT8188_MUTEX_SOF_DPI1 | MT8188_MUTEX_EOF_DPI1,
 	[MUTEX_SOF_DP_INTF0] =
 		MT8188_MUTEX_SOF_DP_INTF0 | MT8188_MUTEX_EOF_DP_INTF0,
 	[MUTEX_SOF_DP_INTF1] =
-- 
2.39.5


