Return-Path: <stable+bounces-140063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4CEAAA4AD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0306F3BAEDB
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F9230222D;
	Mon,  5 May 2025 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxyNI98v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46326302222;
	Mon,  5 May 2025 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484008; cv=none; b=gWQtrL1AArVYw3N4Jx4laBd9vmwMSRHJLj9wFhTe6d38YtxS5a8tQZRtbPRmsWVZeVAm0JkwOqrxElzaNRKBY8SscKJWr6zp5RQ2DTj2xd65yMt1daDH463YhhBwUCMsKySITkULUTYA8xGGrdLGe70i69Ir7Ucdc3vYCqaDYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484008; c=relaxed/simple;
	bh=sxEgw4/xPQat4lCQR+i4/CUFUKOYT7PxqtHzO2BYxog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbJfx0Vi8O5dNnBObT3LT0yAxlTkxmtOfjLguvn0U/1bq7JAGTVUflrPLurWv6vSOrdTG5Hd5c827+W/SV7Vqzoq9xmWcmXPLOZDDWKly1pydEDvMAxA1JsGt1wTswUgf3o2qPhM8ZfbTmvau06NJgTkEyPF0oDHA1n2TbR7LWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxyNI98v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6598CC4CEEE;
	Mon,  5 May 2025 22:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484008;
	bh=sxEgw4/xPQat4lCQR+i4/CUFUKOYT7PxqtHzO2BYxog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxyNI98vSki8vjsvGtYKnMkq4jdcGaLRmz+np5w0Gth9KvF8Wo6hI6yvklWx/pSCT
	 ba+1/olbSu/M+h2yMDRdIla+81tvbikpTZfw7n+eu64GsZhOjitXF7eilzwXPIMRpD
	 14jvrIzOa1N0Bw6c4qr10mQA9eLQrP9bBMhNNW/Oua+mAk5IHw5KbWKcecMM2ugi0j
	 +GPpM/pa0JRQKn8W+BxJKqGSlNExt/BQRzlnDe7OXCU4zYw1kDdBejESCeCygvMk9j
	 Z13PRa3VVuHxtgJG7eMZS8sl94d3bvh8BD5mS9zffA4lOAsnNfCozxOO9jlvWcdX4V
	 NKLLc6iTs+gVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 316/642] soc: ti: k3-socinfo: Do not use syscon helper to build regmap
Date: Mon,  5 May 2025 18:08:52 -0400
Message-Id: <20250505221419.2672473-316-sashal@kernel.org>
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

From: Andrew Davis <afd@ti.com>

[ Upstream commit a5caf03188e44388e8c618dcbe5fffad1a249385 ]

The syscon helper device_node_to_regmap() is used to fetch a regmap
registered to a device node. It also currently creates this regmap
if the node did not already have a regmap associated with it. This
should only be used on "syscon" nodes. This driver is not such a
device and instead uses device_node_to_regmap() on its own node as
a hacky way to create a regmap for itself.

This will not work going forward and so we should create our regmap
the normal way by defining our regmap_config, fetching our memory
resource, then using the normal regmap_init_mmio() function.

Signed-off-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250123181726.597144-1-afd@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/ti/k3-socinfo.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 4fb0f0a248288..704039eb3c078 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -105,6 +105,12 @@ k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
 	return -ENODEV;
 }
 
+static const struct regmap_config k3_chipinfo_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
 static int k3_chipinfo_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -112,13 +118,18 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct soc_device *soc_dev;
 	struct regmap *regmap;
+	void __iomem *base;
 	u32 partno_id;
 	u32 variant;
 	u32 jtag_id;
 	u32 mfg;
 	int ret;
 
-	regmap = device_node_to_regmap(node);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = regmap_init_mmio(dev, base, &k3_chipinfo_regmap_cfg);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.39.5


