Return-Path: <stable+bounces-192410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B97C31990
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 15:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFFEC343056
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14D132E6AE;
	Tue,  4 Nov 2025 14:46:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715A322C9D
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267612; cv=none; b=a5E0Re2XGMbKkXB4PPp93s+youer+cdOZKjXyMajDwP5GWJOu2r+c6Zf6YoD60q87HPluPpbTWa/MWx/QJpPC8E9FePcKAq+3D/21c1MZyMawnXwjcHhmRo7Z8MfUTVTwEEC0co9sotia+SFG+C7cl48heeRLxxn/9JfxqhlGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267612; c=relaxed/simple;
	bh=GphgxYdCpmAtE7BuavJRosM3ZktLUukwXQSCYOFCvOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+BDx3MwSEGBWzHXpGVS6pOcw2xE64nZcAclN8kQnjrEuAa0rcvE5vfxftNTjOWJz4e1rx5fWg6ybdVqH+98ByBXRfKClbgeqe9/IDUUbta+8/SRl1+hu7bFHAxqimMGKUx1cTXUY7WV1fVGgOMVwkJF13bSCRMbpOaTLoDB/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 4 Nov 2025 23:46:40 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 4 Nov 2025 23:46:40 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: swap: remove duplicate nr_swap_pages
 decrement in get_swap_page_of_type()
Message-ID: <aQoR0MxfITbuj9sF@yjaykim-PowerEdge-T330>
References: <20251102082456.79807-1-youngjun.park@lge.com>
 <20251103185608.84b2d685fe0ae4596307b878@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103185608.84b2d685fe0ae4596307b878@linux-foundation.org>

On Mon, Nov 03, 2025 at 06:56:08PM -0800, Andrew Morton wrote:
> On Sun,  2 Nov 2025 17:24:56 +0900 Youngjun Park <youngjun.park@lge.com> wrote:
> 
> > After commit 4f78252da887, nr_swap_pages is decremented in
> > swap_range_alloc(). Since cluster_alloc_swap_entry() calls
> > swap_range_alloc() internally, the decrement in get_swap_page_of_type()
> > causes double-decrementing.
> > 
> > Remove the duplicate decrement.
> 
> Can we please have a description of the userspace-visible runtime
> effects of the bug?
> > Fixes: 4f78252da887 ("mm: swap: move nr_swap_pages counter decrement from folio_alloc_swap() to swap_range_alloc()")
> > Cc: stable@vger.kernel.org # v6.17-rc1
> 
> Especially when proposing a backport.
> 
> Thanks.

Hi Andrew,

Thank you for picking up the patch. Since it's already in mm-hotfixes-unstable,
I'm providing the elaboration here rather than sending v3.

As a representative userspace-visible runtime example of the impact,
/proc/meminfo reports increasingly inaccurate SwapFree values. The
discrepancy grows with each swap allocation, and during hibernation when
large amounts of memory are written to swap, the reported value can deviate
significantly from actual available swap space, misleading users and
monitoring tools. 

Best Regards,
Youngjun

