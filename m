Return-Path: <stable+bounces-227774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMT/HGi/vmmFZwMAu9opvQ
	(envelope-from <stable+bounces-227774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 16:55:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7BA2E63BA
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 16:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85C423024148
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD079396579;
	Sat, 21 Mar 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="NN5OSXfM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675131690A
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774108446; cv=none; b=Dtz5pC8zjd+aePgZnz++X332xUS3E9wVQbnrcMZd8aWCqXYqdrj9AUUPDg4CkP2aC6pEqwUeJRcMzv7pra7+TYtzbkrL4tk11E6XIW9CnH9TAVxHMhk/6PjSOEX3yEP1HK6oHG7r1Jdi/zvHy4Zb1MsTxnaUUK3mEK8GFmN77Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774108446; c=relaxed/simple;
	bh=lThbFxLQM35GPCAzqXWnZ0lGAfqN2/K8/Rfkj2JsO4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5NafelyDMB1R00MHfiZnsKRy+8jlX6cdljfoS4GOEXq2ul6WZ0hzSEKVsc3p6cZzoe150F2LEMl3XWUu7Ew6nzcNdJprx0R2nPcSAikGZ8X8V1COoicoH1X4D7BYVA0sDol94YNTYY2lykX8g145xEyBnsS70UbotCyp7XjjPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=NN5OSXfM; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd8576a512so446117785a.0
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1774108444; x=1774713244; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PjkElUreCSm3Pff79vFh1ZyOTyQLwaGB7r9je7XctHE=;
        b=NN5OSXfM1Y0ylOIRSC4WIwQ1/Le0y6zdLhjPSvNAm7PLrlSNs45Ha0/BarAcTN2A/x
         6P2QnUVKhcUPh8GxukOH2+IyfnGwcFuPNS7A6nSCWDv/0BsfEhAVO5L18jDMpUvCDXIB
         aHanx35S8+X8g4KQ3QqMYxyuk3Vz9a4Dp0UQ6aKcGBnunCxkLXs1mSQM7k414JS3UCyE
         pAwdZUiz29wMnWPcnhEcLR6gXE26dCaD6a3BHcLX6FlwxJd6kkUN6ID3wnliy1q6FGcL
         oOKHoewTyJzsWLWJxYkedWfBKT/1HdXQG/nmdLXwSXo8/A9tzH9KNlcOtSGcHj5eyOBG
         HS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774108444; x=1774713244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjkElUreCSm3Pff79vFh1ZyOTyQLwaGB7r9je7XctHE=;
        b=hLImocMfHV2tqDgO6RAl5t54AhU+c+D1d38gqnU0ON6jnsOl5vtRtRCDRsm7nXVj7f
         06XBikE+Mt7qt0aBcRvA7ghfJdGFcya4fOSUalpB/2QGmDC5OXKqln1CWFl3KHJYsSdo
         3EJdxMTyxcF3L0FOr0jOAlfykwd7hysV2KY5VJtOZoZLNAwWVSqEz5tyZIvSnXd+XKGG
         U7ehZEoAbkKw8RBZIVMDR2AiAV4B+xQK57JfpenkBIdiEo7AQ8WsLWhGWpnq0XuRRpGz
         28J2ophoNWZA8HWpDto2hIgQwkidpJ4qBjXWvNy0xPT4bTWol16Cnwf98Pv0lRkV4gug
         DSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkSAPcj5T/3RRvYmYwV/quBREJx5LwnxYOOh/yOmX6P+OG/+nevJrdMkeCyDwg8mwm/+kUxYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYfosz7J/Y3llIl/K2sSjA+VQglVTMA7P43ZNYo5O6d6iQb49
	+fzlUZtTn4zO0Jj2GxXbUgW1XVxrAknQecpokshVNUubHyI9LQJObdVOLhOWFd26mQ==
X-Gm-Gg: ATEYQzwV8EwN4raasMffk6vxBYuR+57G4D9QzDJvcstE24lnOR6xmCorPBxS8GGJ+Sw
	DCVafjbE84aexhK0WiSvmo8libVxZp4G43u9XWMr0clojF2w1g6vJNpfAyzxY2W23/Ta7njpdzV
	k/XSug5pvr3wQqRItAKBbo0yxYpTVZTx0gi+RDNCAnIIAAIC/x2tDcZEt8oUWqjrcSlYKA3CU+R
	vC4DUJFNqiNBkv5/PpnhkfKJe5NdzrqJz4ft2115LE1gwoxREHOyVKKjftPfC1R/4egwQHvQLHm
	HiH81Nck9FGA5gOhyHznTbk/NI1Jq3CxYMjiMit7+a8imByeDcQ/8/YsmxB5Kye883AJCIbRX6F
	tqgpuk+BYZpXxIe19l2gXLLs4SQ3dtcWpfqqn/r+Cs/lOZ/m6LFaRFBeZJ3XU5rjdQuLliB/1nH
	NejoZAW697MiGoOKQ+h3Oib0A=
X-Received: by 2002:a05:620a:4694:b0:8cf:d1fa:7b41 with SMTP id af79cd13be357-8cfd1fa7dfdmr652813185a.34.1774108443943;
        Sat, 21 Mar 2026 08:54:03 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::b00])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f94b04sm423144585a.17.2026.03.21.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 08:54:03 -0700 (PDT)
Date: Sat, 21 Mar 2026 11:54:00 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Doug Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] driver core: Don't link the device to the bus until
 we're ready to probe
