Return-Path: <stable+bounces-86979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFF99A5544
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 18:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2EBB22861
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 16:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C907B194A5A;
	Sun, 20 Oct 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="I/TzK25e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9EC1922EE
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729442623; cv=none; b=tvkrsbVK55VbovxwR7JN1uItHKtH1y5nQ5mEs9S7YtziNrEHiPR3JbAPMriisjdDbXj2fS4/FiUCsYFVTVKWUP9esWAjOQ2BVQ40L3OyFedPnacnOCZxE2nu3FOwkpLpSe8OloY5Bi3V/WQGr4G163O5FCbphjnpBefo8f/hnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729442623; c=relaxed/simple;
	bh=aXelq+6UcPxutqyDfCpfiq66JRmQ5hET+F7UNbintns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg9GcC6B266+zYK/+A565grBUcYZ7NNWDKuBho8PYq9q5UuuIf9fH0torxvT/NvruFiRiJQdLydUrTVmqhEPfyFRe0wihBUefcXzS5kOKh+2Zs9egesP9iDWBraF4Xcq8piZ41P9EFqIjdUfrYNQ8/ZU2ZOCqzQK6eQsatCkkqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=I/TzK25e; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e57d89ffaso2849822b3a.1
        for <stable@vger.kernel.org>; Sun, 20 Oct 2024 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1729442621; x=1730047421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uuyE0zXThf85ODlV7Yrpi5hwCxVxPXafthR4WU2BoDk=;
        b=I/TzK25euVtXyEraaC865llkN61ZRrBT97P+4LI3uoCdkTS26pJ9NFwd1Fgo97hiIa
         w3efV6xfDpvE2YaxsSj7e1AS7AMXdKGITeQnhTsa6vrGxqCtu7asNm6rnDZXoTcxiAyS
         w+0LzupUDwHRPPzFiKfA/AfYbSKqisx9saJrgjMSmg446klc/D4OkoI6VWFr7oipfXjV
         xT6cwfKdccbXOwEnMSI9yvA8/Kda8GF3lkJ++9pmDpAvndQRwKVN0xSywos6NxqtjOHE
         gBTttzWSZkVnVqCuvL1Ay05Voxqg+J0JGP+NDn/zJY+RfHfMUZa2rCXputkukOQbEIpJ
         v+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729442621; x=1730047421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuyE0zXThf85ODlV7Yrpi5hwCxVxPXafthR4WU2BoDk=;
        b=GjtcPko1pfASwYZuaXjk+a/0q1O3bUSN0pw6iDEEh704LBINFxxi5bz9vbzSN/MSMV
         eDdKd2y39JeknfkLQEH7u75LHfWR1LjlNp6tLMelBlJU+E0PKWYgn7E+bACM3/tDl4w6
         cQBumcofc0BxzbsygSyXTBmbCU4vmsuJ+frZ2dtxhRIV+HSl5F4zHatG27bbCjAJVESy
         g0b1pnUQXDcPsRk4QC+guMCLomMP4iUXqSMo0UHMMyUETLL56s87GeHLVaaPeHGHPsek
         QcFhY0RGxp5NTBnpBbuL+4QByc0NUqWBgV2m5efuYo0UzhSYQzXzNP5h4lMdh9JX1CzV
         gl2w==
X-Forwarded-Encrypted: i=1; AJvYcCXSqerLRfVwDrGUJOHRXI4YcPb9/fiw448wnRhUfrXmBx6U4b2PSjwOzd4GOfex3KFHUUgz3YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYVLkP49xW0QkBCSlR7krPy1zZH305k1VqP48eh+wHbYMyItu
	MpZRruG7TBsg8FTu5Tf/445EH0CLTxATm5WrRUnNR3rVFDkZMEmCCCa4QDdaEQU=
X-Google-Smtp-Source: AGHT+IHFp/oUg1b/dmDTKrHpwmqnvfJj1a4oSvJqt+BGdzsAhPpsM0P8qLXruvy7sWZ869eHE6N/LA==
X-Received: by 2002:a05:6a00:198d:b0:71e:4c86:6594 with SMTP id d2e1a72fcca58-71ea320d843mr11915880b3a.10.1729442620838;
        Sun, 20 Oct 2024 09:43:40 -0700 (PDT)
