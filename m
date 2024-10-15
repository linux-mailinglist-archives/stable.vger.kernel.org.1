Return-Path: <stable+bounces-85082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB899DC4D
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 04:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4272B282F70
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 02:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511EB16726E;
	Tue, 15 Oct 2024 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FqnEUUE+"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D545C8F0
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 02:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728959680; cv=none; b=aL/YOWQcVTg7gSW410tBikakUHnkN56MtMCTWPppv24mzWnN/UkUc5iwnwz15LxP66y/Cw7tXP0p0LeZ7nv+maXDFp4OXqavdxB3WXtS77s79+KEqkwVTMOLUu6ZG4L2jd/xrCNBCbCXBBsoPCzasiZ8zp1scBVLhB4cZSRCeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728959680; c=relaxed/simple;
	bh=J96PNxXho6AM9q+vz7DQJDchGvgBPPRFe2c29HGeAEk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eQ+JBhzvDKrdWAM4/LsKHOE1YVHA1lWxxBVBPPe0xffrJl4LfpKmHU7pfeFrpJPaV0kIlQDXFdx/7wxQriX97V/u/bBkgzyhUmyGCmcW2rpM40xOw/J2f1E73WY2/OPxThkMD+lG4FdQr43mW6OytZi8KiGiHSIul+7UnKHlMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FqnEUUE+; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728959675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCOSs8NjOrK7JCDidX00nNIZGkMQE0/GRhp6aQzYnlc=;
	b=FqnEUUE+n6RFWCBcWGCHCiNREKt4ZvKr2xxWT+4dBB12Rw2thW3r/wofD1pXVtoqaZtjoD
	m0y0dJO/97D8mgNQw/fEFGX9k5ebQzf4mXgwEXbo7rzQoZMSe6KiTYgpW/QzkCQ4RoAkJ2
	MUrhp0aMvdWTHWHdPKVGbE8RdfX78ns=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] mm/swapfile: skip HugeTLB pages for unuse_vma
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20241015014521.570237-1-liushixin2@huawei.com>
Date: Tue, 15 Oct 2024 10:33:36 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <ED9675B2-C82C-45D0-861B-48828553F53D@linux.dev>
References: <20241015014521.570237-1-liushixin2@huawei.com>
To: Liu Shixin <liushixin2@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On Oct 15, 2024, at 09:45, Liu Shixin <liushixin2@huawei.com> wrote:
> 
> I got a bad pud error and lost a 1GB HugeTLB when calling swapoff.
> The problem can be reproduced by the following steps:
> 
> 1. Allocate an anonymous 1GB HugeTLB and some other anonymous memory.
> 2. Swapout the above anonymous memory.
> 3. run swapoff and we will get a bad pud error in kernel message:
> 
>  mm/pgtable-generic.c:42: bad pud 00000000743d215d(84000001400000e7)
> 
> We can tell that pud_clear_bad is called by pud_none_or_clear_bad
> in unuse_pud_range() by ftrace. And therefore the HugeTLB pages will
> never be freed because we lost it from page table. We can skip
> HugeTLB pages for unuse_vma to fix it.
> 
> Fixes: 0fe6e20b9c4c ("hugetlb, rmap: add reverse mapping for hugepage")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


