Return-Path: <stable+bounces-75631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E074497371F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35BE288046
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C730E18F2F0;
	Tue, 10 Sep 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ho7QoLTV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76C18D637;
	Tue, 10 Sep 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970945; cv=none; b=td8vHd4/9egXejgu5utBUSj4wlu5c8bN45DSs6FHcH2xHbXr+u2rE8is9zsJdeD55oBc27FyqtVgNzA6uqEIJVivysJRrjgqEYwb0K/j9XisPw0AlIOegz/sQqFIRoEKLcsslc9BSAydznx7Z/b4lPx/Xdxj/x0eIkaMuya+Z4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970945; c=relaxed/simple;
	bh=XVncRhu89smgyxRthRwxom9MMRDicc/wypTi2pGKFH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uztvirV9+ZPlblc84bOpwYu9hVbLg9rOjgEoNsJkpAtP1DzIrOTXYpJZ+TtO3hnvHYCR6NW/bRE1xr6f+NtrXkGs96UaN3l+PBAOKvNz3ZeHf94z4HJ1JmmQVRtM2jaQhTveNwLh6jah+LrRa+n23rPhqE219IQX+L4cMIGhuOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ho7QoLTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B11C4CEC3;
	Tue, 10 Sep 2024 12:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725970944;
	bh=XVncRhu89smgyxRthRwxom9MMRDicc/wypTi2pGKFH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ho7QoLTV3yETAd/Nsv9paRApm1AWvZXf+ghWeUIbG8D6YK3pgY5mxlwr8DdFw83rG
	 2Y+/CjtQlRSE36XaF+r8QUxeRbefedF32kTyAMXiWGoCEdaQh5uiGs3G+WhH+I+4+E
	 8sfMpkwYQDAbbXvG5ykX4x3TKrxAF1QW0DxQNypg=
Date: Tue, 10 Sep 2024 14:22:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Arthur Borsboom <arthurborsboom@gmail.com>
Cc: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jason Andryuk <jandryuk@gmail.com>, Helge Deller <deller@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
	xen-devel@lists.xenproject.org,
	Jason Andryuk <jason.andryuk@amd.com>, stable@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/xen-fbfront: Assign fb_info->device
Message-ID: <2024091004-destitute-excusably-1eb5@gregkh>
References: <20240910020919.5757-1-jandryuk@gmail.com>
 <Zt_zvt3VXwim_DwS@macbook.local>
 <ad9e19af-fabd-4ce0-a9ac-741149f9aab3@suse.de>
 <Zt__jTESjI7P7Vkj@macbook.local>
 <2024091033-copilot-autistic-926a@gregkh>
 <CALUcmUn30tPxjToysLBVBmibMaQUWW=GqFoqduP-W5QwQ-VriQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALUcmUn30tPxjToysLBVBmibMaQUWW=GqFoqduP-W5QwQ-VriQ@mail.gmail.com>

On Tue, Sep 10, 2024 at 02:18:35PM +0200, Arthur Borsboom wrote:
> On Tue, 10 Sept 2024 at 10:33, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Sep 10, 2024 at 10:13:01AM +0200, Roger Pau Monné wrote:
> > > On Tue, Sep 10, 2024 at 09:29:30AM +0200, Thomas Zimmermann wrote:
> > > > Hi
> > > >
> > > > Am 10.09.24 um 09:22 schrieb Roger Pau Monné:
> > > > > On Mon, Sep 09, 2024 at 10:09:16PM -0400, Jason Andryuk wrote:
> > > > > > From: Jason Andryuk <jason.andryuk@amd.com>
> > > > > >
> > > > > > Probing xen-fbfront faults in video_is_primary_device().  The passed-in
> > > > > > struct device is NULL since xen-fbfront doesn't assign it and the
> > > > > > memory is kzalloc()-ed.  Assign fb_info->device to avoid this.
> > > > > >
> > > > > > This was exposed by the conversion of fb_is_primary_device() to
> > > > > > video_is_primary_device() which dropped a NULL check for struct device.
> > > > > >
> > > > > > Fixes: f178e96de7f0 ("arch: Remove struct fb_info from video helpers")
> > > > > > Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > > > > > Closes: https://lore.kernel.org/xen-devel/CALUcmUncX=LkXWeiSiTKsDY-cOe8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com/
> > > > > > Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > > > > > CC: stable@vger.kernel.org
> > > > > > Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> > > > > Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
> > > > >
> > > > > > ---
> > > > > > The other option would be to re-instate the NULL check in
> > > > > > video_is_primary_device()
> > > > > I do think this is needed, or at least an explanation.  The commit
> > > > > message in f178e96de7f0 doesn't mention anything about
> > > > > video_is_primary_device() not allowing being passed a NULL device
> > > > > (like it was possible with fb_is_primary_device()).
> > > > >
> > > > > Otherwise callers of video_is_primary_device() would need to be
> > > > > adjusted to check for device != NULL.
> > > >
> > > > The helper expects a non-NULL pointer. We might want to document this.
> > >
> > > A BUG_ON(!dev); might be enough documentation that the function
> > > expected a non-NULL dev IMO.
> >
> > No need for that, don't check for things that will never happen.
> 
> And yet, here we are, me reporting a kernel/VM crash due to a thing
> that will never happen, see 'Closes' above.
> 
> I don't want to suggest BUG_ON is the right approach; I have no idea.
> I just want to mention that (!dev) did happen. :-)

A BUG_ON() will cause the same crash, so I don't see your point, sorry.

greg k-h

