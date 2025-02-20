Return-Path: <stable+bounces-118447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867A8A3DC5E
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C73A76ED
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 14:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F261FBC85;
	Thu, 20 Feb 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVUZZN+0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF81F150A;
	Thu, 20 Feb 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060967; cv=none; b=Bdk2ld4zlIdMXcILZRMOmn1K/Z2E9YV7ylgOCkrIOzdMTL9GrNUHJG4ITOpanGMoa04LaP3noeR94cRa3RwNOqx6oJtFnGCWX7ID2++FOaP9KI0ST5qPhYDvnQpxaHrPxbNwW2WHLN7egRse4/cSX4vcUH35YZw70Ok0FazwIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060967; c=relaxed/simple;
	bh=noxCc47/1cJ0ZKN1i7l306cRmB9nXFyLc/NIL4/Irdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVY6bNMO935lNF1nFrNKwyzdvA7p3NBpqPQli4ptj/lSxLm/A2SfeEkIipQk0/A2QQ3TYfdC3h3Mmkn+XHwTEZOiEhyGtmnSZ3/IXaF7unRlkKwl2+WJEt/pINMDPcAQRTRv+xiYzIXW+B0579WNZcSrcPXxMtyiLhijgnEV2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVUZZN+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E6BC4CED1;
	Thu, 20 Feb 2025 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740060966;
	bh=noxCc47/1cJ0ZKN1i7l306cRmB9nXFyLc/NIL4/Irdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVUZZN+0Vfm3hEyng0ZrSAmkunAX0OMZ3m6+hpyMcb7S0J4XTVD6T/0gD6GaQ/Wp8
	 HCYFWkCaM/648x58pHp0xa1yR8B7gxwzwAQPYee5jmoIIAju26lzK8fi6mnfjvE8vy
	 4gR+NT2DOjwwq0nuLpBAaTzSzdVB30QA7yb209so=
Date: Thu, 20 Feb 2025 15:16:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alexander.usyskin@intel.com, arnd@arndb.de,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mei: Add error logging in IRQ handler to prevent silent
 failures
Message-ID: <2025022023-childlike-superjet-f096@gregkh>
References: <20250220133435.1060-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220133435.1060-1-vulab@iscas.ac.cn>

On Thu, Feb 20, 2025 at 09:34:35PM +0800, Wentao Liang wrote:
> Log mei_irq_write_handler() errors to prevent silent IRQ handling failures.
> 
> Fixes: 962ff7bcec24 ("mei: replace callback structures used as list head by list_head")
> Cc: stable@vger.kernel.org # 4.11+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/misc/mei/hw-me.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> index d11a0740b47c..5df42a64b4db 100644
> --- a/drivers/misc/mei/hw-me.c
> +++ b/drivers/misc/mei/hw-me.c
> @@ -1415,6 +1415,8 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
>  	if (dev->pg_event != MEI_PG_EVENT_WAIT &&
>  	    dev->pg_event != MEI_PG_EVENT_RECEIVED) {
>  		rets = mei_irq_write_handler(dev, &cmpl_list);
> +		if (rets)
> +			dev_err(dev->dev, "mei_irq_write_handler ret = %d.\n", rets);
>  		dev->hbuf_is_ready = mei_hbuf_is_ready(dev);
>  	}
>  
> -- 
> 2.42.0.windows.2
> 

How was this found and tested?

And why print an error message in an irq handler, isn't that going to be
messy?  What can the user do with this message?

thanks,

greg k-h

