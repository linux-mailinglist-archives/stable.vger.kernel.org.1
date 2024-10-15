Return-Path: <stable+bounces-85463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606CC99E770
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A8A280ED9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8BA1D90CD;
	Tue, 15 Oct 2024 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ImqqBA/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8A1D0492;
	Tue, 15 Oct 2024 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993198; cv=none; b=F8LI576aLZ+GocxNVLci0t7vJtwRRHBt+KRsy/oo+1GqhTxtJhUYey9nv9kRVJySshUxZPoNc6XO9GHZccw4htHprHEeKJHgi3sFDlZlkYObqk4Q4Ki7DC1hJyypbtJkNTTCDPJlT3hWJERSVbMQT117GYkLRAbXWaVZMJjTDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993198; c=relaxed/simple;
	bh=z2FzzI7CSa6Ua8ED6nAuCr9lrdTBIAWjERhw/YecTKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCVdF/UzeBC2vRVf76XGQRF5FzX+VH7KG1q5E3YP+Bhc3QrTMZ0hOfcOZrMApzKNNLLGKl/PqYLiPbD3jN5NPi5Mr9fvEx5WcWcGNDWFNJII9F6e5ZjGTjTyaNX7GiywSn+2Up3jSNzejapQvoB9wAuTrV2w9PPGZKTXudzhQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ImqqBA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06383C4CEC6;
	Tue, 15 Oct 2024 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993198;
	bh=z2FzzI7CSa6Ua8ED6nAuCr9lrdTBIAWjERhw/YecTKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ImqqBA/Oz8eI4uIMerlXehkqZ9dy2NLjW0Nz35QRWlv8ByaqFn9CCDC4GhDxGjdT
	 r6pKwVzfFLTot6A+6H5rN/7J/icpRIL+4yrTrRODOGA+71/T8O191LxRuee3jUAUs5
	 5xU8Um7mHnrIZW4yRUuQweOtTm4QmmdrjVVWxWnA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen-Yu Tsai <wenst@chromium.org>,
	Guoqing Jiang <guoqing.jiang@canonical.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.15 340/691] hwrng: mtk - Use devm_pm_runtime_enable
Date: Tue, 15 Oct 2024 13:24:48 +0200
Message-ID: <20241015112453.835848990@linuxfoundation.org>
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

From: Guoqing Jiang <guoqing.jiang@canonical.com>

commit 78cb66caa6ab5385ac2090f1aae5f3c19e08f522 upstream.

Replace pm_runtime_enable with the devres-enabled version which
can trigger pm_runtime_disable.

Otherwise, the below appears during reload driver.

mtk_rng 1020f000.rng: Unbalanced pm_runtime_enable!

Fixes: 81d2b34508c6 ("hwrng: mtk - add runtime PM support")
Cc: <stable@vger.kernel.org>
Suggested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Guoqing Jiang <guoqing.jiang@canonical.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/hw_random/mtk-rng.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/hw_random/mtk-rng.c
+++ b/drivers/char/hw_random/mtk-rng.c
@@ -142,7 +142,7 @@ static int mtk_rng_probe(struct platform
 	dev_set_drvdata(&pdev->dev, priv);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, RNG_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	devm_pm_runtime_enable(&pdev->dev);
 
 	dev_info(&pdev->dev, "registered RNG driver\n");
 



