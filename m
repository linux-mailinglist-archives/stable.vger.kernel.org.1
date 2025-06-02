Return-Path: <stable+bounces-148898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CBDACA8B7
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 07:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F78177C99
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F8444C63;
	Mon,  2 Jun 2025 05:01:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D342C325B;
	Mon,  2 Jun 2025 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748840493; cv=none; b=EMSNPHukTjthRn45qOg6P9hR+s4VadFlTmqNNxfA7lrn6mNfzLjoFmSWzqziu4Q0stbzLyTfZ4luQxua9gg+VEt+W9PLLep9deK/fzNHE9mdQBtcKRZKLyjVqKDoj36x3pI+91v8n91OJRo1qww8Unizt0GaOPE1G7jdbEWTmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748840493; c=relaxed/simple;
	bh=CkzyrVKBqeDESZDeEtPTudQj9SBDw/o+5BJY/pHtw/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzbmGfMMp+5YA8BFlbWt8gfdkqBFlqkHPLcFCZ00iUCF5ldvSf3vJfkUJrQCCaQD7ppSMI9d7ZSdXRHLxfghagN6Hv/HTbvbHhqOrSGwLe2zrKXM3pEXA2lR908CxeaV/dZf0hoKBIHNt8slDt2heHH8rX46xpML126g0QqpUKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E49E68C7B; Mon,  2 Jun 2025 07:01:27 +0200 (CEST)
Date: Mon, 2 Jun 2025 07:01:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hongyu Ning <hongyu.ning@linux.intel.com>, stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm: Fix vmstat after removing NR_BOUNCE
Message-ID: <20250602050126.GB21716@lst.de>
References: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 29, 2025 at 01:38:32PM +0300, Kirill A. Shutemov wrote:
> Hongyu noticed that the nr_unaccepted counter kept growing even in the
> absence of unaccepted memory on the machine.
> 
> This happens due to a commit that removed NR_BOUNCE: it removed the
> counter from the enum zone_stat_item, but left it in the vmstat_text
> array.
> 
> As a result, all counters below nr_bounce in /proc/vmstat are
> shifted by one line, causing the numa_hit counter to be labeled as
> nr_unaccepted.
> 
> To fix this issue, remove nr_bounce from the vmstat_text array.

Ooops, yes:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4c268ce39ff2..ae9882063d89 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1201,7 +1201,6 @@ const char * const vmstat_text[] = {
>  	"nr_zone_unevictable",
>  	"nr_zone_write_pending",
>  	"nr_mlock",
> -	"nr_bounce",
>  #if IS_ENABLED(CONFIG_ZSMALLOC)
>  	"nr_zspages",
>  #endif

It would be really useful if such pretty printing arrays used
named initializers, as that would make it obvious that an entry
needs removal.


