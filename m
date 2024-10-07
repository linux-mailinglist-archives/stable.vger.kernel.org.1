Return-Path: <stable+bounces-81479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3421E9937E3
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 22:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E4A1F2143B
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52121DE3C9;
	Mon,  7 Oct 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CS2vbW2j"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D693A1DE3C5
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331537; cv=none; b=cGNU0CymOdtJCqTUQyPWpefbGTfLFYVZkXIsOU0asy1hOjD/4aCe2/RHbq7FO9HitkmBzuSL5SAKaZ1tEfkXJOwpL80aV4fpskm5fukMSJ2AI4pHaBovytA6VF11KeOeDtP5tCjLqtiypzTDf464d0wiyOhP/E5SCkJfMCq6GlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331537; c=relaxed/simple;
	bh=Fiud0yj3UkoKF9eqslOVQBgzuRDk/DsfR+p/SmNwsxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMZuSHNCzy3s4/sHmXh9B7X1mZlqGIZXCirlkxoUL+F/OF7st1Z5/4XJIsIQmiW0jZqi9ZwKl+8xS1ItFuFKA1j/D9RgB7FN1L/7xBwNCAE8i2aV1p0LCG7MJ8sGEwh594fs//Ohv7dMZf86wLszMFHxlFfkaryVG9eifxLGZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CS2vbW2j; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 8 Oct 2024 04:05:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728331531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwnTZ30pE64PPVgzu3ilNOXtrbZO989Ve0baEc4aua0=;
	b=CS2vbW2jGVUL81gcsiQvBhkWv4SlqRUuDyp4/RY5UHhO1JJNZx9E4yJF/Mh0lz8SauXDtI
	bwvlR8idy2Y2jfbPMrtnfw2Yre3y6zG1vUQ0XuNOSLxZciYLpbxfD9IHTrBQ0QmBRoH//3
	ITiCcuBYsMK3k4LqUbm3/9lLi4LHnp4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Julien Meunier <julien.meunier@nokia.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	stable@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	leo.yan@arm.com
Subject: Re: [PATCH] coresight: etm4x: Fix PID tracing when perf is run in an
 init PID namespace
Message-ID: <20241007200528.GB30834@debian-dev>
References: <20240925131357.9468-1-julien.meunier@nokia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925131357.9468-1-julien.meunier@nokia.com>
X-Migadu-Flow: FLOW_OUT

Hi Julien,

On Wed, Sep 25, 2024 at 03:13:56PM +0200, Julien Meunier wrote:
> The previous implementation limited the tracing capabilities when perf
> was run in the init PID namespace, making it impossible to trace
> applications in non-init PID namespaces.
> 
> This update improves the tracing process by verifying the event owner.
> This allows us to determine whether the user has the necessary
> permissions to trace the application.

The original commit aab473867fed is not for constraint permission. It is
about PID namespace mismatching issue.

E.g. Perf runs in non-root namespace, thus it records process info in the
non-root PID namespace. On the other hand, Arm CoreSight traces PID for
root namespace, as a result, it will lead mess when decoding.

With this change, I am not convinced that Arm CoreSight can trace PID for
non-root PID namespace. Seems to me, the concerned issue is still existed
- it might cause PID mismatching issue between hardware trace data and
Perf's process info.

I think we need to check using the software context switch event. With
more clear idea, I will get back at here.

Thanks,
Leo

> Cc: stable@vger.kernel.org
> Fixes: aab473867fed ("coresight: etm4x: Don't trace PID for non-root PID namespace")
> Signed-off-by: Julien Meunier <julien.meunier@nokia.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index bf01f01964cf..8365307b1aec 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -695,7 +695,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>  
>  	/* Only trace contextID when runs in root PID namespace */
>  	if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
> -	    task_is_in_init_pid_ns(current))
> +	    task_is_in_init_pid_ns(event->owner))
>  		/* bit[6], Context ID tracing bit */
>  		config->cfg |= TRCCONFIGR_CID;
>  
> @@ -710,7 +710,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>  			goto out;
>  		}
>  		/* Only trace virtual contextID when runs in root PID namespace */
> -		if (task_is_in_init_pid_ns(current))
> +		if (task_is_in_init_pid_ns(event->owner))
>  			config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
>  	}
>  
> -- 
> 2.34.1
> 
> 

