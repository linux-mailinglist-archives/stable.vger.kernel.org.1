Return-Path: <stable+bounces-229988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FTGIUSDwWnATgQAu9opvQ
	(envelope-from <stable+bounces-229988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:15:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4042FB154
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0737731922BB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1426ED28;
	Mon, 23 Mar 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="YHYBHZ46"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271338839D
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288029; cv=none; b=jW5MimRo8t4zkIdEgOgQ0BTRhSDoLY+ihmF7kndH5I1sIfE+tUkVEOcxyjNt4rB35i+5cwlY2zSH9ISXpPpw96Nan36hxHEj98X6gXfB1ltzPObM2poD9sP7Sz5T6oUQ1B9EfVa3bT/iDkrR2AjBRkt26SrjbhtNLY5Qx3ewQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288029; c=relaxed/simple;
	bh=+GV9mEbjh2KEDYk0Ckp6jh8V/RmZayWw9Oe5F0SFdCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7c+FDk/Rwdb0BsmKh/hxh+F6tuL3r9TFe8r/fZeEtTzVXRnL5UozQxD8WFal/VodxVvaBMBLt16pAuvm//ctrmIysL6ysBrDmjJKa/9UIOgGLO+s5teJHC+QaIIAr7+11pov6hmOaUBMGk8nfbn2Xtc7jNBNkm+KIG1VOBSnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=YHYBHZ46; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89c4feaaeb4so54726126d6.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1774288026; x=1774892826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zt+MMdT6pvPJKfJL2D/x4ENtbBSrsY+G3nmKWRVjgjI=;
        b=YHYBHZ46BALFwnql5PTOkq0MF3qgCVSi1F4XSpwb2z2KBD9h75qTNar8vIfEh2JExu
         eXIwsbMWge5htFekj9JKyZwf3VOJYnOzGeJcgj5dCnZjrkFK+1knkov5xtaMQVyIGWSH
         eJ+nP0iyeUYlFJiZ2PJ14tR83Tlcg99M3Z3uGf21h+v95eCodscoZEsQSRZYl2aSN35G
         5I8ahtU9YbgpVnoj+UZYGpIjDh3ygUPiD9kcfeW7N5eOSZhZo+PZKdlOrtygCuL/3E+M
         kmrJv6GYE7q6jcoa/+CVMBycHPnkvF8iK5FgkDy+jX4Rq2TtJgI8thky+3PZvW/Oj6/S
         Pvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288026; x=1774892826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zt+MMdT6pvPJKfJL2D/x4ENtbBSrsY+G3nmKWRVjgjI=;
        b=oWyVPJTz2RiZEV9YY6DEKi3KNkOASVJ9X6lzxBsY8+j+TShensWJrhYU7eVNPTg2o1
         A6eJlW9i36Qeu27v70F8kvqdDo15D227mI9O3bNrutnCRqfiJyvrKatMMHSk2HtTO+pZ
         16bsUIgDrZhfZp5up548CV+RsCjeUqdtHNuYAoPhnSOYitr6rnIxV/E44v6MGd/nEF1E
         uQnmSUaiVRM1UjOGT0ZtGTRseub6zdYADtTiqV0FU1+n64oIwhBCone43c8C3K4X5gcP
         4C+MUqUe0D7gAojp0Igkz90w4dPOYhak6bGvmzahf6GVRY93lq10PYy6PSDdGa4Q7Z1m
         Hchw==
X-Forwarded-Encrypted: i=1; AJvYcCVWQ+D92JhT3SrNkGJg9H8HP5YByX5JNE4S5BVIqM7Qy2M6ChRm8hgBbz1DZ9Un3lOt+Sz7jK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySl3q3Veh1qo8Duh9x08+VgBS1Rjg/PmVYgRhYksua0TsMilTg
	2i+xJJAarAWe5h9LvJkePIJ3ofD4W3eNsH0jBLeQ/+uPsvAJ+eesAvV0dhylQwp6LOJmjMPE/ll
	axVE=
X-Gm-Gg: ATEYQzxnATeNRwB88E02OE7uTv+zco/miejPHkHnRDBVxND7/23FKavAtzqsMXqZ95J
	XS933SZiFVzLdV6PdCCk/D5DTy0Ycct97KR/NjXQbCro5W+ULwWG4P21fIB2f9rFJqa3HhwfVCa
	0za8/U2QkGZmxGG26Xb25ajUtxyD4EsxsQFroFOl8f4WDqTrA0FYNNwA+Bx8bLvCi/ya1m7z2lx
	Iq2Qt+/RnUmDWAGDjXWwMrcJ130eyiIw57MIBSH7zGFrm6+akSTknCcOZznmNQLcgrqIcNhJdwN
	5X//eH1J8ynyqciZYd9qnMcEHFjDubRPZ7r+cJA53rWavbbH4dDbEmtRpF1VPap6qobblpIGeTm
	WizYky3Y0yVMO/8mRfFeG3l26YJRqNWhLdXXlXTY1uhKWGxB3y3FWRn1jmv3f7vrXou5v9Cik1u
	n+zcX3zqeDz+L0Bqu5z/S3dLioELU4lbpTBIWGQwSUlg0DZlQ58rTtzBXT9TGjDsqmi5o=
X-Received: by 2002:a05:6214:27c5:b0:899:fd64:1b72 with SMTP id 6a1803df08f44-89c85a5bebbmr215431466d6.41.1774288026237;
        Mon, 23 Mar 2026 10:47:06 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:349c:f507:d5eb:5d9e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85335745sm93354426d6.32.2026.03.23.10.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:47:05 -0700 (PDT)
Date: Mon, 23 Mar 2026 13:47:02 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Doug Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] driver core: Don't link the device to the bus until
 we're ready to probe
