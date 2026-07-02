Return-Path: <stable+bounces-270413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +v14EVFSRmr3QgsAu9opvQ
	(envelope-from <stable+bounces-270413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 13:58:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DA26F7239
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 13:58:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270413-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270413-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7246730315C2
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD183F6C22;
	Thu,  2 Jul 2026 11:24:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BD3EDE5E;
	Thu,  2 Jul 2026 11:24:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991483; cv=none; b=XAUrmQF2gnNijoUdmfemcXSgkvU7wSe9re/0StpKSNzN2A9cUrV33kFGK71Od9JLqkYR5YzYz8Rp2EUVjjld1R5P6OtTnAMO25B11lzLzYFLj+ABfdOIhJnaTuullZWHwLcmW3IRzEXz74//I3OwCabKvpQ5IpCYsvFd2V1HuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991483; c=relaxed/simple;
	bh=BrpgNcgC0a1hHbzfOzJMlyVEGH7cAkX+nQvexq9IRRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTYKkE9YVQbMGeShZSAkOUGIXjPquuMo3X5rw5ZYUKWfbU85zOEl83zlW5X/Y/aY1ll6N46QBFPIzIP7cdZ5lTqEw/o97ESwx69ugLAknQFwhnvadGF+LzLsrdaU8nYboZdubE53z+tOTyDM3gYgufzEJy3w05sNvtXgGZxLOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id EBD0F68BEB; Thu,  2 Jul 2026 13:24:38 +0200 (CEST)
Date: Thu, 2 Jul 2026 13:24:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>, "Serge E. Hallyn" <serge@hallyn.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Eric Sandeen <sandeen@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Subject: Re: [PATCH v3 1/5] xfs: fix capability check in xfs
Message-ID: <20260702112438.GA10565@lst.de>
References: <20260702093324.127450-1-cem@kernel.org> <20260702093324.127450-3-cem@kernel.org> <20260702103052.GA6670@lst.de> <akZITB_FDP1nl2_S@nidhogg.toxiclabs.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZITB_FDP1nl2_S@nidhogg.toxiclabs.cc>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cem@kernel.org,m:hch@lst.de,m:stable@vger.kernel.org,m:jack@suse.cz,m:serge@hallyn.com,m:djwong@kernel.org,m:david@fromorbit.com,m:sandeen@redhat.com,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.orgis@uni-hamburg.de,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270413-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82DA26F7239

On Thu, Jul 02, 2026 at 01:17:29PM +0200, Carlos Maiolino wrote:
> On Thu, Jul 02, 2026 at 12:30:52PM +0200, Christoph Hellwig wrote:
> > On Thu, Jul 02, 2026 at 11:33:17AM +0200, cem@kernel.org wrote:
> > > index 6339f4956ecb..205fe2dae732 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -835,7 +835,8 @@ xfs_setattr_nonsize(
> > >  	}
> > >  
> > >  	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
> > > -			has_capability_noaudit(current, CAP_FOWNER), &tp);
> > > +					ns_capable_noaudit(&init_user_ns, CAP_FOWNER),
> > 
> 
> Thanks, I tried to keep the parameters aligned, but I can bring it one
> tab back. Do you mind if I fix it at commit time if -unlikely- no other
> change is required?
> 
> This is what it will look like:
> 
>         error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
> -                       has_capability_noaudit(current, CAP_FOWNER), &tp);
> +                               ns_capable_noaudit(&init_user_ns, CAP_FOWNER),
> +                               &tp);

This still adds an extra tab.  Like much (but not all) of the kernel
we use two-tabs by default, which is also in the other two hinks.  This
now adds a third.  Just keep it as it was:

	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
			ns_capable_noaudit(&init_user_ns, CAP_FOWNER), &tp);