Message-ID: <6ff1444b-f83e-47f6-ab0d-6745738523ba@rowland.harvard.edu>
References: <20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <2026032152-getting-carmaker-29d5@gregkh>
 <CAD=FV=Wag5qx9RXkAHrf+zbwtQgVQW1UUc6DRhUzudBtjbD8ug@mail.gmail.com>
 <2026032114-unlocked-unmoving-091b@gregkh>
 <CAD=FV=WPD5DueD5iGvsxZYUGy7XAQ2NQ2BTJTyVSVNtYYrWOHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WPD5DueD5iGvsxZYUGy7XAQ2NQ2BTJTyVSVNtYYrWOHQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227774-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,android.com:url,rowland.harvard.edu:dkim,rowland.harvard.edu:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: CD7BA2E63BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 01:05:48AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sat, Mar 21, 2026 at 12:42 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Mar 21, 2026 at 12:35:32AM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Fri, Mar 20, 2026 at 10:41 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Mar 20, 2026 at 08:06:58PM -0700, Douglas Anderson wrote:
> > > > > The moment we link a "struct device" into the list of devices for the
> > > > > bus, it's possible probe can happen. This is because another thread
> > > > > can load the driver at any time and that can cause the device to
> > > > > probe. This has been seen in practice with a stack crawl that looks
> > > > > like this [1]:
> > > > >
> > > > >   really_probe()
> > > > >   __driver_probe_device()
> > > > >   driver_probe_device()
> > > > >   __driver_attach()
> > > > >   bus_for_each_dev()
> > > > >   driver_attach()
> > > > >   bus_add_driver()
> > > > >   driver_register()
> > > > >   __platform_driver_register()
> > > > >   init_module() [some module]
> > > > >   do_one_initcall()
> > > > >   do_init_module()
> > > > >   load_module()
> > > > >   __arm64_sys_finit_module()
> > > > >   invoke_syscall()
> > > >
> > > > Are you sure this isn't just a platform bus issue?  A bus should NOT be
> > > > allowing a driver to be added at the same time a device is being added
> > > > for that bus, ideally there should be a bus-specific lock somewhere for
> > > > this.
> > >
> > > Sure, if the right fix for this is somewhere in the platform bus code
> > > then I'd be happy with a patch there to fix it. ...but from my quick
> > > glance (admittedly, it's Friday night and I'm tired), it seems like
> > > the problem is just with driver_register() being called at the same
> > > time as device_add().
> > >
> > > Certainly adding some sort of locking could be a solution (happy for
> > > someone to tell me where to place them), but we'd have to make sure we
> > > aren't regressing performance for the normal case...
> > >
> > >
> > > > When a device is added to the bus, yes, a probe can happen, and is
> > > > expected to happen, for that device, so this feels odd.
> > > >
> > > > that being said, your patch does seem sane, and I don't see anything
> > > > obviously wrong with it.  But it feels odd that this is just now showing
> > > > up for something that has been this way for a few decades...
> > >
> > > I suspect it's a latent bug that was triggered by a new Android
> > > feature. It's showing up on phones that have
> > > "ro.boot.load_modules_parallel" set. I think you can get to the
> > > relevant source code at:
> > >
> > > https://cs.android.com/android/platform/superproject/main/+/main:system/core/libmodprobe/libmodprobe.cpp?q=LoadModulesParallel
> > >
> > > I suspect the bug is never triggered with more normal module loading
> > > schemes. Indeed, one phone that has nearly the same set of drivers but
> > > has parallel module loading turned off has no reports of this
> > > problem...
> >
> > Ah, I think we always assumed that modules can NOT be loaded in
> > parallel, isn't there an internal module lock that prevents this from
> > happening?
> >
> > So yes, that might be the root problem here.
> 
> It's late Friday night for me (technically Saturday morning), so I'm
> not going to dig now. ...but I'm fairly certain that Android isn't
> using any downstream kernel patches to accomplish its "parallel module
> loading". It's just userspace jamming modules in as fast as it can.
> Userspace loading modules quickly shouldn't cause the kernel to behave
> badly.
> 
> If the right solution is to add more locking to the kernel to slow
> userspace down, that is also something I could try. It will likely end
> up impacting boot speed, but of course correctness comes first. Let me
> know if this is a direction I should dig (or someone is free to post a
> patch and I can test it).

As far as I know, there's no particular reason why modules shouldn't be 
loaded in parallel, or at least, in very quick succession.  Locking 
shouldn't matter either -- that is, the existing locks ought to be 
adequate.

> > > I'd also note that the only actual symptom we're seeing is with
> > > fw_devlink misbehaving (because dev->fwnode->dev wasn't set early
> > > enough). fw_devlink is a "new" (ish) feature, is officially optional,
> > > and isn't used on all hardware.
> >
> > That's true too, can we set that earlier?
> 
> Yes, I can post a patch that _just_ moves the set of dev->fwnode->dev
> earlier, and that will probably fix my symptoms (I'll need to test).
> This patch already moves it a bit earlier, but if we don't break the
> linking out as a separate step it would need to move even higher up in
> the function.
> 
> Originally, I was going to just propose that, but then I realized that
> some of the other code in device_add() probably also ought to run
> before we let the driver probe, and hence I ended up with this patch.

This sounds like a more generic problem.  A bunch of things happen after 
bus_add_device() that should be completed before probing can start; the 
firmware node stuff is just one of them.

Splitting bus_add_device() in two sounds reasonable, although I would 
rename the old routine to bus_link_device, since all it does it add some 
groups and symlinks.  The new routine can be called bus_add_device().

The real question is whether any of the other stuff that happens before 
bus_probe_device() needs to come after the device is added to the bus's 
list.  The bus_notify() and kobject_uevent() calls are good examples; I 
don't know what their requirements are.  Should they be moved down, 
between the new bus_add_device() and bus_probe_device()?

Alan Stern

