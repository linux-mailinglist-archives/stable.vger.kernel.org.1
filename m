Return-Path: <stable+bounces-205127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0469CCFB0EA
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 22:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 878A3304B078
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB6A34250E;
	Tue,  6 Jan 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uyqry+Hn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC78342177
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719125; cv=none; b=V4RX+cjnyVlZRKSVY1zZ3j5v/qZoWkhWxTx0DEWDQh01wdKh/bWRpChpj8mJZriIUzFXr06ZCCtBtumo60MyGJNDmPV114nBmjGKolELMzDF2WsGQOAmMqJV4wvXIJpZIfUlBBCbpOqucrVAK83OkTvcXYBvzPWNWU613qkf9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719125; c=relaxed/simple;
	bh=3TchlaZA8JkQQdpVXt7zF2ZWWS6gdryxDAtoZaGy+VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2kvfGaQUDquCj9+lZNqBdNSdmQ776q20W6P9Sl8fmEztyL1hD4Y15/W23m8Y2/LYjKZwtaH1Y/1npKUSiVJKGEXmMK81S1PiXRmuZ4YKkp3evNabUaMjD0wcCXFPuNMxHTuSJQ+c93Jv1I7nwvKQmXfcC3wBqryWdE2HlGSos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uyqry+Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D92C16AAE;
	Tue,  6 Jan 2026 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767719125;
	bh=3TchlaZA8JkQQdpVXt7zF2ZWWS6gdryxDAtoZaGy+VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uyqry+Hn9ejpvtZ3HNSHAI1MrgyoB5jWdhGH6T3mzXVHykCzbztWA8Bno1kZKkwv7
	 SBMAYL3Qk6T/HGMZkoLysn0chKw70a0rZyqjxXlC74qmi0f0oG4ux0Kmq9zjoynpGW
	 t8PaYej5/6Xu7kBOZq1kIzCv/AM/SDRKns5/4cvZZdu0gkGj/5xrunleYHfzNusAw9
	 rNZY5B3aLl0HBkFrAL+12KbaUlFzSy/ESlD3eE52hmDbLiYUBJ0ZTiLtqQeH/kZWSn
	 ASLpPowLuJTjKTkXv2Aj35jQH2MLZk/3iKKq4T2Qwj2ptaL6tlUd5RxYmz1fobx9WE
	 TPYsElVF3nK7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Frank Li <Frank.Li@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] pmdomain: imx: Fix reference count leak in imx_gpc_probe()
Date: Tue,  6 Jan 2026 12:05:17 -0500
Message-ID: <20260106170520.3081258-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106170520.3081258-1-sashal@kernel.org>
References: <2026010514-cahoots-scholar-954d@gregkh>
 <20260106170520.3081258-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 73cb5f6eafb0ac7aea8cdeb8ff12981aa741d8fb ]

of_get_child_by_name() returns a node pointer with refcount incremented.
Use the __free() attribute to manage the pgc_node reference, ensuring
automatic of_node_put() cleanup when pgc_node goes out of scope.

This eliminates the need for explicit error handling paths and avoids
reference count leaks.

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/gpc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 859193153f96..57caf30cd0db 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -405,13 +405,12 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
 static int imx_gpc_probe(struct platform_device *pdev)
 {
 	const struct imx_gpc_dt_data *of_id_data = device_get_match_data(&pdev->dev);
-	struct device_node *pgc_node;
+	struct device_node *pgc_node __free(device_node)
+		= of_get_child_by_name(pdev->dev.of_node, "pgc");
 	struct regmap *regmap;
 	void __iomem *base;
 	int ret;
 
-	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
-
 	/* bail out if DT too old and doesn't provide the necessary info */
 	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
 	    !pgc_node)
-- 
2.51.0


