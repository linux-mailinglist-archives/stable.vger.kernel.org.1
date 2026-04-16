Return-Path: <stable+bounces-238285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKJ3Izus4GkCkwAAu9opvQ
	(envelope-from <stable+bounces-238285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:30:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA3940C617
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FD28300EDA2
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244A839A80E;
	Thu, 16 Apr 2026 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vjBUYv/o"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FC333120C;
	Thu, 16 Apr 2026 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331832; cv=none; b=VaH5tGOFRGS/oJ1SD60PHHpOow1WmzIAywHJ9HFIpz8URSbvp6MDPG4DLTEK5POTkChkzUdL77anRIJgCXv6DelKTpt+Y9vOhf6wVxBiorrrMek0l/OO20yUB20hoYwpEcPdk9uvLuysjdatCmPXwH7yZT6ML8j41te/HG5eqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331832; c=relaxed/simple;
	bh=evCSgKpVBFb0A+dSG71xa2VfI3qVglLRmCaaMCz809w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1HfHeODLr9vUx/SwWUWTOFmnRB7gPMwel5ILq7AwmN9bnbEZtKrTglXMJ2dFp6wkX8Q5WgMqdCBKxCgkYpdsl9DqOC0+TKTT0/2B4moTglEADLKSGZ01jH0qB4GssdN3WfdbHv+hoPAUaiSUD3+kq1kvVTBtiW3pGFTMBaukU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vjBUYv/o; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38AC522EE;
	Thu, 16 Apr 2026 02:30:25 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 071643F641;
	Thu, 16 Apr 2026 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776331830; bh=evCSgKpVBFb0A+dSG71xa2VfI3qVglLRmCaaMCz809w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vjBUYv/oHhZt5IDME2rqdMYHH/Q5ecolMz+cBVoFUOp68y1j46RiTF+AbY3ziJLVs
	 b86XJcZUqSEgu40OVqUwBUrUiP67W4ujeit6TW4OipcSMxTzYEXsBfz9IgAbmdo7eG
	 1s/a95a2gbj+Rg2phlE2Ew4ielZIPWQPewgTf+to=
Date: Thu, 16 Apr 2026 10:30:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device
 registration
Message-ID: <aeCsLy-45QyeCwGA@J2N7QTR9R3>
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
 <ad_WmuauLJ3xDKqh@J2N7QTR9R3>
 <2026041603-guts-crested-ef76@gregkh>
 <aeCOdWLaVpH-5w8s@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeCOdWLaVpH-5w8s@hovoldconsulting.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,kernel.org,arm.com,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238285-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:dkim]
X-Rspamd-Queue-Id: 2CA3940C617
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 09:23:33AM +0200, Johan Hovold wrote:
> On Thu, Apr 16, 2026 at 06:40:55AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 15, 2026 at 07:19:06PM +0100, Mark Rutland wrote:
> 
> > > AFAICT you're saying that the reference was taken *within*
> > > platform_device_register(), and then platform_device_register() itself
> > > has failed. I think it's surprising that platform_device_register()
> > > doesn't clean that up itself in the case of an error.
> > > 
> > > There are *tonnes* of calls to platform_device_register() throughout the
> > > kernel that don't even bother to check the return value, and many that
> > > just pass the return onto a caller that can't possibly know to call
> > > platform_device_put().
> > > 
> > > Code in the same file as platform_device_register() expects it to clean up
> > > after itself, e.g.
> > > 
> > > | int platform_add_devices(struct platform_device **devs, int num) 
> > > | {
> > > |         int i, ret = 0; 
> > > | 
> > > |         for (i = 0; i < num; i++) {
> > > |                 ret = platform_device_register(devs[i]);
> > > |                 if (ret) {
> > > |                         while (--i >= 0)
> > > |                                 platform_device_unregister(devs[i]);
> > > |                         break;
> > > |                 }    
> > > |         }    
> > > | 
> > > |         return ret; 
> > > | }
> > > 
> > > That's been there since the initial git commit, and back then,
> > > platform_device_register() didn't mention that callers needed to perform
> > > any cleanup.
> > > 
> > > I see a comment was added to platform_device_register() in commit:
> > > 
> > >   67e532a42cf4 ("driver core: platform: document registration-failure requirement")
> > > 
> > > ... and that copied the commend added for device_register() in commit:
> > > 
> > >   5739411acbaa ("Driver core: Clarify device cleanup.")
> > > 
> > > ... but the potential brokenness is so widespread, and the behaviour is
> > > so surprising, that I'd argue the real but is that device_register()
> > > doesn't clean up in case of error. I don't think it's worth changing
> > > this single instance given the prevalance and churn fixing all of that
> > > would involve.
> > > 
> > > I think it would be far better to fix the core driver API such that when
> > > those functions return an error, they've already cleaned up for
> > > themselves.
> > > 
> > > Greg, am I missing some functional reason why we can't rework
> > > device_register() and friends to handle cleanup themselves? I appreciate
> > > that'll involve churn for some callers, but AFAICT the majority of
> > > callers don't have the required cleanup.
> > 
> > Yes, we should fix the platform core code here, this should not be
> > required to do everywhere as obviously we all got it wrong.
> 
> It's not just the platform code as this directly reflects the behaviour
> of device_register() as Mark pointed out.
> 
> It is indeed an unfortunate quirk of the driver model, but one can argue
> that having a registration function that frees its argument on errors
> would be even worse. And even more so when many (or most) users get this
> right.

Ah, sorry; I had missed that the _put() step would actually free the
object (and as you explain below, how that won't work for many callers).

> So if we want to change this, I think we would need to deprecate
> device_register() in favour of explicit device_initialize() and
> device_add().

Is is possible to have {platfom_,}device_uninitialize() functions that
does everything except the ->release() call? If we had that, then we'd
be able to have a flow along the lines of:

	int some_init_function(void)
	{
		int err;
	
		platform_device_init(&static_pdev);
	
		err = platform_device_add(&static_pdev))
		if (err)
			goto out_uninit;
	
		return 0;
	
	out_uninit:
		platform_device_uninit(&static_pdev);
		return err;
	}

... which I think would align with what people generally expect to have
to do.

Those would have to check that only a single reference was held (from
the corresponding _initialize()), and could WARN/fail if more were held.

> That said, most users of platform_device_register() appear to operate
> on static platform devices which don't even have a release function and
> would trigger a WARN() if we ever drop the reference (which is arguably
> worse than leaking a tiny bit of memory).
> 
> So leaving things as-is is also an option.

I suspect that might be the best option for now.

Mark.

