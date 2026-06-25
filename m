Return-Path: <stable+bounces-268310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DpE0KBfsPGrOuQgAu9opvQ
	(envelope-from <stable+bounces-268310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:51:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E50E6C3F80
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:51:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ElZBykRK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268310-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268310-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 538D13022DCA
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EBB385D99;
	Thu, 25 Jun 2026 08:50:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A07938655C
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 08:50:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377456; cv=none; b=NHyqRFUNzJLboHoEw+E7afuph3Gpu3hTruZUau7fd78M0yO0jE5IGeSQapZMUKlkL4l3yb67swbqS1ZIKOirLcKGITiq6Mt9FkWrYnRB7N8NCSkLcJ+3Q/6yGmbElcHl1JUy67X7/T3p1ZOOyd37sS34l9083UJeIVQ3NiQq2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377456; c=relaxed/simple;
	bh=eAUE4cHxHPrECI9jHnsBEOHWjcdZZQoBblRYb2Tehs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJshN/Ote59DM/SRHCJZhVkSEXrdF0sqHXuk2s2/yTDWCP5vt1+Cc27iIlOy5dEGzf+Dom/7mfniFmjATnXbhIZnVcrqrFIFb8DEG5wxr4nAovKh4npAxTt2KHYxb2ASgwY5AGBKv4IUCD62paMGgMtWDWZO8/UWZl16Ft6UQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElZBykRK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343A21F000E9;
	Thu, 25 Jun 2026 08:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782377455;
	bh=94j9tcH3gHmgqgGGvo6s8vTq5w3oHDWpmmtffj7Lr/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ElZBykRKpnvAKp8ZpTdCQ5/E8HvExus66+R6Tx1kILNRrlqkzWC7m0Yul3nArpEAD
	 Q/1HB8S2T2juGjR53x0A/0VtMbZ63cDvKch3NMj+PALadhSfCAXyA3Df5Op4oAt/jI
	 3Jkrc9BEBd6+edUqKT8UHd8TuEFmOf+Y+i6h7bs0MDPI22AveLGmK8b+tr31CUiyFP
	 vQDpBRxltp9BW5DLMC6pRP+wEs3oGoGWhTSf7UW96I0xBL3hINlLN9zeo6n/sVFxnG
	 eMJJh8Z+JOTRvqe7PvBg8ow0WoZaZVboKdNZjos39hG8Mnk059SgZ2t0878rRk0BSF
	 LrWU5s1+rGyIA==
Date: Thu, 25 Jun 2026 10:50:50 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, 
	Martin Hodo <martin.hodo@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Return NULL on error in active_instanceg
Message-ID: <ajznzdwvxSv2YNHp@zenone.zhora.eu>
References: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com>
 <178230031953.112641.4817434529385736057@jlahtine-mobl>
 <ajvTjodx7LLj_BPO@zenone.zhora.eu>
 <178236741262.19845.6184407491878204182@jlahtine-mobl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178236741262.19845.6184407491878204182@jlahtine-mobl>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268310-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:joonas.lahtinen@linux.intel.com,m:intel-gfx@lists.freedesktop.org,m:martin.hodo@intel.com,m:maarten.lankhorst@linux.intel.com,m:thomas.hellstrom@linux.intel.com,m:simona.vetter@ffwll.ch,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,zenone.zhora.eu:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E50E6C3F80

Hi Joonas,

On Thu, Jun 25, 2026 at 09:03:32AM +0300, Joonas Lahtinen wrote:
> Quoting Andi Shyti (2026-06-24 15:59:30)
> > On Wed, Jun 24, 2026 at 02:25:19PM +0300, Joonas Lahtinen wrote:
> > > Pushed to drm-intel-gt-next, thanks for the reviews.
> > 
> > please, next time:
> > 
> > - Give people more time to review the patch. Only two hours
> >   passed between posting it and pushing it
> 
> And why exactly is that a problem? I got the review from the original
> patch author and a yet another person on top while it's a very
> uncontroversial and trivial patch. Two reviewers per patch is already
> quite a high bar to clear if you look at git history.
> 
> > (during lunch time, BTW).
> 
> Sorry, I did not know there is a universally agreed 2 hour lunch window
> in UTC timezone that I should follow. I've missed that memo.

It's not a matter of how many reviewers there are or how
controversial a patch may be. A patch needs to stay on the list
long enough for the whole community to have a chance to review
it. Give it one or two days.

Even if you and the other reviewers don't see anything wrong,
someone else might. As submitters and maintainers, we need to
give people a reasonable amount of time to look at every patch.
Two hours, at any time of the day, are definitely not enough.

We often complain when people send new revisions too early for
exactly the same reason.

> > - There were BAT failures. They were unrelated, but so far we
> >   have generally held back patches until BAT was green, even for
> >   the most obvious changes.
> 
> Strong disagree here. That'd have caused the patch to miss -next-fixes
> PR just due to random noise of CI.

We shouldn't care. The rules are the same for everyone, including
maintainers. Very often I've been told to wait until the next
cycle and very often I've asked others to do the same.

Besides, it's unfair to keep a patch on the list for only two
hours just to avoid missing the current cycle, while everyone
else is expected to wait.

> If there was a reasonable doubt about the impact of the patch on the
> failure, that'd of course be different, but here there was absolutely
> none in this case.
> 
> As per patchwork automated mail reply:
> 
> > If you think the reported changes have nothing to do with the changes
> > introduced in Patchwork_169089v1, please notify your bug team

The bug team is a different matter. Here we're talking about the
review process.

> That's exactly what was done here. That's a fair ask, but asking for
> maintainers not to merge any code because of false positives is simply
> not.

False positive or not, controversial or not, easy or difficult,
patches have *always* been blocked when BAT was red. The shard
tests don't even start if BAT is red.

Otherwise, we might as well stop running automatic tests for
patches considered "non-controversial" and save CI resources.

Andi

> Regards, Joonas
> 
> > 
> > Thanks,
> > Andi

