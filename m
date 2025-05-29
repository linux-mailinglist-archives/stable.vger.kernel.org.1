Return-Path: <stable+bounces-148085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65925AC7C47
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 12:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CC4A22533
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7467628E570;
	Thu, 29 May 2025 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3cr/Aiv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5E21C176;
	Thu, 29 May 2025 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515918; cv=none; b=fuK+5atI4KYOIARMJYK1zLzPlIpqXkS5ymIK55IOJ69oCfp2h26zEk5Y+idm9SuWfPEa3+/YVzfzE/QF6+aB4o4OtNwdCSfjaZnBDYsVBe53RiV6/ORG5iHodQnj31DM/FZgZI6LP5kb0LlujPcNmSa6/o50H7LRxGYU6ZfbXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515918; c=relaxed/simple;
	bh=CV3Segr+veKxtyhySTzj+LnOToA4J4nvptR6pD+VoRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIvHkrlUVtlEwpIDMy++O1SSfcJSsZ4qty8wjizKiQ8v4WvLG9bRN+4laPx/EAbqXWAxGavlCLkCnsvjiBwb3aFZZyIyZnDkkN33cF+XZiCXYEMXDDWMKgLjbDGezEAiBzdId+59AH+cpghhWFL7WM3XbJ9xEmiyRSl89OVrR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3cr/Aiv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748515916; x=1780051916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CV3Segr+veKxtyhySTzj+LnOToA4J4nvptR6pD+VoRE=;
  b=D3cr/AivU2cmoclyZK+wicu9OkTmcjA4TklIepDvMGrboewZHH2/TIqM
   eTiBUSIVbAr2cZpyK/JUjU3+2aArna7OFsfLr01AKK8JTNNHgy5YE6UWM
   icejfI60AUeqNsOfoOjvrkAkYhKTJoKRWNtOLk7NAhk9VayIkvC61u1kW
   nGFAdAcoeUssURXll9S2UlOGEIfAenjGVATFK5uSRnowtmYv00VavwnUG
   RsrPNfNlfVbmWhAhhs17wajKyboTJmDnMmxk+ERSmnvfNTVferHL7HBzm
   Ib817oW3EStgEzqil0UQQgS/Pqw1G7VbsdggOxB4sHGDRGAClILFzMyTU
   A==;
X-CSE-ConnectionGUID: guUTZH4gQ+2gY+ppBH7fww==
X-CSE-MsgGUID: drkAJ/UESXKnUPi2k5uM6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="38193296"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="38193296"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 03:51:55 -0700
X-CSE-ConnectionGUID: zDBZD/qxTgOe40wSfVsqqw==
X-CSE-MsgGUID: l4kaQccHQHq7ivgnE+yDOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="180722481"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 29 May 2025 03:51:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B8FE914B; Thu, 29 May 2025 13:51:48 +0300 (EEST)
Date: Thu, 29 May 2025 13:51:48 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Vlastimil Babka <vbabka@suse.cz>, 
	Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hongyu Ning <hongyu.ning@linux.intel.com>, 
	stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm: Fix vmstat after removing NR_BOUNCE
Message-ID: <scchmajjawfmmoreihui4yyzuyutzf3evhmmx2j4f2lhu6r62n@ovaamezmqgun>
References: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
 <7ae9e9f9-80e7-4285-83f0-a0946d238243@suse.cz>
 <ow3adiccumedegsm4agxlvaiaq3ypeto42hxr4ln6v3zzluhyu@2cdoez7of6ic>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ow3adiccumedegsm4agxlvaiaq3ypeto42hxr4ln6v3zzluhyu@2cdoez7of6ic>

On Thu, May 29, 2025 at 01:47:10PM +0300, Kirill A. Shutemov wrote:
> On Thu, May 29, 2025 at 12:40:21PM +0200, Vlastimil Babka wrote:
> > On 5/29/25 12:38, Kirill A. Shutemov wrote:
> > > Hongyu noticed that the nr_unaccepted counter kept growing even in the
> > > absence of unaccepted memory on the machine.
> > > 
> > > This happens due to a commit that removed NR_BOUNCE: it removed the
> > > counter from the enum zone_stat_item, but left it in the vmstat_text
> > > array.
> > > 
> > > As a result, all counters below nr_bounce in /proc/vmstat are
> > > shifted by one line, causing the numa_hit counter to be labeled as
> > > nr_unaccepted.
> > > 
> > > To fix this issue, remove nr_bounce from the vmstat_text array.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > > Fixes: 194df9f66db8 ("mm: remove NR_BOUNCE zone stat")
> > > Cc: stable@vger.kernel.org
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Hannes Reinecke <hare@suse.de>
> > > Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > Cc: Jens Axboe <axboe@kernel.dk>
> > 
> > Is there a way to add a BUILD_BUG_ON to catch a future case like this one?
> 
> There's
> 
> 	BUILD_BUG_ON(ARRAY_SIZE(vmstat_text) < NR_VMSTAT_ITEMS);
> 
> in vmstat_start().
> 
> Making it strict != seems to do the trick for my config. But it requires
> wider testing.
> 
> I can prepare a patch for that.

There was a strict check before 9d7ea9a297e6 ("mm/vmstat: add helpers to
get vmstat item names for each enum type"). Not sure if changing != to <
was intentional.

Konstantin?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

