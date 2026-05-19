Return-Path: <stable+bounces-249584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE4nKgZeDGq5gQUAu9opvQ
	(envelope-from <stable+bounces-249584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:56:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1717E57F227
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3002430AB81D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FB54E377E;
	Tue, 19 May 2026 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mi5Rgg1O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039A4E3763;
	Tue, 19 May 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194985; cv=none; b=o0GTi8Je7vFrMpnutvF2ErljE5UyyNitpTEY0MwxdxvRKAr3Uu5+XkvV/HSY+2VtBJ+wNAaLzn4Iv0uh3mYjrpfDNKI31m1DwAGoQHn9WQ2qXQ9oNPkYtpN0FR9aMqgegPinhILaGjI2KU24fnMIIZIRMjwVj3grIKtNncX4odg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194985; c=relaxed/simple;
	bh=eqjqNP7S444fzbeIgre3bD11ZF6b0frGn5B3goLhHXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB/lwo3ofH9Gisv6LL49F26i1lmekJngBSiBXdVFjC29O0t/1SIqVUdi+TryLJfF6xUzRkX+tcyjKtcuRBUtxKXUlzva4u12VFj9Pubh8aOGwmW6GyRDeTJzxTm3zFtmqqIqZt8f9RRVcIGVyGxXChfjop1w2m+yb14N0S/aUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mi5Rgg1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E11C2BCB3;
	Tue, 19 May 2026 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779194984;
	bh=eqjqNP7S444fzbeIgre3bD11ZF6b0frGn5B3goLhHXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mi5Rgg1O6tyHGtgKJSao86QbGuasY0Fr9q+IHguBHFxT3sb5D4kkcPtO/07hqYuXk
	 lrQpC75eUElj4HcidvDYQBVz0FhEM9qiHnuR0Qr2s6oTjLHFYOOCI4GWiGbN/8hepR
	 TClJsBXZRyyDUuBReYn8wP+jDuCvxFUbW4ljbf8Q=
Date: Tue, 19 May 2026 14:48:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/4] HID: Proper fix for OOM in hid-core
Message-ID: <2026051937-hefty-registry-37b2@gregkh>
References: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
 <20260506091606.GB305027@google.com>
 <20260512101723.GU305027@google.com>
 <20260519111723.GU305027@google.com>
 <agxbD6k60vQYrJ6T@beelink>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agxbD6k60vQYrJ6T@beelink>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249584-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1717E57F227
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 02:46:13PM +0200, Benjamin Tissoires wrote:
> On May 19 2026, Lee Jones wrote:
> > On Tue, 12 May 2026, Lee Jones wrote:
> > 
> > > On Wed, 06 May 2026, Lee Jones wrote:
> > > 
> > > > On Mon, 04 May 2026, Benjamin Tissoires wrote:
> > > > 
> > > > > Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> > > > > bogus memset()") enforced the provided data to be at least the size of
> > > > > the declared buffer in the report descriptor to prevent a buffer
> > > > > overflow.
> > > > > 
> > > > > We only had corner cases of malicious devices exposing the OOM because
> > > > > in most cases, the buffer provided by the transport layer needs to be
> > > > > allocated at probe time and is large enough to handle all the possible
> > > > > reports.
> > > > > 
> > > > > However, the patch from above, which enforces the spec a little bit more
> > > > > introduced both regressions for devices not following the spec (not
> > > > > necesserally malicious), but also a stream of errors for those devices.
> > > > > 
> > > > > Let's revert to the old behavior by giving more information to HID core
> > > > > to be able to decide whether it can or not memset the rest of the buffer
> > > > > to 0 and continue the processing.
> > > > > 
> > > > > Note that the first commit makes an API change, but the callers are
> > > > > relatively limited, so it should be fine on its own. The second patch
> > > > > can't really make the same kind of API change because we have too many
> > > > > callers in various subsystems. We can switch them one by one to the safe
> > > > > approach when needed.
> > > > > 
> > > > > The last 2 patches are small cleanups I initially put together with the
> > > > > 2 first patches, but they can be applied on their own and don't need to
> > > > > be pulled in stable like the first 2.
> > > > > 
> > > > > Cheers,
> > > > > Benjamin
> > > > > 
> > > > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > > > ---
> > > > > Changes in v3:
> > > > > - fixed ghib -> ghid in greybus
> > > > > - fixed i386 size_t debug size reported by kernel-bot
> > > > > - Link to v2: https://lore.kernel.org/r/20260416-wip-fix-core-v2-0-be92570e5627@kernel.org
> > > > > 
> > > > > Changes in v2:
> > > > > - added a small blurb explaining the difference between the safe and the
> > > > >   non safe version of hid_safe_input_report
> > > > > - Link to v1: https://lore.kernel.org/r/20260415-wip-fix-core-v1-0-ed3c4c823175@kernel.org
> > > > > 
> > > > > ---
> > > > > Benjamin Tissoires (4):
> > > > >       HID: pass the buffer size to hid_report_raw_event
> > > > >       HID: core: introduce hid_safe_input_report()
> > > > >       HID: multitouch: use __free(kfree) to clean up temporary buffers
> > > > >       HID: wacom: use __free(kfree) to clean up temporary buffers
> > > > > 
> > > > >  drivers/hid/bpf/hid_bpf_dispatch.c |  6 ++--
> > > > >  drivers/hid/hid-core.c             | 67 ++++++++++++++++++++++++++++++--------
> > > > >  drivers/hid/hid-gfrm.c             |  4 +--
> > > > >  drivers/hid/hid-logitech-hidpp.c   |  2 +-
> > > > >  drivers/hid/hid-multitouch.c       | 18 ++++------
> > > > >  drivers/hid/hid-primax.c           |  2 +-
> > > > >  drivers/hid/hid-vivaldi-common.c   |  2 +-
> > > > >  drivers/hid/i2c-hid/i2c-hid-core.c |  7 ++--
> > > > >  drivers/hid/usbhid/hid-core.c      | 11 ++++---
> > > > >  drivers/hid/wacom_sys.c            | 46 +++++++++-----------------
> > > > >  drivers/staging/greybus/hid.c      |  2 +-
> > > > >  include/linux/hid.h                |  6 ++--
> > > > >  include/linux/hid_bpf.h            | 14 +++++---
> > > > >  13 files changed, 109 insertions(+), 78 deletions(-)
> > > > 
> > > > What's the plan for this set Benjamin? -rcs or -next?
> > > 
> > > Are there any updates on this set please?
> > > 
> > > FYI, this set is still important to us.
> > > 
> > > Ideally, if all is well, it would go into the -rcs for v7.1.
> > 
> > I'm still actively tracking these.
> > 
> > It looks like Mark has been reverting them from -next and I'm getting
> > complaints from the Stable folks that they are causing build errors.
> > 
> >   drivers/hid/hid-core.c: In function 'hid_safe_input_report':
> >   drivers/hid/hid-core.c:2195:16: error: too many arguments to function '__hid_input_report'
> >     2195 |         return __hid_input_report(hid, type, data, bufsize, size, interrupt, 0,
> > 
> > Are you folks still working on this set?
> 
> Well, everything is in Linus' tree:
> 
> not yet in a released rc (taken yesterday by Linus directly):
> 
> 4d3a2a466b8d HID: core: Fix size_t specifier in hid_report_raw_event()
> 
> Already in 7.1-rc4:
> 
> 206342541fc8 HID: core: introduce hid_safe_input_report()
> 2c85c61d1332 HID: pass the buffer size to hid_report_raw_event
> 
> Not sure why the patches don't apply to stable, but from an upstream
> subsystem point of view, everything is in order.

We dropped them from stable because of the build breakage :(

thanks,

greg k-h

