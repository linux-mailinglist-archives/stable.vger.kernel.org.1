Return-Path: <stable+bounces-205121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6DDCF9316
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6DF2304EBE1
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3BD22F77B;
	Tue,  6 Jan 2026 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7PeoYT2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A590227BA4
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714973; cv=none; b=sFwdeaywSimVyHhWxBsCtNtvGKqGr9XUr6tIIhaXbvcYZ7TmCGf2ieyBXN9522sEOQcmaTR1FtGu5BxwEJoJMZ16UfFCg3sTVnvr0Xke+Cel73e/oZvkTDTZxCs+OHz7PK2HfwcvYe/TvRuxViXQHdqHchc9QMwuOMvVzdbdFgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714973; c=relaxed/simple;
	bh=2566f26oVNqH4CdqBJwOcbDvRrScgHLNSqtEEJXpxE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drRSSgDKtvdmuWaCiqmDuT3d0OZL166tdN/cOpKXGWUTH7xp4w35bfGnNx5Aaf/0hYFMNRGg7qYmNzYg3Wl9r4WdbMrSXszEeAQwQ0c2qKrAJhkLHtZzgpfhTCIDEvavpq0yfOA9MekTQ9NgORmJGJGSFWL+Vu8TyDX1eDUbVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7PeoYT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85869C16AAE;
	Tue,  6 Jan 2026 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767714973;
	bh=2566f26oVNqH4CdqBJwOcbDvRrScgHLNSqtEEJXpxE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7PeoYT2A0TM2rfNPB3AyagxGkfRIMCF5M8OwmhSAf9z31Rutc60sxqySHmr31J3v
	 WMdidJDiz+O1E1zDiotQqw0OeTCHiElzEPIzg8kLgDeFRYK5W/snXRUIBs6M3K9tQl
	 m99VN1J0N338/KT/7tFVPhHl8Eq8Gmafq877q9cBWPmnVssTooSB75jSFl8vE1FszG
	 VKKpF/8Lv6Sl9OSAQbnJfyBWsDWqBsI8JjtcFP5YaCmgABDeSdQrVZ/Deu2NNVYLt1
	 WOpZcDsuMFhBzzJycG/k4DHmOr1Hia9TF6X6PN6c6i6RzVWnWSt/rNV2yiHzMAZLuX
	 hKUvhtLuBYnnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Frank Li <Frank.Li@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] pmdomain: imx: Fix reference count leak in imx_gpc_probe()
Date: Tue,  6 Jan 2026 10:56:03 -0500
Message-ID: <20260106155609.3056915-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106155609.3056915-1-sashal@kernel.org>
References: <2026010514-aerospace-cathouse-bd44@gregkh>
 <20260106155609.3056915-1-sashal@kernel.org>
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
 drivers/pmdomain/imx/gpc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 9ccab78c8986..45625b6be62d 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
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


