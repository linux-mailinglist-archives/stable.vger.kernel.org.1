Return-Path: <stable+bounces-19759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0A1853556
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0841C26455
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10E65F853;
	Tue, 13 Feb 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GNuOJsxk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544575F84C
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839713; cv=none; b=nP1se9pznoQh8Ik6kqJxOxb1yrMd9PtVhkJhT6nohLimbrsl3HLKZ1pYZXAqOxw4Nm6JBbLXtElIWGFTQTp4D5jw4QEAjhLD85HH5mGtyJTaWoc2BmikG9NcSIzvUj5eqYIIvgntF3iFaC8GDEld4jX1lBRyZ12pNx6tu1qIr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839713; c=relaxed/simple;
	bh=8JLDwVOIdaH1l6OCgkzmhKbJyZ5SrbCkf4G2+8zT+os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPUIh1sT8lFgy5u8PiKGWwxbZaqUzXWxt/mEN3oXNuWyihufC2JV0AJxEMRJdnnc43y1eN/SLXrsZcTQhBlHDFA2YuMDpBqkroS9tihZa6bSBFYjMx1hPKsSs+uWQ/MblmLVCBqjgXP8KQmdcTWogBLaVuLgkBthxKzVi+jjEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GNuOJsxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A03FC43390;
	Tue, 13 Feb 2024 15:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707839712;
	bh=8JLDwVOIdaH1l6OCgkzmhKbJyZ5SrbCkf4G2+8zT+os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GNuOJsxkv29FE5osspDHcADL51M420nZVegKRxzdEMv+HK6bMOEUyINTJoQUZAWSC
	 gteBAmIBdXi/dyWYi/rSIo6RZCZaNIq/mNyPCqBRIrjA5mD2+R/7RnjTYMkAvd3IsE
	 KcUq96ugG4SVJbaiqj6j1cKA3qkqpUZDPQ+v5w5U=
Date: Tue, 13 Feb 2024 16:55:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/net: limit inline multishot
 retries" failed to apply to 6.7-stable tree
Message-ID: <2024021344-headlamp-steed-92c2@gregkh>
References: <2024021328-washboard-crevice-aaa0@gregkh>
 <19f32ce2-cd5d-4a02-b3e6-441140e026b8@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19f32ce2-cd5d-4a02-b3e6-441140e026b8@kernel.dk>

On Tue, Feb 13, 2024 at 07:44:12AM -0700, Jens Axboe wrote:
> On 2/13/24 6:19 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.7-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 76b367a2d83163cf19173d5cb0b562acbabc8eac
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021328-washboard-crevice-aaa0@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 76b367a2d831 ("io_uring/net: limit inline multishot retries")
> > 91e5d765a82f ("io_uring/net: un-indent mshot retry path in io_recv_finish()")
> 
> This has a number of dependencies, as listed in the commit. You need all three
> to make this both apply cleanly, and work. Here's the series for 6.7, I'll send
> the same for the other ones separately.

I tried applying the dependencies, but they didn't all apply either :(

Thanks for all the backports, I'll go queue them up.

greg k-h

