Return-Path: <stable+bounces-192454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D48CC3334B
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 23:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837D7188BCAB
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 22:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61322877C3;
	Tue,  4 Nov 2025 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="k55W2weX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF61DF74F
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295086; cv=none; b=drtqnpo+25sPcp1/EJgEraMo+WEajmvkXbjDomx6UQuWQ9I2bYRhk2rrUfbdj3UrGXd+LkAfe1dJUcthRT6n4+yRho/QhZXU2j+DXIPyJqrgSFLV2OazvHqTJgvO/oXMOSJ2++ry8I5QqfieWlvDpBg8GcmxA7E1jIAP6GSa/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295086; c=relaxed/simple;
	bh=LtiM9kM1E4WpynYnWVmMW5Swio+KvwnsEioEDooha5I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d3ycYURvzO+dzDAd0ODg7LiaYRmJE/pg2R0OJtABNX2mIHoWeI1uYIIbo+fe7GjAOC/k6T6n2M2hOUhvIbE9r7W4tnTGqsXBerNjQoyNzNLqpHAsyrkjCp68kGlv3ozaLTZPBuK3hPJqUIwerfsSgMmAjZpo4jUwqjbqu6wamj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=k55W2weX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEE9C4CEF7;
	Tue,  4 Nov 2025 22:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762295086;
	bh=LtiM9kM1E4WpynYnWVmMW5Swio+KvwnsEioEDooha5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k55W2weXz5QLrUx7/EGmnM9f9o1yd7C9lmRdx4eUCBvC+3r1zZjn/y3JezTbd+QSF
	 N9LcGAsObgVsQl8lbvzWuuY8/ozHgV88sYmGgMLVmlbir61lBizHUb095JnbZjQH22
	 o6/Zm0QMhqwCFQXzXM9Ru7MzXh4YHGiRgoGHxhyA=
Date: Tue, 4 Nov 2025 14:24:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song
 <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li
 <chrisl@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: swap: remove duplicate nr_swap_pages
 decrement in get_swap_page_of_type()
Message-Id: <20251104142445.47e68d38b36c81aa304b55cc@linux-foundation.org>
In-Reply-To: <aQoR0MxfITbuj9sF@yjaykim-PowerEdge-T330>
References: <20251102082456.79807-1-youngjun.park@lge.com>
	<20251103185608.84b2d685fe0ae4596307b878@linux-foundation.org>
	<aQoR0MxfITbuj9sF@yjaykim-PowerEdge-T330>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Nov 2025 23:46:40 +0900 YoungJun Park <youngjun.park@lge.com> wrote:

> > Can we please have a description of the userspace-visible runtime
> > effects of the bug?
> > > Fixes: 4f78252da887 ("mm: swap: move nr_swap_pages counter decrement from folio_alloc_swap() to swap_range_alloc()")
> > > Cc: stable@vger.kernel.org # v6.17-rc1
> > 
> > Especially when proposing a backport.
> > 
> > Thanks.
> 
> Hi Andrew,
> 
> Thank you for picking up the patch. Since it's already in mm-hotfixes-unstable,
> I'm providing the elaboration here rather than sending v3.
> 
> As a representative userspace-visible runtime example of the impact,
> /proc/meminfo reports increasingly inaccurate SwapFree values. The
> discrepancy grows with each swap allocation, and during hibernation when
> large amounts of memory are written to swap, the reported value can deviate
> significantly from actual available swap space, misleading users and
> monitoring tools. 

Great, thanks, very helpful.  I pasted that into the mm.git copy of
this patch.


