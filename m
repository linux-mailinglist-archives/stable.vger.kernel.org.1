Return-Path: <stable+bounces-106244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A59B9FE23A
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 04:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB71161CEA
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 03:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D231422A8;
	Mon, 30 Dec 2024 03:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlJIaLbe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611213C9D4
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735528731; cv=none; b=LVaKkASv5nGBSQ8s5kdY2/K37W3KRtCpyRfjVFFAeZBqgrJPWCXsCwDt74V9SwLyiNjo64SkH37kU/+6Ps7n1fqf4D60Kzyrluy1jZFVtNeJk0EPbpGpszGaq2GYx5f7spifSCKVA+C/C2Gi5mEvetmvTgTVUsTamGhUI32t6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735528731; c=relaxed/simple;
	bh=rqhr8kj2LNw5ZTbFNDRKrqGBkknPlW07bXvwqdU13ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTEvrBM/Dan6tAkooHCf4vYtByYUR4+jZduGpyypTlsvQW2iE25LTeWWEOrfiNvdDzm9HXYrWuCkNLPRl3+mM145mauPO3NGBo8hq8N7GXbqO6hK7zbgTSl2vqBImlvEyM5t8vaRj3gnLuWGn4Lefgu7gbo7oHSEOYjOny8kUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlJIaLbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EFBC4CED1;
	Mon, 30 Dec 2024 03:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735528730;
	bh=rqhr8kj2LNw5ZTbFNDRKrqGBkknPlW07bXvwqdU13ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlJIaLbebY6txNMBLHv7NJcwgHb2gMqpbpvtJuGYUeSMQbKN/7UMVI5+YTM/0+v+D
	 uMdgCEqfXT22hNJBREUlGe575P6T9x+I4Kk+Oaq8pDWuGPJ8i/EY1jVrfVGNIs8Opa
	 4Tjwm1uPTTaaSZJarSIEm3T7UEUx2zXChbTzNs8VHqVY4Ck20NCFo7Jkcaq3fuYGaN
	 7V9qqmrn3aSWy/hZxw486jprHGeIuPpjlVLGKRIvojWrvE3ZeiQDQne0JMZAIIeaMJ
	 YTM20qyCIOJOO+Tj+YWakz7f+BxavPHB/y4sz4IzqIc4Zw44TGfVS76zJwRT49J/Dk
	 1qrrmXdHaeZRQ==
Date: Sun, 29 Dec 2024 22:18:48 -0500
From: Sasha Levin <sashal@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: stable@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 6.12.y] dmaengine: loongson2-apb: Change GENMASK to
 GENMASK_ULL
Message-ID: <Z3IRGGQ0iqya5jnA@lappy>
References: <2024122721-badge-research-e542@gregkh>
 <20241230013919.1086511-1-zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241230013919.1086511-1-zhoubinbin@loongson.cn>

On Mon, Dec 30, 2024 at 09:39:19AM +0800, Binbin Zhou wrote:
>Fix the following smatch static checker warning:
>
>drivers/dma/loongson2-apb-dma.c:189 ls2x_dma_write_cmd()
>warn: was expecting a 64 bit value instead of '~(((0)) + (((~((0))) - (((1)) << (0)) + 1) & (~((0)) >> ((8 * 4) - 1 - (4)))))'
>
>The GENMASK macro used "unsigned long", which caused build issues when
>using a 32-bit toolchain because it would try to access bits > 31. This
>patch switches GENMASK to GENMASK_ULL, which uses "unsigned long long".
>
>Fixes: 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA controller")
>Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>Closes: https://lore.kernel.org/all/87cdc025-7246-4548-85ca-3d36fdc2be2d@stanley.mountain/
>Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>Link: https://lore.kernel.org/r/20241028093413.1145820-1-zhoubinbin@loongson.cn
>Signed-off-by: Vinod Koul <vkoul@kernel.org>
>(cherry picked from commit 4b65d5322e1d8994acfdb9b867aa00bdb30d177b)

I'll queue it up, but please read
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

-- 
Thanks,
Sasha

