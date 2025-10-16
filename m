Return-Path: <stable+bounces-186025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F03E4BE3643
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FEE54E6AC5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A348530648D;
	Thu, 16 Oct 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2KLXwiDs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037D41AAC
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618089; cv=none; b=I0goBO3nrnDRwYUyBskez9F0cowj3i3lGKDrd1g6RpqgnzZlvHQorRR6Q7McXocmJmceQDmMmOxhn+JGMnaFMTKt8oMbNFnEHFZJTweYS771iT1/xb9U+PykY4ccfnLmL6fDKZkfuXZpYNjc6SyLJS5X8C96BqFX24bxVi89k0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618089; c=relaxed/simple;
	bh=QBB9BnFdg7GaiI07hORDhoZyzllLUO5CFEFHI/+MIZw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PQvg515vPxd24b+e5glxc+NOQCj11lrHdkHy9oTwJm3mNUIv95H8k+G209OcvPzPeQljyQgzI+u2+mr7Uif6OjLrcFDCKKtjN3TAUu8Z2XPyotrNpZkO5Y9Cw5VZyViS5J8EHFstBeFi+Ok2fyl2Ng+XAuXJNfLK9DUiL43nvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2KLXwiDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F7CC4CEF1;
	Thu, 16 Oct 2025 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760618088;
	bh=QBB9BnFdg7GaiI07hORDhoZyzllLUO5CFEFHI/+MIZw=;
	h=Subject:To:Cc:From:Date:From;
	b=2KLXwiDst26qApoA88X+P/zv++EUJjxczdzOHzEvsAUkSu4ADfVYsVkH/SwsjPEfN
	 v68F69cFlwztgr3e8VvUMK1tQhZhZ2vrxtG/ytg+reO6lWUHVxvl5NY/9XrsIZQi4w
	 +gIDKZu3fcx60C9mK5QjAgY3UOzUy4pgTrcyOOXQ=
Subject: FAILED: patch "[PATCH] crypto: rockchip - Fix dma_unmap_sg() nents value" failed to apply to 6.1-stable tree
To: fourier.thomas@gmail.com,herbert@gondor.apana.org.au,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:34:46 +0200
Message-ID: <2025101646-unsent-pull-230d@gregkh>
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
git cherry-pick -x 21140e5caf019e4a24e1ceabcaaa16bd693b393f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101646-unsent-pull-230d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 21140e5caf019e4a24e1ceabcaaa16bd693b393f Mon Sep 17 00:00:00 2001
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Wed, 3 Sep 2025 10:06:46 +0200
Subject: [PATCH] crypto: rockchip - Fix dma_unmap_sg() nents value

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: 57d67c6e8219 ("crypto: rockchip - rework by using crypto_engine")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index d6928ebe9526..b9f5a8b42e66 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -254,7 +254,7 @@ static void rk_hash_unprepare(struct crypto_engine *engine, void *breq)
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
 	struct rk_crypto_info *rkc = rctx->dev;
 
-	dma_unmap_sg(rkc->dev, areq->src, rctx->nrsg, DMA_TO_DEVICE);
+	dma_unmap_sg(rkc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
 }
 
 static int rk_hash_run(struct crypto_engine *engine, void *breq)


