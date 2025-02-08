Return-Path: <stable+bounces-114370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3613A2D471
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 08:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6871B164655
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B411AAE0B;
	Sat,  8 Feb 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S94L/SWL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5571A83FF;
	Sat,  8 Feb 2025 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738998904; cv=none; b=GMXg/MD9GiOpbk5BmHZomKj8VJZ1+o6Zbu87FQIK1q3i3xrIIpv1Dd5oql9fsQjplxXvneXqaENClHcLTdweg9WfmPzUR8OtQqScGGp8i5dt5pV2k0/OFplQXMFvhAsVgjDTdoLj9leZ41mX0PZtsZ6esunYJfkvmrOcwZQGfK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738998904; c=relaxed/simple;
	bh=Iq3jiQK/RAsDjgRbxGyZobesn7rZGV66mz8pWo6XRLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmKYOtQ/IjEZUT/zoDTlMRWiSz5M11V+L3BdxxDJsn1ufLysyiXX0AUKC/mzMrizyAr8uJGwh8bx5ediz4UWxT01fUXkNsPEwaz3ZUUFkBaU2nxLI7ta9pg1n57uODVDpwUvz+NjlomjOMHKR6jaxdfPQa+wmhGE62I5yn1QCFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S94L/SWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF32C4CED6;
	Sat,  8 Feb 2025 07:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738998903;
	bh=Iq3jiQK/RAsDjgRbxGyZobesn7rZGV66mz8pWo6XRLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S94L/SWLk8PB6NeA77WgvCCQk9OzrR7Q2Mq8MY2fkv/lkbdy+lS7slkRS417jf4nZ
	 IgB/ZgngvBoKYwksYi67w4jRKUaAm666Z4HgLxWJnYDcXvOOAEEOxQHNLVSwq6BCFV
	 gRdrF0LEWIhv37mLwRClO59amhkIFPl7mDnE4cLc=
Date: Sat, 8 Feb 2025 08:14:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jill Donahue <jilliandonahue58@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] f_midi_complete to call tasklet_hi_schedule
Message-ID: <2025020836-refining-gutless-0d5f@gregkh>
References: <20250207203441.945196-1-jilliandonahue58@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207203441.945196-1-jilliandonahue58@gmail.com>

On Fri, Feb 07, 2025 at 01:34:41PM -0700, Jill Donahue wrote:
> When using USB MIDI, a lock is attempted to be acquired twice through a
> re-entrant call to f_midi_transmit, causing a deadlock.
> 
> Fix it by using tasklet_hi_schedule() to schedule the inner
> f_midi_transmit() via a tasklet from the completion handler.
> 
> Link: https://lore.kernel.org/all/CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com/
> Fixes: d5daf49b58661 ("USB: gadget: midi: add midi function driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jill Donahue <jilliandonahue58@gmail.com>
> ---
>  drivers/usb/gadget/function/f_midi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index 837fcdfa3840..37d438e5d451 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -283,7 +283,7 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
>  			/* Our transmit completed. See if there's more to go.
>  			 * f_midi_transmit eats req, don't queue it again. */
>  			req->length = 0;
> -			f_midi_transmit(midi);
> +			tasklet_hi_schedule(&midi->tasklet);
>  			return;
>  		}
>  		break;
> -- 
> 2.25.1
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

