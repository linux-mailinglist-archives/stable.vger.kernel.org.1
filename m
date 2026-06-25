Return-Path: <stable+bounces-268347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oxv3MRALPWpFwQgAu9opvQ
	(envelope-from <stable+bounces-268347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B07C6C4F24
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:03:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WQ6F2O4Q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268347-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268347-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D5313087EE3
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5400C3A9017;
	Thu, 25 Jun 2026 11:01:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0621DDC35;
	Thu, 25 Jun 2026 11:01:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385273; cv=none; b=P3S9fM+LFNyFpyHk4qJuHTTFipUNUo8FAEHMYo8cXf39XlsTqgTDAI3iLRLS22rxM2/sadO0qGRsbBJfc0u0zG6SbTPdgTcn7oxXn+9FtUYJEvn1IABDfzRjoBIZreQudqaa6CIdbOqMIwiBHeKJYpl4rySyYFBSmg8BVW+nYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385273; c=relaxed/simple;
	bh=ggUX/i5MMvnQQ/+vcgb785AjIAFWFHYOkxaxWC5vnys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLmm2Yg7upYpavdzn91w7qkYaCyRphoiDV2gv3BFwNnKYpQMnhNoBlYZ8M5Kw+swbSsaUY3OdVYTIth47wd+izqVVd0W10xdykt5zB+OxMIvj6lGzVXX094ofvqse4w9tLSfyoUvylVAd2sduaYLWQFwFzOasIVAhgUOHuroDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ6F2O4Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656771F00A3A;
	Thu, 25 Jun 2026 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782385271;
	bh=P2kyeABYV5X0XyNgkH9lLtgLno2Ur3/Fbk7oOiClOZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WQ6F2O4Qc6lCQL8w5jZMZop5SgDcB4qg06aT74MugGs/hTslVn3hXLRr+asBjt8bK
	 OQLRJnoH005WgGoQPk7iNQUBPWbOn7mUZAhZcRbt500s1PTQ08Nf+fbphKeJLLJPYd
	 q6s5/U8HLbsGXVNCGt8X30crOf5K39ETKHFle9DTgxz9mIwFuNdJDkoSWfc0sOC3Uv
	 XYTO6+B3XuZt2AOrgLGnY5BltyFxtRSIsVD8a6xlVHkqozuRZJIVVXPmT6zg0DVMuv
	 TjxcU1AnzCvLPt764sZrNvRdlN2okM5bkkL+Izb+on/kz0dGRhTMv51fousgGDp1DW
	 lX66cOEJZ/VWA==
Date: Thu, 25 Jun 2026 13:01:06 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org, 
	stable@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Eric Sandeen <sandeen@redhat.com>, 
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] xfs: fix capabily check in xfs_setattr_nonsize
Message-ID: <aj0KNVV24VmkrTrk@nidhogg.toxiclabs.cc>
References: <20260624101436.362533-1-cem@kernel.org>
 <20260624134039.GB5649@lst.de>
 <qcsdbdpp23fsu3cqhpjdpwusvl6onc2knnrun522ofrutxpz6j@reh3k2ofqjir>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qcsdbdpp23fsu3cqhpjdpwusvl6onc2knnrun522ofrutxpz6j@reh3k2ofqjir>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268347-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jack@suse.cz,m:hch@lst.de,m:linux-xfs@vger.kernel.org,m:stable@vger.kernel.org,m:djwong@kernel.org,m:david@fromorbit.com,m:sandeen@redhat.com,m:thomas.orgis@uni-hamburg.de,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nidhogg.toxiclabs.cc:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B07C6C4F24

On Thu, Jun 25, 2026 at 12:43:54PM +0200, Jan Kara wrote:
> On Wed 24-06-26 15:40:39, Christoph Hellwig wrote:
> > Adding Jan and Christian for quota and user_ns knowledge.
> > 
> > On Wed, Jun 24, 2026 at 12:14:29PM +0200, cem@kernel.org wrote:
> > > From: Carlos Maiolino <cem@kernel.org>
> > > 
> > > An user reported a bug where he managed to evade group's quota
> > > by changing a file's gid to a different group id the same user
> > > belonged to, even though quotas were enforced on both gids and the
> > > file's size was big enough to exceed the quota's hardlimit.
> > > 
> > > Commit eba0549bc7d1 replaced a capable() call by a
> > > has_capability_noaudit() to prevent unnecessary selinux audit messages.
> > > Turns out that both calls have slightly different semantics even though
> > > their documentation seems similar. Where in a nutshell:
> > > 
> > > capable() - Tests the task's effective credentials
> > > has_ns_capability_noaudit() - Tests the task's real credentials
> > 
> > Eww..
> 
> Yeah, that's a catch.
> 
> > > This most of the time has no practical difference but in some cases like
> > > changing attrs (specifically group id in this case) through a NFS client
> > > this will allow the quota code to use XFS_QMOPT_FORCE_RES, effectively
> > > bypassing quota accounting checks.
> > 
> > Yeah, this does look wrong.  Do the other conversion in the above commit
> > have tthe same issue?
> > 
> > > Using instead ns_capable_noaudit() should fix this issue and prevent
> > > selinux audit messages.
> > 
> > The generic quota code manages to do without either has_capability_noaudit
> > or ns_capable_noaudit.  I think this might be hidden behind
> > inode_owner_or_capable calls.  Any idea why we're different?
> 
> Actually no. Generic quota code has equivalent checks in ignore_hardlimit()
> function which does capable(CAP_SYS_RESOURCE) check. I guess the reason why
> nobody complained about generic quota code is that we call
> ignore_hardlimit() only if we are above hardlimit whereas XFS calls this
> for every transaction...

But the capable() call works fine, it's the replacement by
has_capability_noaudit() that enables quota bypass I *think* generic
quota code is safe from this point.

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

