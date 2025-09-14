Return-Path: <stable+bounces-179560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4924CB56745
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 09:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31C717F397
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 07:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6F51F874C;
	Sun, 14 Sep 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="peF/10ck"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5772610;
	Sun, 14 Sep 2025 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757835979; cv=none; b=lASKfrSijUp4I61fkYPMw4YSJ8Q7FHQczMpKijd7AlKr1N6OlCW5j8s+aM4npX9Do5anLC7fbqSoPkOeQoHg1De0m6pLJcE7Chb+VaKdn247aAS6dTXXCFp/X+0RJrdMj2QOwitxwy1RW2wht3WfDlF4Lv0rRzigfXEB8JDz/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757835979; c=relaxed/simple;
	bh=uRoR8HF+Jj93KvQtO8TpSGfoT2TfKi54xjzjuPQ1C4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPzQkc1mzpaEWeFUjz0UnCdQxEyXRMb6CeH5sIpasVMzFcNC6cIDR8EVm8qGTOWqSyoPjvnp4Z+pvWpKv90ztKNbgOR0UAyJuSoWyi/JLrZwp/ErndUAwLqL984oNV5+tUkIBCNypIk2wRfDWkZMWN4Q5KWlnc32UZj3b4nTe2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=peF/10ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10353C4CEF0;
	Sun, 14 Sep 2025 07:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757835975;
	bh=uRoR8HF+Jj93KvQtO8TpSGfoT2TfKi54xjzjuPQ1C4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peF/10ck23Rt+vFIAstmyQGLbn+bo3R01SX+81aamcQSLfpMCD2vbQR3vDPMN27uK
	 4gkcOXHyYB9kcZHkxTSY4wom6Fbvide8Nhs0XjnwSsgOLueiTpej38SNa33NskVg2o
	 ExuFP8ahJ16MLV/SxhsOOfpyEL28PCIKg/9lm7Gg=
Date: Sun, 14 Sep 2025 09:46:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	ze zuo <zuoze1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/damon/lru_sort: avoid divide-by-zero in
 damon_lru_sort_apply_parameters()
Message-ID: <2025091402-errand-pegboard-a439@gregkh>
References: <20250914033350.2284-1-sj@kernel.org>
 <20250914033711.2344-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914033711.2344-1-sj@kernel.org>

On Sat, Sep 13, 2025 at 08:37:11PM -0700, SeongJae Park wrote:
> On Sat, 13 Sep 2025 20:33:50 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > From: Quanmin Yan <yanquanmin1@huawei.com>
> > 
> > Patch series "mm/damon: avoid divide-by-zero in DAMON module's parameters
> > application".
> > 
> > DAMON's RECLAIM and LRU_SORT modules perform no validation on
> > user-configured parameters during application, which may lead to
> > division-by-zero errors.
> > 
> > Avoid the divide-by-zero by adding validation checks when DAMON modules
> > attempt to apply the parameters.
> > 
> > This patch (of 2):
> > 
> > During the calculation of 'hot_thres' and 'cold_thres', either
> > 'sample_interval' or 'aggr_interval' is used as the divisor, which may
> > lead to division-by-zero errors.  Fix it by directly returning -EINVAL
> > when such a case occurs.  Additionally, since 'aggr_interval' is already
> > required to be set no smaller than 'sample_interval' in damon_set_attrs(),
> > only the case where 'sample_interval' is zero needs to be checked.
> > 
> > Link: https://lkml.kernel.org/r/20250827115858.1186261-2-yanquanmin1@huawei.com
> > Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
> > Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> > Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Cc: ze zuo <zuoze1@huawei.com>
> > Cc: <stable@vger.kernel.org>	[6.0+]
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > (cherry picked from commit 711f19dfd783ffb37ca4324388b9c4cb87e71363)
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> FYI, the commit was able to be cleanly cherry-picked, but seems it caused a
> build error, similar to that [1] for 6.1.y.  This patch fixes the build error.
> 
> [1] https://lore.kernel.org/20250914033221.49447-1-sj@kernel.org

Wonderful, thank you.

greg k-h

