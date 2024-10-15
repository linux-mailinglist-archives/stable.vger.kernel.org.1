Return-Path: <stable+bounces-85505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1459B99E79A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41CD2834CE
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC441E7640;
	Tue, 15 Oct 2024 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hfcGsRgn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FB1D0492;
	Tue, 15 Oct 2024 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993341; cv=none; b=ZN+AD2Xq1wFVi0064FQ/MyJbYk638lbxn8M9AMCKKVRHKJfRC8dnBCyxp4Xc+lvQ55t8KeVG5S+Lw5TYl9sLa/MksmMJsrrWez5nFBs3j1fejWtICMQuSanitnjX61XANO9h/RVOqayio1RLui4fdrzxULMQDKGPEY13JqXt5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993341; c=relaxed/simple;
	bh=L+EHNQW1tq/RK2Kv40U5ZWQR0U0syXLWqnO+gkeOhvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdUIw6k595vaksLkHjVLtgzPuJVo4zyoqwF/ozDfaFqsKGud+uZhc63BHdG1KBUQ3vfqUoR3YedevaWzGWvMYunmA/lGDE5yPdQuS29/k0oqBtBfxhER5WjT0LxqbtCZYn5Oi0ApJrag5MEt9f7D4vo+YGnMRZZouqQ4osHO3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hfcGsRgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AD9C4CEC6;
	Tue, 15 Oct 2024 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993341;
	bh=L+EHNQW1tq/RK2Kv40U5ZWQR0U0syXLWqnO+gkeOhvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfcGsRgnFCLUA8eSFX2rWLY9YAT0zSRYZGystbSHnFqsePChTchNbv/zBpmltLhM5
	 so7Is8qyDdHHqY7Ggbn1V6HbqBnj1E48hxyLlpY5IdEbbh5lIiQrFKU0EjAYKTQpx0
	 vsPJVSjyzmZUOVdGEd1fH1wM0FVPKVNkiPy4lL+w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 351/691] soc: versatile: realview: fix soc_dev leak during device remove
Date: Tue, 15 Oct 2024 13:24:59 +0200
Message-ID: <20241015112454.277489730@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c774f2564c0086c23f5269fd4691f233756bf075 ]

If device is unbound, the soc_dev should be unregistered to prevent
memory leak.

Fixes: a2974c9c1f83 ("soc: add driver for the ARM RealView")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/20240825-soc-dev-fixes-v1-3-ff4b35abed83@linaro.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/versatile/soc-realview.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
index d304ee69287af..cf91abe07d38d 100644
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
-- 
2.43.0




