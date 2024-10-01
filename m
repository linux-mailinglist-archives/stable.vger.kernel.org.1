Return-Path: <stable+bounces-78359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F56C98B883
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4978C1F2288B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3156519F125;
	Tue,  1 Oct 2024 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y8uFMFnR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A519922D
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775740; cv=none; b=Z0+40aTs3klnf5vdkmdNFuVnkBUk54ey8kGsavewGqCUl7gdV3DkUazwt9SyoSKZJ2ACOg6kwTaLsnbXLnO4hQo2DMTDtU8y5UPfH/+zHkBeN+P8tDFkmBCkCEDL4xuTaOiOSGWslxYDAdXaz8a8PP6qybIqkuQHqWjnLNn0+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775740; c=relaxed/simple;
	bh=F5LGZSYQCecShSY/g/78hRNAXC1Qi4EP7wR4Ytfm+Kk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YL3eoNvxhf8+O8y/n9/9mHL6MOec8Vj7a6COmwTqD/7fq5FbypUBxuMQbEbXrVbTG8SYFtA7KZnVzI7GU+VDU8LW+86m/dwFVuTLt6/pUb9fcu0yT52ceVB0S2bF4ITuG+WsXgkVf+AlCPYdjFUyxJTG4t0Yt7iJVmBJy37bsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y8uFMFnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390A1C4CECE;
	Tue,  1 Oct 2024 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727775738;
	bh=F5LGZSYQCecShSY/g/78hRNAXC1Qi4EP7wR4Ytfm+Kk=;
	h=Subject:To:Cc:From:Date:From;
	b=Y8uFMFnRp2efq8skdpidSGJBxQZxX0VBr3jAqsKKI9pFW3h2W22C9/RialpMpYxNU
	 qBOo+G7oRZnt4H7s6TorQ334sP7mSMH50UYHv576HZBNJS35O5BTGVQZcjLuQkQqkd
	 AXzA38E+e9Q3Cud6rk5D5gXG7aZzrvnzkuWuVK7c=
Subject: FAILED: patch "[PATCH] soc: versatile: realview: fix soc_dev leak during device" failed to apply to 6.11-stable tree
To: krzysztof.kozlowski@linaro.org,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 11:42:15 +0200
Message-ID: <2024100115-dose-process-0db6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x c774f2564c0086c23f5269fd4691f233756bf075
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100115-dose-process-0db6@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:

c774f2564c00 ("soc: versatile: realview: fix soc_dev leak during device remove")
1c4f26a41f9d ("soc: versatile: realview: fix memory leak during device remove")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c774f2564c0086c23f5269fd4691f233756bf075 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 Aug 2024 20:05:24 +0200
Subject: [PATCH] soc: versatile: realview: fix soc_dev leak during device
 remove

If device is unbound, the soc_dev should be unregistered to prevent
memory leak.

Fixes: a2974c9c1f83 ("soc: add driver for the ARM RealView")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/20240825-soc-dev-fixes-v1-3-ff4b35abed83@linaro.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
index d304ee69287a..cf91abe07d38 100644
--- a/drivers/soc/versatile/soc-realview.c
+++ b/drivers/soc/versatile/soc-realview.c
@@ -4,6 +4,7 @@
  *
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -81,6 +82,13 @@ static struct attribute *realview_attrs[] = {
 
 ATTRIBUTE_GROUPS(realview);
 
+static void realview_soc_socdev_release(void *data)
+{
+	struct soc_device *soc_dev = data;
+
+	soc_device_unregister(soc_dev);
+}
+
 static int realview_soc_probe(struct platform_device *pdev)
 {
 	struct regmap *syscon_regmap;
@@ -109,6 +117,11 @@ static int realview_soc_probe(struct platform_device *pdev)
 	if (IS_ERR(soc_dev))
 		return -ENODEV;
 
+	ret = devm_add_action_or_reset(&pdev->dev, realview_soc_socdev_release,
+				       soc_dev);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(syscon_regmap, REALVIEW_SYS_ID_OFFSET,
 			  &realview_coreid);
 	if (ret)


