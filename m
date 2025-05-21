Return-Path: <stable+bounces-145750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA59ABEA6A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 05:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD773A64BA
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47704221FD8;
	Wed, 21 May 2025 03:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="acZXug5F"
X-Original-To: stable@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027E61C6FE4;
	Wed, 21 May 2025 03:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747797747; cv=none; b=dK7KnwMsHIxa/EN4eWAG7mtKdkLzGk54rXbdcxN/N4apTuLFo+w/GpgmqdBarrqoe+g235QiXzc+MUNv3/1e8BFZGu6kn3NifgOGnXg6Km36Vgo7EOxSeTc0pCe+kiR7NoB2bqUrJOJwKEvH8f01b9kU02Z43NXzXnTzSg5ko4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747797747; c=relaxed/simple;
	bh=hfpTbGukhUuuV/oX81p85tSk0qYsKNTnGDkObllnbMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K81yxo/xpICa/ihBgj1kjpNKjKQln6V0iDAir5tqrUwC7ziO3kB1LTqvRGJUPK85mJ/t9dvWBD2bsvgZgEhHMbnpiHoSzaVj/2zSvx53Klcg/sJciiYpsZtiBWVBs6/S2X5oE+MnR5Vavwtn6uCOOD68qKIhWm/Qozij9il57O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=acZXug5F; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747797740; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zlVKiVEB7vpkr2KFpFFhqSVF1yp9ZMoxg8EAbgOOIjk=;
	b=acZXug5FDz6rLRCySBP2l905UQHq6JBmHsgCO2EmjUX74QXjNFZt2x+30RgYld72STzpnWQRLlP2gKD4ozeo42p9oJ7F+sQU/lNNPEZyGHfNqFTunc8wgDnK34LAsMsF/YReiXhg/Od9YA1F+gTkJcNp9eioRqV+Q/FE6+5Q1+I=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WbPwqoP_1747797739 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 May 2025 11:22:20 +0800
Message-ID: <6f0b7332-477b-4028-b663-09803718e8d9@linux.alibaba.com>
Date: Wed, 21 May 2025 11:22:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-sprd: Add error handling for
 sdhci_runtime_suspend_host()
To: Wentao Liang <vulab@iscas.ac.cn>, adrian.hunter@intel.com,
 ulf.hansson@linaro.org, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250519123347.2242-1-vulab@iscas.ac.cn>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250519123347.2242-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/5/19 20:33, Wentao Liang wrote:
> The dhci_sprd_runtime_suspend() calls sdhci_runtime_suspend_host() but
> does not handle the return value. A proper implementation can be found
> in sdhci_am654_runtime_suspend().
> 
> Add error handling for sdhci_runtime_suspend_host(). Return the error
> code if the suspend fails.
> 
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Cc: stable@vger.kernel.org # v4.20
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/mmc/host/sdhci-sprd.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index db5e253b0f79..dd41427e973a 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -922,9 +922,12 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
>   {
>   	struct sdhci_host *host = dev_get_drvdata(dev);
>   	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> +	int ret;
>   
>   	mmc_hsq_suspend(host->mmc);
> -	sdhci_runtime_suspend_host(host);
> +	ret = sdhci_runtime_suspend_host(host);
> +	if (ret)
> +		return ret;
>   
>   	clk_disable_unprepare(sprd_host->clk_sdio);
>   	clk_disable_unprepare(sprd_host->clk_enable);

