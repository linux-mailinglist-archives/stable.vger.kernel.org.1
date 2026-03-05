Return-Path: <stable+bounces-223190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HbAEdxdqWkL6AAAu9opvQ
	(envelope-from <stable+bounces-223190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 11:41:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 043DC20FD5C
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 11:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 465483058444
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05C4382F12;
	Thu,  5 Mar 2026 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS8F24UG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC84382372;
	Thu,  5 Mar 2026 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707250; cv=none; b=JpgaVsfHVukAvvTQHdHq69WIfRFXbnPPWdPJrTSWhAOY7L1o4Y+K3XVNhFyvV3ModocDYyfvBh94CA5ti8EmQJhj12+g8y2Y0uTckSmgfPRVGBtO3ntVd5DXpK0LNCfTORCyIlA+/FC2OmzI6J1VDYW2a8oqqXSuy1gYR0g9Uqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707250; c=relaxed/simple;
	bh=hzsXfB7P4G4WYEx5Pd6UFeqyQ4kF1hTUa0Oig7JuPJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3RSgFDFnMb1ZManBwBx5JIN5c0bUitFV12wldrtCQJhr6pAGelh8KN5YEuGr27iUVAoGWZjyaiO+w052RFKsk9LVjDpWiQW4QGw9DSrUrIOUzBeStWFlNvKI3/VVfXi2Gpz3TojeTnhOmdE25v1NCu6EaA1xrd6X5O9QVW6ztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS8F24UG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512DCC116C6;
	Thu,  5 Mar 2026 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707249;
	bh=hzsXfB7P4G4WYEx5Pd6UFeqyQ4kF1hTUa0Oig7JuPJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bS8F24UGoMYUpzPfK1fUha1+8KSwCsJbE/giONrlagbGSkGnxK9uKeTPe88Eo53y2
	 ow4KoAS9aQh/Su1iSrZt7SWqb5d8lnmbbEfFnuDFslh2qpW71wBmO8EHeQEQET96g3
	 TcB1VEhbQ+EZgJ1Ce5QKqRo1Ooa8kQzWPk7HL9DG6GVNBZ5lJjemln6xdYK9m+Cy9p
	 Gvj+PC+KKmV7FJD7l43xImictWudPeRr3kXAzNScaK8nuKWcmMu9eR3ieXy/O8bHku
	 7wH06EXBPDa5fQzbYmllVLPeFSdW+2oRnPBQ1pyGQNPt26PgAaBErN+HKdbZB7cwOF
	 JtiRDhXsdbnWQ==
Date: Thu, 5 Mar 2026 12:40:43 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memfd_luo: always dirty all folios
Message-ID: <aaldqxw90rdwCt6p@kernel.org>
References: <20260223173931.2221759-1-pratyush@kernel.org>
 <20260223173931.2221759-3-pratyush@kernel.org>
 <aZ65uvOrTDndpic6@kernel.org>
 <2vxzv7fabr84.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzv7fabr84.fsf@kernel.org>
X-Rspamd-Queue-Id: 043DC20FD5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223190-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:44:27AM +0100, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Wed, Feb 25 2026, Mike Rapoport wrote:
> 
> > On Mon, Feb 23, 2026 at 06:39:29PM +0100, Pratyush Yadav wrote:
> [...]
> >> -		if (folio_test_dirty(folio))
> >> -			flags |= MEMFD_LUO_FOLIO_DIRTY;
> >> +		/*
> >> +		 * A dirty folio is one which has been written to. A clean folio
> >> +		 * is its opposite. Since a clean folio does not carry user
> >> +		 * data, it can be freed by page reclaim under memory pressure.
> >> +		 *
> >> +		 * Saving the dirty flag at prepare() time doesn't work since it
> >> +		 * can change later. Saving it at freeze() also won't work
> >> +		 * because the dirty bit is normally synced at unmap and there
> >> +		 * might still be a mapping of the file at freeze().
> >> +		 *
> >> +		 * To see why this is a problem, say a folio is clean at
> >> +		 * preserve, but gets dirtied later. The pfolio flags will mark
> >> +		 * it as clean. After retrieve, the next kernel might try to
> >> +		 * reclaim this folio under memory pressure, losing user data.
> >> +		 *
> >> +		 * Unconditionally mark it dirty to avoid this problem. This
> >> +		 * comes at the cost of making clean folios un-reclaimable after
> >> +		 * live update.
> >> +		 */
> >
> > Can we make the comment here shorter to only contain the gist of the issue?
> 
> Is this any better? Or should I try to make it shorter still?

Yep, thanks! :)

I don't think it can be made shorter without loosing information. What we
might do is to add a larger comment in what state we preserve folios on top
of memfd_luo_preserve_folios() and leave the code inside the function
alone. Can't say I have strong feelings about it.
 
> 	/*
> 	 * Tracking the dirty flag of the folio is difficult since it is
> 	 * normally synced at unmap and there might still be mappings of
> 	 * the file alive.
> 	 *
> 	 * Not tracking it correctly can cause a dirty folio to be
> 	 * restored as clean after KHO. The next kernel might then try
> 	 * to reclaim it, losing user data.
> 	 *
> 	 * Unconditionally mark the folio dirty to avoid this. This
> 	 * comes at the cost of making clean folios un-reclaimable.
> 	 */
> 
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

