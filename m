Return-Path: <stable+bounces-212644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF2DKbpFemn34wEAu9opvQ
	(envelope-from <stable+bounces-212644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:22:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2689AA6C18
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7802F3026A95
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1059350A0F;
	Wed, 28 Jan 2026 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuFsJGTe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263472FF164
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619187; cv=none; b=nCGT2ZPSewDMIN8LJ4+pdD1m+P/xQx3QiHKwbgvROJBuk4PgTydR/4gLiicM68ZA82DXhhMlK205/wh2B1REnRpCj+ZyXHdonTdzU0A/+A1TUSV+fq82wmPVdCJBBjjMpKzFQMvry0xJ8YSgRvmwXcbLxqPbJz9UvBt5UeSF8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619187; c=relaxed/simple;
	bh=rckFLLAm1SSfIECkf+mbm0qJyh8hohIZ16wsToU/d7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS/qDx61q0APKyEB0ry8niA3Kf1IwzMqGNdPDwjML3JIpH1bwJs1r2CS8TqPM+KkCJpN7C9jXDrqdP4I8S5sNSQbv/fqgsxBFzase64ZtmIXCrAjbrP0/VoYXAlguF7UPy9x8YX1DD5d7swv3qEufEB37CcgtdGRPKx/NFUUo+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuFsJGTe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81df6a302b1so12176b3a.2
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 08:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769619185; x=1770223985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+VIwZPYuTL84mdN01DfXHCnboBlP6LUsRJWXcsio5Wo=;
        b=JuFsJGTeaChw/ojU/qXfwiaQGeN5Su2beOCONeCc+s2KyA5UDFRwSoHgVjEcQk1UKp
         MvAc8wFHKkRcBThzUV3tz/n+vtd5lt/Qm0sXUAMEhXsBYF+gElJvbgk4wJbrwQ6ghQ4f
         3bX7dwQQP9LyszqTZ6KBulk6pi++mkuvHlhIbJE6Fsuc1c6msn4moL15uS72rASpFihx
         4TgC6yQ+6cDHihUIEgY5eYIwIxZVZ9hsFq+iXpayCbTFkcjjOYJmeRN2XFCETQjOIM1N
         SKC3lGpFuW7zKl7cNpyu6tUJHRPdE4fTyvj1GogZCWx3W1CzHEAIFG06F97p8zr+CEfH
         sdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769619185; x=1770223985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VIwZPYuTL84mdN01DfXHCnboBlP6LUsRJWXcsio5Wo=;
        b=Yw34a/jswOqDNTGUh/wukTRJ47MXD6GygrfmzBWmN6mN4bPxT+nQqvP8kwhPhUQS0v
         qvU54R8N+5pcZ9c8LNnoWcCAe25jBSjj/sZXphQH0lVESgLQUcACNBJU/Kln1oXtLNrP
         CcIEQbkPkqi3BZa+DG++wJpR4MUbEdbO7JWkRFfEqfDljiY8Arv5zKiTXj6Iq+/FJ+bX
         4SjAQySlWXf1KkOhxLXo1BqpF06LW/0V22V5tkoIEpdF64DnzTPkGFGYQonMB2fivmUL
         kBMypOMXAnLpC7ezQGMT+F0qo5QELamtCLqkwdR0M8OSvY7VvZuF4oUFJjG+8wfpEOHT
         bwAw==
X-Forwarded-Encrypted: i=1; AJvYcCXvvfQv8NIkVYe87L0wtFkt1csV4InE8MII7vhIUcWUGIlPVThOw141/6xIicp1hfWfSXkJaRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkeCnw/IqgwR2YEOKsvVkph6WYG3CZ6CmvDHD2Xc1IBcSJAT1
	35MTAOkmvQlR2vYqcKtkDOJ7zGcLbToRrovxqUOFmV/IcpsfK6v8tOhc
X-Gm-Gg: AZuq6aIurUowkPDpeu9tf2eg74lF1dpiUX38r443dQsMMf6tIDjU5YPIHVMyeAouLgy
	ZL/nckiwbUIBazYbBgbbFkRJy/IXLuKf/CfJmBw8Zc+0AtINgkDATDmRRqPlXhCKHfxPdahXlmu
	6DX0LEgnFq6RZFPPbZdULz/CNqWd//MpM85p4c3NPEI8bkdC/vGoGfFsmsv2YdSeMK6gIF+aPaC
	suEJ/bs/kYFCT+g5AaaLcC7Cbi9KBBuxzKEW2lWTo8FN2kbi5QtMtaijvevoWMbbBZW6N5lBCK5
	urFDXGt+GRbbTjACrvSl6eVrmNPmnT/KQFehIdddH4fs5VVT9CNysVIsCLUHJOh6Hh6yj/ZOAjI
	KA/JsG/RItdCJg8pT9PLEIqCbki5KA8sWB9UzLIZJXDtDCNx+t3zkROLpWkIh7Qc+Xj7+xFxs+U
	WSHrYmWC1RTlRKOJIL1Fe8BeJJ3or2T1rGDmx8LciTfwyraE0=
X-Received: by 2002:a05:6a00:4fcc:b0:7aa:4f1d:c458 with SMTP id d2e1a72fcca58-823691849afmr5864355b3a.19.1769619185349;
        Wed, 28 Jan 2026 08:53:05 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1f188sm3546757b3a.13.2026.01.28.08.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:53:04 -0800 (PST)
Date: Thu, 29 Jan 2026 00:52:59 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Chris Mason <clm@meta.com>, linux-mm@kvack.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/shmem, swap: fix race of truncate and swap entry
 split
Message-ID: <aXo6ltB5iqAKJzY8@KASONG-MC4>
References: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
 <20260128130336.727049-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128130336.727049-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212644-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kvack.org,google.com,linux.alibaba.com,linux-foundation.org,huaweicloud.com,gmail.com,kernel.org,redhat.com,vger.kernel.org,tencent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2689AA6C18
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 05:02:34AM +0800, Chris Mason wrote:
> 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> 
> [ ... ]
> 
> > @@ -1191,12 +1203,23 @@
> >  		folio = fbatch.folios[i];
> >
> >  		if (xa_is_value(folio)) {
> > +			int order;
> >  			long swaps_freed;
> >
> >  			if (unfalloc)
> >  				continue;
> > -			swaps_freed = shmem_free_swap(mapping, indices[i], folio);
> > +			swaps_freed = shmem_free_swap(mapping, indices[i],
> > +						      end - 1, folio);
> >  			if (!swaps_freed) {
> > +				/*
> > +				 * If found a large swap entry cross the end border,
> > +				 * skip it as the truncate_inode_partial_folio above
> > +				 * should have at least zerod its content once.
> > +				 */
> > +				order = shmem_confirm_swap(mapping, indices[i],
> > +							   radix_to_swp_entry(folio));
> > +				if (order > 0 && indices[i] + (1 << order) > end)
> > +					continue;
> >  				/* Swap was replaced by page: retry */
> >  				index = indices[i];
> >  				break;
> 
> Could this code infinite loop if a large swap entry crosses the START
> boundary instead of the END boundary?

Thanks for the review! It's really helpful :)

> When shmem_free_swap() returns 0, it could be either because:
> (a) The entry was replaced by a page, or
> (b) The entry failed the boundary check (base < index ||
>     base + nr_pages - 1 > end)
> 
> The boundary check here only handles case (b) for entries crossing the
> END boundary:
> 
>     if (order > 0 && indices[i] + (1 << order) > end)
>         continue;
> 
> But what happens if the entry crosses the START boundary? If
> find_get_entries() returns a large swap entry at indices[i] where
> the entry's base (calculated as indices[i] & ~((1 << order) - 1)) is
> less than the truncation start point, then shmem_free_swap() will
> return 0 due to the "base < index" check. The code will then call
> shmem_confirm_swap(), get the order, check if it crosses the END
> boundary (which it doesn't), and retry with the same index:
> 
>     index = indices[i];
>     break;
> 
> The next iteration will find the same entry again at the same index,
> leading to an infinite loop. For example:
> 
> - Truncating range [18, 30]
> - Large swap entry at [16, 23] (order 3, 8 pages)
> - indices[i] = 18
> - shmem_free_swap() sees base=16 < index=18, returns 0
> - Check: 18 + 8 > 30 is false (26 <= 30)
> - Retries with index=18
> - Loop repeats indefinitely

I think this is a valid issue. And it's worse than that, during the `while (index < end)` loop a new large entry can land anywhere in the range, if one interaction's starting `index` points to the middle of any large entry, an infinite loop will occur: indices[0] are always equal to the `index` iteration value of that moments, shmem_free_swap will fail because the swap entry's index doesn't match indices[0], and so the `index = indices[i]; break;` keep it loop forever.

The chance seems very low though.

> Should the boundary check also handle the START case, perhaps:
> 
>     if (order > 0) {
>         pgoff_t base = indices[i] & ~((1UL << order) - 1);
>         if (base + (1 << order) - 1 > end || base < start)
>             continue;
>     }

This still doesn't cover the case when a new large entry somehow lands in the range during the loop.

> where 'start' is preserved from before the loop?

How about following patch:

From 863f38c757ee0898b6b7f0f8c695f551a1380ce8 Mon Sep 17 00:00:00 2001
From: Kairui Song <kasong@tencent.com>
Date: Thu, 29 Jan 2026 00:19:23 +0800
Subject: [PATCH] mm, shmem: prevent infinite loop on truncate race

When truncating a large swap entry, shmem_free_swap() returns 0 when the
entry's index doesn't match the given index due to lookup alignment. The
failure fallback path checks if the entry crosses the end border and
aborts when it happens, so truncate won't erase an unexpected entry or
range. But one scenario was ignored.

When `index` points to the middle of a large swap entry, and the large
swap entry doesn't go across the end border, find_get_entries() will
return that large swap entry as the first item in the batch with
`indices[0]` equal to `index`. The entry's base index will be smaller
than `indices[0]`, so shmem_free_swap() will fail and return 0 due to
the "base < index" check. The code will then call shmem_confirm_swap(),
get the order, check if it crosses the END boundary (which it doesn't),
and retry with the same index.

The next iteration will find the same entry again at the same index with
same indices, leading to an infinite loop.

Fix this by retrying with a round-down index, and abort if the index is
smaller than the truncate range.

Reported-by: Chris Mason <clm@meta.com>
Closes: https://lore.kernel.org/linux-mm/20260128130336.727049-1-clm@meta.com/
Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Fixes: 8a1968bd997f ("mm/shmem, swap: fix race of truncate and swap entry split")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b9ddd38621a0..fe3719eb5a3c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1211,17 +1211,22 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				swaps_freed = shmem_free_swap(mapping, indices[i],
 							      end - 1, folio);
 				if (!swaps_freed) {
-					/*
-					 * If found a large swap entry cross the end border,
-					 * skip it as the truncate_inode_partial_folio above
-					 * should have at least zerod its content once.
-					 */
+					pgoff_t base = indices[i];
+
 					order = shmem_confirm_swap(mapping, indices[i],
 								   radix_to_swp_entry(folio));
-					if (order > 0 && indices[i] + (1 << order) > end)
-						continue;
-					/* Swap was replaced by page: retry */
-					index = indices[i];
+					/*
+					 * If found a large swap entry cross the end or start
+					 * border, skip it as the truncate_inode_partial_folio
+					 * above should have at least zerod its content once.
+					 */
+					if (order > 0) {
+						base = round_down(base, 1 << order);
+						if (base < start || base + (1 << order) > end)
+							continue;
+					}
+					/* Swap was replaced by page or extended, retry */
+					index = base;
 					break;
 				}
 				nr_swaps_freed += swaps_freed;
-- 
2.52.0

And I think we really should simplify the whole truncate loop.

