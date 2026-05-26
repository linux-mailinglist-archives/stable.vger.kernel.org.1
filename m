Return-Path: <stable+bounces-254327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MCuMGWJFWqGWQcAu9opvQ
	(envelope-from <stable+bounces-254327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:52:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392DE5D52B9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3B5230300DE
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181243F7865;
	Tue, 26 May 2026 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOI6QCiK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8593F58CE;
	Tue, 26 May 2026 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796292; cv=none; b=WhE5Aw8JXLPXXPzu1uxZHNRXT2SIVc0Zxj75mpQ3s/r6htXXCEweU4m4BlmgPAanFPMYaWSrzAkJuyLLdBAO0KGXHKCEXEj30wvecPAMRcwOUtworHMQ/0BHZQjmNr4110m27K1AHEstODg8ZdDQp+Y1ln/Eiy2qW2w5YkxmsWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796292; c=relaxed/simple;
	bh=XkUbvdXXFLoifUt0Q6vsljmpmzVFdVRttB13zX9CaBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSV6sYMM60NI8uOXsz91t8Ov//aixEtPdZWhoda/KMQezBH8GpOdWMGYx5lB6YPZxyDXFvFvxJPyb3JOjGJ/yICmNXI5PO8ILGbv3seNuUlT7VD1NS0LnTR48lcPYpKrY6s8ECfaBETePacFwEO6d6IYyf+XHma90wsX/XAltM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOI6QCiK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CA31F00A3A;
	Tue, 26 May 2026 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779796283;
	bh=Zf3nA9b/f6KJ6opNUnUvkbE1AyejuVsXjSNIH4NC8L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LOI6QCiKOPAi5/pvTmUe+J2ivE0RgADm3Y0EtHjTPaGbjdyK3F39dM8lmTJ0+htsT
	 bjs4R63fzZ/knOCYKNHUWjgzWUqO6vafbf8ADs2CxSybZph9TzGY8xjlpGTtI3dnwZ
	 1clkTKh04k7vKFdUCBnQbPNZ9RJRgO7RDo238EAsh+dVC2PgJvL2gSgr9GmbdV2Foo
	 ssdlGwIWt0kbNAWZAWhorUkkTo8t9AxFG1DSvTxr++RAFU3bGXc82Koykb6BBS8567
	 OVcH25v3KUnOT1RXQpbZi5cG8leYuqpDy3LcRsuiQve6wCa+3r1zsbxAFKUI/j9jgc
	 TWWRH2RJoLUZA==
Date: Tue, 26 May 2026 13:51:15 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [PATCH] mm/cma: fix reserved page leak on activation failure
Message-ID: <ahWJMwG8xoQli_Q0@localhost.localdomain>
References: <20260522062658.4095405-1-songmuchun@bytedance.com>
 <20260526113005.3610737-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526113005.3610737-1-usama.arif@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254327-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c04:e001:36c::12fc:5321:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osalvador@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,100.103.45.18:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 392DE5D52B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 04:30:03AM -0700, Usama Arif wrote:
> On Fri, 22 May 2026 14:26:58 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
...
> > diff --git a/mm/cma.c b/mm/cma.c
> > index c7ca567f4c5c..a30075507d41 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -188,10 +188,13 @@ static void __init cma_activate_area(struct cma *cma)
> >  
> >  	/* Expose all pages to the buddy, they are useless for CMA. */
> >  	if (!test_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags)) {
> > -		for (r = 0; r < allocrange; r++) {
> > +		for (r = 0; r < cma->nranges; r++) {
> > +			unsigned long start_pfn;
> > +
> >  			cmr = &cma->ranges[r];
> > +			start_pfn = r < allocrange ? early_pfn[r] : cmr->early_pfn;
> 
> Should this be r <= allocrange?

Yes, I think you are right. I missed that.

early_pfn[alloc_range] holds the last assignment, so we should start
from the next one reading cmr->early_pfn.

 

-- 
Oscar Salvador
SUSE Labs

