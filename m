Return-Path: <stable+bounces-263690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zExKCLE8MWr+egUAu9opvQ
	(envelope-from <stable+bounces-263690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:08:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AB668F1D5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:08:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=zNWF2Vvj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263690-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263690-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A8830F4C49
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 12:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8443CEFF;
	Tue, 16 Jun 2026 12:07:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5B43CEEF
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:07:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611666; cv=none; b=tzstQ0I+jw1UKoRbiP9LxbDdnz5s8H0EPTo1pYSgV5dhrZdnwYFyzzFrn+vWM/LBhnBZfpP983EaFHEEAtiRXYR8iRzWt5ERAgaGbYyrZOyB4XcbQzDAjf16twe8wLAPTtiZ6Y1BJplKYRGS3d6HiNjwVpAvcoW2h5+vfRK6E7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611666; c=relaxed/simple;
	bh=aefywNorBjtG7Ab4/CtoyHSmkGL3g+aGnLYLrtcN6g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci0ZyN71a+kPcVcBluLp6lrwxnSLXANOAAs45GVulc1ZaKvwKxkUJ0cOzwDwrO7zjgWMiA1KAVyddeUTsHcm95kniKk5e5xO+tTBksI/rbkvKlqcWxE6VcFzNIr0FAIfmrRJN9pPI3399YQ7b1KSMwTAAdNOHfBrVOZREgT4WRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zNWF2Vvj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1D31F000E9;
	Tue, 16 Jun 2026 12:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781611665;
	bh=ny94/my199aySWtIHlh+NSB7NXA2rnfenepVm3aFYx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zNWF2Vvj15y6z0+r5M8wHOaXSBWWgVb86AoWuE3R5fV/5C0Oqu6Q1mEwE3sPQBqjQ
	 bqWrqHAtoPR/8YnOupdJGfJXodJXB0ZAA5zMLNu5usph9/VLYWUlKVpda5VRWZ9uUV
	 wREaCwsSbq8Wph3jK943tpOIeG7dle78mGN2hcpE=
Date: Tue, 16 Jun 2026 17:16:49 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, lee@kernel.org,
	sdonthineni@nvidia.com, will@kernel.org
Subject: Re: [PATCH 6.18.y 0/5] arm64: errata: Mitigate TLBI errata on
 various Arm CPUs
Message-ID: <2026061641-flip-baggage-b527@gregkh>
References: <20260616051329.111597-1-mark.rutland@arm.com>
 <2026061655-veggie-rerun-83e6@gregkh>
 <2026061658-landowner-dangling-5d07@gregkh>
 <ajEq3rRp8rYQg7Fu@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajEq3rRp8rYQg7Fu@J2N7QTR9R3>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mark.rutland@arm.com,m:stable@vger.kernel.org,m:catalin.marinas@arm.com,m:lee@kernel.org,m:sdonthineni@nvidia.com,m:will@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263690-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,arm.com:url,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62AB668F1D5

On Tue, Jun 16, 2026 at 11:52:14AM +0100, Mark Rutland wrote:
> On Tue, Jun 16, 2026 at 03:34:27PM +0530, Greg KH wrote:
> > On Tue, Jun 16, 2026 at 03:31:11PM +0530, Greg KH wrote:
> > > On Tue, Jun 16, 2026 at 06:13:24AM +0100, Mark Rutland wrote:
> > > > This is a v6.18-only backport of a workaround for a TLB invalidation
> > > > issue affecting several CPUs. The final patches landed in mainline
> > > > yesterday:
> > > > 
> > > >   https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16
> > > > 
> > > > This issue has been assigned CVE ID CVE-2025-10263, and Arm have
> > > > published a security bulletin:
> > > > 
> > > >   https://developer.arm.com/documentation/112137/latest/
> > > > 
> > > > I've pushed a copy of this backport to my kernel.org repo:
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.18/arm-4118414/backport
> > > 
> > > Should I cherry-pick these to 7.1.y and 7.0.y as well?
> > 
> > Ok, cherry-picking didn't work well, I gave up on patch 3...
> > 
> > Can you send backports for those branches too?
> 
> Sorry about that.
> 
> I'll send out backports for v7.0.y and v7.1.y later today.

Wonderful, thanks!

greg k-h

