Return-Path: <stable+bounces-8228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E381B012
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 09:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3597E283381
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151DF156F1;
	Thu, 21 Dec 2023 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bJPsA3Od"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5A15AD5
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Dec 2023 17:13:09 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703146399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlVlCHdINWUQiqZsia9JThp9Z+zsHuZHc773Y+yBfJU=;
	b=bJPsA3Oda69G/YgDW7AKSZx7jxGYdWTbIEBAvKafSZQ++oQcYmeZQy4udncX7wd3uHjmwb
	LZmmG54ZGk90Tts0lhezPfmLIMKxfzDBttEE27jbOmw9b3uxGZEKbGKel63aR+lvcoj4P7
	Sk5HJy+z+kVHNWj+ItUEMUOIyVUoUx4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Dan Williams <dan.j.williams@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/memory-failure: Pass the folio and the page to
 collect_procs()
Message-ID: <20231221081309.GA1295773@ik1-406-35019.vs.sakura.ne.jp>
References: <20231218135837.3310403-1-willy@infradead.org>
 <20231218135837.3310403-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218135837.3310403-2-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 18, 2023 at 01:58:35PM +0000, Matthew Wilcox (Oracle) wrote:
> Both collect_procs_anon() and collect_procs_file() iterate over the VMA
> interval trees looking for a single pgoff, so it is wrong to look for
> the pgoff of the head page as is currently done.  However, it is also
> wrong to look at page->mapping of the precise page as this is invalid
> for tail pages.  Clear up the confusion by passing both the folio and
> the precise page to collect_procs().
> 
> Fixes: 415c64c1453a ("mm/memory-failure: split thp earlier in memory error handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me, thank you.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

