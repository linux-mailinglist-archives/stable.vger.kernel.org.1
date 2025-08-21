Return-Path: <stable+bounces-172191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFADB2FFF6
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3549CAA6FA2
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AEA2DCF72;
	Thu, 21 Aug 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qobOqvdJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621A82DCF5C
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793228; cv=none; b=nL7srelZyZ989DYq5DYj0JApmzxIYdFoW7HvfuUpGfauY/UiqB1ZkJTbIe+hj518nY2F1teCvz1cIfrRF040Mo+IVX6AkdHKNlj2JyxTmh7TCWH02Oh7SSmeqTDef/fPCZflCt+3k96tH7TmJE+IHElfqcGR5XaXWbEbji4qGDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793228; c=relaxed/simple;
	bh=my/Z8H85oZaRVnGLV9iFusab5U6f0ntkTFVkF+okZl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjbWksr5imjQczQQOPiB/oloPwYRrZHl64wLWcQpyIHnBK/csJUvY8xbpevSCKJyiSZ37EGyUqFcnI/BPywchXC5BCaIAHw+UcWyf6y5mcI/ar6zyejhoT/ehNrT6J02kA4ulvjqJKvGQ8f6cAzsltSmryODjqi3r412+qEfoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qobOqvdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD086C4CEED;
	Thu, 21 Aug 2025 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755793228;
	bh=my/Z8H85oZaRVnGLV9iFusab5U6f0ntkTFVkF+okZl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qobOqvdJAQDzuIc641IPWU9q/Acrv4+zyLz+IDz4Xi3w6X4b+PlcWmAqsQZZ5TRQy
	 JL13EfpP7VOK+95OlTop2Wd9wZOR62ueS9V6pAGKPxZ4p8Qvl5qR2KGb3KGx+jswmJ
	 0Tu8evGH5lRsyN4Ggl/T7LQ3Xx8MJQw9I2INARlAIZYlH6omeSTuu0Uy6pGq/M0lu2
	 t+ZDE55UJ+/HMm5+9FfnbVJJzA/qJ7Ca50f39K7b33sXIOtvcyV/+/Qra/Ve10s6t6
	 O4JH7xpXMVps1ppKMapnVxRPK9VdZ2KzKpPPuUXseGVB1JwQyqX1JCCZcM2ybX7yp/
	 w9x+PemQ1r/Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/2] usb: musb: omap2430: fix device leak at unbind
Date: Thu, 21 Aug 2025 12:20:25 -0400
Message-ID: <20250821162025.780036-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821162025.780036-1-sashal@kernel.org>
References: <2025082155-sympathy-finally-e1ad@gregkh>
 <20250821162025.780036-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 1473e9e7679bd4f5a62d1abccae894fb86de280f ]

Make sure to drop the reference to the control device taken by
of_find_device_by_node() during probe when the driver is unbound.

Fixes: 8934d3e4d0e7 ("usb: musb: omap2430: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20250724091910.21092-5-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Removed populate_irqs-related goto changes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/omap2430.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 56f4fa411e27..db4e9b46fb8a 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -476,13 +476,13 @@ static int omap2430_probe(struct platform_device *pdev)
 			ARRAY_SIZE(musb_resources));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	pm_runtime_enable(glue->dev);
@@ -497,7 +497,9 @@ static int omap2430_probe(struct platform_device *pdev)
 
 err3:
 	pm_runtime_disable(glue->dev);
-
+err_put_control_otghs:
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 err2:
 	platform_device_put(musb);
 
@@ -511,6 +513,8 @@ static void omap2430_remove(struct platform_device *pdev)
 
 	platform_device_unregister(glue->musb);
 	pm_runtime_disable(glue->dev);
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 }
 
 #ifdef CONFIG_PM
-- 
2.50.1


