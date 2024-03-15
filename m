Return-Path: <stable+bounces-28242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 801CF87CE9C
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 15:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360AE1F21AF5
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 14:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3407937167;
	Fri, 15 Mar 2024 14:22:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B3B1B374E0
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512531; cv=none; b=UzsFKkxsAJZlUewd6M9GLTVdwEnvkIMR9R4d5zUCQnjiwsHGiAWNILO3lx3043bx3hsPn7m1oFqIiy8YFzIfZa3ZYGTZqHfw6JZTA3ny666gTJuB4BYMgejk960uPQF/b/oclonQTOccrToV2E94ZfQjc8USycOYw7JumoJIQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512531; c=relaxed/simple;
	bh=935tHhPFb8easobao5KURj8zNIGm8JAYqqWC6Vw2Ocw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9JBOgFsm5C1ouNHozCF9LZRE8uVfJwciGztTvXfBvuvgeV1ORBM1WR8bAghQZbxpOxKHmq85xDjnYlWSitzXbdf/9h39TrwE+efwz5f8J8nWS1JHgE0m0W+agQo4S0s8zUAWB7vqoAgFZ0i8gIkZ2mPi95JvaJm4TPThziLntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 487065 invoked by uid 1000); 15 Mar 2024 10:22:04 -0400
Date: Fri, 15 Mar 2024 10:22:04 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: yuan linyu <yuanlinyu@hihonor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: udc: remove warning when queue disabled ep
Message-ID: <17a9f299-7550-4498-b209-8f9433c493b6@rowland.harvard.edu>
References: <20240315020144.2715575-1-yuanlinyu@hihonor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315020144.2715575-1-yuanlinyu@hihonor.com>

On Fri, Mar 15, 2024 at 10:01:44AM +0800, yuan linyu wrote:
> It is possible trigger below warning message from mass storage function,
> 
> WARNING: CPU: 6 PID: 3839 at drivers/usb/gadget/udc/core.c:294 usb_ep_queue+0x7c/0x104
> pc : usb_ep_queue+0x7c/0x104
> lr : fsg_main_thread+0x494/0x1b3c
> 
> Root cause is mass storage function try to queue request from main thread,
> but other thread may already disable ep when function disable.
> 
> As there is no function failure in the driver, in order to avoid effort
> to fix warning, change WARN_ON_ONCE() in usb_ep_queue() to pr_debug().
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: yuan linyu <yuanlinyu@hihonor.com>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

> v4: add version info in subject
> v3: add more debug info, remove two line commit description
>     https://lore.kernel.org/linux-usb/20240315015854.2715357-1-yuanlinyu@hihonor.com/
> v2: change WARN_ON_ONCE() in usb_ep_queue() to pr_debug()
>     https://lore.kernel.org/linux-usb/20240315013019.2711135-1-yuanlinyu@hihonor.com/
> v1: https://lore.kernel.org/linux-usb/20240314065949.2627778-1-yuanlinyu@hihonor.com/
> 
>  drivers/usb/gadget/udc/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 9d4150124fdb..b3a9d18a8dcd 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -292,7 +292,9 @@ int usb_ep_queue(struct usb_ep *ep,
>  {
>  	int ret = 0;
>  
> -	if (WARN_ON_ONCE(!ep->enabled && ep->address)) {
> +	if (!ep->enabled && ep->address) {
> +		pr_debug("USB gadget: queue request to disabled ep 0x%x (%s)\n",
> +				 ep->address, ep->name);
>  		ret = -ESHUTDOWN;
>  		goto out;
>  	}
> -- 
> 2.25.1
> 

