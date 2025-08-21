Return-Path: <stable+bounces-172184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCC6B2FFC9
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531CF3A408D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B713C2D0C98;
	Thu, 21 Aug 2025 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlAiygll"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151C285CB6
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792857; cv=none; b=fny83ccVcD/Eatgr547PWXWLEhet4xCe7k1YJRt6YWk5mRKZMmYkeyy2s/maWbuJp/K3patYrDTfBsGLpP7cNtFfqZlrY3JUhtxJNUpYv/XV+25fuC6WGUEFmvt8M2Lrr5Na46OGayeI0C5R4AVJyIZePhoVjbQyVlzDugnV+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792857; c=relaxed/simple;
	bh=T9WxCJmXrHYQJbORE055IbWbW+I+qEC1nW7TRRxxmlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqga1kt9Vg6lcG4MPwz3e4MMGCLkev6iuSpOooTZwPth7bxOdR2vXCe7wfmDpB8Aoam4T22XHK5ETJfzZtUnZXr3PxuA/1GL5qRUcpi/VErxBXpw8plsK2HO8+mB/pUYWzJc7Ixh+6iXredB2l8QpGzLXk5Rrn3VyTdWah7SVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlAiygll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6760AC4CEF4;
	Thu, 21 Aug 2025 16:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755792857;
	bh=T9WxCJmXrHYQJbORE055IbWbW+I+qEC1nW7TRRxxmlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlAiyglls+c1/iCjxbF99RJbClILhgoDXI//4bBFpVbxvrYaDIbuTQKtWoq/+MYzH
	 KccxTHTBTIAWyL0BPM3Lh2MfiX2jeWgArFRZbW1p0u4Myjr7XOuxaZg/9W6VlB4nMv
	 vG3faYG6Ntvqv+ubgThcBEmbse7Uk6GoG8o7V2EqpgxbbtNf0YTUznNq8fLN6oPZQS
	 NfYcQGcmdY/bpFkyeDvzT52QKypqiKYPLBgJQui6IUh1JotkDkyLfT2UEPMTaEYAXV
	 KUa/LEquVKRGadEcOzAfcN/mWQY5GgsCNBwMndBFywVQgs/hNdejrVL6zPbVqbzxUm
	 dxHXj8Z9rOdqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] usb: musb: omap2430: fix device leak at unbind
Date: Thu, 21 Aug 2025 12:14:13 -0400
Message-ID: <20250821161413.775044-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821161413.775044-1-sashal@kernel.org>
References: <2025082155-easing-flavorful-b21d@gregkh>
 <20250821161413.775044-1-sashal@kernel.org>
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
index 95cfd6ef3041..b02bfcfb2ab9 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -403,13 +403,13 @@ static int omap2430_probe(struct platform_device *pdev)
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
@@ -424,7 +424,9 @@ static int omap2430_probe(struct platform_device *pdev)
 
 err3:
 	pm_runtime_disable(glue->dev);
-
+err_put_control_otghs:
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 err2:
 	platform_device_put(musb);
 
@@ -438,6 +440,8 @@ static void omap2430_remove(struct platform_device *pdev)
 
 	platform_device_unregister(glue->musb);
 	pm_runtime_disable(glue->dev);
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 }
 
 #ifdef CONFIG_PM
-- 
2.50.1


