Return-Path: <stable+bounces-171994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADE7B2F8CF
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4517B3A5BCD
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C78B311974;
	Thu, 21 Aug 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fOVZmXbw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956731076E
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780250; cv=none; b=UNI9zcwMao+d/AK3dQ4R8cd4vPf3TZZlIkMvOF2W8mibEYp7b6dTS1zC5ZsP5pSSLrBXRexSbBSeT7AYRkeNzrAxMvjrnzzn9WNfR6ZqdKsPUMGsA4fTj9LbfBrF8qe4FUOPBfVYPQqPp7EnlkiGgJXMcWRgnCKhg7miyrffaq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780250; c=relaxed/simple;
	bh=dzDY4KZPBK7p5SCkpv8ckXgE5FIK+eQx3QOf/L+DPG0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q6on0S9q9+diW8AigIkT1uskr/Dv1hAStGFNfH3zU9xijTWX6CVrGQYzR7R0k1IJxWXxjyre5xmkhei8iJV6tlREsdGK3mD16tPOmYRQxD+NPmFiSusU1P0jswE/UE0Wa+qYrNnFHwa1bZxKfzcItmEY9gnzDY6tkTcC/ZbgK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fOVZmXbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1E1C4CEEB;
	Thu, 21 Aug 2025 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780249;
	bh=dzDY4KZPBK7p5SCkpv8ckXgE5FIK+eQx3QOf/L+DPG0=;
	h=Subject:To:Cc:From:Date:From;
	b=fOVZmXbwdTzGT5dahkk6XAkxx0MCwGon8FsHVXHcutWJvnqjYYiTvC3EwENLp8ZHZ
	 O/TN3ZSgfyuUVfRtly4DnierkeCzcU2B8SslHD+XBQve2N8ZaX0DUVxWdOXUbK6p5Q
	 vea6EXQ8UErNDAGkD+DntZq/n4Hp8ioiKOZ6Dbrk=
Subject: FAILED: patch "[PATCH] usb: musb: omap2430: fix device leak at unbind" failed to apply to 5.4-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org,rogerq@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:43:55 +0200
Message-ID: <2025082155-sympathy-finally-e1ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 1473e9e7679bd4f5a62d1abccae894fb86de280f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082155-sympathy-finally-e1ad@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1473e9e7679bd4f5a62d1abccae894fb86de280f Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 24 Jul 2025 11:19:09 +0200
Subject: [PATCH] usb: musb: omap2430: fix device leak at unbind

Make sure to drop the reference to the control device taken by
of_find_device_by_node() during probe when the driver is unbound.

Fixes: 8934d3e4d0e7 ("usb: musb: omap2430: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20250724091910.21092-5-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 2970967a4fd2..36f756f9b7f6 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -400,7 +400,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	ret = platform_device_add_resources(musb, pdev->resource, pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	if (populate_irqs) {
@@ -413,7 +413,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (!res) {
 			ret = -EINVAL;
-			goto err2;
+			goto err_put_control_otghs;
 		}
 
 		musb_res[i].start = res->start;
@@ -441,14 +441,14 @@ static int omap2430_probe(struct platform_device *pdev)
 		ret = platform_device_add_resources(musb, musb_res, i);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to add IRQ resources\n");
-			goto err2;
+			goto err_put_control_otghs;
 		}
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	pm_runtime_enable(glue->dev);
@@ -463,7 +463,9 @@ static int omap2430_probe(struct platform_device *pdev)
 
 err3:
 	pm_runtime_disable(glue->dev);
-
+err_put_control_otghs:
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 err2:
 	platform_device_put(musb);
 
@@ -477,6 +479,8 @@ static void omap2430_remove(struct platform_device *pdev)
 
 	platform_device_unregister(glue->musb);
 	pm_runtime_disable(glue->dev);
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 }
 
 #ifdef CONFIG_PM


