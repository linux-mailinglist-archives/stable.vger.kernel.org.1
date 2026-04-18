Return-Path: <stable+bounces-238580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CxpNDhS42lLFAEAu9opvQ
	(envelope-from <stable+bounces-238580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 11:43:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D51B42098C
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 11:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4482F302A2E7
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03353346777;
	Sat, 18 Apr 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO1/6a67"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34A2DECD3;
	Sat, 18 Apr 2026 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776505392; cv=none; b=mT8yx2/DuEVasi7QfqHo7J2OzmtHMcUkIUGuB+hLTd2Qebk9vD4DvP9CPD+kjh29yE9728DokGblE37C9gG4pSmKewVEyZApQzDAAbyXe43OAVnxBZe6ZVz75X2exskFRngikI651ohGYJngA1tr2abB3GnBkrRc4+5FeQgXgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776505392; c=relaxed/simple;
	bh=4qv15OMRZbvDqipOyBhNhFxMI2nsxkL5GflkG1BfMI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Or5GUy9bNGnf4Iso1cXQlebxbSh2J3BXyoCXGU3GFZ3TCIp83wlb5dynQFz7flPq+R9FbNh1naiL8WuU/tnorh4yk3EcydUKfSN+a2IU9b3tQ+IpIHYx1HBdTNkKv7Qi7ZCdizcgez5W/+JlK5YVO1yf2bLyV2GjOhesYBbSYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO1/6a67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2994C19424;
	Sat, 18 Apr 2026 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776505392;
	bh=4qv15OMRZbvDqipOyBhNhFxMI2nsxkL5GflkG1BfMI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AO1/6a67qp1lP8LGBI8fV17oEJbzoLjr3BTZ2L5gDH1eL0YAWelgVYiLL3x4dvRbE
	 zcZ2QiEbh/kCSXvAYytZn643G1AFDHLrBc6Pe4dkVNR4+ljsZ2de0Zh0E3ukbNFXfk
	 ySEEBNrjfJD6b8kjn9+doBto0byr+FwzyBXe7iOM9WulDgpt/ABRXaG6xruVfBqGc9
	 s5lDTZUWEfxBFy+vm5wllbpyvkMyBKEdMeTSJYp/xLc0f+imLEjFrifadQGKF0nv/E
	 pMpocQELblj7/HO00VoksQpzuXDRERR7sZ8jXByjQwbEZvOPUtNT9GIkkfIhcve5hp
	 u5iG6afEQfXow==
From: William Breathitt Gray <wbg@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] counter: Fix refcount leak in counter_alloc() error path
Date: Sat, 18 Apr 2026 18:42:37 +0900
Message-ID: <20260418094249.305435-1-wbg@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <adyb3Cdr1p3p76h6@monoceros>
References: <adyb3Cdr1p3p76h6@monoceros>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3692; i=wbg@kernel.org; h=from:subject; bh=4qv15OMRZbvDqipOyBhNhFxMI2nsxkL5GflkG1BfMI8=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJmPA68evX5bNtyzoar/UnvtqefxuemCst3L31WIP3TSv /E35HRTRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRdToM/7QXGZgp5G+/KLhl TT9jk5W2iG8C3+5b0fUH1Gcz5An3ZjP8lbjp+uODwcEDBnXc92Q/9Uzv2nT91KlcSw7xabufq28 vZgcA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238580-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wbg@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iu.edu:url]
X-Rspamd-Queue-Id: 3D51B42098C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:47:04AM +0200, Uwe Kleine-König wrote:
> On Sat, Apr 11, 2026 at 09:35:11PM +0800, Guangshuo Li wrote:
> > After device_initialize(), the lifetime of the embedded struct device
> > is expected to be managed through the device core reference counting.
> > 
> > In counter_alloc(), if dev_set_name() fails after device_initialize(),
> > the error path removes the chrdev, frees the ID, and frees the backing
> > allocation directly instead of releasing the device reference with
> > put_device(). This bypasses the normal device lifetime rules and may
> > leave the reference count of the embedded struct device unbalanced,
> > resulting in a refcount leak and potentially leading to a use-after-free.
> > 
> > Fix this by using put_device() in the dev_set_name() failure path and
> > let counter_device_release() handle the final cleanup.
> > 
> > Fixes: 4da08477ea1f ("counter: Set counter device name")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/counter/counter-core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> > index 50bd30ba3d03..12dc18c78672 100644
> > --- a/drivers/counter/counter-core.c
> > +++ b/drivers/counter/counter-core.c
> > @@ -123,10 +123,10 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
> >  	return counter;
> >  
> >  err_dev_set_name:
> > +	put_device(dev);
> > +	return NULL;
> >  
> > -	counter_chrdev_remove(counter);
> >  err_chrdev_add:
> > -
> >  	ida_free(&counter_ida, dev->id);
> >  err_ida_alloc:
> 
> This patch is technically correct. Looking in more detail however I
> wonder why 4da08477ea1f ("counter: Set counter device name") was created
> in the presence of
> 
> 	static const struct bus_type counter_bus_type = {
> 		...
> 		.dev_name = "counter",
> 	};
> 
> 	int device_add(struct device *dev)
> 	{
> 		...
> 		if (dev->bus && dev->bus->dev_name)
> 			error = dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);
> 		...
> 	}
> 
> The only upside I can see is that the name is already set before
> device_add() is called. 

Looking at the current code, the only Counter subsystem specific call
occurring after device_initialize() but before device_add() is
counter_sysfs_add() which does perform a number devm_kcalloc() and other
such devres operations. I suspect the reason we added the dev_set_name()
call is to make those operations in counter_sysfs_add() clearer in the
devres_log events.

> Assuming the dev_set_name() call should be kept, I think that
> 
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> index 50bd30ba3d03..69f042ce4418 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -114,12 +114,12 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
>  	if (err < 0)
>  		goto err_chrdev_add;
>  
> -	device_initialize(dev);
> -
>  	err = dev_set_name(dev, COUNTER_NAME "%d", dev->id);
>  	if (err)
>  		goto err_dev_set_name;
>  
> +	device_initialize(dev);
> +
>  	return counter;
>  
>  err_dev_set_name:
> 
> also fixes the issue.

We moved dev_set_name() after device_initialize() so that the device
core takes care of freeing the memory allocated for the name.[^1] I
think that's the behavior expected for dev_set_name(), so it's probably
best to keep it after device_initialize() so that there is no need to
manually free memory on failure.

William Breathitt Gray

[^1] https://lkml.iu.edu/hypermail/linux/kernel/2202.0/03859.html

