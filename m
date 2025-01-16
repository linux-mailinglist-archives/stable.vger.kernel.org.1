Return-Path: <stable+bounces-109186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D09A12F9F
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7CD1638B8
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711F8C1E;
	Thu, 16 Jan 2025 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRnmsM8J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446FC79EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987123; cv=none; b=dFdI7hb3c9htm7g9iyhVhwAM1WTH5MIQRZhnAV3CJnd6CvbzVm1EyIeTI7Y37ub+Arkt5+REIrEaeHJwFWowBQdXphC8ic1lUgYq6pWQfRKnV7kUAy4lx6Fp2wAJpScmGhq8FMisE7S4hAiX8k+hxaXy8Sn0qeaMNXunY3bKVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987123; c=relaxed/simple;
	bh=chBegomibIYso92YbKhHCfduR+LFKOn7QusaY0L0mOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QiLup8B46uIwwBQ1G/Lv2Osj0LtR8Gph52isMpl1wl8c5zjKqPhvBSCLsw+FJw3bal1cpqroyxT/X1ziqS7TN1XZ73JNgllyOp0McyDBWjRZzi0csEIP22bXchnLUTiF2m/GrofWxO/R5CSZn74RI8vVmt2lIhps97igUtgfA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRnmsM8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B267C4CEE2;
	Thu, 16 Jan 2025 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987122;
	bh=chBegomibIYso92YbKhHCfduR+LFKOn7QusaY0L0mOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRnmsM8JoXrmJjPT6t+/ktGEqEBDcuMlGbVOvfo9Lrs+R2bEunCCPaVU6k4vzpxsP
	 RqvZWE83iT/gVI4oYe7gPj0Aqoq3BT/ezDJ1evDc3fSwmyHf+GHlGGAHrW8c1oP6sJ
	 mYXCbBD1J8fps9FqBQs0xb1X8kTbbAuAsDs8RIs86pF449Ikg0CmbPsq0+Ew6iPMch
	 6YUnByUdfR7DpwU2YKIU2mVi5ISmDVP0hT4M0pijAP6A9ThItetnfBnKt0LdDQBA5T
	 hAG7CQag00+xIxBi+Ur6Bmi8iseEJpjMGZwN0++DlBMYlS/1Hjf+RuGD5Kcctekxt8
	 ntadPCXwCKqbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: lanbincn@qq.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] iio: adc: rockchip_saradc: fix information leak in triggered buffer
Date: Wed, 15 Jan 2025 19:25:17 -0500
Message-Id: <20250115164254-cba2fbc998419b75@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_C1498A587BE144C04035BCD022D5307F3C0A@qq.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 38724591364e1e3b278b4053f102b49ea06ee17c

WARNING: Author mismatch between patch and upstream commit:
Backport author: lanbincn@qq.com
Commit author: Javier Carrasco<javier.carrasco.cruz@gmail.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 4291becc8b99)
6.6.y | Present (different SHA1: 0b5e30f0aceb)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  38724591364e ! 1:  a5b3d23cd86f iio: adc: rockchip_saradc: fix information leak in triggered buffer
    @@ Metadata
      ## Commit message ##
         iio: adc: rockchip_saradc: fix information leak in triggered buffer
     
    +    commit 38724591364e1e3b278b4053f102b49ea06ee17c upstream.
    +
         The 'data' local struct is used to push data to user space from a
         triggered buffer, but it does not set values for inactive channels, as
         it only uses iio_for_each_active_channel() to assign new values.
    @@ Commit message
         Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
         Link: https://patch.msgid.link/20241125-iio_memset_scan_holes-v1-4-0cb6e98d895c@gmail.com
         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    (cherry picked from commit 38724591364e1e3b278b4053f102b49ea06ee17c)
    +    Signed-off-by: Bin Lan <lanbincn@qq.com>
     
      ## drivers/iio/adc/rockchip_saradc.c ##
     @@ drivers/iio/adc/rockchip_saradc.c: static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
    @@ drivers/iio/adc/rockchip_saradc.c: static irqreturn_t rockchip_saradc_trigger_ha
      
     +	memset(&data, 0, sizeof(data));
     +
    - 	mutex_lock(&info->lock);
    + 	mutex_lock(&i_dev->mlock);
      
    - 	iio_for_each_active_channel(i_dev, i) {
    + 	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

