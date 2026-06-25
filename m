Return-Path: <stable+bounces-268608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 91SSCo9RPWrz1AgAu9opvQ
	(envelope-from <stable+bounces-268608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 18:04:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 973166C747D
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 18:04:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eh7r+dl5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268608-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268608-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27A1F301D947
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AD83B531A;
	Thu, 25 Jun 2026 16:03:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F823B47DD;
	Thu, 25 Jun 2026 16:03:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403400; cv=none; b=saq0gfdjuClQdZHSVIXxaxz3cyRgt9cCqmHzi7UV5TYB/dfiEjI0kMD9QiVPtBVRadq1PJu1X071Hg0gahmuB+uqsapWBkzxHtD38ysFUaaylPSN1NKOiTAg9oAVKSQkCSpkOD19MxXkgZl7HyS5yv3Zu23SxSE/I5WFWaIzllM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403400; c=relaxed/simple;
	bh=7bKoxFM7KIOZ8oc/Q47QcvjrAFswlZcecxV75ra08vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfXq7QJ4F9hCYWtW3TuUbNN9RdheO/u12Q8kf06H/b86BT14wPVnPyvkeKK6ja67MvB46IFkRj4yULSjGvfCDHH85TbO98iukc5YBjAs7/OLXiILGHdeH/YqA8t35FVmZqs4uP/Wk8qz5Y9cZpGs0Z7zqnS/f0fLp9WJQDpKxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh7r+dl5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D838E1F000E9;
	Thu, 25 Jun 2026 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782403397;
	bh=keGsTG6PzRLpDRyGU6n06RqldyGUbJfHiuRsazLhSQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eh7r+dl5/FXG6ihuw6LEBQjpMJrMq5hkgURRWMfeq3pnk7K4AlEW5Ra5Gb0pY7h+z
	 JYKHp11flSpRSS0O0Qv4V57geJ2LwlvGXZD4RajjSxpiBVHpwGFzkVKPZFGsECHYxZ
	 H6Js9ytE1f/MWsYl9EvZqOH1yYowhbXSOnAENVebqIfhK64GOwnkM/RQWxBAH2mo+x
	 93XRUgIl1bZChegrJN4no1TVLZLdEhRlP7QcqVhWlJqzUvVdI1cB/FFmOZ7IjBIpCE
	 4n35yoVy1Jxca4ocCyp5KzLqsu5HpHDH75/KLTs4YEwpLyvomrQf51cE17B7TSlag6
	 77hYGon+G2/pw==
Date: Thu, 25 Jun 2026 09:03:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Carlos Maiolino <cem@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	linux-xfs@vger.kernel.org, stable@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Eric Sandeen <sandeen@redhat.com>,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] xfs: fix capabily check in xfs_setattr_nonsize
Message-ID: <20260625160317.GY6078@frogsfrogsfrogs>
References: <20260624101436.362533-1-cem@kernel.org>
 <20260624134039.GB5649@lst.de>
 <qcsdbdpp23fsu3cqhpjdpwusvl6onc2knnrun522ofrutxpz6j@reh3k2ofqjir>
 <20260625123754.GA19947@lst.de>
 <aj1CdKwE3A40vQhQ@nidhogg.toxiclabs.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj1CdKwE3A40vQhQ@nidhogg.toxiclabs.cc>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-268608-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cem@kernel.org,m:hch@lst.de,m:jack@suse.cz,m:linux-xfs@vger.kernel.org,m:stable@vger.kernel.org,m:david@fromorbit.com,m:sandeen@redhat.com,m:thomas.orgis@uni-hamburg.de,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 973166C747D

On Thu, Jun 25, 2026 at 05:00:21PM +0200, Carlos Maiolino wrote:
> On Thu, Jun 25, 2026 at 02:37:54PM +0200, Christoph Hellwig wrote:
> > On Thu, Jun 25, 2026 at 12:43:54PM +0200, Jan Kara wrote:
> > > On Wed 24-06-26 15:40:39, Christoph Hellwig wrote:
> > > > Adding Jan and Christian for quota and user_ns knowledge.
> > > > 
> > > > On Wed, Jun 24, 2026 at 12:14:29PM +0200, cem@kernel.org wrote:
> > > > > From: Carlos Maiolino <cem@kernel.org>
> > > > > 
> > > > > An user reported a bug where he managed to evade group's quota
> > > > > by changing a file's gid to a different group id the same user
> > > > > belonged to, even though quotas were enforced on both gids and the
> > > > > file's size was big enough to exceed the quota's hardlimit.
> > > > > 
> > > > > Commit eba0549bc7d1 replaced a capable() call by a
> > > > > has_capability_noaudit() to prevent unnecessary selinux audit messages.
> > > > > Turns out that both calls have slightly different semantics even though
> > > > > their documentation seems similar. Where in a nutshell:
> > > > > 
> > > > > capable() - Tests the task's effective credentials
> > > > > has_ns_capability_noaudit() - Tests the task's real credentials
> > > > 
> > > > Eww..
> > > 
> > > Yeah, that's a catch.

