Return-Path: <stable+bounces-69598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA9C956D34
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 16:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C581C22B47
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507CC1714D1;
	Mon, 19 Aug 2024 14:29:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB73C17109B;
	Mon, 19 Aug 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077741; cv=none; b=sQQ8TjnzbYg7tgBJ9eQunBGoFXzdWP096+FR4lOc8ZWkeJddQAUb+m2WgequGIZuf7tlfZhFpiQe4PUQa8gbBTkxbV6omdfgQXKoih1FQ2gwgjtsaicEBGRy8a5YIVsQ6MuJZckhumYccmPg0bjoN4x+fsZM/6KFnLVWnfLHz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077741; c=relaxed/simple;
	bh=5EuotScSVvzW6F/X0cx+ZhoSagam/i4NAGo4wbEsK40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s96ClrFXsn1lm8uPv9lWpo6q0BIA5fMEhmEijR+gvCwvFD2nT2/T3PE4w0SkidWu2t6d5lNunmOaNxjkAp1lPhVaRrxfns5g3fCR09qjVjTDv9sarwz5E+F09FTEAf83bhkuw3fh0w29b6PmJZxsL9LrB7qjpvR7/O3HUM0r0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BC5D339;
	Mon, 19 Aug 2024 07:29:25 -0700 (PDT)
Received: from [10.1.36.36] (FVFF763DQ05P.cambridge.arm.com [10.1.36.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E0D53F73B;
	Mon, 19 Aug 2024 07:28:58 -0700 (PDT)
Message-ID: <7e166d5f-a8cf-46ab-a95d-46bacec58f5f@arm.com>
Date: Mon, 19 Aug 2024 15:28:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm-cci: Fix refcount leak in cci_probe
Content-Language: en-GB
To: Ma Ke <make24@iscas.ac.cn>, nico@fluxnic.net, will@kernel.org,
 punitagrawal@gmail.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240819090405.1014759-1-make24@iscas.ac.cn>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240819090405.1014759-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2024 10:04, Ma Ke wrote:
> Add the missing of_node_put() to release the refcount incremented
> by of_find_matching_node().
> 
> Cc: stable@vger.kernel.org
> Fixes: f6b9e83ce05e ("arm-cci: Rearrange code for splitting PMU vs driver code")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   drivers/bus/arm-cci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index b8184a903583..6be7b05b5ff1 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -548,6 +548,7 @@ static int cci_probe(void)
>   	}
>   	if (ret || !cci_ctrl_base) {
>   		WARN(1, "unable to ioremap CCI ctrl\n");
> +		of_node_put(np);
>   		return -ENXIO;
>   	}
>   

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

