Return-Path: <stable+bounces-208439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E3AD243AB
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 12:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 554373029F8F
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD0B37A4B7;
	Thu, 15 Jan 2026 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yGaHV9eJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433AD37C0E9;
	Thu, 15 Jan 2026 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477252; cv=none; b=FtoVSfzBSMo5XhTHXHR0lsgiYKuyPNduQLU15mWys5mGSPzgiH5+nZWf9RWHCaPu7UvINMCrvTg8keLFcggpjqSpkQQrliPWAiFZtjEyWlSQcnmJbH4tJ2uEyJOmJAS1E55ANbE+fulYRsgMQ6MEt9pFyr8AiMVsDYc6tPFSmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477252; c=relaxed/simple;
	bh=VWDR7AT8+wU0Lz5np4hYE3TgvnOpkYak1mBXuNbBq8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFt/V9SMwXWM7R44XnTkr4qfl21M1BtIBuCYFfJJzTss3bJq/PM/KITv26mFNE1zM3R1vDhmJYcGIZLUo/l2LO+jsNXU9aNH0RvyC1YwdifUDqSqH6z/zfi1yocfPdA7cOCbeLtzUuT20dG/H1Dl81pt+m4kT7fypfT9I6SoGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yGaHV9eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AA4C2BC86;
	Thu, 15 Jan 2026 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768477251;
	bh=VWDR7AT8+wU0Lz5np4hYE3TgvnOpkYak1mBXuNbBq8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yGaHV9eJReu4/Nvotsf08O+3xILYaj4FeD9kiIjE6NwvlKUD5Ac001afTJy+zLeVC
	 ZemNFIYWo+ijbmC/NGEdmdYsAhTrOZUx1dkSv+oWwssCMHhUo3NArNfOBe2QgPvy/M
	 jPQQt3ZeOxo8Qme6qkNgLbv8Pqxc7ws+soRCRAM0=
Date: Thu, 15 Jan 2026 12:40:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	zhangshida@kylinos.cn, Coly Li <colyli@fnnas.com>
Subject: Re: Patch "bcache: fix improper use of bi_end_io" has been added to
 the 6.6-stable tree
Message-ID: <2026011537-visiting-fastness-a184@gregkh>
References: <20260112172345.800703-1-sashal@kernel.org>
 <aWipoJjgc2cQpcl5@moria.home.lan>
 <2026011517-apricot-supply-051c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026011517-apricot-supply-051c@gregkh>

On Thu, Jan 15, 2026 at 12:39:34PM +0100, Greg KH wrote:
> On Thu, Jan 15, 2026 at 03:47:39AM -0500, Kent Overstreet wrote:
> > On Mon, Jan 12, 2026 at 12:23:45PM -0500, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     bcache: fix improper use of bi_end_io
> > > 
> > > to the 6.6-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      bcache-fix-improper-use-of-bi_end_io.patch
> > > and it can be found in the queue-6.6 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > Sasha, has this been dropped?
> 
> Why just drop it from 6.6?  What about all other branches?  What about
> Linus's tree?

Ah, it's being reverted there, ok, I'll go drop this from all branches
now, thanks.

greg k-h

