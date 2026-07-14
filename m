Return-Path: <stable+bounces-274127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q9AUMVnHVWposwAAu9opvQ
	(envelope-from <stable+bounces-274127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 07:21:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D37751164
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 07:21:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274127-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274127-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BF993027B51
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825E314B8F;
	Tue, 14 Jul 2026 05:20:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC15B314D13;
	Tue, 14 Jul 2026 05:20:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006416; cv=none; b=u/yTG/SFhtZThHBqjEhJEy7Ca80jZTS9TEvgGjUpJ/itQBvcZpUOSzPV5tZqrCVWml2Bq6exnEvgyofhF9xA5XACBW8V3f3aK3RSksqehHKnxuNSqiZT/leg4Vne5Ql0Qa+1mQ4tD5zLgIk8FfXK2X8rCiixhDc4qtOkGSCHHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006416; c=relaxed/simple;
	bh=MitakgT13Ss/MpEJIxEJ1E/XKAuOsJV6Ppty4ExJX/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvJKvvdeHyg5hxk5bIiVTE/9vxFn1Gekahf9ZakdcyuXh8EkjwOpeIAYFMvNkGtxmDGRJ5w0oUtc4RY7uLL7VoXx724jQT0JwdVa5XRGzZttJUcRO/17WpouCE+KRgOz+ML0vuXERZlvX8cylvgQH5IHtYENLx83GylNoDWkY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 41EB868BFE; Tue, 14 Jul 2026 07:20:12 +0200 (CEST)
Date: Tue, 14 Jul 2026 07:20:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, cem@kernel.org, stable@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/6] xfs: write the rg superblock when fixing it
Message-ID: <20260714052011.GA31796@lst.de>
References: <178346726054.1271589.14164163317011378817.stgit@frogsfrogsfrogs> <178346726193.1271589.8429966417697809477.stgit@frogsfrogsfrogs> <20260713064105.GA29416@lst.de> <20260713215857.GG7195@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713215857.GG7195@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:hch@lst.de,m:cem@kernel.org,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274127-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lst.de:from_mime,lst.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47D37751164

On Mon, Jul 13, 2026 at 02:58:57PM -0700, Darrick J. Wong wrote:
> Hrmm.  Right now both superblock scrubbers don't do much for group 0,
> because both buffers are pinned to the xfs_mount, so they assume that
> there's no need to check anything.  However, the ondisk super could have
> gotten corrupted (or blown away by fdisk), in which case an immediate
> crash could render the filesystem unmountable.
> 
> So, I could (a) teach the super scrubbers to read the primary / rt
> super; and (b) teach them both to log the superblock and bwrite it
> immediately to shorten the window in which this could happen.
> 
> What do you think?

I guess the only sensible time to scrub the sb would be early during
mount? 

> Also, this patch should be calling xfs_log_sb *after* xfs_trans_getsb,
> so I'll fix that for the repost.

Oops.


