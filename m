Return-Path: <stable+bounces-233350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPcvNTxV02nehAcAu9opvQ
	(envelope-from <stable+bounces-233350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 08:39:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE223A1D5A
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 08:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF903300647B
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 06:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0916835B649;
	Mon,  6 Apr 2026 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gXtUsyoJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE32E1722;
	Mon,  6 Apr 2026 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775457591; cv=none; b=Z0Jk/53A5i+H8ar5WSX5wSGKw4/QNYdiFSkM9WqojGUxjbo8A+BiOi5767TV0fUGu1zg97NyeQGbZQeu86ELiB2yzh81Nej3VBk2JP1uQls3I05I42bQl9HW8GadTryBbggKi/uHz/eyXOFhe8e4jhvL7Nry2rgAmvBOVkcsH2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775457591; c=relaxed/simple;
	bh=0CodlUg2uSwhhc5vNnrj3eNR4GbEfu40Za9ILLej1S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFZFhaIKL4gyzxUxPDVcRjIaTMkFoSHtqCflLIKOCbbrIhhhGwtyqAMDiuiLV4AmSd7U2UvnnrQAuzUyJNtUFZLMEVB5gamS/L81xiRduU/HqPBywszRzrpvoHv5VJGY8mgshfmnm6aR/HrvEOXnAtvtxoF0Aj3DSEBeJMF2QIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gXtUsyoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA30C4CEF7;
	Mon,  6 Apr 2026 06:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775457591;
	bh=0CodlUg2uSwhhc5vNnrj3eNR4GbEfu40Za9ILLej1S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXtUsyoJ/Dz3n0uUg5YNV/IPj2yCqCjwPRpVtDsLjk4D0txEN8jzRzP8Yhez5Jol1
	 c/MpSQ4rSRK6gWIQ+IRx0W2Ydi43G0pvY/YcCfCdkopd5eXhQAxIX3NPbitoV1j53Y
	 kmQcLhenSExrA3+UitZZYRT3UNJX8ycoyrA5AcQc=
Date: Mon, 6 Apr 2026 08:39:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Saravana Kannan <saravanak@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
	Johan Hovold <johan@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] driver core: Don't let a device probe until it's
 ready
Message-ID: <2026040606-brewery-veteran-e013@gregkh>
References: <20260404000644.522677-1-dianders@chromium.org>
 <20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <DHLITCTY913U.J59JSQOVL0NH@kernel.org>
 <CAD=FV=Wgw7kU+Xse6dwjE+U06_A_tWcA93UXu6TTf0Erh+Mt8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Wgw7kU+Xse6dwjE+U06_A_tWcA93UXu6TTf0Erh+Mt8Q@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233350-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8DE223A1D5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 03:39:26PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sun, Apr 5, 2026 at 1:58 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Sat Apr 4, 2026 at 2:04 AM CEST, Douglas Anderson wrote:
> > > Instead of adding another flag to the bitfields already in "struct
> > > device", instead add a new "flags" field and use that. This allows us
> > > to freely change the bit from different thread without holding the
> > > device lock and without worrying about corrupting nearby bits.
> >
> > I was just about to pick up this patch series (Greg mentioned to pick it up next
> > week, but we agreed offlist that I will pick it now, so it gets a few more
> > cycles in linux-next).
> >
> > Due to this, taking a second glance at the code, I noticed the below issue.
> >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 09b98f02f559..f07745659de3 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -3688,6 +3688,19 @@ int device_add(struct device *dev)
> > >               fw_devlink_link_device(dev);
> > >       }
> > >
> > > +     /*
> > > +      * The moment the device was linked into the bus's "klist_devices" in
> > > +      * bus_add_device() then it's possible that probe could have been
> > > +      * attempted in a different thread via userspace loading a driver
> > > +      * matching the device. "ready_to_prove" being unset would have
> > > +      * blocked those attempts. Now that all of the above initialization has
> > > +      * happened, unblock probe. If probe happens through another thread
> > > +      * after this point but before bus_probe_device() runs then it's fine.
> > > +      * bus_probe_device() -> device_initial_probe() -> __device_attach()
> > > +      * will notice (under device_lock) that the device is already bound.
> > > +      */
> > > +     dev_set_ready_to_probe(dev);
> >
> > By converting this to a bitop, we now avoid races with other bitfields (such as
> > dev->can_match), but I think we still need to take the device lock for this one
> > specifically:
> >
> >         Task 0 (device_add):            Task 1 (__driver_probe_device):
> >
> >         dev->fwnode->dev = dev;
> >                                         device_lock(dev);
> >         device_lock(dev);                       if (dev_ready_to_probe())
> >         dev_set_ready_to_probe()                        access(fwnode->dev);
> >         device_unlock(dev);             device_unlock(dev);
> >
> > Otherwise, nothing prevents the above dev->fwnode->dev = dev assignment to be
> > re-ordered with dev_set_ready_to_probe() and we are back to the problem the
> > commit attempts to solve in the first place.
> 
> Ah, that sounds like a reasonable concern, and I agree that taking the
> device_lock() here seems like the cleanest solution.
> 
> 
> > > @@ -848,6 +848,18 @@ static int __driver_probe_device(const struct device_driver *drv, struct device
> > >       if (dev->driver)
> > >               return -EBUSY;
> > >
> > > +     /*
> > > +      * In device_add(), the "struct device" gets linked into the subsystem's
> > > +      * list of devices and broadcast to userspace (via uevent) before we're
> > > +      * quite ready to probe. Those open pathways to driver probe before
> > > +      * we've finished enough of device_add() to reliably support probe.
> > > +      * Detect this and tell other pathways to try again later. device_add()
> > > +      * itself will also try to probe immediately after setting
> > > +      * "ready_to_probe".
> > > +      */
> > > +     if (!dev_ready_to_probe(dev))
> > > +             return dev_err_probe(dev, -EPROBE_DEFER, "Device not ready to probe\n");
> > > +
> > >       dev->can_match = true;
> >
> > Focused on ordering from the above, I also noticed that this ordering of
> > dev_ready_to_probe() and dev->can_match = true is actually pretty subtle and we
> > should add the following comment.
> >
> >         /*
> >          * Set can_match = true after calling dev_ready_to_probe(), so
> >          * driver_deferred_probe_add() won't actually add the device to the
> >          * deferred probe list when dev_ready_to_probe() returns false.
> >          *
> >          * When dev_ready_to_probe() returns false, it means that device_add()
> >          * will do another probe() attempt for us.
> >          */
> 
> Sure. That seems useful for future readers.
> 
> 
> > As it would be nice to land this for v7.1-rc1, I can apply both changes on
> > apply, i.e. not need to resend AFAIC.
> 
> Thanks! I'm happy to resend a new version if need be, but I'm also
> happy if you want to make changes when applying.

New version is always best :)

thanks,

greg k-h

