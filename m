Return-Path: <stable+bounces-272365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0jFVIDGuTGohoAEAu9opvQ
	(envelope-from <stable+bounces-272365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 09:43:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C28571899F
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 09:43:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HPerxWTj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272365-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272365-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5333E30151FA
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 07:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509063D75AD;
	Tue,  7 Jul 2026 07:24:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9E42087C;
	Tue,  7 Jul 2026 07:24:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409057; cv=none; b=DTJRDwmdsj8e67zF5AzA0v3k7q478lk2QSaLSTaPtGqyZgt3zDRjbeOFomdVHppHSBheRLJUBBkeNnvnyVjlG2hTqDxnkC5/OQ5jS3oT61EncmYn/fiI2E/Qu+BdOycn1TRWauammrXNrvRLyIKK9balmgV3sweZGpjNY9qQFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409057; c=relaxed/simple;
	bh=8oZm9V0Eegm7U/oCUttyoG6iz90fG6p7gML4ZQdCQTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOICZLe9KlRZZCrSKBlUwOX/i/fAyg2D1sFEe5OKvYGXE3bPCWrum5DUdpBcl5Grgt4v4dLhpKTkcrVpWwlY6Cwe4RYzSRCnmsOpQQc7zlvtHG2rphFD5k2LKKiAVZbqKU7LeqEIsLg+PMmhRbUq3qv9rgvvOL3zWFtdeNV4bGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPerxWTj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F8E1F000E9;
	Tue,  7 Jul 2026 07:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409048;
	bh=AIB+BapHUzxV/CmBubl0Ce2T16FkAn0tCi+DQMi1NGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HPerxWTj/wR/yz9KqR7BZ/IE74mbMjRVdfVb/Na/vo3crjk7v7RkPkkYTA7oAGN7l
	 5EKfl+gdyapyQpbNfITb611pxx3ENjIBTmAcaN26elsvf00r97h8TwXf3qZhw7+B0A
	 4T8+W93k0iBaAhuqFPoslEDKCs3dt36Wsm1rQwFLRKBQ+y3XZ1qGbmUBuEqlhKSZFu
	 U29dKQZ44cXhfda1viJ6wn/gnz9Gf59/RcUsVHEUCZFx0k/DwxPr3gqs4xVezR3mR8
	 o1NMhxcG45RFk+L8j94ly1pa9t9+uDj823pW4sqQjCJF8iFir+E5lvhr0zbwbWAFtC
	 Ca/kv4P02wFtw==
Date: Tue, 7 Jul 2026 08:23:57 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>, 
	vova tokarev <vladimirelitokarev@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: prevent registration of special VMAs
Message-ID: <akypf9pq8NCeZlMi@lucifer>
References: <ajOvwGs5xhnfBu-k@kernel.org>
 <41ef0dce-e973-4947-b5e3-150fdb07f1a6@kernel.org>
 <ajO4sLq2UBciSgOn@kernel.org>
 <dd2ae577-9b7d-4e40-81d0-fa9fcd7e0767@kernel.org>
 <ajO7yI541hphWRb8@kernel.org>
 <11bae87d-73e6-4946-a41f-c5542fb40b75@kernel.org>
 <akeJdxdZXAFb8XCr@lucifer>
 <ake3JZJPYHP-0N7n@kernel.org>
 <ake7PLwdHUHu4idi@lucifer>
 <20260705005124.307e2379ab03109e5f77bd1c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705005124.307e2379ab03109e5f77bd1c@linux-foundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:rppt@kernel.org,m:david@kernel.org,m:torvalds@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:oleg@redhat.com,m:peterx@redhat.com,m:vladimirelitokarev@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272365-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,zeniv.linux.org.uk,suse.cz,redhat.com,gmail.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C28571899F

On Sun, Jul 05, 2026 at 12:51:24AM -0700, Andrew Morton wrote:
> On Fri, 3 Jul 2026 14:38:56 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
>
> > On Fri, Jul 03, 2026 at 04:20:37PM +0300, Mike Rapoport wrote:
> > > On Fri, Jul 03, 2026 at 11:11:14AM +0100, Lorenzo Stoakes wrote:
> > > > On Thu, Jun 18, 2026 at 11:37:10AM +0200, David Hildenbrand (Arm) wrote:
> > > > > > In a way that's an extra check for hugetlb, but it will work.
> > > > >
> > > > > My point would be that we exclude all special VMAs, except hugetlb (which is
> > > > > special but supported ... in its special way).
> > > >
> > > > Mike - you said you were respinning, it'd help my series if you respan the above
> > > > quickly so I could base my change on that :).
> > >
> > > I sent it already:
> > >
> > > https://lore.kernel.org/all/20260618095017.2553004-1-rppt@kernel.org
> > >
> > > and Andrew apparently ook it:
> > >
> > > https://lore.kernel.org/all/20260618183442.BBCD71F000E9@smtp.kernel.org
> >
> > It's not anywhere :)
> >
> > Andrew - did you take that thread as signal this should not go in?
> >
> > It should definitely go in. I will clean up the mess discussed there separately.
>
> Thanks, yes, I added it then hid it when Linus objected.  I'll unhide
> it now.

Thanks!

