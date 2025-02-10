Return-Path: <stable+bounces-114656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9BDA2F0ED
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB7C3A4F6E
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A41F8BB0;
	Mon, 10 Feb 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYsPGa1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F63E1F8BAA
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200083; cv=none; b=QsXpiMzX/yNN49sXbBEie6prMPcgAVcoZKMc00OHAOt1NyoljDHkH8jUjFytmOQ/IZ7IbvyoTH1L6H9pXf/Qworx1splkADs+MJFqn1K3o0bWTFQAaPPjaZvN5/DrNmw9X1dT8ihEoPUl5hZEGnO3uxPokQDhYl91WO8CSAvRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200083; c=relaxed/simple;
	bh=rl+nC+SgrA1bHYMhg76vLEdJO+cxrRgh4MzzmbXaV0k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FbZ/UlT46ZWan+6fu4XKMLJ7gRIAkpoqWHPJXzGH0Evd3dT5LVtgnA8e0v7yxAAMsf7q8hq2zdFB2YCviobUcvOikkcVlSAjGPC/zCINjWQ3NAHduAJGCLgrnpbnXCxY7AhPEwK5l+iyiCkBlc6mxEDLKI2+gb9nowNN6NmRaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYsPGa1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC89C4CED1;
	Mon, 10 Feb 2025 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739200083;
	bh=rl+nC+SgrA1bHYMhg76vLEdJO+cxrRgh4MzzmbXaV0k=;
	h=Subject:To:Cc:From:Date:From;
	b=JYsPGa1JfHhX8PLQCpU/tolq1h0xOFWJIW05NzoiFs2rt+6rJBqoWvhdFlWV97bNN
	 1RVLgBejTJZCUml+/fd/sRiviiASCes/rTPfpLhENTASLdmK7tpB3VT8aBJY/Sh4B7
	 Byvd+95iz6584f8MLl7V8Lhs0piGccM+VXJVn0Aw=
Subject: FAILED: patch "[PATCH] soc: mediatek: mtk-devapc: Fix leaking IO map on error paths" failed to apply to 6.1-stable tree
To: krzysztof.kozlowski@linaro.org,angelogioacchino.delregno@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:07:59 +0100
Message-ID: <2025021059-repulsive-savor-1f9d@gregkh>
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
git cherry-pick -x c0eb059a4575ed57f265d9883a5203799c19982c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021059-repulsive-savor-1f9d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0eb059a4575ed57f265d9883a5203799c19982c Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 4 Jan 2025 15:20:11 +0100
Subject: [PATCH] soc: mediatek: mtk-devapc: Fix leaking IO map on error paths

Error paths of mtk_devapc_probe() should unmap the memory.  Reported by
Smatch:

  drivers/soc/mediatek/mtk-devapc.c:292 mtk_devapc_probe() warn: 'ctx->infra_base' from of_iomap() not released on lines: 277,281,286.

Fixes: 0890beb22618 ("soc: mediatek: add mt6779 devapc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250104142012.115974-1-krzysztof.kozlowski@linaro.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index 2a1adcb87d4e..500847b41b16 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -273,23 +273,31 @@ static int mtk_devapc_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	devapc_irq = irq_of_parse_and_map(node, 0);
-	if (!devapc_irq)
-		return -EINVAL;
+	if (!devapc_irq) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ctx->infra_clk = devm_clk_get_enabled(&pdev->dev, "devapc-infra-clock");
-	if (IS_ERR(ctx->infra_clk))
-		return -EINVAL;
+	if (IS_ERR(ctx->infra_clk)) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ret = devm_request_irq(&pdev->dev, devapc_irq, devapc_violation_irq,
 			       IRQF_TRIGGER_NONE, "devapc", ctx);
 	if (ret)
-		return ret;
+		goto err;
 
 	platform_set_drvdata(pdev, ctx);
 
 	start_devapc(ctx);
 
 	return 0;
+
+err:
+	iounmap(ctx->infra_base);
+	return ret;
 }
 
 static void mtk_devapc_remove(struct platform_device *pdev)


