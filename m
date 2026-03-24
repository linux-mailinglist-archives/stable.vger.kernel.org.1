Return-Path: <stable+bounces-230187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKF3BFCswmlBkwQAu9opvQ
	(envelope-from <stable+bounces-230187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:22:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6DF317EE5
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71095304D651
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764740245E;
	Tue, 24 Mar 2026 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="JV3Aj0v+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB83D5246
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365701; cv=none; b=EmMIL0eKxF9ECVCX26fLtYsjflNRoeG+6+EPH40hs6VEtPh2zYk45FWWw3429P2PdYR7r1o2ohHFo6chJhEj1rLiiqLBxTGdT3ftWoD/Y9CZDpEA4CuZq6ppSGJnyYzUcBNeArV+tAlux7mIVu2r5IZiF3pW5uZi1NaYDJZk86k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365701; c=relaxed/simple;
	bh=NJo5NdzOjtwBWX7+M/YjO+ycHqysL7+cmpjOt2K5IaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svpN75OrooLLDJVHtrYqaDG1b79JW+1qUFSlKY96DeSFLnZzWr4oqeqDCuQNwscwAppJn/V2NUrXARuf4OC/qMaxxD6AXwk3ONCfCuo0dHBH5T4k1UD/BgxGk5qynu1znP3Z4TAg7dQmpYcWr2PXV5QwKSRDKyQ5NBrd18jmJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=JV3Aj0v+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb5c9ba82bso620679485a.2
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1774365699; x=1774970499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tiLKmr/C5OTHsK7h85BV4WJ+HRj+xEBrHGkLJfB0mtU=;
        b=JV3Aj0v+Z46SyNtzD3i8WnoW8IVMMjJ+bWg/7mBLKr22fMpeV3H9SRZBml8Tdqags5
         LswoX19VCleisShCsdoXaHop+rRiVHzL5UK1KyG80/WMOP+2DwRB85Acw2BJML05Qc7F
         xSHtjd36bx26pZoDTOqyK52YA0Tmw+D8KdgtZYQygzTbGKalFoxLdXzeGK9CtYedYmd8
         ArKxZf88U++cIeymF0QvvwM4XWdJP7eyVIiz59RyQGubdPKFVt5ptJ5Jih+beK+sLqU7
         iD+MAJ5J3i6T9j6yVYc2ydiHMXx0ljuOFtH7RBzWS/X61ekdd2B6+e5/RLxTWS2EVqmE
         QgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365699; x=1774970499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiLKmr/C5OTHsK7h85BV4WJ+HRj+xEBrHGkLJfB0mtU=;
        b=mFpXLQsWGSIz9czkkyyviMb1igw8AJvCYFiT5Q+kq0xx4lQrofQAmPC3gSgBN8uwFD
         dbRO9Y3009ypKOE+pgcVPyG+A98c3HX4ajhUXKLNMIBwf6QNo238jAPxOMd1D5/0anFP
         CKYSkAV/b4N/7wctnrUoe7FJR7W5q61OLQV2+heWJHth1t4+pI+mSSk/kgOsFB6CE1Oh
         1Cu7j66YzfccCNyZgBu3JWQFud6NydSfejyppVzeJLXbAX8V6RwoqtbJQ0hSvwkKaxLm
         OiUgFWp/qCI9sq+DYZEmABeVRHRemmEgVQh/B+nQEgMjeDc9H8MSsSblCfqx8RmHkqHk
         Nfkw==
X-Forwarded-Encrypted: i=1; AJvYcCWunZ1Q9i2uPXJ+/ugx7bU7N2QCduK3Kumm61GILP/Ud7/7BMkxct7xkJ8gLTYSQAk5gLcVnx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT5MMQVitz4B1CeSywdgu1QYpN15Piwwl0Hl0b8MD5GjhhbQy1
	MMYijlEwGc6JyFWzwAW7fahniakZFgy0/ZZgG0+C7dX2OFOiKeajILcbk77vXnyn4Q==
X-Gm-Gg: ATEYQzyfMWcwXAzmX4L2ejoQhB2+Rb4Y/DNTXwtf6ucTBMvaY1b+ii5lRG69vxAgHBg
	AHhpWExO9ulNbhjwuPGLkXHgcXRzLFiwguU7VAVatKXaWyjpAdf2m8ZZg2DZpPXYxV340ECZKad
	r/HHaPnU0CUwXjykPzBOV5PG6ydb+IfdCnG58bFelC93UqndSVnG5xNQ5XF6eSrpKKAG8ASGoyP
	Da3WuWJ+EfGAT23d32LMTJj9Xack8Re8Ymscj2OEgsNmc/gjKguGfUUTdscK7eYADakNIaGIlWz
	jZLrvEMHPjkwhK5ynfWpjXPipT0KVC7lXBS+w1Vu1xSCpvDYvHVGIq3QIQtl2+HEXzyPrKuG1vX
	XUnQM6FlNjC4MEgcLKQ2xs4l362ahq2kBozFLFyJD5MOqoYaJpfNxwr+GFmRhi1D5TBEVUsKN10
	Xvv5uEJqjsak9ERL8tnqvFnv3s
X-Received: by 2002:a05:620a:408b:b0:8cf:de1c:ede4 with SMTP id af79cd13be357-8cfde1cf987mr1729724985a.26.1774365697099;
        Tue, 24 Mar 2026 08:21:37 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::9c76])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90b4a7fsm1015857885a.32.2026.03.24.08.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:21:36 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:21:33 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Doug Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] driver core: Don't link the device to the bus until
 we're ready to probe
