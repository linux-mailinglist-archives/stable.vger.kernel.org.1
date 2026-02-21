Return-Path: <stable+bounces-217624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bM8aFk9GmWnySQMAu9opvQ
	(envelope-from <stable+bounces-217624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:44:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA05E16C352
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7525300898A
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 05:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139C313287;
	Sat, 21 Feb 2026 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FGeGjp6V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548714414
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771652683; cv=none; b=C6OTTtlwGRZuAKw6063DSt49j+6HZGvtBAZVlB+54OvETrQGyPHLIQxwr7Rj+k4+uVXN64PFwp7Z31ikZYRnfhCMj3yjiOwEfxc3XHC4vrDZved0X5pUB+sznMPDQbIDQh4S2X/rgUG/AwsKebmflBqhOm+QkAj2pZIkT/fqmAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771652683; c=relaxed/simple;
	bh=L0S8drGWjFk6KEnAO+uGBlVcUrNdz/CeGlNCcbnoA1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAimirZyFpFcI566y2mdk8rUqyP0N79QZEtakehgO67tPNUVZMsu1+YnI8M8rVC6PioW2ns386z80gSheieD14h/GJAm7uB92jmY8gLJzW+HXajEuqJScLp+9sbcMD9wU7of4N0TMUlby1C/Tz9i4Qb9tBWJduk8D58AZjfMmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FGeGjp6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879CFC4CEF7;
	Sat, 21 Feb 2026 05:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771652683;
	bh=L0S8drGWjFk6KEnAO+uGBlVcUrNdz/CeGlNCcbnoA1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGeGjp6VPnsHmAVNPUV0tpR0QUOyFc7QdjEVCNB//xXzNBNvujs8fGBLOtelRkCB5
	 gB2WbjBctG8Bt3MLYA63wkar1KgTdB0GrLfFV1ptUwqI1Vas+6QaDrGmIgvPTH02jN
	 9rWLVLv+iVq4cJmRote93aYm9RjEGH/odHKNzk5I=
Date: Sat, 21 Feb 2026 06:44:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Koen Koning <koen.koning@linux.intel.com>,
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Matthew Auld <matthew.auld@intel.com>,
	Dave Airlie <airlied@redhat.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] gpu/buddy: fix module_init() usage
Message-ID: <2026022156-citizen-shredding-5d6d@gregkh>
References: <DGJPMOESHINC.1NGNT8LLY8DKW@kernel.org>
 <1771594440.99434@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1771594440.99434@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217624-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA05E16C352
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 08:55:52AM -0500, Joel Fernandes wrote:
> > On Feb 20, 2026, at 5:17 AM, Danilo Krummrich <dakr@kernel.org> wrote:
> > 
> > ﻿On Fri Feb 20, 2026 at 7:06 AM CET, Greg KH wrote:
> >>> On Thu, Feb 19, 2026 at 10:38:56PM +0100, Koen Koning wrote:
> >>> Use subsys_initcall() instead of module_init() (which compiles to
> >>> device_initcall() for built-ins) for buddy, so its initialization code
> >>> always runs before any (built-in) drivers.
> >>> This happened to work correctly so far due to the order of linking in
> >>> the Makefiles, but this should not be relied upon.
> >> 
> >> Same here, Makefile order can always be relied on.
> > 
> > I want to point out that Koen's original patch fixed the Makefile order:
> > 
> > diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> > index 5cd54d06e262..b4e5e338efa2 100644
> > --- a/drivers/gpu/Makefile
> > +++ b/drivers/gpu/Makefile
> > @@ -2,8 +2,9 @@
> > # drm/tegra depends on host1x, so if both drivers are built-in care must be
> > # taken to initialize them in the correct order. Link order is the only way
> > # to ensure this currently.
> > +# Similarly, buddy must come first since it is used by other drivers.
> > +obj-$(CONFIG_GPU_BUDDY)    += buddy.o
> > obj-y            += host1x/ drm/ vga/ tests/
> > obj-$(CONFIG_IMX_IPUV3_CORE)    += ipu-v3/
> > obj-$(CONFIG_TRACE_GPU_MEM)        += trace/
> > obj-$(CONFIG_NOVA_CORE)        += nova-core/
> > -obj-$(CONFIG_GPU_BUDDY)        += buddy.o
> > 
> > He was then suggested to not rely on this and rather use subsys_initcall().
> 
> I take the blame for the suggestion; however, I am not yet convinced it is a bad
> idea. 
> > 
> > When I then came across the new patch using subsys_initcall() I made it worse; I
> > badly confused this with something else and gave a wrong advise -- sorry Koen!
> > 
> > (Of course, since this is all within the same subsystem, without any external
> > ordering contraints, Makefile order is sufficient.)
> 
> If we are still going to do the link ordering by reordering in the Makefile,
> may I ask what is the drawback of doing the alternative - that is, not
> relying on that (and its associated potential for breakage)?
> 
> Even if Makefile ordering can be relied on, why do we want to rely on it if
> there is an alternative? Also module_init() compiles to device_initcall() for
> built-ins and this is shared infra.
> 
> We use this technique in other code paths too, no? See
> drivers/i2c/i2c-core-base.c:
> 
>   /* We must initialize early, because some subsystems register i2c drivers
>    * in subsys_initcall() code, but are linked (and initialized) before i2c.
>    */
>   postcore_initcall(i2c_init);
> 
> If there is a drawback I am all ears but otherwise I would prefer the new
> patch tbh. 

The "problem" is that the init levels are very "coarse", and the link
order is very specific.  You can play with init levels a lot, but what
happens if another driver also sets to the same init level, or an
earlier one to try to solve something that way?

So it can be a loosing battle for many things, choose the best and
simplest solution, but always remember, Makefile order matters, which is
what I was wanting to correct here.

thanks,

greg k-h