Message-ID: <6511a5b9-ac67-49a1-8336-3d2afaaab593@rowland.harvard.edu>
References: <20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <2026032152-getting-carmaker-29d5@gregkh>
 <CAD=FV=Wag5qx9RXkAHrf+zbwtQgVQW1UUc6DRhUzudBtjbD8ug@mail.gmail.com>
 <2026032114-unlocked-unmoving-091b@gregkh>
 <CAD=FV=WPD5DueD5iGvsxZYUGy7XAQ2NQ2BTJTyVSVNtYYrWOHQ@mail.gmail.com>
 <6ff1444b-f83e-47f6-ab0d-6745738523ba@rowland.harvard.edu>
 <CAD=FV=Vco+hRBNxGpUDf-YofEwTR13ht=nTnjvUvT+3_76+1MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Vco+hRBNxGpUDf-YofEwTR13ht=nTnjvUvT+3_76+1MA@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229988-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rowland.harvard.edu:dkim,rowland.harvard.edu:mid,harvard.edu:email]
X-Rspamd-Queue-Id: CB4042FB154
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 10:07:01AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sat, Mar 21, 2026 at 8:54 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > > > > I'd also note that the only actual symptom we're seeing is with
> > > > > fw_devlink misbehaving (because dev->fwnode->dev wasn't set early
> > > > > enough). fw_devlink is a "new" (ish) feature, is officially optional,
> > > > > and isn't used on all hardware.
> > > >
> > > > That's true too, can we set that earlier?
> > >
> > > Yes, I can post a patch that _just_ moves the set of dev->fwnode->dev
> > > earlier, and that will probably fix my symptoms (I'll need to test).
> > > This patch already moves it a bit earlier, but if we don't break the
> > > linking out as a separate step it would need to move even higher up in
> > > the function.
> > >
> > > Originally, I was going to just propose that, but then I realized that
> > > some of the other code in device_add() probably also ought to run
> > > before we let the driver probe, and hence I ended up with this patch.
> >
> > This sounds like a more generic problem.  A bunch of things happen after
> > bus_add_device() that should be completed before probing can start; the
> > firmware node stuff is just one of them.

You know, I wrote this but I'm not so sure that it's accurate.  We've 
gone many years with no big changes to this code; most likely it doesn't 
need alterations now.

> > Splitting bus_add_device() in two sounds reasonable, although I would
> > rename the old routine to bus_link_device, since all it does it add some
> > groups and symlinks.  The new routine can be called bus_add_device().
> 
> LOL, so basically you want them named exactly opposite I did? That's
> OK with me, though maybe:
> 
> bus_prep_device()
> bus_add_device()

Nothing wrong with those names.  But instead of making these fairly 
intrusive changes it might be better just to move the firmware stuff to 
a different place in the code (you mentioned this possibility in your 
first email).  It would be a smaller change, that's for sure.

> > The real question is whether any of the other stuff that happens before
> > bus_probe_device() needs to come after the device is added to the bus's
> > list.  The bus_notify() and kobject_uevent() calls are good examples; I
> > don't know what their requirements are.  Should they be moved down,
> > between the new bus_add_device() and bus_probe_device()?
> 
> Yes, this is my question too. The question is, what's worse:
> 
> 1. Potentially the device getting probed before the calls to
> "bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)" and
> "kobject_uevent(&dev->kobj, KOBJ_ADD)"
> 
> 2. Calling "bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)" and
> "kobject_uevent(&dev->kobj, KOBJ_ADD)" without first adding to the
> subsystem's list of devices.
> 
> As it is, my patch says #2 is worse and thus allows for #1. ...but I
> don't actually know the answer. The main reason I chose to allow for
> #1 is that it makes the behavior less different than it was before my
> patch, but that doesn't mean it's correct.
> 
> Reading  through a handful of "BUS_NOTIFY_ADD_DEVICE" calls, my guess
> is that they expect to be called before probe... That would imply that
> my patch made the wrong choice...

I don't know about other subsystems, only USB.  As far as I remember, 
USB doesn't really care about the order of probing vs. notifications.  
In general, since probing can be asynchronous with registration, the 
kernel always has to work with probing after bus_notify().  It's 
best to preserve that order unless there's a very good reason not to.

uevents may be different, since they go to userspace.  It could be 
weird for a user program to be told about a new device and then not be 
able to find it on the bus.

> I think another option here might be to just add a new bitfield flag
> to "struct device", like "ready_to_probe". Right before the call to
> bus_probe_device(dev), we could do something like:
> 
> device_lock(dev);
> dev->ready_to_probe = true;
> device_unlcok(dev);
> 
> Then in __driver_attach() I can have:
> 
> device_lock(dev);
> ready_to_probe = dev->ready_to_probe;
> device_unlock(dev);
> if (!ready_to_probe)
>   return 0;
> 
> If I do that, I don't think I'll even need to re-order anything, and I
> think it's all safe. Basically, it just the device hidden from the
> __driver_attach() logic until probe is ready.
> 
> What do you think?

There should not be any difference between probing caused by the device 
being added to the bus, vs. caused by a new driver being registered, vs. 
caused by anything else (such as sysfs).  None of these should be 
allowed until all of them can be handled properly.

And linking the device into the bus's list of devices should be the 
event that makes probing possible.

Alan Stern

