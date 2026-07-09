Return-Path: <stable+bounces-272772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +79PA8rpTmpoWgIAu9opvQ
	(envelope-from <stable+bounces-272772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 02:22:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C57072B564
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 02:22:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=SB4Vm80u;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272772-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272772-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1945F301C59A
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 00:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189F31AA92;
	Thu,  9 Jul 2026 00:22:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07B316905;
	Thu,  9 Jul 2026 00:22:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783556547; cv=none; b=i/77ovcWm1yK7URoQ/3ny9w96JFGesh8xjKmMGCu0KrLVVLU+PKh6Z2XcveDFnnUguNwdAkpkNHVpWTrtBm/b7RFzCc7tY1L7IbVrFdDiLcA4fGgLei6DZ5v4Dgx34SjUh8dpQohS58RwwlPcc4mmaKVM8japAQJyh8zGc6NYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783556547; c=relaxed/simple;
	bh=5otryLbL9wcehZn3JqeQ5NUvUHsoZRGcqi1rWDe5amk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YyYPD07cFbShwAgnFXDIgTSfPpqXYtr3rM48JXxr6cPgtkDxA6e5QciWrKD50FvwluHdnJHS2Np6VcUO8zSf7IAZNYcFrai7Yj6SxDEXMoKimo919I8esDc9UJFf9HL6UAHtOqvn3v+s5iKXiz/CpxjKNRGbhM2iOdCq7ndnoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SB4Vm80u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D521F000E9;
	Thu,  9 Jul 2026 00:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783556545;
	bh=IFnt3Ev2dcFJzcdhHsm14oZW2o5/ZmcubtTPCpiK30k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SB4Vm80uRCpDeWODkTtcoxRBu/TZxPbDoj4rha6005eIZgtN8+gCEBn0JHU87x/Pd
	 GnYGX2v2Y6HCRSIIs+bSOIVpwQWlOqhfUje9GKX6JjxrCagbTAaquM4muIFsr7UfR2
	 GWfABpESVZZgwWxhqZYdNXWzLyiF46kN2z8yPgig=
Date: Wed, 8 Jul 2026 17:22:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: mm-commits@vger.kernel.org, vbabka@kernel.org, surenb@google.com,
 stable@vger.kernel.org, sourabhjain@linux.ibm.com, rppt@kernel.org,
 ritesh.list@gmail.com, mhocko@suse.com, luizcap@redhat.com, ljs@kernel.org,
 liam@infradead.org, david@kernel.org, aboorvad@linux.ibm.com
Subject: Re: +
 mm-util-dont-read-__page_2-for-order-1-folios-in-snapshot_page.patch added
 to mm-hotfixes-unstable branch
Message-Id: <20260708172224.f919bee522da26d700cef447@linux-foundation.org>
In-Reply-To: <ak7J8oaLkNsWNOrx@casper.infradead.org>
References: <20260708205653.14D251F000E9@smtp.kernel.org>
	<ak7J8oaLkNsWNOrx@casper.infradead.org>
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
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willy@infradead.org,m:mm-commits@vger.kernel.org,m:vbabka@kernel.org,m:surenb@google.com,m:stable@vger.kernel.org,m:sourabhjain@linux.ibm.com,m:rppt@kernel.org,m:ritesh.list@gmail.com,m:mhocko@suse.com,m:luizcap@redhat.com,m:ljs@kernel.org,m:liam@infradead.org,m:david@kernel.org,m:aboorvad@linux.ibm.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272772-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,linux.ibm.com,gmail.com,suse.com,redhat.com,infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C57072B564

On Wed, 8 Jul 2026 23:06:42 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Jul 08, 2026 at 01:56:52PM -0700, Andrew Morton wrote:
> > From: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > Subject: mm/util: don't read __page_2 for order-1 folios in snapshot_page()
> > Date: Thu, 9 Jul 2026 01:49:54 +0530
> > 
> > snapshot_page() currently reads __page_2 after checking nr_pages > 1, but
> > it should only do so when nr_pages > 2.
> > 
> > If an order-1 folio is allocated at the end of a vmemmap section,
> > __page_2 will not exist and reading it will cause a fault.
> > 
> > During DLPAR memory remove on a 22 TB ppc64le LPAR, snapshot_page() oopsed
> > on the page isolation path while reading an order-1 folio's __page_2 from
> > an adjacent absent section (unmapped vmemmap).
> > 
> > Fix this to avoid reading memmap that doesn't exist (e.g., a vmemmap
> > hole).
> > 
> > Link: https://lore.kernel.org/20260708201954.686111-1-aboorvad@linux.ibm.com
> > Fixes: 31a31da8a618 ("mm: move _pincount in folio to page[2] on 32bit")
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> You're taking my R-b without taking my rewording of the second
> paragraph?

I added your sentence.  Aboorva's info was potentially useful, absent a
Link: to a report,

