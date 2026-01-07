Return-Path: <stable+bounces-206181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9388CFF05E
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 18:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4727833369A8
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477353596FF;
	Wed,  7 Jan 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBlp4ufA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273F272E56
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802453; cv=none; b=lyUrEcGCo4hjMRRInz158oq1/4flUGtOAqocdJ12VAk0btnNN9KJozQ/B7z/VN6EZLjDk1tEc+cHZGe7jig30uBzgB8C+wYKyfbL5Atk6rCNg3Ara0xYqemBQkbmBEjJMy62xXTKJUsSozX98mFodvsXh1SPVYvg55mNJ3DjZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802453; c=relaxed/simple;
	bh=DLI+FuYKAkyyISE2zX5uTpKb7VUwwntL+GhNGjZv53Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVt1SdZ9fiZI6rZZ7g7abjG+YcVtEXBE5srPJsKiIbvERkdRFuICzXTznhpV37I4nr+LR5VFZbhVYLHq2sS8Z14pN72pvPqMEWOaGN8Dc6ZjJefIcD2HFhCUo01o/f84Eoazu5BoHq4IyQntYm1hYKky5WJyWmjFS7xzm8v+ESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBlp4ufA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67721C4CEF1;
	Wed,  7 Jan 2026 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767802451;
	bh=DLI+FuYKAkyyISE2zX5uTpKb7VUwwntL+GhNGjZv53Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBlp4ufAzoYDT5Yp3LdxEXa7VdjxHC1ta7mTGkMop9tP3tr50yDadRYPf7xi/0KO5
	 9k5IOHkcRBw6rYuZ6X17qJRmg7wtsGfNJ1lZE84lTXNP2+x3siKlmmFX0RAYqH3geI
	 S4O60zBm0Nk8D4UScb+EDZvAWmbyx1batbXsX2wkIYiNqn3YQSFQj8VrtWkCkPEMlo
	 nO1iavVsL+lAR1m1xK8GsfUZkqBhIes41VWaowEWjUjSE0Un3CHdXh30jYhqy6ntVW
	 bqUZLxgwCXwNqoU9pgPY0Xpf0FDyk3cfjIOKVFMkfXxEHjdgPPhHV0oXpyFkpSfLOa
	 BNAP82QsfylDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Philipp Stanner <pstanner@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] drm/tilcdc: request and mapp iomem with devres
Date: Wed,  7 Jan 2026 11:14:07 -0500
Message-ID: <20260107161408.4074126-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010530-discard-saggy-15cd@gregkh>
References: <2026010530-discard-saggy-15cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit a196a5166e0812db267281c32fa0724fc5be6582 ]

tilcdc currently just ioremaps its iomem, without doing the (a bit more
robust) request on the memory first. The devm_ functions provide a handy
way to both request and ioremap the memory with automatic cleanup.

Replace the manual ioremap with the devm_ version.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Jyri Sarha <jyri.sarha@iki.fi>
Tested-by: Jyri Sarha <jyri.sarha@iki.fi>
Signed-off-by: Jyri Sarha <jyri.sarha@iki.fi>
Link: https://patchwork.freedesktop.org/patch/msgid/20231222115216.19218-2-pstanner@redhat.com
Stable-dep-of: a585c7ef9cab ("drm/tilcdc: Fix removal actions in case of failed probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 2f6eaac7f659..c79613b66154 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -182,9 +182,6 @@ static void tilcdc_fini(struct drm_device *dev)
 	if (priv->clk)
 		clk_put(priv->clk);
 
-	if (priv->mmio)
-		iounmap(priv->mmio);
-
 	if (priv->wq)
 		destroy_workqueue(priv->wq);
 
@@ -201,7 +198,6 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *node = dev->of_node;
 	struct tilcdc_drm_private *priv;
-	struct resource *res;
 	u32 bpp = 0;
 	int ret;
 
@@ -226,17 +222,10 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 		goto init_failed;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "failed to get memory resource\n");
-		ret = -EINVAL;
-		goto init_failed;
-	}
-
-	priv->mmio = ioremap(res->start, resource_size(res));
-	if (!priv->mmio) {
-		dev_err(dev, "failed to ioremap\n");
-		ret = -ENOMEM;
+	priv->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->mmio)) {
+		dev_err(dev, "failed to request / ioremap\n");
+		ret = PTR_ERR(priv->mmio);
 		goto init_failed;
 	}
 
-- 
2.51.0


