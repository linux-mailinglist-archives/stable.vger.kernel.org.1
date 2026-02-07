Return-Path: <stable+bounces-214807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bxUeGsdth2miXwQAu9opvQ
	(envelope-from <stable+bounces-214807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 17:52:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7690106903
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C69B3010B98
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA36337BAA;
	Sat,  7 Feb 2026 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="kQk+/GcV";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="ZPZLCxnZ"
X-Original-To: stable@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D92367D1;
	Sat,  7 Feb 2026 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770483139; cv=none; b=Y//s8iKpqACnZxpORXUiD06Eo9pU63gJ30xPHUeC4zaJhhtEU+eChL2Db7r0qGcZ5/4wbq3do4KZqNNpc91ZNAFxQdn2rrLevLiU0cFa/7jolpuQBzI/n5GP9fyQhOR0GSvWYzjDnK7isHwJz14iDVSdUvV3dsSL5PDJjg5O2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770483139; c=relaxed/simple;
	bh=Cq2kgS/mFtEzI5MeIrqup5XgLRqKsKaM4lyIzoiA3WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnHYDuiDPlMV5kDvTlWtlA0Wb6akxWrrDfAmZtbdtsvElHTt5oreyfW72Go5DA2kfjQz3ZEFgCSmfc1zoog271pa9M/BytSuvCzaYN4bjchuSFip0DF5abMYBZZZgF0d0OVEfaKnDjquQLfHQgqF20Ih4KXJJg7sLPsTOk0L45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=kQk+/GcV; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=ZPZLCxnZ; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1770483132; bh=q10hx3KWWXV7Wk7/wCW7B2Q
	gJDRB8xAT7VvF2sPs5/8=; b=kQk+/GcVP6/ZQTyZMwq2lT8m2At5V9HY5pGDmxHInZLcvRRp6K
	Q8UKEsoKN19VKmx+GIUCLpUmrB309G5LKJBGcyW2XPTfbEcz7CI9R+MxRLlG4v1D3X1YdtlFn5e
	LNDImmw8BoXXSJzac/kQKuHc6kd6QEHJljiZHr5gIPsWvh/PQ86VY5QS9TzUJLbelQm4Q+vTfzx
	AhrmEMYn/4zJJBN/duidQP0YJyUwSR11EwLpcOVIIsXhmbTi5ridkffCaPChmZNf3OHV+rII3No
	9R9rEyWennn/xUBmkdPgTygFIJfDvg9HJoqQ0AJBmMDmDwo1QK5yyG16HHuxn1VjxLw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1770483132; bh=q10hx3KWWXV7Wk7/wCW7B2Q
	gJDRB8xAT7VvF2sPs5/8=; b=ZPZLCxnZk6cAysFwTyBXXE62yHsBSQ0X1dWBFtfpfHnJWaJygn
	o/zF5OOeIRYHZSSV5BPLBk1jeWxbMqG7rlCQ==;
Date: Sat, 7 Feb 2026 11:52:11 -0500
From: Daniel Hodges <daniel@danielhodges.dev>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Daniel Hodges <git@danielhodges.dev>, 
	Prasanth Ksr <prasanth.ksr@dell.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, 
	Divya Bharathi <divya.bharathi@dell.com>, Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: fix kobject leak on
 populate failure
Message-ID: <tscj73a7jrwnncnc7flzxbymtbztnicfm2hu5rqyavmfwv7apv@5x2k2g5p3u2m>
References: <20260206231642.30051-1-git@danielhodges.dev>
 <2026020715-spilt-cupped-aeab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026020715-spilt-cupped-aeab@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214807-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@danielhodges.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[danielhodges.dev:email,danielhodges.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7690106903
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 08:48:34AM +0100, Greg KH wrote:
> On Fri, Feb 06, 2026 at 06:16:42PM -0500, Daniel Hodges wrote:
> > When populate_enum_data(), populate_int_data(), populate_str_data(),
> > or populate_po_data() fails after a successful kobject_init_and_add(),
> > the code jumps to err_attr_init without calling kobject_put() on
> > attr_name_kobj, leaking the kobject and its associated memory.
> > 
> > Add the missing kobject_put() call before the goto to properly release
> > the kobject on error.
> > 
> > Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> > ---
> >  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> > index f5402b714657..d9f6d24c84d6 100644
> > --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> > +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> > @@ -497,6 +497,7 @@ static int init_bios_attributes(int attr_type, const char *guid)
> >  		if (retval) {
> >  			pr_debug("failed to populate %s\n",
> >  				elements[ATTR_NAME].string.pointer);
> > +			kobject_put(attr_name_kobj);
> >  			goto err_attr_init;
> >  		}
> >  
> 
> The "larger" problem with this driver is its use of raw kobjects.  No
> driver should be doing that, it is hiding all of this information from
> userspace tools by doing so, and there's loads of race conditions
> happening with the creation of these files.  It should be fixed by just
> using normal device attributes and not attempting to custom create
> kobjects by hand like this (as it is very easy to get things wrong, as
> this patch shows.)
> 
> thanks,
> 
> greg k-h

Yeah, that makes sense. I think your point of finding "bad patterns" in
usage would also be really helpful for code analysis tools. If there's
some canonical docs on various antipatterns it would be pretty helpful.

-Daniel

