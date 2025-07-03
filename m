Return-Path: <stable+bounces-159312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B75AF752F
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF884E7D59
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 13:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93EA2E716C;
	Thu,  3 Jul 2025 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odf+D7HY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D51F76A5;
	Thu,  3 Jul 2025 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548485; cv=none; b=VSe4Z5IugNgJQZyN6KOgdSMHSNVJKTw0Ea3ioTPzs5WrY4yecy5jPkNM/vx4pr+cxDf1L4xnen8ckDd79WmPHPrCozQzGBXzx5Yl/Q9XMAw+ipQtveiSApBR2b2sXC+Vr9DsMk0UpXpvMbT+wF8LZbC0KXB29dyfyQ5Ig2XOlno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548485; c=relaxed/simple;
	bh=H/wr5QVHTI02mpdPrQqUd11tPaub38c5GIw2ZsHSJzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCWbPS1TRvWHe1ciGfWBbY9oo/ObanaqMNy8QweEP542FR3Xz+MCc7BWmurlJ2g/OPtABzSfzxjmGhz0j360c2ORicw388UKRO2nAnB7vCq8PUJ2sAhmFkeiaz6A2Kzt0dfSfrW4maTKX+wlH7gY3UR2FtFjNK2ef6Cg+lT1ABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odf+D7HY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD93C4CEE3;
	Thu,  3 Jul 2025 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751548485;
	bh=H/wr5QVHTI02mpdPrQqUd11tPaub38c5GIw2ZsHSJzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odf+D7HYykBMy2o0CQntA7AuW8Gb8wFhDjiICCIrQ3XnVgR4K9kE1yMUkXsg17y9y
	 IAJ5N/DmyStfMRbdQkln8xM2yqGksNPya9NBdfGHBo8KR/Opghqqcq3iusIDJPkpXc
	 xxQ3c0d5gY87Elme6EjUO8TQ6LcY9Yeiv7lTR5a5sQ8+YTB7EzftYh0ocLs52HBR2f
	 Bu1u4Gl5G4SU9YEYseYqT4tCcnovTKl3FaCdIyfJJEwVYwb+1lDetTPZyvyKXYxGhK
	 Kp9ubfwz4pkeevdeOT21BEJnn1dZ6aJOqwOmUeeXoAOajAbkAZ7EVTkgVkvGiLXs64
	 zm2SBhVjpfnQg==
Date: Thu, 3 Jul 2025 13:14:42 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bleung@chromium.org, chrome-platform@lists.linux.dev, dawidn@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_chardev: Fix UAF of ec_dev
Message-ID: <aGaCQuvwPjDIaH6W@google.com>
References: <20250703113509.2511758-1-tzungbi@kernel.org>
 <20250703113509.2511758-3-tzungbi@kernel.org>
 <2025070320-gathering-smitten-8909@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025070320-gathering-smitten-8909@gregkh>

On Thu, Jul 03, 2025 at 01:52:02PM +0200, Greg KH wrote:
> On Thu, Jul 03, 2025 at 11:35:09AM +0000, Tzung-Bi Shih wrote:
> But yes, one that people have been talking about and discussing generic
> ways of solving for years now, you have seen the plumbers talks about
> it, right?

Will check them.

> > @@ -31,7 +34,14 @@
> >  /* Arbitrary bounded size for the event queue */
> >  #define CROS_MAX_EVENT_LEN	PAGE_SIZE
> >  
> > +/* This protects 'chardev_list' */
> > +static DEFINE_MUTEX(chardev_lock);
> > +static LIST_HEAD(chardev_list);
> 
> Having a static list of chardevices feels very odd and driver-specific,
> right

The `chardev_list` is for recording all opened instances. Adding/removing
entries in the .open()/.release() fops. The `chardev_lock` is for protecting
from accessing the list simultaneously.

They are statically allocated because they can't follow the lifecycle of
neither the platform_device (e.g. can be gone after unbinding the driver)
nor the chardev (e.g. can be gone after closing the file).

Side note: realized an issue in current version: in the .remove() of
platform_driver, it unconditionally resets `ec_dev` for all opened instances.

> > +
> >  struct chardev_priv {
> > +	struct list_head list;
> > +	/* This protects 'ec_dev' */
> > +	struct mutex lock;
> 
> Protects it from what?
> 
> You now have two locks in play, one for the structure itself, and one
> for the list.  Yet how do they interact as the list is a list of the
> objects which have their own lock?
> 
> Are you _SURE_ you need two locks here?  If so, you need to document
> these really well.

`struct chardev_priv` is bound to chardev's lifecycle. It is allocated in
the .open() fops; and freed in the .release() fops. The `lock` is for
protecting from accessing the `ec_dev` simultaneously (one is chardev
itself, another one is the .remove() of platform_driver).

> > @@ -341,16 +364,20 @@ static long cros_ec_chardev_ioctl(struct file *filp, unsigned int cmd,
> >  				   unsigned long arg)
> >  {
> >  	struct chardev_priv *priv = filp->private_data;
> > -	struct cros_ec_dev *ec = priv->ec_dev;
> >  
> >  	if (_IOC_TYPE(cmd) != CROS_EC_DEV_IOC)
> >  		return -ENOTTY;
> >  
> > +	scoped_guard(mutex, &priv->lock) {
> > +		if (!priv->ec_dev)
> > +			return -ENODEV;
> > +	}
> 
> What prevents ec_dev from changing now, after you have just checked it?
> This feels very wrong as:

Ah, yes. I did it wrong. The `priv->lock` should be held at least for the
following cros_ec_chardev_ioctl_xcmd() and cros_ec_chardev_ioctl_readmem().

> > +
> >  	switch (cmd) {
> >  	case CROS_EC_DEV_IOCXCMD:
> > -		return cros_ec_chardev_ioctl_xcmd(ec, (void __user *)arg);
> > +		return cros_ec_chardev_ioctl_xcmd(priv->ec_dev, (void __user *)arg);
> 
> Look, it could have gone away here, right?  If not, how?

Yes, I did it wrong. The lock should be still held for them.

> > @@ -394,8 +421,28 @@ static int cros_ec_chardev_probe(struct platform_device *pdev)
> >  static void cros_ec_chardev_remove(struct platform_device *pdev)
> >  {
> >  	struct miscdevice *misc = dev_get_drvdata(&pdev->dev);
> > +	struct chardev_priv *priv;
> >  
> > +	/*
> > +	 * Must deregister the misc device first so that the following
> > +	 * open fops get handled correctly.
> > +	 *
> > +	 * misc device is serialized by `misc_mtx`.
> > +	 * 1) If misc_deregister() gets the lock earlier than misc_open(),
> > +	 *    the open fops won't be called as the corresponding misc
> > +	 *    device is already destroyed.
> > +	 * 2) If misc_open() gets the lock earlier than misc_deregister(),
> > +	 *    the following code block resets the `ec_dev` to prevent
> > +	 *    the rest of fops from accessing the obsolete `ec_dev`.
> 
> What "following code block"?  What will reset the structure?

+	scoped_guard(mutex, &chardev_lock) {
+		list_for_each_entry(priv, &chardev_list, list) {
+			scoped_guard(mutex, &priv->lock)
+				priv->ec_dev = NULL;
+		}
+	}

