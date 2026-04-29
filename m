Return-Path: <stable+bounces-241855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG3YBnDZ8WmLkwEAu9opvQ
	(envelope-from <stable+bounces-241855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:12:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B18D492AD1
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F34A8301ECFD
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DFD3CCFB4;
	Wed, 29 Apr 2026 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlHsBqc1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9393CA4B6;
	Wed, 29 Apr 2026 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457499; cv=none; b=MXEVaV2VgjqAgKpsBjK4k588cUjarI/4w5Vbf9gPcieeGjtNz5kWcCdiCAo/7HyS7JcFnx2eyakjLnZthJEru16johWcTq5FyXCb4u4290ov7SkSCtDfVYDTHHopSJ2fj/0OWSJ/Bx4ijY/AaL5m4hnTKdoEKB5gwWNB9U7gqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457499; c=relaxed/simple;
	bh=nOE+9uX50nDfGJAc5vKevUJM+C7rQPPSFyaTh3o32rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtmPQaMFTigBb6XR+YlZsAIBoNhZHo9QLBCg5fPMr0Jph+biZ1p1gdeKo5oZoxBMJsEc0rJ31Xcus/s8r6GTRU/1R2+qBdV/QQU6CQiuFnNGqtRymxv0rf3HfBIFzwBpQzJEpeZ+wnbLW2zXyiqaz32f9Mo2E8pq2uzFVrrm4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlHsBqc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960A6C2BCC4;
	Wed, 29 Apr 2026 10:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777457499;
	bh=nOE+9uX50nDfGJAc5vKevUJM+C7rQPPSFyaTh3o32rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QlHsBqc1f6w+v47Y9AV7veIwaHdrIhEYrTKT1neHqqxoDyuqNuMSTXrvW1A5bMiqn
	 q6FLLI3Fg4FqmEnJXZkIOo2WWO1lUGJTtKeKnF+LWOWjkxroEzdOvzSZRnPr/qGyRM
	 yczOpNjd96ggr5JmVuZCPB5KIqK82vvOG8pjWVWerRsc50/nZtgua1oNsG90BJqaMv
	 RFNYUx+ljiI8iZW8/FaZ1jn9y9lG2G/AiNPnFkjeA0HBWBnrnQ9ilsHMPwKsw4aLsy
	 jJOuk0AJyGRVaS9SJ7DYzJC5ipwixQYppKDC/Iyy4WR3IV1v2jwd615I4leaIQT0kE
	 fuhn7zLfINFoQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI1tJ-00000000hzw-1MnH;
	Wed, 29 Apr 2026 12:11:37 +0200
Date: Wed, 29 Apr 2026 12:11:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: reject devices with unregistered buses
Message-ID: <afHZWasOhRaeBCnt@hovoldconsulting.com>
References: <20260427102852.2174-1-johan@kernel.org>
 <DI50WG9XK1I4.1R6DXSZSWFRDC@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI50WG9XK1I4.1R6DXSZSWFRDC@kernel.org>
X-Rspamd-Queue-Id: 6B18D492AD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241855-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 09:09:04PM +0200, Danilo Krummrich wrote:
> On Mon Apr 27, 2026 at 12:28 PM CEST, Johan Hovold wrote:
> > Trying to register a device on a bus which has not yet been registered
> > used to trigger a NULL-pointer dereference, but since the const bus
> > structure rework registration instead succeeds without the device being
> > added to the bus.
> >
> > Reject devices with unregistered buses to catch any callers that get
> > the ordering wrong and to handle bus registration failures more
> > gracefully.
> >
> > Fixes: 5221b82d46f2 ("driver core: bus: bus_add/probe/remove_device() cleanups")
> > Cc: stable@vger.kernel.org	# 6.3
> 
> Hm...this sounds like hardening and not like a "real" bug fix. Do you have a
> specific reason why you added Cc: stable?

It's certainly a bug fix and this change in behaviour was clearly
unintended.

Any caller getting the ordering wrong would now succeed in registering
devices, but no driver would ever be bound which is harder to detect
than the earlier crashes. 

Whether any offenders have snuck in since 6.3 I don't know, but I still
think this warrants a backport.

Johan

