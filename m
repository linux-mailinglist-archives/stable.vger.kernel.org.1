Return-Path: <stable+bounces-106056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFBF9FBA43
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 08:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3F7162CC3
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 07:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807E6183098;
	Tue, 24 Dec 2024 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TqZclh3B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A286224EA;
	Tue, 24 Dec 2024 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735025962; cv=none; b=r2GA50IphMUSp8w+VzpwhZnPP8vf6CBmErDPQS0hprjhN6MVRCbCEF88HDqI9eIlW67ni0e8lbTPLyL9oRpzc5JyYBCJsle7LvJ0EVeT8SQScYrIuGUP4RzrJ7bhCHzugkmmlRyBQkQ/MJjmr5g2UqoTO0b+bWT7lS90O7Cv7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735025962; c=relaxed/simple;
	bh=cCQtsKCeEZog/LrYCxk88omHx4Ew2PH39UDmDC7uwBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqXmQFybQR0i/TudBR38vOlMgOe3NypBvf602b+pj0e6KV0yVb8b8e9RWYGroh4pPesmHubZpxt/nL8k9alpygiV/LvXivM6NL3UcXStxaHXDd7spb8GNeRqoCbD72r2HEPO8/sFoEH4hQXW5FRE8WVYidIkDtp3GO8EUe2Jk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TqZclh3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F308AC4CED0;
	Tue, 24 Dec 2024 07:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735025961;
	bh=cCQtsKCeEZog/LrYCxk88omHx4Ew2PH39UDmDC7uwBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqZclh3BaWFHEbQKMzD9fEyl0NYD8ZDGj2qPafWujR3koUujZls63KurKoBDAofjM
	 0mziwBwF1YNAXh/0kSRS6yHRVY3/NhEuUVlyTe/DeMamzQsQcLacO4g4ss2/X9UGNz
	 XGBxEZOfulwiC+GP5QkLEM6NPZiT79eODYOhr5ss=
Date: Tue, 24 Dec 2024 08:38:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Akash M/Akash M <akash.m5@samsung.com>
Cc: paul@crapouillou.net, Chris.Wulff@biamp.com, tudor.ambarus@linaro.org,
	m.grzeschik@pengutronix.de, viro@zeniv.linux.org.uk,
	quic_jjohnson@quicinc.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, rc93.raju@samsung.com,
	taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, selvarasu.g@samsung.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_fs: Remove WARN_ON in functionfs_bind
Message-ID: <2024122413-jersey-dimmer-b01a@gregkh>
References: <CGME20241219125248epcas5p3887188e4df29b7b580cce9cfe6fed79f@epcas5p3.samsung.com>
 <20241219125221.1679-1-akash.m5@samsung.com>
 <0375d572-4c88-40ce-af24-62a8b38fb7bf@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0375d572-4c88-40ce-af24-62a8b38fb7bf@samsung.com>

On Tue, Dec 24, 2024 at 12:12:49PM +0530, Akash M/Akash M wrote:
> 
> On 12/19/2024 6:22 PM, Akash M wrote:
> > This commit addresses an issue related to below kernel panic where
> > panic_on_warn is enabled. It is caused by the unnecessary use of WARN_ON
> > in functionsfs_bind, which easily leads to the following scenarios.
> >
> > 1.adb_write in adbd               2. UDC write via configfs
> >    =================	             =====================
> >
> > ->usb_ffs_open_thread()           ->UDC write
> >   ->open_functionfs()               ->configfs_write_iter()
> >    ->adb_open()                      ->gadget_dev_desc_UDC_store()
> >     ->adb_write()                     ->usb_gadget_register_driver_owner
> >                                        ->driver_register()
> > ->StartMonitor()                       ->bus_add_driver()
> >   ->adb_read()                           ->gadget_bind_driver()
> > <times-out without BIND event>           ->configfs_composite_bind()
> >                                            ->usb_add_function()
> > ->open_functionfs()                        ->ffs_func_bind()
> >   ->adb_open()                               ->functionfs_bind()
> >                                         <ffs->state !=FFS_ACTIVE>
> >
> > The adb_open, adb_read, and adb_write operations are invoked from the
> > daemon, but trying to bind the function is a process that is invoked by
> > UDC write through configfs, which opens up the possibility of a race
> > condition between the two paths. In this race scenario, the kernel panic
> > occurs due to the WARN_ON from functionfs_bind when panic_on_warn is
> > enabled. This commit fixes the kernel panic by removing the unnecessary
> > WARN_ON.
> >
> > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > [   14.542395] Call trace:
> > [   14.542464]  ffs_func_bind+0x1c8/0x14a8
> > [   14.542468]  usb_add_function+0xcc/0x1f0
> > [   14.542473]  configfs_composite_bind+0x468/0x588
> > [   14.542478]  gadget_bind_driver+0x108/0x27c
> > [   14.542483]  really_probe+0x190/0x374
> > [   14.542488]  __driver_probe_device+0xa0/0x12c
> > [   14.542492]  driver_probe_device+0x3c/0x220
> > [   14.542498]  __driver_attach+0x11c/0x1fc
> > [   14.542502]  bus_for_each_dev+0x104/0x160
> > [   14.542506]  driver_attach+0x24/0x34
> > [   14.542510]  bus_add_driver+0x154/0x270
> > [   14.542514]  driver_register+0x68/0x104
> > [   14.542518]  usb_gadget_register_driver_owner+0x48/0xf4
> > [   14.542523]  gadget_dev_desc_UDC_store+0xf8/0x144
> > [   14.542526]  configfs_write_iter+0xf0/0x138
> >
> > Fixes: ddf8abd25994 ("USB: f_fs: the FunctionFS driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Akash M <akash.m5@samsung.com>
> >
> > diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> > index 2920f8000bbd..92c883440e02 100644
> > --- a/drivers/usb/gadget/function/f_fs.c
> > +++ b/drivers/usb/gadget/function/f_fs.c
> > @@ -2285,7 +2285,7 @@ static int functionfs_bind(struct ffs_data *ffs, struct usb_composite_dev *cdev)
> >   	struct usb_gadget_strings **lang;
> >   	int first_id;
> >   
> > -	if (WARN_ON(ffs->state != FFS_ACTIVE
> > +	if ((ffs->state != FFS_ACTIVE
> >   		 || test_and_set_bit(FFS_FL_BOUND, &ffs->flags)))
> >   		return -EBADFD;
> >   
> Hi Greg,
> 
> I realized there's a minor nitpick with the patch I submitted - 
> specifically a pair of extra brackets not removed.
> 
> Do you want me to proceed with sending a v2 to address this, or is this 
> something you can take care while applying this patch?

It's already in my tree, as you should have gotten an email about that.

Just send a cleanup patch for later, it's not a big deal.

thanks,

greg k-h

