Return-Path: <stable+bounces-155327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E4FAE39A5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE4A18966FF
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472A230268;
	Mon, 23 Jun 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qo6A3jw7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0C22331E
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670148; cv=none; b=rZlVoD18ukmxPM2piFSiwOabybU57nYRdM2MFA6Be66/5OYhQHl5C9wCEibPA0LtXteNMtY7O/56hF3mYGczQTMMXgVc7+ZH8whAjaQwBfKLMlW2YO1ZexM2CmZNpI1EshijvQjmJTIGQDkCTzH4Gk5mGW3JZRfsDSrGNqaVGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670148; c=relaxed/simple;
	bh=H3MxyUUr5s0Er51BrWe8nGLS2gI/UvSH1+f5iiT8/I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6beipFCRfIQ3FifbnCozEmH/pq++3C5Gx0nSpKVsZYBwDBBBTDCNiuC2e01cSHn3P5LwInY61bvj8oHZ07xuSRJ+Qn01fCYpZbLNxBk8+6SbX/kR1tz83v+0bhFbkWl9Xp/C15ZE2L1gmJepy9VkNnwSlRCVBuanAWBwKgGr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qo6A3jw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E88C4CEEA;
	Mon, 23 Jun 2025 09:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750670148;
	bh=H3MxyUUr5s0Er51BrWe8nGLS2gI/UvSH1+f5iiT8/I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qo6A3jw7fyjNiw/QMYwarGZPN0gPjNu36AI9VOS17xpXDlNG1Q3DK3er5bfHSAdAn
	 djiHUZrH6ryRBwlLtWr5na9IIlU1VhQaQC4fZw/F/0l+PW4mKOiLQPceH3oW7vzrS4
	 Jcp8+NDZ6dJqix18e6IRRYhhEzuxJedeBR4Ic5Y4=
Date: Mon, 23 Jun 2025 11:15:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Lyakas <alex.lyakas@zadara.com>
Cc: stable@vger.kernel.org
Subject: Re: stable patch 42fac18 missing from linux-6.6
Message-ID: <2025062326-tutu-improve-c423@gregkh>
References: <CAOcd+r0Rg6JGMjwZnCran8s+dbqZ+VyUcgP_u7EucKEXZasOdg@mail.gmail.com>
 <2025062334-circular-tiring-0359@gregkh>
 <CAOcd+r3C3LKPv-Jc1op5t1Xn5aijV9k-M4wm1hopARu=sy+fnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOcd+r3C3LKPv-Jc1op5t1Xn5aijV9k-M4wm1hopARu=sy+fnQ@mail.gmail.com>

On Mon, Jun 23, 2025 at 12:07:42PM +0300, Alex Lyakas wrote:
> On Mon, Jun 23, 2025 at 9:35 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jun 15, 2025 at 06:36:44PM +0300, Alex Lyakas wrote:
> > > Greetings,
> > >
> > > The following patch [1]:
> > > "42fac18 btrfs: check delayed refs when we're checking if a ref exists"
> > > has been marked as
> > > "CC: stable@vger.kernel.org # 5.4+"
> > > but I do not see that it has been backported to linux-6.6.y branch.
> > >
> > > Can this patch be picked up in the next version of linux-6.6 please?
> >
> > It does not apply cleanly there at all, which is why we did not apply it
> > already.  How did you test this change works in this tree?
> Hi Greg,
> Thank you for your response.
> 
> >
> > If you want it here, great, can you provide a backported and tested
> > version?
> I backported the patch and tested it to the best of my ability. I was
> able to test the part where the reference exists in the extent tree,
> which means the patch doesn't break existing functionality. However, I
> was not able to test the case where we only have the delayed
> reference.

Then it's hard to know if it works :(

> Please let me know if this is still good enough, so that I can post
> this patch for review here (or on linux-stable-commits?).

linux-stable-commits is just for when we apply stuff to the tree,
stable@vger.kernel.org is for submitting new stuff.

If you think your backport is correct, sure, submit it, it's your call.

thanks,

greg k-h

