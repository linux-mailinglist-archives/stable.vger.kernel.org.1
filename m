Return-Path: <stable+bounces-8285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1898D81C2AD
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 02:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40EB281DA7
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 01:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69EA23;
	Fri, 22 Dec 2023 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c8a9ks3y"
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868FA2906
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 Dec 2023 10:23:48 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703208236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qJRNr9giEq/71KVpxfihkTPoPWw449NvldKPv/jlnco=;
	b=c8a9ks3yzhb9fWE5RD1d3/XVbtcd6OWpztxgvXJpQY4oX0uPFfRWY4W5i5WyrWfiLOY2l0
	iaameRwp6Ty4nQRQrQUin1S+H+FU1Egx+hUCNOgK9bTYImlJGpbIFAoaKxpX7uDcR6AB6V
	RfDxxgu1hmuy/yCYGDwMEMBuluYujgk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Dan Williams <dan.j.williams@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/memory-failure: Check the mapcount of the precise
 page
Message-ID: <20231222012348.GA1572627@ik1-406-35019.vs.sakura.ne.jp>
References: <20231218135837.3310403-1-willy@infradead.org>
 <20231218135837.3310403-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218135837.3310403-3-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 18, 2023 at 01:58:36PM +0000, Matthew Wilcox (Oracle) wrote:
> A process may map only some of the pages in a folio, and might be missed
> if it maps the poisoned page but not the head page.  Or it might be
> unnecessarily hit if it maps the head page, but not the poisoned page.
> 
> Fixes: 7af446a841a2 ("HWPOISON, hugetlb: enable error handling path for hugepage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

