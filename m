Return-Path: <stable+bounces-195212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D710BC719A3
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 01:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D4B392968F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 00:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B6209F5A;
	Thu, 20 Nov 2025 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn5LbCtn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568520459A
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 00:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599782; cv=none; b=dsZlRBH1DpKYZlIVqp31L1fohNlHBMu/qozQp20ZkfDBGAXwi6P0nwSfKr1gKh+IGtZC4FiKiHaUk1JOnn8V7TJWjLexj3KPieIsunw+ZUCnpj6gmjDQZlgtyE+V7ECxw0z/pJQ2qvV6M7sv25s44IMjbkztmhGfOSoIUx5ZNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599782; c=relaxed/simple;
	bh=HAGeTuo3u+V5/Het3b/mUgAsyHDHyKe9hL53tlZfpIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFfHtKznt69LnH9Vmm03C1J4oqOWvMb2UfXHWUYxy5C7DGP4pHB7BW+wkGIyzCfxGTpru5H1J4xtcwSVtspeS8uhw6hMUT99+9qPVKpq5DRIKwRZuV56tZ1CA0csehntiQ470cc2pz0yMOabOMwFYkqsd7t2d9OgzMFJUKpwkXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn5LbCtn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b713c7096f9so53647266b.3
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 16:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763599779; x=1764204579; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFzHXxyk6we/pBImLIWglgwRBcWEEHpcqfaS4xxBUvQ=;
        b=Qn5LbCtn28PM0I+Kre+RWaUZfXrDEDzoFDPveP3tG4ZT4b5OwPtUT9xywIP4BuZ1me
         gS7ZjSgfZJy8MouKwUL/6j3HfFNRVHihefqmP3sKUHzDmoM0mgbqoC9A7z9PU0Ty9RWY
         BwXdIapsSqHs29Vu61REWJ4RuTRiEsnZAZ8+A8LplA+ainFDpHKUefcMs9l51liCOjYx
         YKMUXG9pWsIB9mMfEpJdjqE6WJ6zy5h5l+ActtT+5pYt6FdXeaybK7kSjc8JIAMrllQC
         V2iBMcyL0tj6IoULOU1R0Dw/z2/o+OpypOcMj7Zx8sAoa/ZhPmZoQmOUxW+dTt3uj9ke
         pQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763599779; x=1764204579;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFzHXxyk6we/pBImLIWglgwRBcWEEHpcqfaS4xxBUvQ=;
        b=RYlgTMLfDGMrd1jiFIFAc71CJn2wgdFGIHJi0Q5Hwi46VslcBgBwBL1INSq7Rjk7Lt
         YRXQkMylBJoKiAUD/vCFN1vi7PHHYnOy/LI7TJZpGiCBQuLm3uBbjFetqsahyzV1U98x
         n4JFX3lBxkER5e8yFmExbyNR6rBBeB9rgeh48vewVSbZCqtlsN/8cIxTvIIkBSio6fkY
         KZIRPIGhUtgfAJwcLo/WxVnwfShRmOGMR6TD0I9koz9J5fVx49fhY4nG47rgsOGlWoSY
         jiKp4Cgm1ncsdDUZagbNFDLwCJrAKzgJlWKrxTeS5KpYqsHTntLLEakdlng3QU4shg/x
         n38w==
X-Forwarded-Encrypted: i=1; AJvYcCXjzH+/1w+jbug9KIWndLTTNzx+GYd7XTXzcnOoun2Mh79Zq2jDU2+z9cMQPR4HxkUvWLPKY9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyAOBgcUtDmydEZiHUSjLb904eWbwkX+3RRpdzsxhS6VPVLpR
	bkgdpRZxjhfi5v/GGmF2q4UfwWA5vFtMCQlKaxsJwGS0zaniEXvCkFGs
X-Gm-Gg: ASbGnctlyadIa5HCk84MGB9sQKPA1rKCy4zpxfjfx7bJOiGarmrDlEX70RfpE6rb9vI
	YnuQoyu0bhJgYR/k3DCYLqHWlLTVipDfeusYXJwSZFloglv1gq+7aURVMkG0ivGPXNq+rjWq600
	8DOWK7xbz6W+BVpZ2hmtKa2p2wAPPjTvqfHtBsN903SBlab93vw77tjIBYmPHYpvJO9W6zPBZvb
	khuK/9DzQ6HM5w142o2iVB7o7Er1e2S1ublL1hFGU8ttgxgS5cro+Z7DPi003D0oGDy6nWA1uTQ
	WiU/ZyIbZBuTe6c7lG7WIbNGhu6YH1q+UebIT92gW5JMKvxVZ7AFHSOOvEDO6QnnHzLOI0cFjwF
	ogwvTTcZ3q3QO4f4ZjuyGMz08JT7n2Nr7nTBvTI2m/kkvdSU+LJSw3fpmR1cO4Cd/IjcUkIGVIi
	ccJJAK/VOBzY98Xw==
