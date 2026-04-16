Return-Path: <stable+bounces-238267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJZ8DnqP4Gl6jwAAu9opvQ
	(envelope-from <stable+bounces-238267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:27:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB3640B05C
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A8E73038AED
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308983822A5;
	Thu, 16 Apr 2026 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnax644u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE1379EFE;
	Thu, 16 Apr 2026 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324216; cv=none; b=qpVhqco4+4v1fsuOkTwY0oti2gta7OqME6Tu68NjfbL7h3GdVIW92yK9jh7Qvh6nFjWuA9r3ZXJB2728Ra01ot5HXio513IVZ3/xsw0kc8RNn3QXhvtukPRMZvqDTZliKNRYF7keiIOKiH/BQLN/VOCoutsojclfHNISDu7ku1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324216; c=relaxed/simple;
	bh=P+FuZfShs9iMgOTaMD//Wnw5a/RJh3BxiGbmdFf8F2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKRRyBaFqw+rt5DvD8GfS6pNuf4HzyDH5nhi99ORE4RbAzoDHJKVFU1jYURa8QfGlJYQTjef7RiAy5sOC5ErGlJY5/zHFNDLnOaw8LhReOIUr/Ip+abLQdSIThrrRmZRPRlFhPSC1LY/ROTxn60SpgnzSVsGStUcweOdAtOS6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnax644u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A07C2BCAF;
	Thu, 16 Apr 2026 07:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776324215;
	bh=P+FuZfShs9iMgOTaMD//Wnw5a/RJh3BxiGbmdFf8F2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnax644uwJyOxuWtqck9KnuRFgfIoxCSKmn1nw0fMp9pMA5zLajeWDZKvIhtbr3pd
	 CABfIrBIpEdvUKdnAfwjX/v8IYioe1XfBUQgAxtsqEb1GnNVdYM57Z4KBy5t1fkb2X
	 a4h6FvgRy7X/Zvt10dq6xwbuboN1siTqdKllss2K5wHn7Zf/Op5WYrBg6gvMdgU6zP
	 d2AphfduoHpFM45XrrHAsF4F4dLA/NuhfpsvSs10TM7CUbZoijJW8KtuEIevSRgdRH
	 We9+Sv/2S/zmbjixHgztR3SvjFu8/HEq1lHklAtsN5VErbmb+LlJwX8Vp/qNnik5sG
	 ysiMaVGQXujCA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wDH4X-00000004VI7-0XUG;
	Thu, 16 Apr 2026 09:23:33 +0200
Date: Thu, 16 Apr 2026 09:23:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device
 registration
Message-ID: <aeCOdWLaVpH-5w8s@hovoldconsulting.com>
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
 <ad_WmuauLJ3xDKqh@J2N7QTR9R3>
 <2026041603-guts-crested-ef76@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026041603-guts-crested-ef76@gregkh>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	FREEMAIL_CC(0.00)[arm.com,gmail.com,kernel.org,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238267-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCB3640B05C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 06:40:55AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 15, 2026 at 07:19:06PM +0100, Mark Rutland wrote:

> > AFAICT you're saying that the reference was taken *within*
> > platform_device_register(), and then platform_device_register() itself
> > has failed. I think it's surprising that platform_device_register()
> > doesn't clean that up itself in the case of an error.
> > 
> > There are *tonnes* of calls to platform_device_register() throughout the
> > kernel that don't even bother to check the return value, and many that
> > just pass the return onto a caller that can't possibly know to call
> > platform_device_put().
> > 
> > Code in the same file as platform_device_register() expects it to clean up
> > after itself, e.g.
> > 
> > | int platform_add_devices(struct platform_device **devs, int num) 
> > | {
> > |         int i, ret = 0; 
> > | 
> > |         for (i = 0; i < num; i++) {
> > |                 ret = platform_device_register(devs[i]);
> > |                 if (ret) {
> > |                         while (--i >= 0)
> > |                                 platform_device_unregister(devs[i]);
> > |                         break;
> > |                 }    
> > |         }    
> > | 
> > |         return ret; 
> > | }
> > 
> > That's been there since the initial git commit, and back then,
> > platform_device_register() didn't mention that callers needed to perform
> > any cleanup.
> > 
> > I see a comment was added to platform_device_register() in commit:
> > 
> >   67e532a42cf4 ("driver core: platform: document registration-failure requirement")
> > 
> > ... and that copied the commend added for device_register() in commit:
> > 
> >   5739411acbaa ("Driver core: Clarify device cleanup.")
> > 
> > ... but the potential brokenness is so widespread, and the behaviour is
> > so surprising, that I'd argue the real but is that device_register()
> > doesn't clean up in case of error. I don't think it's worth changing
> > this single instance given the prevalance and churn fixing all of that
> > would involve.
> > 
> > I think it would be far better to fix the core driver API such that when
> > those functions return an error, they've already cleaned up for
> > themselves.
> > 
> > Greg, am I missing some functional reason why we can't rework
> > device_register() and friends to handle cleanup themselves? I appreciate
> > that'll involve churn for some callers, but AFAICT the majority of
> > callers don't have the required cleanup.
> 
> Yes, we should fix the platform core code here, this should not be
> required to do everywhere as obviously we all got it wrong.

It's not just the platform code as this directly reflects the behaviour
of device_register() as Mark pointed out.

It is indeed an unfortunate quirk of the driver model, but one can argue
that having a registration function that frees its argument on errors
would be even worse. And even more so when many (or most) users get this
right.

So if we want to change this, I think we would need to deprecate
device_register() in favour of explicit device_initialize() and
device_add().

That said, most users of platform_device_register() appear to operate
on static platform devices which don't even have a release function and
would trigger a WARN() if we ever drop the reference (which is arguably
worse than leaking a tiny bit of memory).

So leaving things as-is is also an option.

Johan

