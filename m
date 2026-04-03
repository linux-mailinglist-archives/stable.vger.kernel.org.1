Return-Path: <stable+bounces-233202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB5JGHzhz2kS1gYAu9opvQ
	(envelope-from <stable+bounces-233202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:49:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB852395F3B
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 239C530C5DAA
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A63ACA65;
	Fri,  3 Apr 2026 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xvWB+aog"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1A2DCF57;
	Fri,  3 Apr 2026 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231069; cv=none; b=PkKK2Lj+c2PV1Y1NkY709X+RmUw6ByzAmpbhWxII0AcIin1ZmuzbAn/ZCY8+0k4yEMpM+RGs2PCpbreCW7rXtXOhK94eBu0OZJuumQ8SDJHaZ27VJl7sNBHrz2X12qic3LWBl6qiBAUrf4mNHWTF2jHux9ZaSMhV1xqStyCMq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231069; c=relaxed/simple;
	bh=e6bgTSt90iCMYIh5P7i291wyPkSrhxtntuuzyhX6Blo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP2DJE8EkiRQH2PWSQB5deD7vMEijdkOosgKwVH+mIgn8WkzcCnJU/HNxwiTawucS4APNCZ2zYqTTJd8JkbyuMKzp3Vg5cH4vc3irORFmi57E2/+o9RP8H8nmRH53IdlO4oYn9IHB+HIWMWpsMwp0HFn6u+rPcU1LCx9o+ycpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xvWB+aog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065FDC4CEF7;
	Fri,  3 Apr 2026 15:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775231069;
	bh=e6bgTSt90iCMYIh5P7i291wyPkSrhxtntuuzyhX6Blo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xvWB+aogUe1CgVuM1eqDLSmj36gX/g9Gz130ev8n5SQYvaMFdPOaTRlZSiUTKbYVh
	 GS6mKzMPXf7oVCxTMtIZnEzj4+H5ayN0lslxD7rTxuFsbloPf9vZvlYCw5fLo7rSxB
	 kGgnRBhQUTjIWh5S+DgHu5fYJ6eSzght2v8SqVSg=
Date: Fri, 3 Apr 2026 17:44:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Doug Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>, Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] driver core: Don't let a device probe until it's
 ready
Message-ID: <2026040353-glamour-repacking-0e53@gregkh>
References: <20260403005005.30424-1-dianders@chromium.org>
 <20260402174925.v3.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <2026040319-seventeen-humorless-5541@gregkh>
 <CAD=FV=XmnWjVzQcr13GmRKX3cvRortA==5C8TH5D-jRBe0VBqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XmnWjVzQcr13GmRKX3cvRortA==5C8TH5D-jRBe0VBqw@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233202-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: BB852395F3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 08:34:20AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Apr 3, 2026 at 12:04 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > > @@ -458,6 +458,18 @@ struct device_physical_location {
> > >       bool lid;
> > >  };
> > >
> > > +/**
> > > + * enum struct_device_flags - Flags in struct device
> > > + *
> > > + * Should be accessed with thread-safe bitops.
> > > + *
> > > + * @DEV_FLAG_READY_TO_PROBE: If set then device_add() has finished enough
> > > + *           initialization that probe could be called.
> > > + */
> > > +enum struct_device_flags {
> > > +     DEV_FLAG_READY_TO_PROBE,
> > > +};
> >
> > If you are going to want this to be a bit value, please use BIT(X) and
> > not an enum, as that's going to just get confusing over time.
> 
> I don't believe I can do that. BIT(x) is not compatible with the
> atomic bitops API. BIT(x) will turn the bit number (x) into a hex
> value, but the atomic bitops API needs the bit number.

Ah, yeah, sorry, missed that.

> If you wish, I can turn this into something like:
> 
> #define DEV_FLAG_READY_TO_PROBE         0
> #define DEV_FLAG_CAN_MATCH              1
> #define DEV_FLAG_DMA_IOMMU              2
> ...
> 
> ...but that seemed worse (to me) than the enum. Please shout if I
> misunderstood or you disagree.

If you make it a numbered enum, that's fine (I hate unnumbered ones),
and a comment somewhere saying we will "max out" at 63, or have a
DEV_FLAG_MAX_BIT entry in there.

> > Also, none of this manual test_bit()/set_bit() stuff, please give us
> > real "accessors" for this like:
> >         bool device_ready_to_probe(struct device *dev);
> >
> > so that it's obvious what is happening.
> 
> Sure, that matches Rafael's request and is a nice improvement. To keep
> from having to replicate a bunch of boilerplate code, I'll have macros
> define the accessors:
> 
> #define __create_dev_flag_accessors(accessor_name, flag_name) \
> static inline bool dev_##accessor_name(const struct device *dev) { \
>         return test_bit(flag_name, &dev->flags); \
> } \
> static inline void dev_set_##accessor_name(struct device *dev) { \
>         set_bit(flag_name, &dev->flags); \
> } \
> static inline void dev_clear_##accessor_name(struct device *dev) { \
>         clear_bit(flag_name, &dev->flags); \
> } \
> static inline void dev_assign_##accessor_name(struct device *dev, bool
> value) { \
>         assign_bit(flag_name, &dev->flags, value); \
> } \
> static inline bool dev_test_and_set_##accessor_name(struct device *dev) { \
>         return test_and_set_bit(flag_name, &dev->flags); \
> }
> 
> __create_dev_flag_accessors(ready_to_probe, DEV_FLAG_READY_TO_PROBE);
> __create_dev_flag_accessors(can_match, DEV_FLAG_CAN_MATCH);
> __create_dev_flag_accessors(dma_iommu, DEV_FLAG_DMA_IOMMU);
> __create_dev_flag_accessors(dma_skip_sync, DEV_FLAG_DMA_SKIP_SYNC);
> __create_dev_flag_accessors(dma_ops_bypass, DEV_FLAG_DMA_OPS_BYPASS);
> __create_dev_flag_accessors(state_synced, DEV_FLAG_STATE_SYNCED);
> __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
> __create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
> __create_dev_flag_accessors(offline_disabled, DEV_FLAG_OFFLINE_DISABLED);
> __create_dev_flag_accessors(offline, DEV_FLAG_OFFLINE);
> 
> Happy to tweak the above if desired.

Sure, that works, thanks!

greg k-h

