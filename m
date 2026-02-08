Return-Path: <stable+bounces-214848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEe8ILotiGkhkgQAu9opvQ
	(envelope-from <stable+bounces-214848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 07:31:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D167108011
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 07:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55B0630137B0
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 06:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A82E8DFE;
	Sun,  8 Feb 2026 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CfeyA6k9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38E163;
	Sun,  8 Feb 2026 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770532277; cv=none; b=hvafrqQP0qsp1IkodpimSBmADeHdYZyQejOkxRD8FKzuSdqXHh9WMHpkRzKAhiOvCHjw+meNb1hYy1db0SD1BxtoFb96670cBlj20+PuvtoyL5ZDvzslhJfxuIYJBiKx0bQ9qruFg2vhyTQ6Xz6qQyA7zY9pW5mLNMCg/GVAgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770532277; c=relaxed/simple;
	bh=7AUya8kdOOvgoL1LtLhKe8OxWfRas8MMuwwuCMEkNL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dzm+xFE8p7WvIDSVqSdQj12+i+LSaNq9pAR8z6cHlnyA9QGzuvV0fRCoFU+iq1K3NJoRIdclWD+Hl43TUh2/YZ3unGVx+phXqYhUaP/wD3AF8j5mt732Qs0pZeYUykkNj+R3bJHOzAKUdWrJssSKpMiMpwGEmiOEJBr6HeySOI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CfeyA6k9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10784C4CEF7;
	Sun,  8 Feb 2026 06:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770532276;
	bh=7AUya8kdOOvgoL1LtLhKe8OxWfRas8MMuwwuCMEkNL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfeyA6k9SRbZAa9xIFzMOF8QkdSZ1YK6MIpoEn1NFCdfsxciVzu8xM7mSmQ5cGDHP
	 dtGZ1SbuudMrKB7kH2l8AuCJl/g4/Lnj78PPIJlMh+dZ8nVo+xTCsG8vv8PNLhwAO4
	 7/rlH0M11kMy8fTDjNKhEwplEpPvTowUBlGPbYCo=
Date: Sun, 8 Feb 2026 07:31:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Hodges <daniel@danielhodges.dev>
Cc: Daniel Hodges <git@danielhodges.dev>,
	Prasanth Ksr <prasanth.ksr@dell.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@dell.com>,
	Divya Bharathi <divya.bharathi@dell.com>,
	Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: fix kobject leak on
 populate failure
Message-ID: <2026020828-panther-rice-9388@gregkh>
References: <20260206231642.30051-1-git@danielhodges.dev>
 <2026020715-spilt-cupped-aeab@gregkh>
 <tscj73a7jrwnncnc7flzxbymtbztnicfm2hu5rqyavmfwv7apv@5x2k2g5p3u2m>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tscj73a7jrwnncnc7flzxbymtbztnicfm2hu5rqyavmfwv7apv@5x2k2g5p3u2m>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-214848-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[danielhodges.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D167108011
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 11:52:11AM -0500, Daniel Hodges wrote:
> On Sat, Feb 07, 2026 at 08:48:34AM +0100, Greg KH wrote:
> > On Fri, Feb 06, 2026 at 06:16:42PM -0500, Daniel Hodges wrote:
> > > When populate_enum_data(), populate_int_data(), populate_str_data(),
> > > or populate_po_data() fails after a successful kobject_init_and_add(),
> > > the code jumps to err_attr_init without calling kobject_put() on
> > > attr_name_kobj, leaking the kobject and its associated memory.
> > > 
> > > Add the missing kobject_put() call before the goto to properly release
> > > the kobject on error.
> > > 
> > > Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> > > ---
> > >  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> > > index f5402b714657..d9f6d24c84d6 100644
> > > --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> > > +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> > > @@ -497,6 +497,7 @@ static int init_bios_attributes(int attr_type, const char *guid)
> > >  		if (retval) {
> > >  			pr_debug("failed to populate %s\n",
> > >  				elements[ATTR_NAME].string.pointer);
> > > +			kobject_put(attr_name_kobj);
> > >  			goto err_attr_init;
> > >  		}
> > >  
> > 
> > The "larger" problem with this driver is its use of raw kobjects.  No
> > driver should be doing that, it is hiding all of this information from
> > userspace tools by doing so, and there's loads of race conditions
> > happening with the creation of these files.  It should be fixed by just
> > using normal device attributes and not attempting to custom create
> > kobjects by hand like this (as it is very easy to get things wrong, as
> > this patch shows.)
> > 
> > thanks,
> > 
> > greg k-h
> 
> Yeah, that makes sense. I think your point of finding "bad patterns" in
> usage would also be really helpful for code analysis tools. If there's
> some canonical docs on various antipatterns it would be pretty helpful.

Huge hint, any driver that calls any sysfs_*() function or touches a
kobject at all, is probably doing things wrong.  Start there and see
what you find :)

thanks,

greg k-h

