Return-Path: <stable+bounces-268343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kcMnMP8GPWoYwAgAu9opvQ
	(envelope-from <stable+bounces-268343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:46:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C27C56C4CC5
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:46:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v5+HoMHQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nCoydn7r;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v5+HoMHQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nCoydn7r;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268343-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268343-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E6BD3015619
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB103D45FA;
	Thu, 25 Jun 2026 10:44:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E793CF699
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:44:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384246; cv=none; b=gUNacl2JKSbu0yD1709AEmSEMXZxmSgq9mSa95hHogbY/OUb8eiNEISaDTTarW5400u18gD66DqQTJ2CMmwKxZHQEMQkJNBklg9ZapUbkkGXdP9srBjpi8NIXwOXUdImChds/iC0fgDeaPT3ERV73Yuj1BZez5f56bAchP/4Bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384246; c=relaxed/simple;
	bh=tnZeXJHehJ+A52w8B4DoKvRqhsJXdVGIORGG61VkSbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXzVk8a+3y8BvMUy4zjg22xoU9su4ko/A0DKRw2e6eT5bR/FFtT/n6JpuHzVRqGSP/PXuy5Vs666Upn/l4tYYaVEP83mGg39kwocPSA74lBMFDJmYEbpnQY0rah7jVGiKytYJ7kdpQP8l3bEAZpyyCAM62il0rd248uJoFQY4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5+HoMHQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nCoydn7r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5+HoMHQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nCoydn7r; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF6DE7182E;
	Thu, 25 Jun 2026 10:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782384242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIWR4ZG0IOd3ZVwv89DuimxILHVqAiCjPspcDkVjjIw=;
	b=v5+HoMHQ5jcnGevca330BQxWuIIdlcDtwmqY5Feml7DY2Cxf5n1sOjj1OD2xCuSPxrQQWi
	5CsL0ff7t080cF0ZIe+qmg0GFoK+H4FzRb2spRNdDDiJZFLbNtKPTJcsBq+WlJhTrjGUg9
	eLnf4fyNX3TfVGhl0oGEQMEB7vlkjew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782384242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIWR4ZG0IOd3ZVwv89DuimxILHVqAiCjPspcDkVjjIw=;
	b=nCoydn7rOmPosCH95uNSfw1ePXmT3IcMznMe0Hl1f8krkwclFbaX2A4HM9JFVv2TqqgNgS
	T7wVG9hEFL0W68Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782384242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIWR4ZG0IOd3ZVwv89DuimxILHVqAiCjPspcDkVjjIw=;
	b=v5+HoMHQ5jcnGevca330BQxWuIIdlcDtwmqY5Feml7DY2Cxf5n1sOjj1OD2xCuSPxrQQWi
	5CsL0ff7t080cF0ZIe+qmg0GFoK+H4FzRb2spRNdDDiJZFLbNtKPTJcsBq+WlJhTrjGUg9
	eLnf4fyNX3TfVGhl0oGEQMEB7vlkjew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782384242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIWR4ZG0IOd3ZVwv89DuimxILHVqAiCjPspcDkVjjIw=;
	b=nCoydn7rOmPosCH95uNSfw1ePXmT3IcMznMe0Hl1f8krkwclFbaX2A4HM9JFVv2TqqgNgS
	T7wVG9hEFL0W68Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3029779A8;
	Thu, 25 Jun 2026 10:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YtV7M3IGPWpXPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jun 2026 10:44:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7A40DA10A3; Thu, 25 Jun 2026 12:43:54 +0200 (CEST)
Date: Thu, 25 Jun 2026 12:43:54 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, stable@vger.kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
	Eric Sandeen <sandeen@redhat.com>, "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] xfs: fix capabily check in xfs_setattr_nonsize
Message-ID: <qcsdbdpp23fsu3cqhpjdpwusvl6onc2knnrun522ofrutxpz6j@reh3k2ofqjir>
References: <20260624101436.362533-1-cem@kernel.org>
 <20260624134039.GB5649@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624134039.GB5649@lst.de>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268343-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:stable@vger.kernel.org,m:djwong@kernel.org,m:david@fromorbit.com,m:sandeen@redhat.com,m:thomas.orgis@uni-hamburg.de,m:jack@suse.cz,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:from_mime,vger.kernel.org:from_smtp,suse.com:email,reh3k2ofqjir:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C27C56C4CC5

On Wed 24-06-26 15:40:39, Christoph Hellwig wrote:
> Adding Jan and Christian for quota and user_ns knowledge.
> 
> On Wed, Jun 24, 2026 at 12:14:29PM +0200, cem@kernel.org wrote:
> > From: Carlos Maiolino <cem@kernel.org>
> > 
> > An user reported a bug where he managed to evade group's quota
> > by changing a file's gid to a different group id the same user
> > belonged to, even though quotas were enforced on both gids and the
> > file's size was big enough to exceed the quota's hardlimit.
> > 
> > Commit eba0549bc7d1 replaced a capable() call by a
> > has_capability_noaudit() to prevent unnecessary selinux audit messages.
> > Turns out that both calls have slightly different semantics even though
> > their documentation seems similar. Where in a nutshell:
> > 
> > capable() - Tests the task's effective credentials
> > has_ns_capability_noaudit() - Tests the task's real credentials
> 
> Eww..

Yeah, that's a catch.

> > This most of the time has no practical difference but in some cases like
> > changing attrs (specifically group id in this case) through a NFS client
> > this will allow the quota code to use XFS_QMOPT_FORCE_RES, effectively
> > bypassing quota accounting checks.
> 
> Yeah, this does look wrong.  Do the other conversion in the above commit
> have tthe same issue?
> 
> > Using instead ns_capable_noaudit() should fix this issue and prevent
> > selinux audit messages.
> 
> The generic quota code manages to do without either has_capability_noaudit
> or ns_capable_noaudit.  I think this might be hidden behind
> inode_owner_or_capable calls.  Any idea why we're different?

Actually no. Generic quota code has equivalent checks in ignore_hardlimit()
function which does capable(CAP_SYS_RESOURCE) check. I guess the reason why
nobody complained about generic quota code is that we call
ignore_hardlimit() only if we are above hardlimit whereas XFS calls this
for every transaction...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

