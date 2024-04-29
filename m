Return-Path: <stable+bounces-41620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790EA8B55CC
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3346E286117
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC653D0B3;
	Mon, 29 Apr 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PaV+cRX8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20AE3CF74
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387804; cv=none; b=r0pPZMOMofBG7cS92w+DCaQR6jGhmWjzCA5fsqPedGcMm3FvwwbADP02PSiQC9SGYH1Ga+4IxeScxlYcg1vGQvwrATASGvKu789DwQ0yBlFJRqLafmoUVxsqYZkpuBYjLg/lYzFqFyxs5ryhDyf6j5+CKCwX4nztPRqcE69vwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387804; c=relaxed/simple;
	bh=Nl9gMivwT24dSkcBiPoGQClajMHtX4eAjYkm4cRIQFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jadPypEyQ+s+Nr7yfmLlpBIFkGTyqB7STr7lWTTHy/asR2qNukSUFCwpi8uct+Au5aWDYNAzyjZsfy9GUqwX5W4R2JEaWitlsd4qF3sU3n30gDrukZZys8YA6iQY171Q9C3kdYnoLJaGyrUoRn+YyoxOk+DfUfUKp4AH7vHFJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PaV+cRX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C75C4AF17;
	Mon, 29 Apr 2024 10:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714387803;
	bh=Nl9gMivwT24dSkcBiPoGQClajMHtX4eAjYkm4cRIQFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PaV+cRX8fifDk3gsYuK0k2fzlG0Ym+sfWdFBeQ6uvSEvos+iR2Lgq7j3x+OH5OW39
	 dPyMBs42tcCi8nvC7u7cLoFA91I5F9tYTHZj8T2m4QGaIHr/u314QhtPH755QruGJ0
	 wGnGxZjzPgmAhbWUhfgBXylG4T+TxUkN4HYLNivk=
Date: Mon, 29 Apr 2024 12:49:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, "# 3.4.x" <stable@vger.kernel.org>,
	jan.setjeeilers@oracle.com
Subject: Re: v5.15 backport request
Message-ID: <2024042947-smith-shallow-1439@gregkh>
References: <CAMj1kXEGNNZm9RrDxT6RzmE8WGFG-3kZePaZZNKJrT4fj3iveg@mail.gmail.com>
 <2024041134-strobe-childhood-cc74@gregkh>
 <2024041113-flyaway-headphone-df2b@gregkh>
 <CAMj1kXEagP6psCc=YcpV9Ye=cMYgu-O8npbzH4qaN1xxe=eQDA@mail.gmail.com>
 <Zifui1Z8p4R24wyL@char.us.oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zifui1Z8p4R24wyL@char.us.oracle.com>

On Tue, Apr 23, 2024 at 01:23:23PM -0400, Konrad Rzeszutek Wilk wrote:
> On Thu, Apr 11, 2024 at 03:14:23PM +0200, Ard Biesheuvel wrote:
> > On Thu, 11 Apr 2024 at 13:50, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Apr 11, 2024 at 12:30:30PM +0200, Greg KH wrote:
> > > > On Thu, Apr 11, 2024 at 12:23:37PM +0200, Ard Biesheuvel wrote:
> > > > > Please consider the commits below for backporting to v5.15. These
> > > > > patches are prerequisites for the backport of the x86 EFI stub
> > > > > refactor that is needed for distros to sign v5.15 images for secure
> > > > > boot in a way that complies with new MS requirements for memory
> 
> Secure Boot needn't be enabled.
> > > > > protections while running in the EFI firmware.
> 
> And here is the background:
> https://microsoft.github.io/mu/WhatAndWhy/enhancedmemoryprotection/
> 
> > > >
> > > > What old distros still care about this for a kernel that was released in
> > > > 2021?  I can almost understand this for 6.1.y and newer, but why for
> > > > this one too?
> > >
> > > To be more specific, we have taken very large backports for some
> > > subsystems recently for 5.15 in order to fix a lot of known security
> > > issues with the current codebase, and to make the maintenance of that
> > > kernel easier over time (i.e. keeping it in sync to again, fix security
> > > issues.)
> > >
> > > But this feels like a "new feature" that is being imposed by an external
> > > force, and is not actually "fixing" anything wrong with the current
> > > codebase, other than it not supporting this type of architecture.  And
> > > for that, wouldn't it just make more sense to use a newer kernel?
> > >
> > 
> > Jan (on cc) raised this: apparently, Oracle has v5.15 based long term
> > supported distro releases, and these will not be installable on future
> > x86 PC hardware with secure boot enabled unless the EFI stub changes
> > are backported.
> > 
> > >From my pov, the situation is not that different from v6.1: the number
> > of backports is not that much higher than the number that went/are
> > going into v6.1, and most of the fallout of the v6.1 backport has been
> > addressed by now.
> > 
> > For an operational pov, I need to defer to Jan: I have no idea what
> > OEMs are planning to do wrt these new MS requirements, if they will
> 
> .. snip..
> 
> Hey Greg,
> 
> This is driven by the BlackLotus exploit and alike to fix boot-time
> security lapses. From a risk perspective it is boot-time code so it is
> very easy to figure out if it backports are busted.
> 
> In terms of OEMs, it is actually more of a cloud vendor wanting to roll
> this soon-ish and that combined with our customers worshipping these
> crusty old 5.15 kernels that puts us in this situation.

I think that worship needs to stop when they desire massive new features
like this, sorry.  Please have them move to the 6.1 kernel tree instead
if they wish to care about this type of thing, or better yet, 6.6.

thanks,

greg k-h

