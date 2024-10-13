Return-Path: <stable+bounces-83623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C11A99B9E0
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 16:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F442281D2B
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749C714658D;
	Sun, 13 Oct 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s15h6lrC"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FFC14601C
	for <stable@vger.kernel.org>; Sun, 13 Oct 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728831337; cv=none; b=VPfWweznJfSueH5zDY5/HKc6ritN6Yh34rjsDIGpF3QrX9eSS3DcgFxR6ckYF9eG5cbSEIcPivQsOsSW4wrSsSmlHB344PhRODJnHVE73KPVFurtzKkcIVTL7AiD0XTZ4Hj/opccgAbdUdWVdqhFAjjz44bJL1kYaa6nRpS7y3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728831337; c=relaxed/simple;
	bh=RkAcVw7imkH83Lnz9Bl0fGaXr29lw9m1rZVlseqBl4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KexpCdV9CQw496/BlXXWQtmCuBQFYqX0XGiOQMteSsLmLlrh/gwHUf9+jpkq9psp7wnVEgegq1up1yNGKSYMktXRJ8lbdiyav7r07qhRu8VI79uJVy9/XFW2uAj5hdjidq4W6K9qWh51YpduYLaNcC+pUt438ZdkHGipW+st0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s15h6lrC; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 13 Oct 2024 22:55:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728831327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYqRfss1NBTVeKYiNPPzCz5FIOGRLaUuCoy3A+BmjfQ=;
	b=s15h6lrC6VPLqgaN7mFH23tSUn6W8ayRJVR8GxXO409adtjdnhAfQ7h5dW7Ce4YjmDLgpL
	DSf2xWD2kKeqBNxE3gNLi1Wrt3bv1hSvrOZkfFhf2daQZFWJHMntQRuIVVw1bP7sD8H59q
	t7oEJnp2V64HZZfecGHOpEiV+TAff+g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Julien Meunier <julien.meunier@nokia.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	stable@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: etm4x: Fix PID tracing when perf is run in
 an init PID namespace
Message-ID: <20241013145524.GB45976@debian-dev>
References: <20240925131357.9468-1-julien.meunier@nokia.com>
 <20241008200226.12229-1-julien.meunier@nokia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008200226.12229-1-julien.meunier@nokia.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 08, 2024 at 10:02:25PM +0200, Julien Meunier wrote:
> The previous implementation limited the tracing capabilities when perf
> was run in the init PID namespace, making it impossible to trace
> applications in non-init PID namespaces.
> 
> This update improves the tracing process by verifying the event owner.
> This allows us to determine whether the user has the necessary
> permissions to trace the application.
> 
> Cc: stable@vger.kernel.org
> Fixes: aab473867fed ("coresight: etm4x: Don't trace PID for non-root PID namespace")
> Signed-off-by: Julien Meunier <julien.meunier@nokia.com>

Reviewed-by: Leo Yan <leo.yan@linux.dev>

> ---
> Changes in v2:
> * Update comments
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 66d44a404ad0..cf41c42399e1 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -693,9 +693,9 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>  		config->cfg |= TRCCONFIGR_TS;
>  	}
>  
> -	/* Only trace contextID when runs in root PID namespace */
> +	/* Only trace contextID when the event owner is in root PID namespace */
>  	if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
> -	    task_is_in_init_pid_ns(current))
> +	    task_is_in_init_pid_ns(event->owner))
>  		/* bit[6], Context ID tracing bit */
>  		config->cfg |= TRCCONFIGR_CID;
>  
> @@ -709,8 +709,8 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> -		/* Only trace virtual contextID when runs in root PID namespace */
> -		if (task_is_in_init_pid_ns(current))
> +		/* Only trace virtual contextID when the event owner is in root PID namespace */
> +		if (task_is_in_init_pid_ns(event->owner))
>  			config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
>  	}
>  
> -- 
> 2.34.1
> 

