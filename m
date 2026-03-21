Return-Path: <stable+bounces-227730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MnDpMPdLvmkRMAMAu9opvQ
	(envelope-from <stable+bounces-227730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 08:42:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F62E4014
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 08:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C86630185E1
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4294A33F58F;
	Sat, 21 Mar 2026 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XzAWoOFp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53119D08F;
	Sat, 21 Mar 2026 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774078960; cv=none; b=KNYs5Gd+FI3Kv9zrFbW4cfkL1971VlNTNddF9vj4zIFhEwTOjHqXXaip1utfe9+et5uSsdKoT2ighPJPPLkKb1yzN8Uz/s62Uz7J24i1tqg21E1c/FHdaOiN9ZWBhmVIto9VYJfQz7JlkZmmbaBjeLAwWm4AvVRDOKdbWwgi8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774078960; c=relaxed/simple;
	bh=zcHap2OBdTZAgK+vRBAteKVupMfOwv53AVmFSiKqfMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omCIHeLo3VQ5PP2ZM0kmNeABVLxbxi9ZTceMInb/NvB+WAC1kXG3nwd9Q7KTnLPOB+vgj0J6v2sCOXVPBcOkO1brxj0oBW9r98ruVGhjNohpBclBaZzpexJOmt87FuuTvZwWQjyOtx1Ry/7fXpoJn/7CRWnYlvjwXSbgvpjy4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XzAWoOFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF949C19421;
	Sat, 21 Mar 2026 07:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774078959;
	bh=zcHap2OBdTZAgK+vRBAteKVupMfOwv53AVmFSiKqfMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzAWoOFpBuj6NldjNHtiWzCehq+HiScllsQURACV//Br/2+ynk+R9YVRJrXk1aXvr
	 F5hJQymWxNjms9kcN8EcGA48Dkx8hOFoZYIaOd01o2C+Ge/V+LMtsFDCHLAhEpJRDx
	 saRpDQm137/cXERL4oG6cbfbV0ktbiICwQRqCcJU=
Date: Sat, 21 Mar 2026 08:42:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Doug Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] driver core: Don't link the device to the bus until
 we're ready to probe
Message-ID: <2026032114-unlocked-unmoving-091b@gregkh>
References: <20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <2026032152-getting-carmaker-29d5@gregkh>
 <CAD=FV=Wag5qx9RXkAHrf+zbwtQgVQW1UUc6DRhUzudBtjbD8ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Wag5qx9RXkAHrf+zbwtQgVQW1UUc6DRhUzudBtjbD8ug@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227730-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C00F62E4014
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 12:35:32AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Mar 20, 2026 at 10:41 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Mar 20, 2026 at 08:06:58PM -0700, Douglas Anderson wrote:
> > > The moment we link a "struct device" into the list of devices for the
> > > bus, it's possible probe can happen. This is because another thread
> > > can load the driver at any time and that can cause the device to
> > > probe. This has been seen in practice with a stack crawl that looks
> > > like this [1]:
> > >
> > >   really_probe()
> > >   __driver_probe_device()
> > >   driver_probe_device()
> > >   __driver_attach()
> > >   bus_for_each_dev()
> > >   driver_attach()
> > >   bus_add_driver()
> > >   driver_register()
> > >   __platform_driver_register()
> > >   init_module() [some module]
> > >   do_one_initcall()
> > >   do_init_module()
> > >   load_module()
> > >   __arm64_sys_finit_module()
> > >   invoke_syscall()
> >
> > Are you sure this isn't just a platform bus issue?  A bus should NOT be
> > allowing a driver to be added at the same time a device is being added
> > for that bus, ideally there should be a bus-specific lock somewhere for
> > this.
> 
> Sure, if the right fix for this is somewhere in the platform bus code
> then I'd be happy with a patch there to fix it. ...but from my quick
> glance (admittedly, it's Friday night and I'm tired), it seems like
> the problem is just with driver_register() being called at the same
> time as device_add().
> 
> Certainly adding some sort of locking could be a solution (happy for
> someone to tell me where to place them), but we'd have to make sure we
> aren't regressing performance for the normal case...
> 
> 
> > When a device is added to the bus, yes, a probe can happen, and is
> > expected to happen, for that device, so this feels odd.
> >
> > that being said, your patch does seem sane, and I don't see anything
> > obviously wrong with it.  But it feels odd that this is just now showing
> > up for something that has been this way for a few decades...
> 
> I suspect it's a latent bug that was triggered by a new Android
> feature. It's showing up on phones that have
> "ro.boot.load_modules_parallel" set. I think you can get to the
> relevant source code at:
> 
> https://cs.android.com/android/platform/superproject/main/+/main:system/core/libmodprobe/libmodprobe.cpp?q=LoadModulesParallel
> 
> I suspect the bug is never triggered with more normal module loading
> schemes. Indeed, one phone that has nearly the same set of drivers but
> has parallel module loading turned off has no reports of this
> problem...

Ah, I think we always assumed that modules can NOT be loaded in
parallel, isn't there an internal module lock that prevents this from
happening?

So yes, that might be the root problem here.

> I'd also note that the only actual symptom we're seeing is with
> fw_devlink misbehaving (because dev->fwnode->dev wasn't set early
> enough). fw_devlink is a "new" (ish) feature, is officially optional,
> and isn't used on all hardware.

That's true too, can we set that earlier?

thanks,

greg k-h

