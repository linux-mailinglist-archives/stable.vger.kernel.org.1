Return-Path: <stable+bounces-268260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id emjXGsSxPGqcqggAu9opvQ
	(envelope-from <stable+bounces-268260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 06:42:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B3F6C2AE5
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 06:42:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="i0hVhT/R";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268260-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268260-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A11C3302B397
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 04:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7158F2D97BA;
	Thu, 25 Jun 2026 04:42:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018413002A0;
	Thu, 25 Jun 2026 04:42:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782362554; cv=none; b=kT1/NXuCDbLlwPfUxaPlVIllOrXXHIZp5mHb2fkfbeLAb+Za0EoN3p7jtcRQ3T7oQtJEcOlBW0XNJ4KAmSIytilxnKiXZhlvVArVE0hY6+0M7L6VZEee28kp5oiwODamYuqvczooXd//C5KnWK7B7fyEU5Q9sbxXiNsIj6shyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782362554; c=relaxed/simple;
	bh=2zVst6mLPWuDUyaGdXN+wzX46zSKCBxxH0hRFEmhJ/Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s2+1cLNdG+yZGhF6NI0BS6atvEPDuXzDK0iix28WYShefSVuExlTAlJmYL8fFrlJ6gdikOji4PNVBB2w8Ys3fvIh2k36AHCzTIWhiHVvzUTwCAswJ5Gz8mCq/740MzvpN4IBTUuYYRv3jnvvyginAj/wkZhyyMZZQRUtauHnoio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=i0hVhT/R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E311F000E9;
	Thu, 25 Jun 2026 04:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782362551;
	bh=CA0sktO++Ow6VRpzdYwlIlbQ5DKIdcDWBy7MYZV0Fsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i0hVhT/RTreO4fATKMJB2/9g3pPL6K6+1aKqy1vkjPFkSiV2rIS4DOxlirhKwBBDI
	 EnLEEivh6FnqU/wcSGx29p0ih0BtsRKhw53f2g67FoZwvCS8Sh9/yti+VoLV52WXLe
	 niklqSXkacwoAn7Tj6t/L7UF9AlLT5MOqGxGCle4=
Date: Wed, 24 Jun 2026 21:42:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: david@kernel.org, ljs@kernel.org, riel@surriel.com, liam@infradead.org,
 vbabka@kernel.org, harry@kernel.org, jannh@google.com, kas@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
Message-Id: <20260624214230.4aff522ec8fa4a8f1607c942@linux-foundation.org>
In-Reply-To: <20260625042853.2752898-1-dev.jain@arm.com>
References: <20260625042853.2752898-1-dev.jain@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dev.jain@arm.com,m:david@kernel.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268260-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,linux-foundation.org:from_mime,arm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1B3F6C2AE5

On Thu, 25 Jun 2026 04:28:51 +0000 Dev Jain <dev.jain@arm.com> wrote:

> try_to_unmap_one() handles hugetlb folios when memory failure needs
> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
> case page_vma_mapped_walk() returns the hugetlb entry in pvmw.pte, but
> the code reads it with ptep_get() before decoding the PFN.
> 
> That is wrong on architectures where hugetlb entries are not encoded as
> regular PTEs. On s390, for example, a raw huge RSTE must be converted
> by huge_ptep_get() before helpers such as pte_pfn() can inspect it. A
> raw decode can select the wrong subpage, so try_to_unmap_one() can
> install a hwpoison entry for the wrong PFN.
> 
> The userspace-visible result is that a later access to the poisoned
> hugetlb subpage can miss the expected SIGBUS. With DEBUG_VM, the wrong
> subpage can also trip the PageHWPoison check.
> 
> Use huge_ptep_get() for hugetlb mappings before decoding the PFN.
> 
> Before c7ab0d2fdc84, the bug existed in the form of a plain dereference:
> we would check the head page pfn of the hugetlb with pte_pfn(*pte), and
> bail out on mismatch. This would mean that the hwpoisoned entry will not
> get installed.
> 
> I am not sure what is the procedure on such kinds of very old bugs - how
> back should I really go?

I think 9 years is enough ;)

> There are similar old bugs present, in try_to_migrate_one(), check_pte(),
> remove_migration_pte(), prot_none_hugetlb_entry().

Why now?  Was there some more recent (s390?) change which exposed this?


