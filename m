Return-Path: <stable+bounces-186084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6189BE3881
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE9F5851B6
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C2A334392;
	Thu, 16 Oct 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uwoyr2Xv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B6305E19
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619369; cv=none; b=kdpzI9OBIYt0Ip/lUbnAmgrEtswsgkjXFXJ920+RcNyHhKzYV+BgGxY5rCC5lpufSLD4AvW5M6FzE3IrStY8V5QQXp89pn/irn342AQtOMC1Q6qUto2gb8U/5rAiIC5Te4kFNxlqc/+a0Wh11E4d7vh8UYYyfuH8a0hobB2bOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619369; c=relaxed/simple;
	bh=tYK16sCtRSjTz4TSYnBMBV8aKsLQBCIFxd5DHYWsygI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QaTlqgdnNvExj8KZpFP9sTMDcegdzRtpyyph6+NGxItbBC+AMbisluk0EXtAxbYchyDT328J5nMfyrLjyoo23YrWMHMEadM5H2VGcwpRo3H48FZfNtIQX3oiBq5y3kS0EtUc+nvEReBvwAUEHOEKz8uqSVh0ta6Q4fIOCVtzjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uwoyr2Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA34C113D0;
	Thu, 16 Oct 2025 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619369;
	bh=tYK16sCtRSjTz4TSYnBMBV8aKsLQBCIFxd5DHYWsygI=;
	h=Subject:To:Cc:From:Date:From;
	b=Uwoyr2XvEopYZafXQQwljfG3NfmwksUAHgWa/uIMie7BrqJ6fQ2+hQPpdP8wDZAu6
	 gb3VoEqdTWXDpB++86nVV3Y9u5XIDSB1dFDgWK0rjocC7Vem77AX0b6hK2UJVmpXWd
	 WHGuLZxoTfYWb9zgGSLtdw0HXeA9aiofCzx4dIQE=
Subject: FAILED: patch "[PATCH] memory: samsung: exynos-srom: Fix of_iomap leak in" failed to apply to 5.4-stable tree
To: zhen.ni@easystack.cn,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:56:07 +0200
Message-ID: <2025101607-discharge-haiku-4150@gregkh>
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
git cherry-pick -x 6744085079e785dae5f7a2239456135407c58b25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101607-discharge-haiku-4150@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6744085079e785dae5f7a2239456135407c58b25 Mon Sep 17 00:00:00 2001
From: Zhen Ni <zhen.ni@easystack.cn>
Date: Wed, 6 Aug 2025 10:55:38 +0800
Subject: [PATCH] memory: samsung: exynos-srom: Fix of_iomap leak in
 exynos_srom_probe

The of_platform_populate() call at the end of the function has a
possible failure path, causing a resource leak.

Replace of_iomap() with devm_platform_ioremap_resource() to ensure
automatic cleanup of srom->reg_base.

This issue was detected by smatch static analysis:
drivers/memory/samsung/exynos-srom.c:155 exynos_srom_probe()warn:
'srom->reg_base' from of_iomap() not released on lines: 155.

Fixes: 8ac2266d8831 ("memory: samsung: exynos-srom: Add support for bank configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
Link: https://lore.kernel.org/r/20250806025538.306593-1-zhen.ni@easystack.cn
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index e73dd330af47..d913fb901973 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -121,20 +121,18 @@ static int exynos_srom_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	srom->dev = dev;
-	srom->reg_base = of_iomap(np, 0);
-	if (!srom->reg_base) {
+	srom->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(srom->reg_base)) {
 		dev_err(&pdev->dev, "iomap of exynos srom controller failed\n");
-		return -ENOMEM;
+		return PTR_ERR(srom->reg_base);
 	}
 
 	platform_set_drvdata(pdev, srom);
 
 	srom->reg_offset = exynos_srom_alloc_reg_dump(exynos_srom_offsets,
 						      ARRAY_SIZE(exynos_srom_offsets));
-	if (!srom->reg_offset) {
-		iounmap(srom->reg_base);
+	if (!srom->reg_offset)
 		return -ENOMEM;
-	}
 
 	for_each_child_of_node(np, child) {
 		if (exynos_srom_configure_bank(srom, child)) {


