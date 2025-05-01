Return-Path: <stable+bounces-139315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE46AA60BB
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44821897ED2
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DDB201262;
	Thu,  1 May 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vTL7p63H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC12F37;
	Thu,  1 May 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746113202; cv=none; b=DujS/lChnnRVWUeRGn+RhKn06Fxsv4CCSF5GsgggUZ6ojXv+AQ9rWZ/HMUNOnyZQXZmSzIY9I0rr77gbFqekKK2kUrIkisMSkrtsSyK0uXc1evmWw5+nZf1TGReKfHGKPVRn64WmtSc0mJpuniNinW9ECjcozQYkDdFxQKr0M8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746113202; c=relaxed/simple;
	bh=LLKO3O1vN7BhMZwgJ5+IsLeh192o/DqrORrLu5VNyKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlnlcCAFvyz/vI/LBi4HefdeiRSIF/QCf593QhDMcSm6gEJ0l8cKYyWP5oc5+wTCG6Uk13/9/+X0jt19dNsP61QVlNm1ipvq+k3zoncIzMFvpQWdIq6zueMu676AvvmOl9JyTm72X4OSiyl4renuAoxmIYRVEUyO7O8+fCuAvPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vTL7p63H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C07C4CEE3;
	Thu,  1 May 2025 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746113200;
	bh=LLKO3O1vN7BhMZwgJ5+IsLeh192o/DqrORrLu5VNyKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vTL7p63HJida5dYda8YQ7+p8Q1BZ7lLgAYYLFzRu6hS+Qxa+5J1e/YTZ/verq7odp
	 hF5O0J1w7p0gxWSb6EOjzB11rHBfwzBmdY/ysOjDUJFs9uqn5JnsvuIppuP9a8nA2D
	 PF7Ctaxc0WNbUKsSTBz6Ry86BP6u/zd22lyM5Ra4=
Date: Thu, 1 May 2025 17:26:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: linux-usb@vger.kernel.org, guido.kiener@rohde-schwarz.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/3 V3] usb: usbtmc: Fix erroneous ioctl returns
Message-ID: <2025050156-murkiness-undecided-4c81@gregkh>
References: <20250427074750.26447-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427074750.26447-1-dpenkler@gmail.com>

On Sun, Apr 27, 2025 at 09:47:50AM +0200, Dave Penkler wrote:
> Recent tests with timeouts > INT_MAX produced random error returns
> with usbtmc_get_stb. This was caused by assigning the return value
> of wait_event_interruptible_timeout to an int which overflowed to
> negative values. Also return value on success was the remaining
> number of jiffies instead of 0.
> 
> These patches fix all the cases where the return of
> wait_event_interruptible_timeout was assigned to an int and
> the case of the remaining jiffies return in usbtmc_get_stb.
> 
> Patch 1: Fixes usbtmc_get_stb 
> Patch 2: Fixes usbtmc488_ioctl_wait_srq
> Patch 3: Fixes usbtmc_generic_read
> 
> Dave Penkler (3):
>   usb: usbtmc: Fix erroneous get_stb ioctl error returns
>   usb: usbtmc: Fix erroneous wait_srq ioctl return
>   usb: usbtmc: Fix erroneous generic_read ioctl return
> 
>  drivers/usb/class/usbtmc.c | 53 ++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
> 
> --
> Changes V1 => V2 Add cc to stable line
>         V2 => V3 Add susbsystem to cover letter
> 2.49.0
> 
> 

I'm confused, I don't see a full v3 set of patches here.  Look at what
ended up on the list:
	https://lore.kernel.org/all/20250427074750.26447-1-dpenkler@gmail.com/

That's just the cover letter?

Can you try again?  Something seems to have gotten lost.

thanks,

greg k-h

