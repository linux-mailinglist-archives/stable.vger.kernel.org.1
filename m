Return-Path: <stable+bounces-238712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI5aFLvV5WnWoQEAu9opvQ
	(envelope-from <stable+bounces-238712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:28:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9B427BEB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB12D30080B6
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087723845D4;
	Mon, 20 Apr 2026 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwIj29lT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3697E792;
	Mon, 20 Apr 2026 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670130; cv=none; b=sjwgL4tZmeeKvegjrYkj+6lhoRvLUH8vlaI3W/reTlzb+WJaHyFy2Bg4k3gajkIevdlWDJu08GSM4ev9QcDteKbTucZWtJtTzCGn+yYwGDfg06edgxcE3p5e+fb3FjOGrmmcvecRaWMvmT1Tpip5JNB0zyhmi6vOevhodWccgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670130; c=relaxed/simple;
	bh=7ChK6EQOifVBDW8+zChThUU7L0yGoWl0XYx6PRCHSwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KscpWyoag0urmzI13/Ck8x9XH+N8aoyJjZ0VF9M4j532MOs2I5YINhranEo5OrmivzIJx2ocHzb3bshJwBXqMIYVbz5AJtGFXU1GrEDLP7C+4ER562TjYhyWF+YKRcFi81f04MIkjfYem87VfI3gruu6roOXIIvI9wRabW2kIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwIj29lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C91EC19425;
	Mon, 20 Apr 2026 07:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776670130;
	bh=7ChK6EQOifVBDW8+zChThUU7L0yGoWl0XYx6PRCHSwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwIj29lTn8M+8gOloHELG4EU+JtrPnmGw6Ek35JzLIC2pilkTvLC97UMLnppqBZga
	 aQ8QvoB1Nu5G8V04WJiLNc4PTBrpkyF0rPu89ZIvpw7471Kf3VHq23Dyx0diWYIWOf
	 kfqz+TQsCc60I+9bbxpuQ+Wz/84oDLZNx6clt4L+V2uHQB/1d2UN0nnGWMCIX9HZaE
	 SjMOuBAAoi2bR27Pikvj4BkY2vkoaimPjouHV1OCQ5PaS5a92VPVmlB2HK6bo5118D
	 807qKMAS3spfdLQYgCanfLyKQS/+qQxPJGuaEFPWTTNTCKK3EmTObulQXZy6Ss2WRc
	 KEOoiOxISoOwg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wEj3n-00000005umO-44a0;
	Mon, 20 Apr 2026 09:28:47 +0200
Date: Mon, 20 Apr 2026 09:28:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device
 registration
Message-ID: <aeXVr5enpjb3rfq7@hovoldconsulting.com>
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
 <ad_WmuauLJ3xDKqh@J2N7QTR9R3>
 <2026041603-guts-crested-ef76@gregkh>
 <aeCOdWLaVpH-5w8s@hovoldconsulting.com>
 <aeCsLy-45QyeCwGA@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeCsLy-45QyeCwGA@J2N7QTR9R3>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,kernel.org,arm.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238712-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 16E9B427BEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 10:30:23AM +0100, Mark Rutland wrote:
> On Thu, Apr 16, 2026 at 09:23:33AM +0200, Johan Hovold wrote:

> > It's not just the platform code as this directly reflects the behaviour
> > of device_register() as Mark pointed out.
> > 
> > It is indeed an unfortunate quirk of the driver model, but one can argue
> > that having a registration function that frees its argument on errors
> > would be even worse. And even more so when many (or most) users get this
> > right.
> 
> Ah, sorry; I had missed that the _put() step would actually free the
> object (and as you explain below, how that won't work for many callers).
> 
> > So if we want to change this, I think we would need to deprecate
> > device_register() in favour of explicit device_initialize() and
> > device_add().
> 
> Is is possible to have {platfom_,}device_uninitialize() functions that
> does everything except the ->release() call? If we had that, then we'd
> be able to have a flow along the lines of:
> 
> 	int some_init_function(void)
> 	{
> 		int err;
> 	
> 		platform_device_init(&static_pdev);
> 	
> 		err = platform_device_add(&static_pdev))
> 		if (err)
> 			goto out_uninit;
> 	
> 		return 0;
> 	
> 	out_uninit:
> 		platform_device_uninit(&static_pdev);
> 		return err;
> 	}
> 
> ... which I think would align with what people generally expect to have
> to do.

The issue here is that platform_device_add() allocates a device name and
such resources are not released until the last reference is dropped.

It's been this way since 2008, but some of the static platform devices
predates that and they both lack a release callback (explicitly required
since 2003) and are not cleaned up on registration failure.

Since registration would essentially only fail during development (e.g.
due to name collision or fault injection), this is hardly something to
worry about, but we could consider moving towards dynamic objects to
address both issues.

We have a few functions for allocating *and* registering platform
devices that could be used in many of these cases (and they already
clean up after themselves on errors):

	platform_device_register_simple()
	platform_device_register_data()
	platform_device_register_resndata()
	platform_device_register_full()

and where those do not fit (and cannot be extended) we have the
underlying:

	platform_device_alloc()
	platform_device_add_resources()
	platform_device_add_data()
	plaform_device_add()

But there are some 800 static platform devices left, mostly in legacy
platform code and board files that I assume few people care about.

Johan

