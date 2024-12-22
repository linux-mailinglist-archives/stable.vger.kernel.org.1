Return-Path: <stable+bounces-105554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B45B9FA4BB
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 09:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90079166D46
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3B17C7C4;
	Sun, 22 Dec 2024 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+rn7u4D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5F3D561;
	Sun, 22 Dec 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734856677; cv=none; b=jbigbnJxYelIvklUtOzqYDL1oCeoeqbgR8EPXzikI+Xm2ng0NBw5qNe1aArSjFKFhfwnEzZtQ7lNcaYAhWEPkWWWYnlU6nMQkvqDMbH2igXwlvdD0DfzbNbvT+putCShjzPUS3akqtueMY/IuucB9aLnFmuAsWGf1WzxWhMjPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734856677; c=relaxed/simple;
	bh=ScnuKx4U4VegmYhx0R2xrwGZ/4XvMe1Dhhut4teYpZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVQVgvTk0M5Aq4/6cYKD3tjWN2dlfwd2OLFQq+TjMWiVP2VqBQAAc2amm+Ka9CR8EtxGlSH8wkpx8sbyx1F9Lu48khSNZVSJU6+EEt+Kz1b4dsoHT8MolS4IWcTJgjGvqQqe1ZwPExVvNISxnlndRh8K/lIncKNY2I/fSd0rOUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+rn7u4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC04C4CECD;
	Sun, 22 Dec 2024 08:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734856676;
	bh=ScnuKx4U4VegmYhx0R2xrwGZ/4XvMe1Dhhut4teYpZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+rn7u4D8HdILa6yZs//7VkwuorLftTyomjR/Yzg23Vb2F1GhuM5/ZlThjKI8gQMx
	 AMB8FJlNAYPjc3ITUyKYuVPXE72RYy6nv8NhLfkE/CoiecqIinu/cHNZBGnhoXy2eM
	 jpVRbS2ksg5K42FmumxfCH4XO+CSnwu2hBwMSRP0=
Date: Sun, 22 Dec 2024 09:37:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Jann Horn <jannh@google.com>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	Jiri Slaby <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: Permit some TIOCL_SETSEL modes without
 CAP_SYS_ADMIN
Message-ID: <2024122254-chewing-trickery-3eda@gregkh>
References: <Z2ahOy7XaflrfCMw@google.com>
 <20241221111045.1082615-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241221111045.1082615-1-gnoack@google.com>

On Sat, Dec 21, 2024 at 11:10:45AM +0000, Günther Noack wrote:
> With this, processes without CAP_SYS_ADMIN are able to use TIOCLINUX with
> subcode TIOCL_SETSEL, in the selection modes TIOCL_SETPOINTER,
> TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT.
> 
> TIOCL_SETSEL was previously changed to require CAP_SYS_ADMIN, as this IOCTL
> let callers change the selection buffer and could be used to simulate
> keypresses.  These three TIOCL_SETSEL selection modes, however, are safe to
> use, as they do not modify the selection buffer.
> 
> This fixes a mouse support regression that affected Emacs (invisible mouse
> cursor).
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/ee3ec63269b43b34e1c90dd8c9743bf8@finder.org
> Fixes: 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste subcommands")
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  drivers/tty/vt/selection.c | 14 ++++++++++++++
>  drivers/tty/vt/vt.c        |  2 --
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 564341f1a74f..0bd6544e30a6 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -192,6 +192,20 @@ int set_selection_user(const struct tiocl_selection __user *sel,
>  	if (copy_from_user(&v, sel, sizeof(*sel)))
>  		return -EFAULT;
>  
> +	/*
> +	 * TIOCL_SELCLEAR, TIOCL_SELPOINTER and TIOCL_SELMOUSEREPORT are OK to
> +	 * use without CAP_SYS_ADMIN as they do not modify the selection.
> +	 */
> +	switch (v.sel_mode) {
> +	case TIOCL_SELCLEAR:
> +	case TIOCL_SELPOINTER:
> +	case TIOCL_SELMOUSEREPORT:
> +		break;
> +	default:
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +	}
> +
>  	return set_selection_kernel(&v, tty);
>  }
>  
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 96842ce817af..be5564ed8c01 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3345,8 +3345,6 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
>  
>  	switch (type) {
>  	case TIOCL_SETSEL:
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
>  		return set_selection_user(param, tty);
>  	case TIOCL_PASTESEL:
>  		if (!capable(CAP_SYS_ADMIN))
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
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

