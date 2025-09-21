Return-Path: <stable+bounces-180821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1246B8DFF2
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 18:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8AB7A5A9C
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 16:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A7B1DDC1E;
	Sun, 21 Sep 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="idpznmJ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236CB155326
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472869; cv=none; b=GfLJtOo1TKywGsxJni12x3JzyMB2dJ4BlN3I6o//le9vkk8H3hsD8LC6EZCzLSoyyZ5xZKuC4Rtgrl7SwgsXo+tgQQJl3DcNi2pUVkRL+DhyrcBfQ+oMyPt3oHhzu64SOBwT0J6Mqy5cNFxjcsToXWbjnCKt+s9reXWl/gghPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472869; c=relaxed/simple;
	bh=L4cQYQD3oDPrMoTBD53mgayv0/r5ERHFxjxryJ5G8Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMmn8rY8VJNHmxk9lJ4O+G+02dfXiUriwD+KPJkG9uovFyx3/JPnlD5eT5qMuQR7/AIGow90AsXkenRsG5yK+a5FC3Xax91LaVfaih5NRavQOhR8wjM4uFNhl1tpX7gvxMIrzNHH5uy17aVWU3ivMkGItkaYP0dwoQWOUAWv4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=idpznmJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D64C4CEE7;
	Sun, 21 Sep 2025 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758472868;
	bh=L4cQYQD3oDPrMoTBD53mgayv0/r5ERHFxjxryJ5G8Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idpznmJ03R5uFA5ZLZKlR+LIoE8JoaCsJ+1/yzZGNSGfOe4j2Fk/2Dhwgox1ohNUl
	 cSz/jMxvWupNH8FVINzR6iVYPtSx8dJHsuEANTl5cqLwc4PkLNVoorbTK/DdmjsmKE
	 OP5yCRme7lBBACjgkVy1hCvRwsGh4sj7IyM3zaZE=
Date: Sun, 21 Sep 2025 18:41:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: ilpo.jarvinen@linux.intel.com, rahul@chandra.net,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] platform/x86: asus-wmi: Re-add extra keys
 to ignore_key_wlan" failed to apply to 6.12-stable tree
Message-ID: <2025092155-gladiator-rocking-c411@gregkh>
References: <2025092126-upstream-favorite-2f89@gregkh>
 <CAGwozwE-wBt2fiDyFPjX2tR9VySQJyXn1zLtEQFCRHnxNS=fWw@mail.gmail.com>
 <2025092134-snazzy-saved-1ef4@gregkh>
 <CAGwozwF3SgRG7ZYSj629NOJx0dWSBYH67v_wwQ7WdKOU9cGxow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGwozwF3SgRG7ZYSj629NOJx0dWSBYH67v_wwQ7WdKOU9cGxow@mail.gmail.com>

On Sun, Sep 21, 2025 at 06:34:27PM +0200, Antheas Kapenekakis wrote:
> On Sun, 21 Sept 2025 at 18:29, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Sep 21, 2025 at 03:57:25PM +0200, Antheas Kapenekakis wrote:
> > > On Sun, 21 Sept 2025 at 14:34, <gregkh@linuxfoundation.org> wrote:
> > > >
> > > >
> > > > The patch below does not apply to the 6.12-stable tree.
> > > > If someone wants it applied there, or to any other stable or longterm
> > > > tree, then please email the backport, including the original git commit
> > > > id to <stable@vger.kernel.org>.
> > > >
> > > > To reproduce the conflict and resubmit, you may use the following commands:
> > > >
> > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > > > git checkout FETCH_HEAD
> > > > git cherry-pick -x 225d1ee0f5ba3218d1814d36564fdb5f37b50474
> > > > # <resolve conflicts, build, test, etc.>
> > > > git commit -s
> > > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092126-upstream-favorite-2f89@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> > > >
> > > > Possible dependencies:
> > > >
> > >
> > > Is commit 1c1d0401d1b8 ("platform/x86: asus-wmi: Fix ROG button
> > > mapping, tablet mode on ASUS ROG Z13") eligible for backport to
> > > stable? If yes it fixes the apply conflict. Z13 users would appreciate
> > > in any case.
> >
> > I don't see that git commit in Linus's tree, are you sure it is correct?
> 
> Sorry, I picked a hash from my own tree by mistake, it is commit
> 132bfcd24925 ("platform/x86: asus-wmi: Fix ROG button mapping, tablet
> mode on ASUS ROG Z13") in v6.17-rc5.

No problem, that worked, thanks!

greg k-h

