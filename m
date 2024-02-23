Return-Path: <stable+bounces-23486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C37E86154C
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 16:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C001C213B3
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308FC811F9;
	Fri, 23 Feb 2024 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YvcNnp3T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11381ACA;
	Fri, 23 Feb 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701092; cv=none; b=py8RQZBJA1BweCypFCXlswN1BBx/atD4DWRMC40hPf5qUB5hYX/k2mgXJb/7dskZuAzxxZOgkk5wNwz5aSUORrmPslzn4ANnl96O/3+geguMz871OjlS2JB5qkKwWgxzgN9tLqJqEKWk7qJEyZ5mlFAMMu22xnd47NV8XcVBjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701092; c=relaxed/simple;
	bh=xjJW8CImIsyMr1OKn14hnhNByQTkOaqts6vEi/9jsh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKln4ETtmprwcdDgqEmL6OACMyapzKUR/w3f6fK8fbZ+m2cLmdrOx1lpCRKQPmH9flQLxhyOpdMZdld1ErWkrBSXbTtB3pwYmPKx7MbOTiQzkv6FE/FiaHLls2ed3jDxMtmxuqmkJn7d+yDgULiK3CdbidKnm7iGFqwHZ+0Z8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YvcNnp3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AB3C433F1;
	Fri, 23 Feb 2024 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708701091;
	bh=xjJW8CImIsyMr1OKn14hnhNByQTkOaqts6vEi/9jsh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvcNnp3TMt/LRzYcqbCp/m4akQkIexqbMtitQatF2zLrVJ7bCmrFFc846qJGx/EqA
	 KowZdORJJF7tDasNZniZ7uCVaU79HVbN23C2wox65thWq9LSKaeKBvbMgg9chz+bWX
	 qQv4uhX/YdczScOf+MZ6BaUX7XnuOCQwfjIjakrY=
Date: Fri, 23 Feb 2024 16:11:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: Stable <stable@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>,
	Steve French <smfrench@gmail.com>
Subject: Re: Request to include a couple of fixes to stable branches
Message-ID: <2024022347-blinking-dingo-1411@gregkh>
References: <CANT5p=rYFOkpnB_SMGd0dAV5orX--Z53O-gjVg4qRkgrH6HiqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANT5p=rYFOkpnB_SMGd0dAV5orX--Z53O-gjVg4qRkgrH6HiqA@mail.gmail.com>

On Fri, Feb 23, 2024 at 07:11:48PM +0530, Shyam Prasad N wrote:
> Hi stable maintainers,
> 
> We seem to have missed adding the stable tag to a couple of important
> patches that went upstream for fs/smb/client. Can you please include
> them in all the stable trees?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4f1fffa2376922f3d1d506e49c0fd445b023a28e
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=79520587fe42cd4988aff8695d60621e689109cb

These do not apply properly at all to any stable kernel trees, did you
get them to work?  How did you test this?

Please send a set of working backports and we will be glad to apply
them.

thanks,

greg k-h

