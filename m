Return-Path: <stable+bounces-267481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ToSaMg9xNmoT/wYAu9opvQ
	(envelope-from <stable+bounces-267481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 12:53:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 667406A8C13
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 12:53:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DolmHIfd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267481-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267481-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C00730247E2
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792BB35AC0C;
	Sat, 20 Jun 2026 10:52:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF454652;
	Sat, 20 Jun 2026 10:52:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781952776; cv=none; b=JHtXSzSgMAgiYxYoeEk3QCmnJiTsA3Wte6r2dq6OLeEctXNbiTczbgSUYW/vH3IVI6c6yiL/KUTbgTucxEUjkWjqcV1IRDxW5eX8o00kVSELF1OvOjSC9QWP0wpJyomwRY7kfgjEDvCdpGWGYw3cjwyqK9D0tJeCTCKNvi6hrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781952776; c=relaxed/simple;
	bh=IbBYGL43vffLym9eGkLNv5YvbFU2CcdCcjmhU5Vb/Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSgQcOIVWrJ5mRrX6OFdquCe2SDBxWXqpXVljfLtZV9OnS72KkBxzCfEjIzQF/HVOZivnw9fnlTVv4k2G7ST/6iZ8Qvhq86rRD9IDNE5XW+hEKrIMXz+j6EW+TDSsvGwwF6P9xw5fJ/e87Ex2bEwvSswJRjn8bj+6HLIAU9tvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DolmHIfd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366771F000E9;
	Sat, 20 Jun 2026 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781952774;
	bh=QqVMlYefT1f4jQExsz4UHA36TXsIUoeNm2/RP0v03pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DolmHIfdJk05rN4igrFSy2iSed99+SGMcDm8Vhs92neADbUJeKVe8uSYlnS9Qdvqt
	 8aEr67J8wshT3h2Zdvo1ev/tsndQkcK8Kud9u3XRAhmCrvfm0TBKJTmrGeyOmpp3Mw
	 0RRoVv4MTWO7sVevhviPpCwGMfZzLBaBWZlu6IeA=
Date: Sat, 20 Jun 2026 12:51:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bernard Pidoux <bernard.f6bvp@gmail.com>
Cc: kuba@kernel.org, stable@vger.kernel.org, linux-hams@vger.kernel.org
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier
 (merged out-of-tree in linux-netdev/mod-orphan)
Message-ID: <2026062051-doorframe-crayon-d390@gregkh>
References: <CAFAa3YBfk2UOjAktrLq3_9+563m6UZuKv9XdBjfp2aB1twV1HQ@mail.gmail.com>
 <2026061625-starless-mascot-691a@gregkh>
 <CAFAa3YBciYSJxDT-SH=4oppyBS3hWUSEwJP_86EgUriJfYkjLw@mail.gmail.com>
 <2026062048-posted-scarf-dcf2@gregkh>
 <CAFAa3YAEDsnqcN6UqUE-4X+y0t7RPmNtwdb0LxExryZmAKU9pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFAa3YAEDsnqcN6UqUE-4X+y0t7RPmNtwdb0LxExryZmAKU9pw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267481-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bernard.f6bvp@gmail.com,m:kuba@kernel.org,m:stable@vger.kernel.org,m:linux-hams@vger.kernel.org,m:bernardf6bvp@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 667406A8C13

On Sat, Jun 20, 2026 at 12:37:16PM +0200, Bernard Pidoux wrote:
> Hi Greg, all,
> 
> Sorry about that -- my mail client dropped the list and Jakub from the
> recipients on the previous message; I did not intend to take it off-list.
> Resending the same note to everyone, with the mbox attached again.
> 
> I have prepared a first set, attached as an mbox: 15 ROSE fixes for the
> 7.0.y stable tree (7.0.y is the last stable line that still ships ROSE,
> since it was removed in 7.1). They are the use-after-free, refcount and
> teardown-race fixes I developed and merged in the linux-netdev/mod-orphan
> tree, where ROSE now lives.
> 
> As Greg asked, every patch carries a
> 
> (cherry picked from commit <id>)
> 
> trailer pointing at the exact git id in mod-orphan it was taken from, so
> they can be tracked across releases.
> 
> The whole series applies cleanly with "git am" on top of v7.0.13 (no
> conflicts, no fuzz). The 15 fixes form one coherent set -- the three
> core UAF fixes build on the earlier refactors in the same series, so they
> cannot be cherry-picked in isolation; this is why I send the full set as
> the first batch.
> 
> Please let me know if you would prefer a different format (individual
> mails via git send-email, extra trailers, etc.) and I will adjust. I am
> happy to follow up once this batch has gone through.

Great, does this series also apply to 6.18.y and/or any older trees?  Or
should I just worry about this branch for now while we work out the
workflow?

And at first glance, this looks great.  I'll try to apply these on
Monday and let you know how it goes.

thanks,

greg k-h

