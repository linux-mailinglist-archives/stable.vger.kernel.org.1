Return-Path: <stable+bounces-268583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nQ2HH5dCPWq90QgAu9opvQ
	(envelope-from <stable+bounces-268583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:00:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 252E36C6E43
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:00:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CoS0GIWz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268583-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268583-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 296AA3016502
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999FA3E7BA7;
	Thu, 25 Jun 2026 15:00:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63F26F2BE;
	Thu, 25 Jun 2026 15:00:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399628; cv=none; b=IbCAShA3qKeVHeAJWzKHfOyBu1pch3/sQpi7Wv/TP3R1LL4HvzMpx1JkYO5u03/QXGNFfHDVKr8PGwtadeWcf8IMVQEzgNNVZfMLLwP7mwsvK3gRtoIGbQVdjBnVqWwQ3GFg/bt9YGl8/8uO9Yc3ngfQP5IsU0uyqwZ3ZjsVLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399628; c=relaxed/simple;
	bh=2rGJNW7kzzC2EOAQp+lG2xHE1YA8UeZ14RY+D3jdZss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0mv4IJh5zw838l81ZekftsgHyAt3R/I+K604gNBEk6yRi1L+08+IF791IaWg263eVKjpn0tF38W/KQn35enpfSA9XP4J1VKPwsiyav7EYikSDit2MEuzhcTsq0MvF6q6P643xDR124vI/K45NqwrGZUHt6q6qD5E7IrOz9KRzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoS0GIWz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCB01F00A3A;
	Thu, 25 Jun 2026 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782399627;
	bh=zRvgAQyPPoK2vUdPbDN7JiZo6UURRerJQsTHI7SpChE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CoS0GIWz0OFCjX9XSXwQosvDlIWcW7PHsxkYrGnEXFeBS8OhtuwJTQlXUW9Lztm3G
	 Di7qd+qyhVYKeXaX8UQUXOAF8DGodLgUS92D0ckGmUSBc90zkAbDWgHPLQ0Aei2U4A
	 1SfUzABBMak/gA3UNBS/VaQPIqNojZmQi9SJ5IpDjlR5CCCIavqOsgJ7U2Dp86yBLO
	 zrQft2+1yEi0BM/tRQJLbx4w++Y0Y9vYTetzOlJNjRpVWNt+bJcTp4cUq8L+3K9EZs
	 tgg8YnFILMsneAhqfwSSbudgzgzrwHW+7nlU/esr2nWlx4f/b0nQqRpJKXCVrfzC14
	 UfWx/G2F+nSWA==
Date: Thu, 25 Jun 2026 17:00:21 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, 
	stable@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Eric Sandeen <sandeen@redhat.com>, 
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] xfs: fix capabily check in xfs_setattr_nonsize
Message-ID: <aj1CdKwE3A40vQhQ@nidhogg.toxiclabs.cc>
References: <20260624101436.362533-1-cem@kernel.org>
 <20260624134039.GB5649@lst.de>
 <qcsdbdpp23fsu3cqhpjdpwusvl6onc2knnrun522ofrutxpz6j@reh3k2ofqjir>
 <20260625123754.GA19947@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625123754.GA19947@lst.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268583-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:jack@suse.cz,m:linux-xfs@vger.kernel.org,m:stable@vger.kernel.org,m:djwong@kernel.org,m:david@fromorbit.com,m:sandeen@redhat.com,m:thomas.orgis@uni-hamburg.de,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[stable@vger.kernel.org:query timed out];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 252E36C6E43

On Thu, Jun 25, 2026 at 02:37:54PM +0200, Christoph Hellwig wrote:
> On Thu, Jun 25, 2026 at 12:43:54PM +0200, Jan Kara wrote:
> > On Wed 24-06-26 15:40:39, Christoph Hellwig wrote:
> > > Adding Jan and Christian for quota and user_ns knowledge.
> > > 
> > > On Wed, Jun 24, 2026 at 12:14:29PM +0200, cem@kernel.org wrote:
> > > > From: Carlos Maiolino <cem@kernel.org>
> > > > 
> > > > An user reported a bug where he managed to evade group's quota
> > > > by changing a file's gid to a different group id the same user
> > > > belonged to, even though quotas were enforced on both gids and the
> > > > file's size was big enough to exceed the quota's hardlimit.
> > > > 
> > > > Commit eba0549bc7d1 replaced a capable() call by a
> > > > has_capability_noaudit() to prevent unnecessary selinux audit messages.
> > > > Turns out that both calls have slightly different semantics even though
> > > > their documentation seems similar. Where in a nutshell:
> > > > 
> > > > capable() - Tests the task's effective credentials
> > > > has_ns_capability_noaudit() - Tests the task's real credentials
> > > 
> > > Eww..
> > 
> > Yeah, that's a catch.
> > 
> > > > This most of the time has no practical difference but in some cases like
> > > > changing attrs (specifically group id in this case) through a NFS client
> > > > this will allow the quota code to use XFS_QMOPT_FORCE_RES, effectively
> > > > bypassing quota accounting checks.
> > > 
> > > Yeah, this does look wrong.  Do the other conversion in the above commit
> > > have tthe same issue?
> > > 
> > > > Using instead ns_capable_noaudit() should fix this issue and prevent
> > > > selinux audit messages.
> > > 
> > > The generic quota code manages to do without either has_capability_noaudit
> > > or ns_capable_noaudit.  I think this might be hidden behind
> > > inode_owner_or_capable calls.  Any idea why we're different?
> > 
> > Actually no. Generic quota code has equivalent checks in ignore_hardlimit()
> > function which does capable(CAP_SYS_RESOURCE) check. I guess the reason why
> > nobody complained about generic quota code is that we call
> > ignore_hardlimit() only if we are above hardlimit whereas XFS calls this
> > for every transaction...
> 
> I guess we should aim for the same to avoid the spurious audit logs.
> 
> I.e. xfs_trans_alloc_ichange is currently always called either with
> force = true or force = this capable check.  So as a first step we can
> move the check into xfs_trans_alloc_ichange for the !force case, and the
> propagate that through XFS_QMOPT_FORCE_RES into xfs_trans_dqresv, i.e.
> only set XFS_QMOPT_FORCE_RES for the real forced case and instead
> have the capable check down in xfs_trans_dqresv.
> 

Sounds fair, I'll give it a try tomorrow.