I spent a while trying to figure out how I went wrong in selecting the
function name:

 * capable - Determine if the current task has a superior capability in effect
 * @cap: The capability to be tested for
 *
 * Return true if the current task has the given superior capability currently
 * available for use, false if not.

vs.

 * has_capability_noaudit - Does a task have a capability (unaudited) in the
 * initial user ns
 * @t: The task in question
 * @cap: The capability to be tested for
 *
 * Return true if the specified task has the given superior capability
 * currently in effect to init_user_ns, false if not.  Don't write an
 * audit message for the check.

vs.

 * ns_capable_noaudit - Determine if the current task has a superior capability
 * (unaudited) in effect
 * @ns:  The usernamespace we want the capability in
 * @cap: The capability to be tested for
 *
 * Return true if the current task has the given superior capability currently
 * available for use, false if not.

All three of these sound the same to me.  But what about the call path?

capable -> ns_capable -> ns_capable_common

has_capability_noaudit -> has_ns_capability_noaudit

ns_capable_noaudit -> ns_capable_common

Hum, maybe that's the difference -- ns_capable_common vs.
has_ns_capability_noaudit?

ns_capable_common calls security_capable() with current_cred(), whereas
has_ns_capability_noaudit calls it with __task_cred(t), which is
@current in the xfs_trans_alloc_ichange case.

Aha!  current_cred is current->cred, whereas __task_cred(current) is
current->real_cred, and these aren't the same thing:

	/* Objective and real subjective task credentials (COW): */
	const struct cred __rcu		*real_cred;

	/* Effective (overridable) subjective task credentials (COW): */
	const struct cred __rcu		*cred;

So I guess ns_capable_common (and wrappers) are testing the process'
effective credentials, whereas has_ns_capability_noaudit is testing the
process' real credentials?

It would have been *really* nice if the documentation for those
functions mentioned that distinction!

> > > > > This most of the time has no practical difference but in some cases like
> > > > > changing attrs (specifically group id in this case) through a NFS client
> > > > > this will allow the quota code to use XFS_QMOPT_FORCE_RES, effectively
> > > > > bypassing quota accounting checks.
> > > > 
> > > > Yeah, this does look wrong.  Do the other conversion in the above commit
> > > > have tthe same issue?
> > > > 
> > > > > Using instead ns_capable_noaudit() should fix this issue and prevent
> > > > > selinux audit messages.
> > > > 
> > > > The generic quota code manages to do without either has_capability_noaudit
> > > > or ns_capable_noaudit.  I think this might be hidden behind
> > > > inode_owner_or_capable calls.  Any idea why we're different?
> > > 
> > > Actually no. Generic quota code has equivalent checks in ignore_hardlimit()
> > > function which does capable(CAP_SYS_RESOURCE) check. I guess the reason why
> > > nobody complained about generic quota code is that we call
> > > ignore_hardlimit() only if we are above hardlimit whereas XFS calls this
> > > for every transaction...
> > 
> > I guess we should aim for the same to avoid the spurious audit logs.
> > 
> > I.e. xfs_trans_alloc_ichange is currently always called either with
> > force = true or force = this capable check.  So as a first step we can
> > move the check into xfs_trans_alloc_ichange for the !force case, and the
> > propagate that through XFS_QMOPT_FORCE_RES into xfs_trans_dqresv, i.e.
> > only set XFS_QMOPT_FORCE_RES for the real forced case and instead
> > have the capable check down in xfs_trans_dqresv.
> > 
> 
> Sounds fair, I'll give it a try tomorrow.

So yeah, I agree we should change that to:

	ns_capable_noaudit(&init_user_ns, CAP_FOWNER)

Though it's also weird that XFS gates it on CAP_FOWNER whereas the VFS
checks CAP_SYS_RESOURCE.  Though I would have added this:

static inline bool
current_may_ignore_quota_limits(void)
{
	/*
	 * If the current process' effective credentials include
	 * CAP_FOWNER, then they're allowed to ignore the hard limit.
	 */
	return ns_capable_noaudit(&init_user_ns, CAP_FOWNER);
}

and then changed the callsites in xfs_ioctl/xfs_iops.c to:

	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
			current_may_ignore_quota_limits(), &tp);

The has_capability_noaudit call in xfs_fsmap.c should change to
ns_capable_noaudit.

--D

