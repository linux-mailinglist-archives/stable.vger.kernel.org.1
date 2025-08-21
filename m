Return-Path: <stable+bounces-171992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144C3B2F8BB
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CC05A1E36
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1271F31196E;
	Thu, 21 Aug 2025 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QaPvJl14"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558C3112BD
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780237; cv=none; b=B9hejHfMmHZYH7vvEho75dDEt/7SN+mFybpLVkD0oJc8/OVIxO1XRxAXUBRXimQhqTTe3lzDdXNHjXW21vvb4AyySErjkruik3o3RN0m9AVPwOCaJxCegPsD9uVePa/yngFfprGgRPoY8VkwgZTj92sBU00xo9AMzHo2nLywAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780237; c=relaxed/simple;
	bh=1sPIE38xURr0epFMvESuQDYT4FnIUr2PqqC1PCMyIKc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZFnTz4o0sj1mL6Bc7V6XNnb1J80/4OTZ4oLJ7Y9sgc1a7rY1LaFE943bbYMYNY+AAKsB5ndFeo4mJZ7J5/21sDnKTGp3AUwbM3A3ZlQHJqV9kfZuomqYp0Sa/6JNGF3FMOxk/ikkVnB1MIgU0Opk+NHVVXcvSArqcDk+acOpv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QaPvJl14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA45FC4CEEB;
	Thu, 21 Aug 2025 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780237;
	bh=1sPIE38xURr0epFMvESuQDYT4FnIUr2PqqC1PCMyIKc=;
	h=Subject:To:Cc:From:Date:From;
	b=QaPvJl14oz5U41u9TqZR8i/MU1cLyPpA7iT3dU029IcQwljuuxk4nFqpZrSE9yt2k
	 y+zXtcrAWrbV9Pn4Cmg3zkJzjrWQieegR+qe7lwpRYCBHhdmuC4UF2ZhXCQ+seGrIo
	 ajN1cww/pAiv+29GmufY/0rvZTI9/YCaEP37hyek=
Subject: FAILED: patch "[PATCH] usb: musb: omap2430: fix device leak at unbind" failed to apply to 6.1-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org,rogerq@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:43:54 +0200
Message-ID: <2025082154-deferred-sneak-f740@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1473e9e7679bd4f5a62d1abccae894fb86de280f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082154-deferred-sneak-f740@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


