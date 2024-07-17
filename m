Return-Path: <stable+bounces-60437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A053933CCD
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 14:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517CB282458
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E3718004E;
	Wed, 17 Jul 2024 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AkL4UWH0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A814A17F4FD
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218013; cv=none; b=OsCakmAHds3Sa1e3L7kMwN8MavMmFVWLy3fDngTjZIaosrtYxmFNRjKvFq9SikmL/3ZHgLFPQKCgJXUCjZkujP4CV9IBQgXDWJ68Gy1K1KvSlNFn4jBDYxQnYTXkPM9K8lNRGj42doGst1DibUQvHGRqMQsL2ox+yu1MSFDCOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218013; c=relaxed/simple;
	bh=yvH1bJuJPMDl0yHsKJUGXDy0li3oZEpOxlcFwqBzU0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAHW8UawhNTg80nBAsAB/zHuT61WNcCtXwZE5s8Xsyo0pmzMb6/agHxi2cP2vHOHYojFNWw2q7QxH9cqz2Nz62H0aMm3dg4QcLBQvFNkYXoU7mY5DuaR189DergNcEGyVzTfLXEKZpAe1VCbUSpT5lla6Op6C3Mns/rpl76on68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AkL4UWH0; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58c947a6692so8263782a12.0
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721218008; x=1721822808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1A+uhvZFWN0/aI6TtzrTAyQXjVBtroZMv7k34eBegwY=;
        b=AkL4UWH0fjTo7/yr1I7J0TuJVaNgAI0ni3u0+qPBBRiwa2Ij2HWtnwnnDM3JEsJVBM
         AcE81Vvhm40dS2FytehJdawA0P+MxrZeGAsvruEXemt56Nfta1bKKNsIMpewCXDjZVnO
         7b//JTWbo9NXilIPE4RtKN/PLN3KFPokufLMlnGSbR0ru1ZKE2zvxzw3bjSI8QR2KufY
         ZhXvocpbvRqNSt/xCCgkQetf5GnBESeMiJujUjRYesLLqNatPvCcGR8pghQZWzE5qOj1
         6Mg6uQCOk6sKR4ZoIUtWuyVzE4L8u/bhIlCJH/RkS994CTRiIjn6ul4Uvz4F7tJ8Dqlr
         XNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721218008; x=1721822808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A+uhvZFWN0/aI6TtzrTAyQXjVBtroZMv7k34eBegwY=;
        b=w61JMA3lvHwLwBE4yJHgu7OKXOfq25QD1bxOXHJEBC86ZFBpvmE65YSGYdo9i0sSUr
         WE/xyxlAw4AuIx9u2guro5cyO50UEWVm4REjiVzNgcWwXMu5FO3rcRv7STnE72bnuqhV
         BDoCvn3yDXYM3eT/YBmBT3178DiJkbjBM44GLxy2CBrpae8ribgq95Sb7VBNIpqeADrX
         t0EWNX/PBg01jKUHYfINWNBdCYNAx7kIw8en3psoGkWe+skqzDQelIs7+2o/091rzd37
         akDMv4AuudQY8Ry/xaTP+u1PJGTDcyEnsawmfdBt4qWO+CbZ7dMhhbZh+Y1ZUA3HSz39
         Dbwg==
X-Forwarded-Encrypted: i=1; AJvYcCWd0cq4azLfI8noeh0AE9Pdrp7atD9n9lONZUGZtKi44zAQ2cw9SUol4md3T2VBQMevgKt5usmI9aiC61N4bLZ0aK1lNkU4
X-Gm-Message-State: AOJu0Yzuo1Y75zeiFsZwtdVF/zlFtFg8UlTRokReh8I+HXhbC7AqxA2U
	UWy6XSVCZ/Rwczz8hBj3/MWo3v38o4eisN62L58ekkbrx0lQmGVGsV8NTaVPpBE=
