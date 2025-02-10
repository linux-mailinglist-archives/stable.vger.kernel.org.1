Return-Path: <stable+bounces-114695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFADA2F50B
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472F03A9939
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B9255E3D;
	Mon, 10 Feb 2025 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUTANN9W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62E24BD0B;
	Mon, 10 Feb 2025 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208055; cv=none; b=ZxNHK43Bk/4qHdxvco3KZmaulYRf57XpdqJJZHBXmimDJGh5PM8TEIS7hSFzHh6TDBYyYxnt0cV9vayHD8dXkqW53CjLgZFxaAtjRsFNOtHzG0RkaxHFSR2mbCZptAgbpp2uGNWHYZKDLoBBnT/y9P6dElEg/qxLBgPLU3g8Ic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208055; c=relaxed/simple;
	bh=V26EiT5mL/pxNNUMLsG/dGA25oNWdXvljO6PAFlqOjI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Iu4Ti+c3Y9W/upcrslGTETJM/B5Y0VtmvPn4d9NaTSsLcchh/X+i8lSjVA1sfQtnNFAAECckm2YFzq9bmcKWsQRsv3GaaMCFM/FRpz0W2FvjuNJxi1Ny2abFRsErJLHU8/ydyF1xiFxQT+YWBTxD3sdkwQ2P3ogdDy7XzRqkYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUTANN9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DB8C4CEE5;
	Mon, 10 Feb 2025 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739208055;
	bh=V26EiT5mL/pxNNUMLsG/dGA25oNWdXvljO6PAFlqOjI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nUTANN9W7dquWHQ/NP4187pKGh7HLk821eT5gKGwwbIpaeD8JRt1d7NTIDDBB4jbU
	 EuTmFxJm2/Hv6xCYqmj0wuUF6tnjUCtLER8thOgjk/z8d3Z3/kKLM9c4iur7P5vbbv
	 asgf8Cl8844O9zQWCxWUP5PqRey2ATWDXa9WW1/d+XFILBXYShpkc9pyDFHH/fVXpD
	 ScUu67Ot5I1IWNN1irYeRB05C+FIUSKCZv1fDzrJoU/mXUw7U0Tof4s8SbFIkOw1yD
	 N5roBSClFT6sbqx3myU/szPU37hRIO9tU/p/TI2KQS9HCs+7kEsSrwgdtHdvwOLoYN
	 L1DRnF8VEUzGg==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Vivek Gautam <gautam.vivek@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250209-exynos5-usbdrd-masks-v1-1-4f7f83f323d7@disroot.org>
References: <20250209-exynos5-usbdrd-masks-v1-1-4f7f83f323d7@disroot.org>
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix MPLL_MULTIPLIER and
 SSC_REFCLKSEL masks in refclk
Message-Id: <173920805196.103688.17713863876397258769.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 22:50:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 09 Feb 2025 00:29:30 +0530, Kaustabh Chakraborty wrote:
> In exynos5_usbdrd_{pipe3,utmi}_set_refclk(), the masks
> PHYCLKRST_MPLL_MULTIPLIER_MASK and PHYCLKRST_SSC_REFCLKSEL_MASK are not
> inverted when applied to the register values. Fix it.
> 
> 

Applied, thanks!

[1/1] phy: exynos5-usbdrd: fix MPLL_MULTIPLIER and SSC_REFCLKSEL masks in refclk
      commit: e2158c953c973adb49383ddea2504faf08d375b7

Best regards,
-- 
~Vinod



