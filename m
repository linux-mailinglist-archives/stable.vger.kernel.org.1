Return-Path: <stable+bounces-78362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A4198B886
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF25C2830E4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945F1A01A1;
	Tue,  1 Oct 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cx9Qn+iY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8A19F42A
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775747; cv=none; b=O/yEI16j/2UG7eEBeBD+Hl/+3eoelaLaDBcvCxAi+l+6bDYCBU4hkoh3GlTmH5e9wu6pMuUNBPyvbBDGXKzQ+/gRny5DK4JoAEoojlSSoMKyv+DHSq3whdBmCzhsdyFhpK7c1DdT6x8eQvTJYVbF35Zn183IXeYCSnBSwhelXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775747; c=relaxed/simple;
	bh=AQFIF1KCN5Im2ABJfjSmcD2v4Y8EzVz6ApQ44xUQuJo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=elnj5ZWNZ9Qz2BNWtYRyslWlpYhSCr2dlcfy71vvDQJ5dw9KDzQZeS0DpzAWF+ug2arDU+bqszp8fb9kBeC7xFoUOj/Jgv7rybgMHab+HvHmbOd9gWGze997qFWa5Y20fNFayyVgeZBcSaBJQE/2YTRStKdEJidGwLP/ZQdfZ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cx9Qn+iY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1AAC4CECD;
	Tue,  1 Oct 2024 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727775747;
	bh=AQFIF1KCN5Im2ABJfjSmcD2v4Y8EzVz6ApQ44xUQuJo=;
	h=Subject:To:Cc:From:Date:From;
	b=Cx9Qn+iYmeZelsnvjPsvdWGbWxjrcWbwiDrFS9zbWneKIDF2US89nVQZ/VxAG+pFq
	 VPiFFEtcr7MKmrAyq/u/QZdG4LLEKiQoIU+Mdq4a1OIn4AJwKKDhdJM7w3gXJsQj9r
	 gLznEWpcYQHxEQepy9wccMbd0w7soMXks5EZK1PU=
Subject: FAILED: patch "[PATCH] soc: versatile: realview: fix soc_dev leak during device" failed to apply to 6.1-stable tree
To: krzysztof.kozlowski@linaro.org,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 11:42:17 +0200
Message-ID: <2024100117-railroad-ripening-d584@gregkh>
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
git cherry-pick -x c774f2564c0086c23f5269fd4691f233756bf075
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100117-railroad-ripening-d584@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


