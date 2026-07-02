Return-Path: <stable+bounces-270411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cQQWEm9KRmqANwsAu9opvQ
	(envelope-from <stable+bounces-270411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 13:24:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8321F6F6A49
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 13:24:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jeTdrDsU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270411-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270411-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BDAD305900E
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C43B3ED5B3;
	Thu,  2 Jul 2026 11:17:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0535A3EB0E6;
	Thu,  2 Jul 2026 11:17:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991055; cv=none; b=CsbBjc5Eto1y6gAGLSamZQUbILtTQp6dgnV1KU5XSAEC78qfd/TraQRqsm+TPBTAhnphxXqQtL2+sAmAXMQdsaLTYx2jn36QdHOaQz8uzB/wN/1GZyBdGCTewNd+CGE0n73Ai1+OebUfDeIFgQZvLBA/Iqf3JxiZvwTbQbs3cMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991055; c=relaxed/simple;
	bh=LhOXCibg9a5drTPSzz1LQIpCrkavwlW99AeY8rvjAHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmxXHFjTUfEZWMHfXjVe+ADR9sGN/+H0cMpWoXwWXTs22ALI7WVWSL1620DREwMNcvfJdLC62ov7+rBVV5R9mJLMIwrJElDyTvdYgUxrA6rMmQqz4rXfGXsaiCVeTCSev/ALtEUhQjEN3GQIZDLF3nN3JAXs76RbAqX5P8eM2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeTdrDsU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6DD1F000E9;
	Thu,  2 Jul 2026 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782991054;
	bh=B6qx0fV5Kuct++leTThUpa0sfGnYf2tKGKYlTAvI5PM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jeTdrDsUpWlyRENZ5SuOv40SOfygUjbYr5ohbvCL0H6KeKqJ5xpnjqG4A7+CC3SU/
	 SA+XzP/+GdgXLgZnBiqwBvqRB9T4Qe+xPMnpm9jM5Aqve+Bemm+XvrDTEgUFi9wtu+
	 VGTBkz/CUtT1R5jqtJbTlHKoekOuQ9yMMCpwXxxQF1ZOwxez+DSQok0RTe76DhsD8y
	 iVQ/7bp+Fxfkec2UKWa2G3w0myWjHdHKyxy9esAlwv7peMRJOFzCFt7VL2fZEweg6j
	 aIAjQqtx/AWB2hYLED67A3rpurffS/rpgHV/gHC7hVmewp1lljPws0/icVyn1SXj/T
	 /uhGO1qliYBkg==
Date: Thu, 2 Jul 2026 13:17:29 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	"Serge E. Hallyn" <serge@hallyn.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Eric Sandeen <sandeen@redhat.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Subject: Re: [PATCH v3 1/5] xfs: fix capability check in xfs
Message-ID: <akZITB_FDP1nl2_S@nidhogg.toxiclabs.cc>
References: <20260702093324.127450-1-cem@kernel.org>
 <20260702093324.127450-3-cem@kernel.org>
 <20260702103052.GA6670@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702103052.GA6670@lst.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:stable@vger.kernel.org,m:jack@suse.cz,m:serge@hallyn.com,m:djwong@kernel.org,m:david@fromorbit.com,m:sandeen@redhat.com,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.orgis@uni-hamburg.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-270411-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nidhogg.toxiclabs.cc:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8321F6F6A49

On Thu, Jul 02, 2026 at 12:30:52PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 02, 2026 at 11:33:17AM +0200, cem@kernel.org wrote:
> > index 6339f4956ecb..205fe2dae732 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -835,7 +835,8 @@ xfs_setattr_nonsize(
> >  	}
> >  
> >  	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
> > -			has_capability_noaudit(current, CAP_FOWNER), &tp);
> > +					ns_capable_noaudit(&init_user_ns, CAP_FOWNER),
> 

Thanks, I tried to keep the parameters aligned, but I can bring it one
tab back. Do you mind if I fix it at commit time if -unlikely- no other
change is required?

This is what it will look like:

        error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
-                       has_capability_noaudit(current, CAP_FOWNER), &tp);
+                               ns_capable_noaudit(&init_user_ns, CAP_FOWNER),
+                               &tp);



> Extra indentation and an overly long line caused by that here.
> 
> Otherwise looks good.
> 

