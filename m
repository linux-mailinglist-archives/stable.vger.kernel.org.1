Return-Path: <stable+bounces-125794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6280A6C5DC
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 23:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA243AE6E4
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 22:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A341F3BB7;
	Fri, 21 Mar 2025 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYgPCnOX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842D8BEE;
	Fri, 21 Mar 2025 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595696; cv=none; b=e6wBiNj2W5Dj/MJLqsxiRyuHFWJcXTJZ9VNdAQ0ZZYqtQ/W+c3tMkn3msZQC9F8hpsHMlikHcH4qWsPtAJasR6I4Osl98AoJEQDRZIxzay51303jpXT5x9E8PUP6rmP5r4jubc4NOhOEWLZzEiACMZoGkbp5O94RqAGPOYgsSG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595696; c=relaxed/simple;
	bh=HJFvVXl45GjCHB77vkVbfYG2LXCQM1Yu7VkVLSHwgtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6rbvUIdAn+BmLlmPGNQMFlCYbOwb1dFgB5H2FE9G+a6zNpNx0Wa+xf+ShmpUKXmvxdPvlDlNrZwugN8RgqJj4E2LCC6kmOvYqgcZU/JqWA1kWgUEls/SgT4YteYk9abdJfQQTKZ4Jl43u3zFgijOMB/OOf7CX36odPLOP62P9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYgPCnOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2BAC4CEE3;
	Fri, 21 Mar 2025 22:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742595695;
	bh=HJFvVXl45GjCHB77vkVbfYG2LXCQM1Yu7VkVLSHwgtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYgPCnOX2/NYKWyQPW6LLib0j+Q3H9+rHSpNI2L2Cb1laNKAJiZhik9jvwjU0dPQ7
	 pq/4kAmagE0IORsYyhGLuoooKAOMPPiRu98d2vywU/FmIvED6MeRose+GkaS3LUyJT
	 to/3Kj1w1J1AHdd5z3FfpyS2/UNXHaw0wT1a8IxP1lqTo3WKHLw1oEo+YUdDbpaXil
	 5LhjUHwzgEalhhpc1RRNs/TdE9DO5wgFbTdPHT3lcd2WthohavgGfkJXUVOJslwSPw
	 JnmozSN195VoD86b7eMlo6wgF04gbHq7FvJzu//UP1Pkin43h44fNWJqG//dx/cI7R
	 iP+PQ5DVxZvWA==
Date: Fri, 21 Mar 2025 17:21:33 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH v3] remoteproc: Add device awake calls in rproc boot and
 shutdown path
Message-ID: <6lyuwfypd5sq5fqu2ibgpxiulvq3txe6igxhrpqd4443z4zex4@5bvlrpohwg5c>
References: <20250317114057.1725151-1-quic_schowdhu@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317114057.1725151-1-quic_schowdhu@quicinc.com>

On Mon, Mar 17, 2025 at 05:10:57PM +0530, Souradeep Chowdhury wrote:
> Add device awake calls in case of rproc boot and rproc shutdown path.
> Currently, device awake call is only present in the recovery path
> of remoteproc. If a user stops and starts rproc by using the sysfs
> interface, then on pm suspension the firmware loading fails. Keep the
> device awake in such a case just like it is done for the recovery path.
> 

Please rewrite this in the form expressed in
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

Clearly describe the problem you're solving - not just the change in
behavior.

What do you mean that "firmware loading fails" if we hit a suspend
during stop and start through sysfs? At what point does it fail?

> Fixes: a781e5aa59110 ("remoteproc: core: Prevent system suspend during remoteproc recovery")

That patch clearly states that it intends to keep the system from
suspending during recovery. As far as I can tell you're changing the
start and stop sequences.

As such, I don't think the referred to patch was broken and you're not
fixing it.

> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Cc: stable@vger.kernel.org

It's not clear to me from the commit message why this should be
backported to stable kernel.

> ---
> Changes in v3
> 
> *Add the stability mailing list in commit message
>  
>  drivers/remoteproc/remoteproc_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index c2cf0d277729..908a7b8f6c7e 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1916,7 +1916,8 @@ int rproc_boot(struct rproc *rproc)
>  		pr_err("invalid rproc handle\n");
>  		return -EINVAL;
>  	}
> -
> +	

You're replacing an empty line with a tab...


Other than that, the change looks sensible.

Regards,
Bjorn

> +	pm_stay_awake(rproc->dev.parent);
>  	dev = &rproc->dev;
>  
>  	ret = mutex_lock_interruptible(&rproc->lock);
> @@ -1961,6 +1962,7 @@ int rproc_boot(struct rproc *rproc)
>  		atomic_dec(&rproc->power);
>  unlock_mutex:
>  	mutex_unlock(&rproc->lock);
> +	pm_relax(rproc->dev.parent);
>  	return ret;
>  }
>  EXPORT_SYMBOL(rproc_boot);
> @@ -1991,6 +1993,7 @@ int rproc_shutdown(struct rproc *rproc)
>  	struct device *dev = &rproc->dev;
>  	int ret = 0;
>  
> +	pm_stay_awake(rproc->dev.parent);
>  	ret = mutex_lock_interruptible(&rproc->lock);
>  	if (ret) {
>  		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
> @@ -2027,6 +2030,7 @@ int rproc_shutdown(struct rproc *rproc)
>  	rproc->table_ptr = NULL;
>  out:
>  	mutex_unlock(&rproc->lock);
> +	pm_relax(rproc->dev.parent);
>  	return ret;
>  }
>  EXPORT_SYMBOL(rproc_shutdown);
> -- 
> 2.34.1
> 