Message-ID: <bfd4e1f5-7bc5-448d-aa33-1a977bf00733@rowland.harvard.edu>
References: <20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <2026032152-getting-carmaker-29d5@gregkh>
 <CAD=FV=Wag5qx9RXkAHrf+zbwtQgVQW1UUc6DRhUzudBtjbD8ug@mail.gmail.com>
 <2026032114-unlocked-unmoving-091b@gregkh>
 <CAD=FV=WPD5DueD5iGvsxZYUGy7XAQ2NQ2BTJTyVSVNtYYrWOHQ@mail.gmail.com>
 <6ff1444b-f83e-47f6-ab0d-6745738523ba@rowland.harvard.edu>
 <CAD=FV=Vco+hRBNxGpUDf-YofEwTR13ht=nTnjvUvT+3_76+1MA@mail.gmail.com>
 <6511a5b9-ac67-49a1-8336-3d2afaaab593@rowland.harvard.edu>
 <CAD=FV=WBgKN2MNO-xBHZ3tRN91M82vk3h1AEAXtpBQ-nQocKCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WBgKN2MNO-xBHZ3tRN91M82vk3h1AEAXtpBQ-nQocKCQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230187-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D6DF317EE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 03:24:52PM -0700, Doug Anderson wrote:
> > You know, I wrote this but I'm not so sure that it's accurate.  We've
> > gone many years with no big changes to this code; most likely it doesn't
> > need alterations now.
> 
> That's fair, but I'm really just worried that the Android parallel
> module loading code, which is only ~1 year old (and needs to be opted
> in for each device) is stressing things in a way that nobody else is.
> In most distros, I think modules are loaded "on-demand". A device gets
> added first, and then we figure out which module has the driver that's
> needed and load the module. Nice and sequential. Android seems to have
> a different approach. As far as I understand it just has a list of
> modules to load and slams through loading all of them even as devices
> are still being added.
> 
> I don't think that what Android is doing is technically "wrong", but
> it's certainly odd compared to all other distros.
> 
> Unless we say that what Android is doing is wrong (and decide what to
> do about it), it seems like we need to make sure it's robust.

Loading a bunch of modules as fast as possible should not be wrong.  The 
kernel certainly ought to be able to handle it.

> > Nothing wrong with those names.  But instead of making these fairly
> > intrusive changes it might be better just to move the firmware stuff to
> > a different place in the code (you mentioned this possibility in your
> > first email).  It would be a smaller change, that's for sure.
> 
> I'll do that if that's what everyone wants, but the more I think about
> it the more worried I am that we'll end up with a hidden / harder to
> debug problem where some driver gets unhappy when its probe is called
> before dpm_sysfs_add(), device_pm_add(), device_create_file(),
> device_create_sys_dev_entry(), BUS_NOTIFY_ADD_DEVICE, ...

It's hard to know for all of them.  However, it seems pretty clear that 
device_pm_add() should come before probing, since a probe routine will 
generally want to affect the device's runtime PM state.

> > There should not be any difference between probing caused by the device
> > being added to the bus, vs. caused by a new driver being registered, vs.
> > caused by anything else (such as sysfs).  None of these should be
> > allowed until all of them can be handled properly.
> 
> Right. ...and I think that's what my proposed "ready_to_probe" does.
> It really does seem like quite a safe change. It _just_ prevents the
> driver load path from initiating a probe too early.

Any such consideration should apply to all the probe paths, not just 
driver loading.  (Also, if it's too early to probe the device, perhaps 
the return code should be -EAGAIN instead of 0.)

I'm not at all sure whether the constraints we've got will need to force 
some events to happen after adding the device to the bus list and before 
allowing probing to start.

> > And linking the device into the bus's list of devices should be the
> > event that makes probing possible.
> 
> Sure, but moving the linking into the bus's list of devices all the
> way to the end is definitely a bigger change. If nothing else,
> "bus_for_each_dev()" starts to be able to find the device once it's
> linked into the list. If any of the ~50 drivers who register for
> BUS_NOTIFY_ADD_DEVICE are relying on the device to show up in
> "bus_for_each_dev()", it would be bad...

I don't know the answer to this.  That is, I don't know if there are any 
notification handlers depending on the device showing up in the bus's 
list.  The safest thing to do is issue the notification after adding the 
device to the list -- which may mean after probing has potentially 
started.  Is there any reason why that would be a problem?  I'm not 
aware of any.

The order constraints should be commented explicitly in device_add(), 
not just implicitly implied by the code.  Otherwise people won't know 
what changes are allowed and what changes are forbidden.

Alan Stern

