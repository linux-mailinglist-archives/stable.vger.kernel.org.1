Return-Path: <stable+bounces-230515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNrBEbl/xWkk+wQAu9opvQ
	(envelope-from <stable+bounces-230515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:49:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E580C33A622
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92D563080F8E
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AA039FCC8;
	Thu, 26 Mar 2026 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Sjf0L3+Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D039768C
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550242; cv=none; b=TflcPhn538mM7nrc25vLuG9OeYkEsHKptknxkdDS+fXjMKAz8Hl0VY/nEbe5T4bvHqUCvLXiONqoqb3Z4O7EtiG1APh6NpZBHdveN/+HIvhMxV4VZrQOn7k+8PmTQuM9JQG5gir808NWwv8RDRUb3MSjk3Zdyl70WpALKtXDtVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550242; c=relaxed/simple;
	bh=N6DVkFuvsW65DYYhOEJwgHqfW+DHLGUY+QHYLBuve3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txdatk2OHV+1MJrMNJUJixfaE428mCN0UdjfOG8sieq3Cs1dx7oXXWFbOoLAKVS7Wk5M0SuHmaNsZ6g+/7nKbIov1tVHyE1KHednBcMVpsoPO11JI7jMt+DtHJNAV2l9py20Ic2q5p8/DFxi/7KNJb2nVCejv06AhHaTJcF2Ze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Sjf0L3+Q; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfc1aced74so215216985a.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774550240; x=1775155040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mNnO5uEjZAJK+6dtDEzqReuQwWCmolqZu6o6OpWgRS8=;
        b=Sjf0L3+QsJ/hCtCZ9xiv302bDy4MDog1Onmu9VZ7e1hR6749/SI5wv9PjZmCEDDag6
         QM10/BT4c5FDNanXzFt09HFUkwB0EWCPPFN3+QDZKXe+wj6HnVpnR0fft3vIIaphysn2
         JspgqG0uPJp9yDswrVErPhT1ts3BkFdxsmP87Bu4TBc6hXisu9vVX15PSl/NuLVhGPL4
         IVtWGVdo2Ryv9q8NhqwNttBuMbikJwNqAcW5+PW5gminPfpp+52D8IG4Sx7NTrtRZEwZ
         aDjDE9vo8mnab9sdtUSSfB5hnSvqdEkb7+7bxLhggHk3H7e9TLgTqWAw6QqOVlO4S/Ib
         Xf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774550240; x=1775155040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNnO5uEjZAJK+6dtDEzqReuQwWCmolqZu6o6OpWgRS8=;
        b=d51eI/SAF3NZa4mUrVq3UVFscyuR1MEb/WwNSLMXkNaF9uNARCFJx4ZtZqoh5HkjH/
         z0NTHIfR92OmjAh3h1zZMpmgs30v9ho74wDRSC6gMov5w7AdG6BoqxODRUnn2zs4X/RO
         oUBcfo74y0h8nR4VsEwh8bJjCz2nHk/3b7teRUjyF/h6FGXCrw2UgYZTrwJKrMO6baRv
         xtJkNkDMb143D7pWyyykV+kOcJFCanK4Bz9UiIfNu9dFKfSIkEjXQAwMporg6zcST2tP
         XAQVs1+EfdArTOjREn0XryJUUMpSkKrKVprqcMo75hCBnX3NDRElSTyYgpQkj1y2ExOP
         qOMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJlbX0BgU7HNxUbAYRnbXw/UUeQU0qASuKIbvLpKCQ+U/iPARHdQigCOtd+Rr7Zt/4/tFvB6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8SXP3ykGCCzYEre2NI4y5Xu55NA+1VG3Xw5OrNbmvbth4mpMg
	4RdL15NuBkVn+z4fdd+47N+3rdAnzpQdnxWoHC1SxyrbIuZ+lBNDfK7qqeh1qeP0T8Q=
X-Gm-Gg: ATEYQzwKkZxU69bdTQG7D2ZFUKnDCayLfFfMIQz4tCvzgj3Vyt3jt1ZnoumYLBB5R5z
	lPw/x111tFUlDPAiVjI8TI/ej7oNScnclIVLDCiTlI3wAXcHlLV71SxugA8NXcURT2B0Dhn05jv
	qGaGrA2ViWSNBnMMZVyJZPY+atu6uVUuqekPgfYg4Ks3H9XaOQJi2ebNKCUPhwgI+JMhONIokwx
	bwo/ZDrNzDJ91er046EHFINREIBbz4VER3G0fmyAlzJgTENug5UH9Sm1gDbo5uk2deU8+J9+0Zw
	jdCRLLn2mcrxHfbnZQ+E3fvQ4UArxYDX+vKo3vC3qJbqXnzXWIe93qqdlsoE8EqkXSN7bxKhtgA
	zSrCghJwKLUnvv3byc1bt8w9VsvqXResNU7P/x6vH4U14RVjt/nTGlsxKHyEeRxDpiw9qoUBCYy
	52jouc8YiMGcDaJ/R+QjyQR1GRnC8T+wo=
X-Received: by 2002:a05:620a:f10:b0:8cd:b7ec:7adb with SMTP id af79cd13be357-8d001072b95mr1231136085a.60.1774550239805;
        Thu, 26 Mar 2026 11:37:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::2:e5e8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e3a2340sm321348485a.6.2026.03.26.11.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:37:19 -0700 (PDT)
Date: Thu, 26 Mar 2026 13:37:17 -0500
From: Gregory Price <gourry@gourry.net>
To: Pedro Falcato <pfalcato@suse.de>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hughd@google.com,
	david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: use invalidate_lock to fix hole-punch race
Message-ID: <acV83cdc9ZfNk8Xh@gourry-fedora-PF4VCD3F>
References: <20260326162611.693539-1-gourry@gourry.net>
 <jm5rmcwiauy2fn6fvj6cjowiu2dudjndhhlcd2tm275ibmos5i@dwxwchbs24ko>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jm5rmcwiauy2fn6fvj6cjowiu2dudjndhhlcd2tm275ibmos5i@dwxwchbs24ko>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230515-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	DKIM_TRACE(0.00)[gourry.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E580C33A622
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 05:07:42PM +0000, Pedro Falcato wrote:
> > Two races allow PTEs to be re-installed for a folio that fallocate
> > is about to remove from page cache:
> 
> Hmm, I don't see how your patch fixes anything.
> 

after looking at your comments below i realized race 2 actually requires
the fork as well, which means they're both essentially variations of the
same race, so hopefully i can simplify the change log.

> >   fallocate              fault-around           fork
> >   --------               ------------           ----
> >   set i_private
> >   unmap_mapping_range()
> >   # zaps PTEs
> >                        filemap_map_pages()
> >                         # re-maps folio!
> >                                               dup_mmap()
> >                                               # child VMA
> >                                               # in tree
> >   shmem_undo_range()
> >     lock folio
> >     unmap_mapping_folio()
                  ^^^ i_mmap_lock_read held, iterates VMAs
> 	spin_lock(ptl);
                  ^^^ child VMA's PTL
> >     # child VMA:
> >     #   no PTE, skip
> 	spin_unlock(ptl);
                    ^^^ child VMA done, iterator moves on
		        it will not re-visit the child.

> >                                             copy_page_range()
>                                                spin_lock(dst_ptl);
                                                   ^ Child PTL
> 					       spin_lock(src_ptl);
                                                   ^ Parent PTL
> 						/* does not copy PTE. either
> 						 * we find a zapped PTE, or unmap_mapping_folio()
> 						 * finds two mappings instead of one. */

At this point, unmap_mapping_folio only processed the child VMA
(no PTE, skip). The parent PTE *has not* been zapped.

copy_page_range() acquires src_ptl (parent) and reads a present PTE,
and boom copies it to child.

When it reaches the parent VMA next, it zaps the parent PTE,
but the child PTE (just installed) survives.  

> > 
> > Fix both races with invalidate_lock.
> > 
> 
> I don't see what you're seeing? Note that both map_pages and fault()
> take the folio lock (map_pages does a trylock) to exclude against truncate
> as well.
> 

The folio lock serializes map_pages/fault against truncate - but the
race isn't between those two. It's between truncate's unmap walk and
fork's copy_page_range - and copy_page_range doesn't take folio lock.

The easiest way to deal with this is to prevent these fork-inserted PTEs
from existing rather than try to make copy_page_range aware of
truncation (it already holds the PTL when it finds the PTE, so you can't
take the folio lock unless you drop/reacquire the PTL).

~Gregory

