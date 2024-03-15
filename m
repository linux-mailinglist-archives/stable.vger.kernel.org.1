Return-Path: <stable+bounces-28225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E386F87C74A
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 02:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45324283260
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 01:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3A14C80;
	Fri, 15 Mar 2024 01:42:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7CB4E28FA
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710466927; cv=none; b=AbDzm7Ox0D1xqDO5avS5IUCnjJz4SxPgMMYCUXwGD91MpXTNy+ifcjMUcsSt0FDksuHp+nUWP0WOyBJOznrTsIHsGBHc2gB6RrOicMQlEM77GM/ap/Day1YkcBirGu4l8/wy9SUf/TqZEvmnpXpoQ+/HdPRNpjUZSvTDcE+ap9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710466927; c=relaxed/simple;
	bh=PUv171gSH9E9q1x/63Jq+wTfjs+FAn9d4ZmqAad3ZQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk1M2bGh+43Z4ZsjxZvKIXKmZbxbsmXWpRZn0ahtkSLFhblMPd8VsavFgZOxJ4KaMsMAGjANqyEReRtqS106igYaz4gv8Tq2hdVmA1HtRG2JLWcHBAP2nBV39aTVExOnQL+zVxS5wTX/gM+t04BOJhbqmJ2HHVc11eRE5jDFni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 470303 invoked by uid 1000); 14 Mar 2024 21:41:57 -0400
Date: Thu, 14 Mar 2024 21:41:57 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: yuan linyu <yuanlinyu@hihonor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: udc: remove warning when queue disabled ep
Message-ID: <3f826b68-4f13-46bd-9484-fe663612d154@rowland.harvard.edu>
References: <20240315013019.2711135-1-yuanlinyu@hihonor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315013019.2711135-1-yuanlinyu@hihonor.com>

On Fri, Mar 15, 2024 at 09:30:19AM +0800, yuan linyu wrote:
> It is possible trigger below warning message from mass storage function,
> 
> WARNING: CPU: 6 PID: 3839 at drivers/usb/gadget/udc/core.c:294 usb_ep_queue+0x7c/0x104
> CPU: 6 PID: 3839 Comm: file-storage Tainted: G S      WC O       6.1.25-android14-11-g354e2a7e7cd9 #1
> pstate: 22400005 (nzCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
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
> v2: change WARN_ON_ONCE() in usb_ep_queue() to pr_debug()
> v1: https://lore.kernel.org/linux-usb/20240314065949.2627778-1-yuanlinyu@hihonor.com/
> 
>  drivers/usb/gadget/udc/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 9d4150124fdb..2fbe5977c11d 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -292,7 +292,8 @@ int usb_ep_queue(struct usb_ep *ep,
>  {
>  	int ret = 0;
>  
> -	if (WARN_ON_ONCE(!ep->enabled && ep->address)) {
> +	if (!ep->enabled && ep->address) {
> +		pr_debug("queue disabled ep %x\n", ep->address);
>  		ret = -ESHUTDOWN;
>  		goto out;
>  	}

Okay, this a lot better and a much simpler solution to the problem.

However, I think the message should be more clear.  Something like this:

		pr_debug("USB gadget: request queued to disabled ep 0x%x (%s)\n",
				ep->address, ep->name);

It's too bad that there isn't enough information available to print the 
names of the gadget and the function driver.  Luckily, most systems will 
only have one gadget active at a time.

Alan Stern

