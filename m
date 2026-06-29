Return-Path: <stable+bounces-269750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9m2ABWVtQmq66wkAu9opvQ
	(envelope-from <stable+bounces-269750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:04:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 769616DAB81
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:04:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269750-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269750-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D439338DDE9
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF48F403AE1;
	Mon, 29 Jun 2026 12:44:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ABD36EAA7;
	Mon, 29 Jun 2026 12:44:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737041; cv=none; b=KMX8h0vrdESgW39jsuLntvbc8EXyybdUt/6D2gA6SC1KV21nGf0XihX3gO3q5a+hrdouMU8T8O3RjKZSlZ8hYB2VK5NY6dQZNbOZTWgi+Xv5GrT34n2s12tNphlr9howTqupjvA4hNyq3G60N9wsop5np6KRup4Micm/ezF9xP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737041; c=relaxed/simple;
	bh=6r09yQz7NUq/4qBAtZQdA2gBPKnNaBl9hAWZRPWwwKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHv35wXCEb9IhDRylECuCWQBVQ1jsvnWj7OjMT8c0bKYjxFcVntJuz5nQLOD3KMCx/xP/Ba6yjiUQznKnuMAc5R4XxzoYzfEE2plVkPwVkVs+E1bCDrsw/WAJ/PeDtLpvtM7PRoyZtJ8GCteStBQrSlIJMo0utqtqU8Y/Qz2ydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C67368B05; Mon, 29 Jun 2026 14:43:57 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:43:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Yingjie Gao <gaoyingjie@uniontech.com>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] xfs: retry dqpurge when dquot buffer is busy
Message-ID: <20260629124356.GA22595@lst.de>
References: <20260626095253.3445540-1-gaoyingjie@uniontech.com> <20260626205257.GA6078@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626205257.GA6078@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269750-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:gaoyingjie@uniontech.com,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:hch@lst.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lst.de:mid,lst.de:from_mime,uniontech.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 769616DAB81

On Fri, Jun 26, 2026 at 01:52:57PM -0700, Darrick J. Wong wrote:
> On Fri, Jun 26, 2026 at 05:52:53PM +0800, Yingjie Gao wrote:
> > xfs_qm_dqpurge() marks a zero-reference dquot dead before trying to flush
> > a dirty dquot. If the attached buffer is busy, xfs_dquot_use_attached_buf()
> > returns -EAGAIN.
> > 
> > The error path restores q_lockref.count but then jumps to out_funlock,
> > which continues into the successful purge tail and destroys the dquot.  At
> > that point the attached buffer has not been detached and the dquot log item
> > may still be in the AIL.
> > 
> > Restore the retry behavior by dropping the locks and returning -EAGAIN
> > after resurrecting the lockref.
> > 
> > Link: https://lore.kernel.org/linux-xfs/20260625175519.GF6078@frogsfrogsfrogs/
> > Fixes: 0c5e80bd579f ("xfs: use a lockref for the xfs_dquot reference count")
> > Cc: stable@vger.kernel.org # v6.19+
> > Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>
> 
> Yeah, that's more like what we did before 0c5e80bd579f.  I think the
> lockref resurrection part still looks ok, but maybe hch has an opinion?

But is it the right thing?  In dqpurge we really want to kill of the
dquot, so doing a trylock is not very useful, so we really should not
do a trylock here but just lock the buffer.

Darrick, do you remember if there's any lock order inversions we need
to care about here?


