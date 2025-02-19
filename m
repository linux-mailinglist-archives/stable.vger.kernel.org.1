Return-Path: <stable+bounces-118088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7055A3B93B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53127A6BB4
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F671DE889;
	Wed, 19 Feb 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mllAtUyU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208F1B415A;
	Wed, 19 Feb 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957201; cv=none; b=Dx+BNTpy0ul969sAefqu76XsnvTmoKaRIlVSX0SVeBb9gzt7gBsySlqIq79Id5SvFB3KmMAAQ3RC9pbCIb4CRNQ1NDywJiAbvG3/SjwDzQ92C2BUpzx/Ufp9QigX+ZwFzpnpa/xITuH5c4dXPXlnu6HtSAR9PbrXZN6LpUizsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957201; c=relaxed/simple;
	bh=LMseFM8re0lhYMQNIR8WzqjmLY5I4ekyGj/Rc/SlIHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtUhOtu6FnxRX3g8JYcm9WjQzEkB99SYvV0ariFm36pGYzMRKT/TJe/2dkFRh9eJzLHwtjhobdol5Ns4biYUL1WhhldrKjhFi+H0NoGdx/9bc5N/uPuImrtdVkRt1PB2QJVSB6SeDGZeRjAbShbvF/utMbcUrNREZqDTUUmklaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mllAtUyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BD4C4CEEA;
	Wed, 19 Feb 2025 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957201;
	bh=LMseFM8re0lhYMQNIR8WzqjmLY5I4ekyGj/Rc/SlIHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mllAtUyUCpTAK1QdUwocwKdk99QS1OPwATFpeko/BvrOxQScdubpPxf1ciJUo6z5p
	 izGj5wtK3qLiPTYxZQqkSEcquR7W1GPwZjb2woryHCwNhMApFiKZUEBwl+A3EdSh9b
	 tYBrJHI3NaCuyBAvIOwR2Stajg1Y3Wd2YwzVxVoo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6.1 443/578] pinctrl: samsung: fix fwnode refcount cleanup if platform_get_irq_optional() fails
Date: Wed, 19 Feb 2025 09:27:27 +0100
Message-ID: <20250219082710.428246784@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 459915f55509f4bfd6076daa1428e28490ddee3b upstream.

Commit 50ebd19e3585 ("pinctrl: samsung: drop pin banks references on
error paths") fixed the pin bank references on the error paths of the
probe function, but there is still an error path where this is not done.

If samsung_pinctrl_get_soc_data() does not fail, the child references
will have acquired, and they will need to be released in the error path
of platform_get_irq_optional(), as it is done in the following error
paths within the probe function.

Replace the direct return in the error path with a goto instruction to
the cleanup function.

Cc: stable@vger.kernel.org
Fixes: a382d568f144 ("pinctrl: samsung: Use platform_get_irq_optional() to get the interrupt")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://lore.kernel.org/r/20241106-samsung-pinctrl-put-v1-1-de854e26dd03@gmail.com
[krzysztof: change Fixes SHA to point to commit introducing the return
 leading to OF node leak]
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1149,7 +1149,7 @@ static int samsung_pinctrl_probe(struct
 
 	ret = platform_get_irq_optional(pdev, 0);
 	if (ret < 0 && ret != -ENXIO)
-		return ret;
+		goto err_put_banks;
 	if (ret > 0)
 		drvdata->irq = ret;
 



