Return-Path: <stable+bounces-238292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNUzM/+w4GkRkwAAu9opvQ
	(envelope-from <stable+bounces-238292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:50:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A87D40C9D2
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8E583025E4A
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EFB39BFF6;
	Thu, 16 Apr 2026 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LoiK9oIp"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6043237CD49;
	Thu, 16 Apr 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333049; cv=none; b=VIXx0BBpBGhm7y0w7s+3uakED/BnNK85IgrFu4uAI8rHMhUI3mks2bU0KFDt+hhIiBiuF8gJf2J8Ae0vzZD75FkEJPvsJbcXbUILbAKzzPM+4sTeDJyC0N76sCcyiHP2YqzJKhEa0yhfiPMkLPQPUHxcE8bwUX8MHj1sIH7y7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333049; c=relaxed/simple;
	bh=/l68IUbXGLbQxuUCqvugNkS/csceWjEfor//cgmVMVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv9b6PA6E96oDrqqT2yWljiwzoq5iPACajo9Qk/n3F/4iEz47TR3/KftrWrmEVBwOuM37qSMpKDpoPJWOqJMQnA0JxH6Axfn8gO4IjTmJzV6a3Yh1y6cV7VtoISiP/ZeBeU/c+TIp7HAsRDUHVt7qB5ATBU0PkwXrD2OUYARb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LoiK9oIp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22A5F25E1;
	Thu, 16 Apr 2026 02:50:41 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3C0A3F7B4;
	Thu, 16 Apr 2026 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776333046; bh=/l68IUbXGLbQxuUCqvugNkS/csceWjEfor//cgmVMVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoiK9oIpJe2lsQsQAzs3kUhViI3T+96/XFF/ZNRUkchuQH4d1RyvATNFByr+iyrTw
	 c5QgzgikabCMd1Y87/Wk/0iaiR/eKI3avdLc5t+fioxWcBCntb0Jcq9Y3z0TZ9daqj
	 1cU39usIzS49Q/+1N5Dg4Pk/g92mldrC7xbno9WM=
Date: Thu, 16 Apr 2026 10:50:42 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device
 registration
Message-ID: <aeCw8nLa1mK5tSgN@J2N7QTR9R3>
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
 <ad_WmuauLJ3xDKqh@J2N7QTR9R3>
 <2026041603-guts-crested-ef76@gregkh>
 <aeCOdWLaVpH-5w8s@hovoldconsulting.com>
 <CANUHTR9+Z9s3thfKMC5qiLMdYJAo-1sX1g9QiU65OVCbb+mAMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUHTR9+Z9s3thfKMC5qiLMdYJAo-1sX1g9QiU65OVCbb+mAMQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238292-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[arm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:dkim]
X-Rspamd-Queue-Id: 2A87D40C9D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 04:59:01PM +0800, Guangshuo Li wrote:
> On Thu, 16 Apr 2026 at 15:23, Johan Hovold <johan@kernel.org> wrote:
> > On Thu, Apr 16, 2026 at 06:40:55AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Apr 15, 2026 at 07:19:06PM +0100, Mark Rutland wrote:

> > > > Greg, am I missing some functional reason why we can't rework
> > > > device_register() and friends to handle cleanup themselves? I appreciate
> > > > that'll involve churn for some callers, but AFAICT the majority of
> > > > callers don't have the required cleanup.
> > >
> > > Yes, we should fix the platform core code here, this should not be
> > > required to do everywhere as obviously we all got it wrong.
> >
> > It's not just the platform code as this directly reflects the behaviour
> > of device_register() as Mark pointed out.
> >
> > It is indeed an unfortunate quirk of the driver model, but one can argue
> > that having a registration function that frees its argument on errors
> > would be even worse. And even more so when many (or most) users get this
> > right.
> >
> > So if we want to change this, I think we would need to deprecate
> > device_register() in favour of explicit device_initialize() and
> > device_add().
> >
> > That said, most users of platform_device_register() appear to operate
> > on static platform devices which don't even have a release function and
> > would trigger a WARN() if we ever drop the reference (which is arguably
> > worse than leaking a tiny bit of memory).
> >
> > So leaving things as-is is also an option.
> >
> > Johan
> 
> I did some more investigation, and it looks like directly changing the
> semantics of the existing API would break code that is already correct
> today.

Evidently this wasn't entirely clear, but when I suggested changing the
semantic, I had implicitly meant that we'd also go and fix up callers to
handle the new semantic.

I agree that whatever we do, we'll have to change some callers, given
that existing callers have inconsistent expectations.

> In particular, there seem to be at least two different kinds of callers:
> 
> Callers that already handle the failure path explicitly after
> platform_device_register() fails. For these users, changing
> platform_device_register() itself to drop the reference internally
> would lead to double put / use-after-free issues.

Yes; for those we could drop the explicit cleanup.

As an alternative (as Johan mentioned above), if we deprecated
*_register() in favour of separate *_initialize() and *_add() calls,
then we could require that callers had explicit cleanup. As that cleanup
would more obviously pair with the *_initialize() step, it would be less
surprising than cleaning up for a function that returned an error.

As I mentioned in my other reply to Johan, that might also give options
for how to handle the static platform_device case, e.g. with an
*_uninitialize() function.

> Callers that operate on static struct platform_device objects. Many of
> these do not have a release callback, so blindly dropping the
> reference on failure would trigger a WARN.
> 
> Because of this, changing platform_device_register() itself to always
> clean up on failure does not look safe.

I agree that we probably can't have _*register() do all the necessary
cleanup, since callers want different things.

As per Johan's suggestion, and my reply, I suspect the best option
for a consistent API would be to deprecate *_register() in favour of
separate *_initialize() and *_add() calls.

> One possible direction may be to leave platform_device_register()
> unchanged, and instead add new helper APIs for the different cases.
> 
> For case (1), I was thinking of a helper like:
> 
> platform_device_register_and_put()
> 
> The implementation would simply call platform_device_register(), and if
> that fails, call platform_device_put(). Callers converted to this helper
> would then no longer perform their own put on the failure path.

I think that's going to be a source of confusion, because there's no
clear way to name that function. A '_and_put' suffix makes it sound like
it does a put unconditionally, rather than when the *_add() step fails.

Otherwise, I agree that would work for those callers.

> For case (2), I was thinking of a helper like:
> 
> platform_device_register_static()
> 
> The implementation would first install a no-op release callback when
> pdev->dev.release is not set, and then call
> platform_device_register_and_put(). This would make the failure path
> well-defined for static platform_device users, avoiding the reference
> leak without triggering a WARN.

Something like that might work.

As above, I think my preference would be to have separate
init/add/uninit calls, as that way each of the functions succeeds or
fails atomically, which is more aligned with general conventions.

> If this direction sounds reasonable, I would be happy to work on it and
> send a patch, and I would also be very willing to help with the related
> API conversion work for existing callers.

Fantastic!

I think we should hear what Greg thinks of the options before we start
on that, but it's great to hear that you're willing!

Mark.

