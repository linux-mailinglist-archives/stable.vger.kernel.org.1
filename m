Return-Path: <stable+bounces-272019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eu+YBAINSmpU9wAAu9opvQ
	(envelope-from <stable+bounces-272019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 09:51:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 835F17093ED
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 09:51:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=1r3H7rex;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272019-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272019-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86526300614B
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD3E36729A;
	Sun,  5 Jul 2026 07:51:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9A364EA4;
	Sun,  5 Jul 2026 07:51:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783237887; cv=none; b=UGlR+ISjxuOQovNCm+74bUss84OeMENhrEpVVMpA4kkKXX3jNgQTnPpQzdwBOLSvFOr3PVdq/b+txClvWBPj5uW0eKXlJM/wqFEc5rhUnsi2sTQvd7eWpti/z9M5mpaSif+t4eo/ro3FLUjFmrrB9cAv64Mh+G4NH5Nr4QrZjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783237887; c=relaxed/simple;
	bh=QzgwtEMrdOwbHwOqBYwXkfIPstfanTnnQ52weLckbbs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ImyM0UOJs7bHKPNMHQYnDt4rJ/+SaDFP/UVy8+Q6XBN1AL8ij35F9yrU67YVHx1GSUusDqqmjonEaEz+XZwxfACMd9OZSWctzuhlHt56uJvyHEmq+nwUR1AdbY5h0OwyvMmzseoEwhYTCzMKxC2DXA6LTSSl3gDHus0nHUf6SqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1r3H7rex; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C02A1F000E9;
	Sun,  5 Jul 2026 07:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783237885;
	bh=JmDzrGAApB3p232sFjl+IuA3F1DiyD0h9KZAveodTsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=1r3H7rexoiQDRjGFt+Qjs33P1gVqh+LD73TOTn/BTY0t13tL4G1XibQWtwbBNLJiy
	 /AbaYonfCEjLrKKi9OkCqN7wL49L3MbO1BuGftrDMhCvBcwuagImS8gD8y1Sf6ehPP
	 UGSpFne62asm/Cvv+3d9/HGQrxu5PpvI24+a2L/o=
Date: Sun, 5 Jul 2026 00:51:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Linus Torvalds <torvalds@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Oleg Nesterov
 <oleg@redhat.com>, Peter Xu <peterx@redhat.com>, vova tokarev
 <vladimirelitokarev@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: prevent registration of special VMAs
Message-Id: <20260705005124.307e2379ab03109e5f77bd1c@linux-foundation.org>
In-Reply-To: <ake7PLwdHUHu4idi@lucifer>
References: <5a993689-f730-406d-8515-8bb6025cc851@kernel.org>
	<ajOtfdGgFQYL-T6f@kernel.org>
	<ajOvwGs5xhnfBu-k@kernel.org>
	<41ef0dce-e973-4947-b5e3-150fdb07f1a6@kernel.org>
	<ajO4sLq2UBciSgOn@kernel.org>
	<dd2ae577-9b7d-4e40-81d0-fa9fcd7e0767@kernel.org>
	<ajO7yI541hphWRb8@kernel.org>
	<11bae87d-73e6-4946-a41f-c5542fb40b75@kernel.org>
	<akeJdxdZXAFb8XCr@lucifer>
	<ake3JZJPYHP-0N7n@kernel.org>
	<ake7PLwdHUHu4idi@lucifer>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:rppt@kernel.org,m:david@kernel.org,m:torvalds@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:oleg@redhat.com,m:peterx@redhat.com,m:vladimirelitokarev@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272019-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,zeniv.linux.org.uk,suse.cz,redhat.com,gmail.com,vger.kernel.org,kvack.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 835F17093ED

On Fri, 3 Jul 2026 14:38:56 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> On Fri, Jul 03, 2026 at 04:20:37PM +0300, Mike Rapoport wrote:
> > On Fri, Jul 03, 2026 at 11:11:14AM +0100, Lorenzo Stoakes wrote:
> > > On Thu, Jun 18, 2026 at 11:37:10AM +0200, David Hildenbrand (Arm) wrote:
> > > > > In a way that's an extra check for hugetlb, but it will work.
> > > >
> > > > My point would be that we exclude all special VMAs, except hugetlb (which is
> > > > special but supported ... in its special way).
> > >
> > > Mike - you said you were respinning, it'd help my series if you respan the above
> > > quickly so I could base my change on that :).
> >
> > I sent it already:
> >
> > https://lore.kernel.org/all/20260618095017.2553004-1-rppt@kernel.org
> >
> > and Andrew apparently ook it:
> >
> > https://lore.kernel.org/all/20260618183442.BBCD71F000E9@smtp.kernel.org
> 
> It's not anywhere :)
> 
> Andrew - did you take that thread as signal this should not go in?
> 
> It should definitely go in. I will clean up the mess discussed there separately.

Thanks, yes, I added it then hid it when Linus objected.  I'll unhide
it now.