X-Google-Smtp-Source: AGHT+IHpPW7Sc9vCqGKgvv+ArrMlVJXYKQRzM7WdUX5uPBrdUZ9D6nYP09kf9RuD6MHojf9jBsaXlQ==
X-Received: by 2002:a17:907:2da5:b0:b46:6718:3f20 with SMTP id a640c23a62f3a-b7654f300f5mr129118666b.48.1763599779148;
        Wed, 19 Nov 2025 16:49:39 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d3ecsm797235a12.17.2025.11.19.16.49.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Nov 2025 16:49:38 -0800 (PST)
Date: Thu, 20 Nov 2025 00:49:37 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/huge_memory: fix NULL pointer deference when
 splitting folio
Message-ID: <20251120004937.lkczokv5mdo6dy4u@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251119235302.24773-1-richard.weiyang@gmail.com>
 <20251120000312.xasxdzmmztvp4spa@master>
 <20251119164650.e5ac7e3b5fa6062016652149@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119164650.e5ac7e3b5fa6062016652149@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Nov 19, 2025 at 04:46:50PM -0800, Andrew Morton wrote:
>On Thu, 20 Nov 2025 00:03:12 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> +	 * TODO: this will also currently refuse shmem folios that are in the
>> >+	 * swapcache.
>> >+	 */
>> >+	if (!is_anon && !folio->mapping)
>> >+		return -EBUSY;
>> >+
>> 
>> This one would have a conflict on direct cherry-pick to current master and
>> mm-stable.
>> 
>> But if I move this code before (folio != page_folio(split_at) ...), it could
>> be apply to mm-new and master/mm-stable smoothly.
>> 
>> Not sure whether this could make Andrew's life easier.
>
>I added the below and fixed up fallout in the later patches.
>
>If this doesn't apply to -stable kernels then the -stable maintainers
>might later ask you to help rework it.
>

OK, got it.

>
>
>From: Wei Yang <richard.weiyang@gmail.com>
>Subject: mm/huge_memory: fix NULL pointer deference when splitting folio
>Date: Wed, 19 Nov 2025 23:53:02 +0000
>
>Commit c010d47f107f ("mm: thp: split huge page to any lower order pages")
>introduced an early check on the folio's order via mapping->flags before
>proceeding with the split work.
>
>This check introduced a bug: for shmem folios in the swap cache and
>truncated folios, the mapping pointer can be NULL.  Accessing
>mapping->flags in this state leads directly to a NULL pointer dereference.
>
>This commit fixes the issue by moving the check for mapping != NULL before
>any attempt to access mapping->flags.
>
>Link: https://lkml.kernel.org/r/20251119235302.24773-1-richard.weiyang@gmail.com
>Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>Cc: <stable@vger.kernel.org>
>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>---
>
> mm/huge_memory.c |   22 ++++++++++------------
> 1 file changed, 10 insertions(+), 12 deletions(-)
>
>--- a/mm/huge_memory.c~mm-huge_memory-fix-null-pointer-deference-when-splitting-folio
>+++ a/mm/huge_memory.c
>@@ -3619,6 +3619,16 @@ static int __folio_split(struct folio *f
> 	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
> 		return -EINVAL;
> 
>+	/*
>+	 * Folios that just got truncated cannot get split. Signal to the
>+	 * caller that there was a race.
>+	 *
>+	 * TODO: this will also currently refuse shmem folios that are in the
>+	 * swapcache.
>+	 */
>+	if (!is_anon && !folio->mapping)
>+		return -EBUSY;
>+
> 	if (new_order >= folio_order(folio))
> 		return -EINVAL;
> 
>@@ -3659,18 +3669,6 @@ static int __folio_split(struct folio *f
> 		gfp_t gfp;
> 
> 		mapping = folio->mapping;
>-
>-		/* Truncated ? */
>-		/*
>-		 * TODO: add support for large shmem folio in swap cache.
>-		 * When shmem is in swap cache, mapping is NULL and
>-		 * folio_test_swapcache() is true.
>-		 */
>-		if (!mapping) {
>-			ret = -EBUSY;
>-			goto out;
>-		}
>-
> 		min_order = mapping_min_folio_order(folio->mapping);
> 		if (new_order < min_order) {
> 			ret = -EINVAL;
>_

-- 
Wei Yang
Help you, Help me

