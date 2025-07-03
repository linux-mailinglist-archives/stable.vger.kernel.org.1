Return-Path: <stable+bounces-159317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5053AF762E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950677A7EFE
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB42E7BB1;
	Thu,  3 Jul 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VVEa4FGy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574042E764E;
	Thu,  3 Jul 2025 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550770; cv=none; b=MG4HeVBRqZgCoOisQew7Oh5q96oXPxsWAEoCwSL0I58lUtQnGXQ0+asfLMifyagv1Rl6/v428tTwX6UMDpM5GCUT+eL/gXv/C/xsjWRFru6ROxj0hc49AZc3sR4xO2Oj5bAdF4PZf2PW3gy12mtf8bNI8c3sEWaU1n237fjh034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550770; c=relaxed/simple;
	bh=ZvlwY94c4XkB40aGlbHAPiQ0MpZ6H9V5EllM8ZO0Hnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk7BIfQ2L2OBFPqRas+/b/436LkTc9dSz5iiPY5PHAaNmVQYIDw64QHIYspxbmqRS/P6HtQ+1X0UyHnYj0DPm654BJTrPaXa4+qjX3BHCXWu32MtBFBQhM1j5PYTJSRa6bQFfxr3kfP2Y6My3ux6479Y1pWJZg5ZOYbHmqO51y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VVEa4FGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2D0C4CEE3;
	Thu,  3 Jul 2025 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751550769;
	bh=ZvlwY94c4XkB40aGlbHAPiQ0MpZ6H9V5EllM8ZO0Hnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVEa4FGyt8E7IxesWeWV6bIm39QKXYmZe0gqOmLM0cYmq0CH1t/UWLRmZGFSPkK0+
	 5+npxFWWVJxGoFWvJdSHTRfLmczi0nxdyxXbnKzplcXMr7Laz7DX66OHTHv4lZmDpJ
	 gg7Mc8ja8PkORpkJuimom+v+0x5NaqJOsLMdu1C0=
Date: Thu, 3 Jul 2025 15:52:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, chrome-platform@lists.linux.dev, dawidn@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_chardev: Fix UAF of ec_dev
Message-ID: <2025070306-scoff-entrap-05b2@gregkh>
References: <20250703113509.2511758-1-tzungbi@kernel.org>
 <20250703113509.2511758-3-tzungbi@kernel.org>
 <2025070320-gathering-smitten-8909@gregkh>
 <aGaCQuvwPjDIaH6W@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGaCQuvwPjDIaH6W@google.com>

On Thu, Jul 03, 2025 at 01:14:42PM +0000, Tzung-Bi Shih wrote:
> On Thu, Jul 03, 2025 at 01:52:02PM +0200, Greg KH wrote:
> > On Thu, Jul 03, 2025 at 11:35:09AM +0000, Tzung-Bi Shih wrote:
> > But yes, one that people have been talking about and discussing generic
> > ways of solving for years now, you have seen the plumbers talks about
> > it, right?
> 
> Will check them.
> 
> > > @@ -31,7 +34,14 @@
> > >  /* Arbitrary bounded size for the event queue */
> > >  #define CROS_MAX_EVENT_LEN	PAGE_SIZE
> > >  
> > > +/* This protects 'chardev_list' */
> > > +static DEFINE_MUTEX(chardev_lock);
> > > +static LIST_HEAD(chardev_list);
> > 
> > Having a static list of chardevices feels very odd and driver-specific,
> > right
> 
> The `chardev_list` is for recording all opened instances. Adding/removing
> entries in the .open()/.release() fops. The `chardev_lock` is for protecting
> from accessing the list simultaneously.

Ick, don't attempt to track objects across open/release, as that's not
the driver's job, that's the owner of the object that is doing the
open/release (i.e. the cdev) job.  You "know" that when open/release
happens, your object is "alive".  Any other time, you have no idea, so
don't attempt to try to track that please.

> They are statically allocated because they can't follow the lifecycle of
> neither the platform_device (e.g. can be gone after unbinding the driver)
> nor the chardev (e.g. can be gone after closing the file).

Yes, and your object should not have 2 reference counts, which is why
this is a common issue.  Your single object is trying to span both of
them, and the interactions is "messy".

You should be able to do this without the external list.  I know many
other drivers/subsystems have handled this properly, perhaps look at
them?

Or better yet, split the thing apart into your platform and misc device
portions?

Or even better, don't worry abouut it as NO ONE should be unbinding a
platform device from a driver under real operations.  If that does
happen, they could be, and should be, doing worse things to your system.
This is not a real-world situation that ever should be happening EXCEPT
for maybe when you are doing driver development work.  So it's a very
very very low priority issue.

thanks,

greg k-h

