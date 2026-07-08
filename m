Return-Path: <stable+bounces-272741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tdGfCC7KTmqpUAIAu9opvQ
	(envelope-from <stable+bounces-272741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:07:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AB672AC7B
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:07:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=kmVqc2lW;
	dmarc=pass (policy=none) header.from=infradead.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272741-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272741-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 220C73027687
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 22:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50583367B8B;
	Wed,  8 Jul 2026 22:06:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802F3A7D6E;
	Wed,  8 Jul 2026 22:06:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548408; cv=none; b=fS00Mv/SfeZ22mSqb8NcmmydlupD1dvstyIKK48tLAceetFnBUyq+jUn0WMPbR1u9wIj5+7JizPolNpK9GGDmqq33nJRk5e9hHNeWlRXDdOfcf2DJ0b4CjBcWL1yzvWk85sF9WLCUPdIOL4iZXYOHHD3p3CX0KfdNhc/f3xZuL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548408; c=relaxed/simple;
	bh=ofd8vLEoEze/KbxczkXPc5iC0f/zo3fIZp6aOZEKhRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbT38dL1ZgMQswHWMFj5894gRjm5OaObnHe+RstGkW0OnC8ISO8uGWA5vlyLaUAYqtkZFt97pkcq4g1Tb4hi2GzYcIgoejYn2L7dmXOSiCmdE4WpPzQrZ8EQ87SWb8ku8CpFkywMe08sgUPLw4L3YYiUVuMcP+/A5cAE4cp5uPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kmVqc2lW; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MSi8nwkovIzEEphFPpprWyeRS6xjscWNqnDGyaKormY=; b=kmVqc2lWqtcMm/jCgSL1sEn37O
	WYzOl/3rHs54LgXp8eAOx/qHYMgRIavRoZZTijRGzcZIERqD540PITKaHTzUx8l+zyZ3K5HeJFVy7
	QCPm2mtkY4nZ9b1+Milf0OsxzJ53hRWI7YYOkH+DVnldPj6jx9W+nOGk9Pym+zUjhzqOGhRUIm8lo
	iJHJyO+TGcYSCK2KpFmH4LQjsxdhuQs9wLXWQnwM+hmqxDAE2yG+vsdou9XslcBd/629AdLfSK6OL
	GTAl6BPY/SrPNFmODQb2HZXi2ecRaA0eB7ryTJNrDynd6gFyfHCH9aPHmsFqAqqRyDMCw/T0vuj8C
	J+/2Ghwg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whaPi-00000003Wmf-1lIp;
	Wed, 08 Jul 2026 22:06:42 +0000
Date: Wed, 8 Jul 2026 23:06:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, vbabka@kernel.org, surenb@google.com,
	stable@vger.kernel.org, sourabhjain@linux.ibm.com, rppt@kernel.org,
	ritesh.list@gmail.com, mhocko@suse.com, luizcap@redhat.com,
	ljs@kernel.org, liam@infradead.org, david@kernel.org,
	aboorvad@linux.ibm.com
Subject: Re: +
 mm-util-dont-read-__page_2-for-order-1-folios-in-snapshot_page.patch added
 to mm-hotfixes-unstable branch
Message-ID: <ak7J8oaLkNsWNOrx@casper.infradead.org>
References: <20260708205653.14D251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708205653.14D251F000E9@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272741-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:mm-commits@vger.kernel.org,m:vbabka@kernel.org,m:surenb@google.com,m:stable@vger.kernel.org,m:sourabhjain@linux.ibm.com,m:rppt@kernel.org,m:ritesh.list@gmail.com,m:mhocko@suse.com,m:luizcap@redhat.com,m:ljs@kernel.org,m:liam@infradead.org,m:david@kernel.org,m:aboorvad@linux.ibm.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[willy@infradead.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,linux.ibm.com,gmail.com,suse.com,redhat.com,infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:from_mime,infradead.org:email,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60AB672AC7B

On Wed, Jul 08, 2026 at 01:56:52PM -0700, Andrew Morton wrote:
> From: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Subject: mm/util: don't read __page_2 for order-1 folios in snapshot_page()
> Date: Thu, 9 Jul 2026 01:49:54 +0530
> 
> snapshot_page() currently reads __page_2 after checking nr_pages > 1, but
> it should only do so when nr_pages > 2.
> 
> If an order-1 folio is allocated at the end of a vmemmap section,
> __page_2 will not exist and reading it will cause a fault.
> 
> During DLPAR memory remove on a 22 TB ppc64le LPAR, snapshot_page() oopsed
> on the page isolation path while reading an order-1 folio's __page_2 from
> an adjacent absent section (unmapped vmemmap).
> 
> Fix this to avoid reading memmap that doesn't exist (e.g., a vmemmap
> hole).
> 
> Link: https://lore.kernel.org/20260708201954.686111-1-aboorvad@linux.ibm.com
> Fixes: 31a31da8a618 ("mm: move _pincount in folio to page[2] on 32bit")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

You're taking my R-b without taking my rewording of the second
paragraph?

