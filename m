Return-Path: <stable+bounces-270422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 17ycGixbRmo+RgsAu9opvQ
	(envelope-from <stable+bounces-270422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:35:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A52E46F7AFA
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:35:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=liuOZaG4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270422-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270422-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A833174851
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB10628F5;
	Thu,  2 Jul 2026 12:11:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF43B18A;
	Thu,  2 Jul 2026 12:11:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994304; cv=none; b=fc1pje4ACXNb+EyrGMdPM13unj78w5NDwfz686puVGNH/CIL3hSPHny6CTRncFUrG05RwSRbDRIwZFxYtBthTN3tldK4YHSYX4Ug81GLZSisRFqD4EaRBULI6D0TmmGcYfCorZ1IWKy0gP/6x9VZ6GgW0PN17GnvJeRUmZeN4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994304; c=relaxed/simple;
	bh=UZvI23KSvbAWv2SEA0PbymAV+PkCadSSiY6n7uV2F0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huRjOzirKuNmh9TeFLBECx5kUmPQwBcnwtIrYQrHNfRVOmpSFSXT9eMsmm+OV3Awc4pxW9XxVtuOuIJuvTH4xQHkdoAkjaySzhdMe25FhRgJCWu1PV2pl/yjmS25g/41Zn5XRYM6wA29yIsrtFXscNdOBBuujT2+nVrk/txMMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liuOZaG4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC391F000E9;
	Thu,  2 Jul 2026 12:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782994303;
	bh=nCxAISgEcjC49iBckaad9g67RdR2PRAP40w8i5UPhjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=liuOZaG4mLRU+xtD0qhUoqKBUwt3mjLTJrhBV4a4jXp9CSLfTHhN/GY2DFEpRiVX/
	 kTCjsO7srNQVMcDMp0rZd3ATpW0OBTG4Umbsm68jGyXVIKG/iKU1qkoECfq6K/yHyX
	 QiQpBUf4Hr5C9RNNXlLR5AiZOUOYU5LKqo2EtR4l+za6pkAfg6FOpLiqdUbwcfBe2d
	 EzdICmIncIgCEjL+yTVx8PADwRqBPgdGYxhbMRa/LCUlQryPpjIMnioXFpSeKFpMZE
	 DxrvCpTzN2HIO7w+7de666OLqEJPzGNI8tuMuKw/2lRdlxvWsMTGq2YlZuAWdgbtiD
	 vUDVyVZ/NDQXA==
Date: Thu, 2 Jul 2026 14:11:37 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	"Serge E. Hallyn" <serge@hallyn.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Eric Sandeen <sandeen@redhat.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Subject: Re: [PATCH v3 1/5] xfs: fix capability check in xfs
Message-ID: <akZVYNolu7tZFoJL@nidhogg.toxiclabs.cc>
References: <20260702093324.127450-1-cem@kernel.org>
 <20260702093324.127450-3-cem@kernel.org>
 <20260702103052.GA6670@lst.de>
 <akZITB_FDP1nl2_S@nidhogg.toxiclabs.cc>
 <20260702112438.GA10565@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702112438.GA10565@lst.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:stable@vger.kernel.org,m:jack@suse.cz,m:serge@hallyn.com,m:djwong@kernel.org,m:david@fromorbit.com,m:sandeen@redhat.com,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.orgis@uni-hamburg.de,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270422-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[12];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A52E46F7AFA

On Thu, Jul 02, 2026 at 01:24:38PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 02, 2026 at 01:17:29PM +0200, Carlos Maiolino wrote:
> > On Thu, Jul 02, 2026 at 12:30:52PM +0200, Christoph Hellwig wrote:
> > > On Thu, Jul 02, 2026 at 11:33:17AM +0200, cem@kernel.org wrote:
> > > > index 6339f4956ecb..205fe2dae732 100644
> > > > --- a/fs/xfs/xfs_iops.c
> > > > +++ b/fs/xfs/xfs_iops.c
> > > > @@ -835,7 +835,8 @@ xfs_setattr_nonsize(
> > > >  	}
> > > >  
> > > >  	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
> > > > -			has_capability_noaudit(current, CAP_FOWNER), &tp);
> > > > +					ns_capable_noaudit(&init_user_ns, CAP_FOWNER),
> > > 
> > 
> > Thanks, I tried to keep the parameters aligned, but I can bring it one
> > tab back. Do you mind if I fix it at commit time if -unlikely- no other
> > change is required?
> > 
> > This is what it will look like:
> > 
> >         error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
> > -                       has_capability_noaudit(current, CAP_FOWNER), &tp);
> > +                               ns_capable_noaudit(&init_user_ns, CAP_FOWNER),
> > +                               &tp);
> 
> This still adds an extra tab.  Like much (but not all) of the kernel
> we use two-tabs by default, which is also in the other two hinks.  This
> now adds a third.  Just keep it as it was:
> 
> 	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
> 			ns_capable_noaudit(&init_user_ns, CAP_FOWNER), &tp);
> 
> 

Ok, will do!