Received: from mozart.vkv.me (192-184-160-110.fiber.dynamic.sonic.net. [192.184.160.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea1d1sm1346265b3a.165.2024.10.20.09.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 09:43:40 -0700 (PDT)
Date: Sun, 20 Oct 2024 09:43:37 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>,
	George Spelvin <linux@horizon.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] pps: Remove embedded cdev to fix a use-after-free
Message-ID: <ZxUzORuz4r4HATOe@mozart.vkv.me>
References: <ZuMvmbf6Ru_pxhWn@mozart.vkv.me>
 <8072cd54b02eaebf16739f07e6307271534e21c7.1726119983.git.calvin@wbinvd.org>
 <2024101350-jinx-haggler-5aca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024101350-jinx-haggler-5aca@gregkh>

Hi Greg,

On Sunday 10/13 at 17:04 +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 13, 2024 at 05:24:29PM -0700, Calvin Owens wrote:
> > On a board running ntpd and gpsd, I'm seeing a consistent use-after-free
> > in sys_exit() from gpsd when rebooting:
> > 
> >     pps pps1: removed
> >     ------------[ cut here ]------------
> >     kobject: '(null)' (00000000db4bec24): is not initialized, yet kobject_put() is being called.
> 
> Something is wrong with the reference counting here...
> 
> >     WARNING: CPU: 2 PID: 440 at lib/kobject.c:734 kobject_put+0x120/0x150
> >     CPU: 2 UID: 299 PID: 440 Comm: gpsd Not tainted 6.11.0-rc6-00308-gb31c44928842 #1
> >     Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
> >     pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >     pc : kobject_put+0x120/0x150
> >     lr : kobject_put+0x120/0x150
> >     sp : ffffffc0803d3ae0
> >     x29: ffffffc0803d3ae0 x28: ffffff8042dc9738 x27: 0000000000000001
> >     x26: 0000000000000000 x25: ffffff8042dc9040 x24: ffffff8042dc9440
> >     x23: ffffff80402a4620 x22: ffffff8042ef4bd0 x21: ffffff80405cb600
> >     x20: 000000000008001b x19: ffffff8040b3b6e0 x18: 0000000000000000
> >     x17: 0000000000000000 x16: 0000000000000000 x15: 696e6920746f6e20
> >     x14: 7369203a29343263 x13: 205d303434542020 x12: 0000000000000000
> >     x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> >     x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> >     x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> >     x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> >     Call trace:
> >      kobject_put+0x120/0x150
> >      cdev_put+0x20/0x3c
> >      __fput+0x2c4/0x2d8
> >      ____fput+0x1c/0x38
> >      task_work_run+0x70/0xfc
> >      do_exit+0x2a0/0x924
> >      do_group_exit+0x34/0x90
> >      get_signal+0x7fc/0x8c0
> >      do_signal+0x128/0x13b4
> >      do_notify_resume+0xdc/0x160
> >      el0_svc+0xd4/0xf8
> >      el0t_64_sync_handler+0x140/0x14c
> >      el0t_64_sync+0x190/0x194
> >     ---[ end trace 0000000000000000 ]---
> > 
> > ...followed by more symptoms of corruption, with similar stacks:
> > 
> >     refcount_t: underflow; use-after-free.
> >     kernel BUG at lib/list_debug.c:62!
> >     Kernel panic - not syncing: Oops - BUG: Fatal exception
> > 
> > This happens because pps_device_destruct() frees the pps_device with the
> > embedded cdev immediately after calling cdev_del(), but, as the comment
> > above cdev_del() notes, fops for previously opened cdevs are still
> > callable even after cdev_del() returns. I think this bug has always
> > been there: I can't explain why it suddenly started happening every time
> > I reboot this particular board.
> > 
> > In commit d953e0e837e6 ("pps: Fix a use-after free bug when
> > unregistering a source."), George Spelvin suggested removing the
> > embedded cdev. That seems like the simplest way to fix this, so I've
> > implemented his suggestion, with pps_idr becoming the source of truth
> > for which minor corresponds to which device.
> 
> You remove it, but now the structure has no reference counting at all,
> so you should make it a real "struct device" not just containing a
> pointer to one.

It still uses the device refcount. I didn't change that, see the
kobject_get() (which is confusing and should be get_device() as you note
below) in pps_cdev_open() before my patch.

> > But now that pps_idr defines userspace visibility instead of cdev_add(),
> > we need to be sure the pps->dev kobject refcount can't reach zero while
> > userspace can still find it again. So, the idr_remove() call moves to
> > pps_unregister_cdev(), and pps_idr now holds a reference to the pps->dev
> > kobject.
> 
> An idr shouldn't be doing the reference counting here, the struct device
> should be doing it, right?

Right, I was trying to explain that it is now necessary to call
get_device() to acquire a reference while the device minor is indexed by
the idr.

Before, the minor was deindexed in the idr in ->release(). But now,
since it is visible the moment it is indexed by the idr, deindexing it
in ->release() means this could happen during removal:

	CPU1		CPU2
	---		---
			pps_unregister_cdev()
			<...>
	sys_open()
	<...>
	idr_lookup()
			idr_remove()
			put_device() <--- ref goes to zero
	get_device()		     <--- BOOM
			pps_device_destruct()
			pps_idr_remove()

By calling get_device() in pps_idr_get(), and by moving the idr
deindexing from ->release() to pps_unregister_cdev(), we ensure that
can't happen.

> > 
> >     pps_core: source serial1 got cdev (251:1)
> >     <...>
> >     pps pps1: removed
> >     pps_core: unregistering pps1
> >     pps_core: deallocating pps1
> > 
> > Fixes: d953e0e837e6 ("pps: Fix a use-after free bug when unregistering a source.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > ---
> > Changes in v2:
> > - Don't move pr_debug() from pps_device_destruct() to pps_unregister_cdev()
> > - Actually add stable@vger.kernel.org to CC
> > ---
> >  drivers/pps/pps.c          | 83 ++++++++++++++++++++------------------
> >  include/linux/pps_kernel.h |  1 -
> >  2 files changed, 44 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> > index 5d19baae6a38..6980ab17f314 100644
> > --- a/drivers/pps/pps.c
> > +++ b/drivers/pps/pps.c
> > @@ -25,7 +25,7 @@
> >   * Local variables
> >   */
> >  
> > -static dev_t pps_devt;
> > +static int pps_major;
> >  static struct class *pps_class;
> >  
> >  static DEFINE_MUTEX(pps_idr_lock);
> > @@ -296,19 +296,35 @@ static long pps_cdev_compat_ioctl(struct file *file,
> >  #define pps_cdev_compat_ioctl	NULL
> >  #endif
> >  
> > +static struct pps_device *pps_idr_get(unsigned long id)
> > +{
> > +	struct pps_device *pps;
> > +
> > +	mutex_lock(&pps_idr_lock);
> > +	pps = idr_find(&pps_idr, id);
> > +	if (pps)
> > +		kobject_get(&pps->dev->kobj);
> 
> A driver should never call "raw" kobject calls, this alone makes this
> not ok :(

Oh this is silly, sorry: it's simply open coding put_device() and
get_device(), I'll fix that.

> Please move the structure to be embedded in and then it should be
> simpler.

I actually tried to do that, but got hung up on the API: what's the
right way to do what device_create() does for an embedded device struct?

Today, the pps core does:

	pps = kzalloc(sizeof(*pps));

...then later in pps_register_cdev():

	idr_alloc(&newmin, ...);
	pps->dev = device_create(..., MKDEV(maj, newmin), ...);

To embed the device struct, I guess this would become something like:

	pps = kzalloc(sizeof(*pps));
	device_initialize(&pps->dev);
	idr_alloc(&newmin, ...);
	/* ??? */
	device_register(&pps->dev);

...but the question marks are what I'm not seeing: what's the proper way
to accomplish what device_create() does, but in an embedded dev struct?
Obviously I could just copy device_create(), but I'm sure that's not
what you want.

Thanks,
Calvin

> thanks,
> 
> greg k-h

