Return-Path: <stable+bounces-2868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E96D7FB3A4
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 09:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC481F20EEB
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 08:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D2D156C2;
	Tue, 28 Nov 2023 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NR1X99t5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95E12E45
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 08:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF982C433C8;
	Tue, 28 Nov 2023 08:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701158961;
	bh=aCLAD8i+LZDiDabsl83Z19nb3QNDgPLNO+3Gk3ZKYVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NR1X99t5ZJL+OPcIsSUg3mNtBIxGiGb8vWxz8NVaiAMiKcQ1ouEjLLM0zU6EBT7mJ
	 KKqPN9oNToFYL56YNC87ZvmknUITHepsU3U7b4H6iWNXgD7PoWxz+A16jk2TRbfceP
	 tQa0Rd+QTr01/AmrOViyu39EweTDX5nMnEQ+hzGg=
Date: Tue, 28 Nov 2023 08:09:18 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
Cc: stable@vger.kernel.org, Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dtor@vmware.com>,
	George Zhang <georgezhang@vmware.com>,
	Andy king <acking@vmware.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmci: prevent speculation leaks by sanitizing event in
 event_deliver()
Message-ID: <2023112802-bagginess-wireless-cd95@gregkh>
References: <20231127194817.57209-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127194817.57209-1-hagarhem@amazon.com>

On Mon, Nov 27, 2023 at 07:48:17PM +0000, Hagar Gamal Halim Hemdan wrote:
> Coverity spotted that event_msg is controlled by user-space,
> event_msg->event_data.event is passed to event_deliver() and used
> as an index without sanitization.
> 
> This change ensures that the event index is sanitized to mitigate any
> possibility of speculative information leaks.
> 
> Fixes: 1d990201f9bb ("VMCI: event handling implementation.")
> 
> Signed-off-by: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/misc/vmw_vmci/vmci_event.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
> index 5d7ac07623c2..9a41ab65378d 100644
> --- a/drivers/misc/vmw_vmci/vmci_event.c
> +++ b/drivers/misc/vmw_vmci/vmci_event.c
> @@ -9,6 +9,7 @@
>  #include <linux/vmw_vmci_api.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/nospec.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/rculist.h>
> @@ -86,9 +87,12 @@ static void event_deliver(struct vmci_event_msg *event_msg)
>  {
>  	struct vmci_subscription *cur;
>  	struct list_head *subscriber_list;
> +	u32 sanitized_event, max_vmci_event;
>  
>  	rcu_read_lock();
> -	subscriber_list = &subscriber_array[event_msg->event_data.event];
> +	max_vmci_event = ARRAY_SIZE(subscriber_array);
> +	sanitized_event = array_index_nospec(event_msg->event_data.event, max_vmci_event);
> +	subscriber_list = &subscriber_array[sanitized_event];
>  	list_for_each_entry_rcu(cur, subscriber_list, node) {
>  		cur->callback(cur->id, &event_msg->event_data,
>  			      cur->callback_data);
> -- 
> 2.40.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