X-Google-Smtp-Source: AGHT+IFKEQnsVc87r2NlBgc3y7tiA0/99uSXp6CQ8sd9Ors0/3XF6WibUv9rRg2aDIdfojAjEABnDQ==
X-Received: by 2002:a50:c30a:0:b0:59e:b95d:e748 with SMTP id 4fb4d7f45d1cf-5a05b416a9fmr1228473a12.8.1721218008012;
        Wed, 17 Jul 2024 05:06:48 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a0c2a750c0sm551431a12.60.2024.07.17.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 05:06:47 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:06:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jianxiong Gao <jxgao@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix endless reclaim on machines with unaccepted
 memory.
Message-ID: <Zpez1rkIQzVWxi7q@tiehlicka>
References: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
 <ZpdwcOv9WiILZNvz@tiehlicka>
 <xtcmz6b66wayqxzfio4funmrja7ezgmp3mvudjodt5xfx64rot@s6whj735oimb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xtcmz6b66wayqxzfio4funmrja7ezgmp3mvudjodt5xfx64rot@s6whj735oimb>

On Wed 17-07-24 14:55:08, Kirill A. Shutemov wrote:
> On Wed, Jul 17, 2024 at 09:19:12AM +0200, Michal Hocko wrote:
> > On Tue 16-07-24 16:00:13, Kirill A. Shutemov wrote:
> > > Unaccepted memory is considered unusable free memory, which is not
> > > counted as free on the zone watermark check. This causes
> > > get_page_from_freelist() to accept more memory to hit the high
> > > watermark, but it creates problems in the reclaim path.
> > > 
> > > The reclaim path encounters a failed zone watermark check and attempts
> > > to reclaim memory. This is usually successful, but if there is little or
> > > no reclaimable memory, it can result in endless reclaim with little to
> > > no progress. This can occur early in the boot process, just after start
> > > of the init process when the only reclaimable memory is the page cache
> > > of the init executable and its libraries.
> > 
> > How does this happen when try_to_accept_memory is the first thing to do
> > when wmark check fails in the allocation path?
> 
> Good question.
> 
> I've lost access to the test setup and cannot check it directly right now.
> 
> Reading the code Looks like __alloc_pages_bulk() bypasses
> get_page_from_freelist() where we usually accept more pages and goes
> directly to __rmqueue_pcplist() -> rmqueue_bulk() -> __rmqueue().
> 
> Will look more into it when I have access to the test setup.
> 
> > Could you describe what was the initial configuration of the system? How
> > much of the unaccepted memory was there to trigger this?
> 
> This is large TDX guest VM: 176 vCPUs and ~800GiB of memory.
> 
> One thing that I noticed that the problem is only triggered when LRU_GEN
> enabled. But I failed to identify why.
> 
> The system hang (or have very little progress) shortly after systemd
> starts.

Please try to investigate this further. The patch as is looks rather
questionable to me TBH. Spilling unaccepted memory into the reclaim
seems like something we should avoid if possible as this is something
page allocator should care about IMHO.

> > > To address this issue, teach shrink_node() and shrink_zones() to accept
> > > memory before attempting to reclaim.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Reported-by: Jianxiong Gao <jxgao@google.com>
> > > Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
> > > Cc: stable@vger.kernel.org # v6.5+
> > [...]
> > >  static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> > >  {
> > >  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
> > >  	struct lruvec *target_lruvec;
> > >  	bool reclaimable = false;
> > >  
> > > +	/* Try to accept memory before going for reclaim */
> > > +	if (node_try_to_accept_memory(pgdat, sc)) {
> > > +		if (!should_continue_reclaim(pgdat, 0, sc))
> > > +			return;
> > > +	}
> > > +
> > 
> > This would need an exemption from the memcg reclaim.
> 
> Hm. Could you elaborate why?

Because memcg reclaim doesn't look for memory but rather frees charges
to reclaim for the new use so unaccepted memory is not really relevant
as it couldn't have been charged.
-- 
Michal Hocko
SUSE Labs

