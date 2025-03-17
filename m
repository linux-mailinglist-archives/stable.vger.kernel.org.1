Return-Path: <stable+bounces-124600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D18A64203
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996DC188B210
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A329742C0B;
	Mon, 17 Mar 2025 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="niRk7DAs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E2C33F9
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 06:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193961; cv=none; b=d/uAaVvXflKfTYS6zslqhccPJWMCcvjrgJdx7VIYyW3dNSeH5oROw23cdqGL4rZCtZTNrgz1OejXz1jDhOg6U8gto8HPW3oPDi7/CGdtGDOi8Xbbo1G0rzJWGmXxxoeHZ0eN3VE12J5oRrMH8qi78gS3a0hMWgodX56nWwGLnJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193961; c=relaxed/simple;
	bh=pjGFD7GrejHFqpoAKqhrG2XCSZ5i9+nL4aHKOfAT9j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqWD5bdH2IZ16nTaM1iuhJdpOcqBhWl8qTSWbx7BQLnCI9DWABnxeWdSM1cJSYlBYSSxFWmk46dmwp1GQnqJEAAELLbFFAf3sopVcUAkqPFx3RWl67U3B+hKpOZH5zQ8dOSqSWZfBmsiIMaFbX03Dy761Deo5PORK+gNV4dNMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=niRk7DAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BD9C4CEE3;
	Mon, 17 Mar 2025 06:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742193960;
	bh=pjGFD7GrejHFqpoAKqhrG2XCSZ5i9+nL4aHKOfAT9j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=niRk7DAs2+FoX2BTK11fXlFvxBBezrCfNB1uX3QDMnIoRyLbUZQkDSGcLMsZ+MH2S
	 uuWJY6NejifeROZw9bXOu+o+gaa5Ue2cRemo/SnZEb1F6tM7PIItavqxBKQIff+pXw
	 +9oB6wJEIvAbY+BTfsoJcxBj0T2Gf/09m1Vz4we4=
Date: Mon, 17 Mar 2025 07:44:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc: stable@vger.kernel.org
Subject: Re: [v2] remoteproc: Add device awake calls in rproc boot and
 shutdown path
Message-ID: <2025031731-gills-favoring-37b7@gregkh>
References: <20250317054110.1339365-1-quic_schowdhu@quicinc.com>
 <20250317054110.1339365-2-quic_schowdhu@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317054110.1339365-2-quic_schowdhu@quicinc.com>

On Mon, Mar 17, 2025 at 11:11:10AM +0530, Souradeep Chowdhury wrote:
> Add device awake calls in case of rproc boot and rproc shutdown path.
> Currently, device awake call is only present in the recovery path
> of remoteproc. If a user stops and starts rproc by using the sysfs
> interface, then on pm suspension the firmware loading fails. Keep the
> device awake in such a case just like it is done for the recovery path.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Cc: stable@vger.kernel.org
> ---
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
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

