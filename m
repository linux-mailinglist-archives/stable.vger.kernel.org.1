Return-Path: <stable+bounces-78355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEEA98B869
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F43D1C2221D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B4219CD07;
	Tue,  1 Oct 2024 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HQxheXCs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED712B9B0;
	Tue,  1 Oct 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775196; cv=none; b=s1zLDHDV+9982tH6wS6xK56nAV+D9rEZGKPyTLuDHAaAeVMasHRjTC5nEXJjk6lmyudGddz9C/+PG7S4wmwDVBWblx+g9E2LdBd/tJFRoNvwZaNmQa0L5h2TmyEjZwMS2TkJbX8I1tsSEK1170qP8TjWxvK70hhpmBLHnZ3IY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775196; c=relaxed/simple;
	bh=o1g2izY7Kq/8+XP4SFkp5bIDshCnrC+GUgg6QlSgQnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXM1XHPpjJXXjQWwN6oPFkJwzPOIXv52D+QhY93MBz/t3xnq7LqMFzaFqqEEb5J+4An3gowCmt302h6+a74IoIWykX/14vgsZ7CFzaxRKmpK10cs80ETLFcIC/vukMo35vV+JhPv6qZbbOHQHfCAx3Upc4LHBR9e0xVGsAaZdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HQxheXCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13358C4CEC6;
	Tue,  1 Oct 2024 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727775195;
	bh=o1g2izY7Kq/8+XP4SFkp5bIDshCnrC+GUgg6QlSgQnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQxheXCsdj0qDrnfbPlluDiYy8ntzrNEEbaxsPtXw45Dq0P6wOvz+WBqqtt6LO4S8
	 I+IPJT1AZ0KSNHSwQcmnkaWFsYMihfyVDXXUClYMdgDyCUWDDsI5CEYvtxxhr++Q5m
	 7W7LS7PDWFfYdk1mOT0kNllc4XmrQ+Tk7qji+WNQ=
Date: Tue, 1 Oct 2024 11:33:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	dlechner@baylibre.com
Subject: Re: Patch "Input: ims-pcu - fix calling interruptible mutex" has
 been added to the 6.11-stable tree
Message-ID: <2024100130-stereo-diner-11ba@gregkh>
References: <20240930232429.2569091-1-sashal@kernel.org>
 <Zvu7yZx5XW2nXmxU@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvu7yZx5XW2nXmxU@google.com>

On Tue, Oct 01, 2024 at 02:07:21AM -0700, Dmitry Torokhov wrote:
> On Mon, Sep 30, 2024 at 07:24:28PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     Input: ims-pcu - fix calling interruptible mutex
> > 
> > to the 6.11-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      input-ims-pcu-fix-calling-interruptible-mutex.patch
> > and it can be found in the queue-6.11 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> 
> Did you manage to pick up 703f12672e1f ("Input: ims-pcu - switch to
> using cleanup functions") for stable? I would love to see the
> justification for that... 

It already is in the 6.11 kernel tree, so why would this fix, which
says:

> > commit c137195362a652adfbc6a538b78a40b043de6eb0
> > Author: David Lechner <dlechner@baylibre.com>
> > Date:   Tue Sep 10 16:58:47 2024 -0500
> > 
> >     Input: ims-pcu - fix calling interruptible mutex
> >     
> >     [ Upstream commit 82abef590eb31d373e632743262ee7c42f49c289 ]
> >     
> >     Fix calling scoped_cond_guard() with mutex instead of mutex_intr.
> >     
> >     scoped_cond_guard(mutex, ...) will call mutex_lock() instead of
> >     mutex_lock_interruptible().
> >     
> >     Fixes: 703f12672e1f ("Input: ims-pcu - switch to using cleanup functions")

This is a bugfix for the 6.11 tree, not be applicable to the 6.11.y
releases?

thanks,

greg k-h

