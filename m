Return-Path: <stable+bounces-104120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007759F109C
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F8218838E7
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C761E25EB;
	Fri, 13 Dec 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqNXPti2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB71E1A33
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102805; cv=none; b=pLc2xvFIBi1l/S1Iit+GcC1EIRLYt1FpdpO9U4rd7/FGw3bnZRLNZhCo7OrwY/dLxyxa7mSNbOhlo0xGK6DnwvDjmL/oPEgJxbCZ5TEWgY592r8YApanZoYJjPLGBA94a1mt8LW2xpyJqY82yOpm+TenHMRYVkkrvcnBgqQFwSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102805; c=relaxed/simple;
	bh=VwKYQDijjpSfPrFnNSkgFgLMc3InMbGXlS2nij4y//w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkXK2CJw1zEfxqB50CUm5mKApSI91DtCCpBYIhwLdkv/z68I7L676X/5xKbQ/6sYFtPENGuWui9bW75vS284ppEXs+bmmFBU06EAEhnbdhGZI9dsyK/96Py2afg2Y8eCqQT96HzaFRp9QujXhE0cAAvQ/AN8VWpXb4NKQmB+k9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqNXPti2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A40C4CED0;
	Fri, 13 Dec 2024 15:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102805;
	bh=VwKYQDijjpSfPrFnNSkgFgLMc3InMbGXlS2nij4y//w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqNXPti2CnnXeY+EHh0RJ2zcqk2+PfRl1TjwpksviMT2ZDOec59jPPQGL7np3zYQK
	 CQ1brzDLHH2Ev/nJ7xnBvDZA2Ep7N0efivQBpAV96GVQSD/jqfz2CqTaRQUM0ji8DF
	 Mig2pj0SBwSwAASh/qEVUa1wum10ooLdvrg+YloaoST56ne2eNYA00YBTVa1qzCUo9
	 P3eL+loC+uFJZN2zlsDP9biudi5p8dMKxDbZd7E/8W5P8vDBdDMHqZVTvIPHXI8QKt
	 cz6S8PvRzUjL11ZLGPaAJW15aM0CJ1BPkZvWjP/s8W/v+DygL6Rt4N3jt9GDxAH73F
	 On0ij8EgvJlvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] i2c: lpi2c: Avoid calling clk_get_rate during transfer
Date: Fri, 13 Dec 2024 10:13:23 -0500
Message-ID: <20241213090723-14b079c0f6ece394@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213064314.3560854-1-bin.lan.cn@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 4268254a39484fc11ba991ae148bacbe75d9cc0a

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Alexander Stein <alexander.stein@ew.tq-group.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d038693e08ad)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4268254a39484 ! 1:  3d20023e353b7 i2c: lpi2c: Avoid calling clk_get_rate during transfer
    @@ Metadata
      ## Commit message ##
         i2c: lpi2c: Avoid calling clk_get_rate during transfer
     
    +    [ Upstream commit 4268254a39484fc11ba991ae148bacbe75d9cc0a ]
    +
         Instead of repeatedly calling clk_get_rate for each transfer, lock
         the clock rate and cache the value.
         A deadlock has been observed while adding tlv320aic32x4 audio codec to
    @@ Commit message
         Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
         Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
         Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
    +    [ Don't call devm_clk_rate_exclusive_get() for devm_clk_rate_exclusive_get()
    +      does not exist in v6.1. ]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
     
      ## drivers/i2c/busses/i2c-imx-lpi2c.c ##
     @@ drivers/i2c/busses/i2c-imx-lpi2c.c: struct lpi2c_imx_struct {
    @@ drivers/i2c/busses/i2c-imx-lpi2c.c: static int lpi2c_imx_config(struct lpi2c_imx
      	lpi2c_imx_set_mode(lpi2c_imx);
      
     -	clk_rate = clk_get_rate(lpi2c_imx->clks[0].clk);
    --	if (!clk_rate)
    --		return -EINVAL;
     +	clk_rate = lpi2c_imx->rate_per;
    - 
    ++
      	if (lpi2c_imx->mode == HS || lpi2c_imx->mode == ULTRA_FAST)
      		filt = 0;
    + 	else
     @@ drivers/i2c/busses/i2c-imx-lpi2c.c: static int lpi2c_imx_probe(struct platform_device *pdev)
      	if (ret)
      		return ret;
      
    -+	/*
    -+	 * Lock the parent clock rate to avoid getting parent clock upon
    -+	 * each transfer
    -+	 */
    -+	ret = devm_clk_rate_exclusive_get(&pdev->dev, lpi2c_imx->clks[0].clk);
    -+	if (ret)
    -+		return dev_err_probe(&pdev->dev, ret,
    -+				     "can't lock I2C peripheral clock rate\n");
    -+
     +	lpi2c_imx->rate_per = clk_get_rate(lpi2c_imx->clks[0].clk);
     +	if (!lpi2c_imx->rate_per)
     +		return dev_err_probe(&pdev->dev, -EINVAL,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

