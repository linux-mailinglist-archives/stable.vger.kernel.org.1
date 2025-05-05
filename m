Return-Path: <stable+bounces-140735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D58AAAAF0C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A73A2AFC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C62E2F2753;
	Mon,  5 May 2025 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRq0sTvx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590A38C41F;
	Mon,  5 May 2025 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486094; cv=none; b=GksD7MIfCfQfBnzC8b4/KIQNz+9Tj9+OGtVpgnwTR7FIQPfZNKFYUWv3lVZCoGtiSfOdP01CghioDuDM1Ekv6TJM4MHj9VgTzgGYcjmcHMazc5/pkN/d21PHSaloZKW6fVlD+7cDdfG2/6HlcQcWEDtaDKQuMfF23jWx8Xd2oH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486094; c=relaxed/simple;
	bh=lOfCLognjnfviD9lunmu6frl76a7EqZweCWg3T5tj8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pyhgv1pYItoAUn21unLKwGSlzlGk5J5t2zt35Ha8p0AaeNstlHTtx4Xg8wWMJFGEi0T7JzojiF1QmrQndK5H6h3eE4rjkfGoykwn990PlPZOPJ9SjqrcNPRChA2tcZx6uH1ZO98noNov8MgRecLteGKMnDPxBpPOcZB+dQyyE7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRq0sTvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728F8C4CEEE;
	Mon,  5 May 2025 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486093;
	bh=lOfCLognjnfviD9lunmu6frl76a7EqZweCWg3T5tj8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRq0sTvxbkxvy+3oePjm49AVw/8+xA8YaBSsrSdAGvKw5GZjWAMzE+LquoLmWxOUP
	 DjRI5OEsDh9Vqis8hafiVh1TrYElH9gxNub+RDBt30EjdzNo7ZCwK0/+H1h84/+EbS
	 p92WnQ92hhur2fOg9vns4EmDsygx5uTOX2ND+pvSpMxMr56bgqCADgjURPHcOPE9jw
	 p1O0druKl6eHAQfTOetyyoiE1JuSwdIPKIRDvPWcC75Se2i9wanw70/aVK8+fc3UrL
	 oM7LTlqy6IbheeQ2cY3qKZqLGUWY03RagOF2KFZzz1uHM4ngDgECTBFOyGkHFZFpgD
	 RnndQgyP90fpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 152/294] soc: ti: k3-socinfo: Do not use syscon helper to build regmap
Date: Mon,  5 May 2025 18:54:12 -0400
Message-Id: <20250505225634.2688578-152-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 6ea9b8c7d335c..7a3bdef5a7c0d 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -63,6 +63,12 @@ k3_chipinfo_partno_to_names(unsigned int partno,
 	return -EINVAL;
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
@@ -70,13 +76,18 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
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


