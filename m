Return-Path: <stable+bounces-8229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FB881B015
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 09:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566321C23CF6
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 08:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE76915ADF;
	Thu, 21 Dec 2023 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vQD+RIVG"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D565171B3
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Dec 2023 17:13:53 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703146441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AV2iiAqyq00fHe/5088mCAsv06De78IbBp0kBt3t0iM=;
	b=vQD+RIVG0cRtAsQgXlqEwKySRipmxVWZmJdeN0w5926nWoMgps8RcjD59PEvaUa3658zlT
	0YSkTsTWd3yfHpbe2sCH5oqWpLmggNirhyMZ7d3WyfzJnMMdDzuO4jhNKPQk3JceG9c4MR
	6bbQ1Qzojgp1daIPIhRQofEZiGOXIQo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Dan Williams <dan.j.williams@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/memory-failure: Cast index to loff_t before
 shifting it
Message-ID: <20231221081353.GB1295773@ik1-406-35019.vs.sakura.ne.jp>
References: <20231218135837.3310403-1-willy@infradead.org>
 <20231218135837.3310403-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218135837.3310403-4-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 18, 2023 at 01:58:37PM +0000, Matthew Wilcox (Oracle) wrote:
> On 32-bit systems, we'll lose the top bits of index because arithmetic
> will be performed in unsigned long instead of unsigned long long.  This
> affects files over 4GB in size.
> 
> Fixes: 6100e34b2526 ("mm, memory_failure: Teach memory_failure() about dev_pagemap pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

