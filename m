Return-Path: <stable+bounces-66547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D39294EFB5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2454B251C8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB1017E44F;
	Mon, 12 Aug 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C3xnwVuW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCF916B38D
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473349; cv=none; b=IBnIFMwvrrn57I+B7lVQnyD/GxtKSHuCYfaXk6QArHIubGxTB9UlFi7tFFCoa1Fvn+HqQhm+MfH91dExu2j/vHmRjoE3XdVLQt464nh9MmsQMEjsXQHHhpW4XWE1smE2kfUph6d3OZdenEowsKuS4HfVLOF9p+QIxdZ++Bx7Dlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473349; c=relaxed/simple;
	bh=CfDSOqL02TAiHPPxT/1ThkFvUcXAwUflzWvTdzJ4Z5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtDR94WmzRmKAKR4F130Ke4Se1924eYuBWZXpySo6Ee4jBd7340PqD0/4OFJzymhBKccOORZurOXmDR3uoX/QsajhiUnmeCMXLyC/5kypuiRuerP/beJgs5ziYgPsk4hn7sghZJqr8F8SPSzO1IaYv0yUeApdD+kfzw+7SDp9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C3xnwVuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90686C32782;
	Mon, 12 Aug 2024 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723473349;
	bh=CfDSOqL02TAiHPPxT/1ThkFvUcXAwUflzWvTdzJ4Z5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3xnwVuWkCgD1yVqITQhlMVphuB04hb7J1393zlTOBBWCVCpXQMq6P3mkwH7tQICP
	 sdvuQ6oMQl3G8pnXYsp+jf8BiwcgG4Lur05Ju2aAFSZpWfdArhV6cGypfNbPgnqd2Y
	 yQo5pPUIGLDjLMXd63T9M1h1C7A1f68s9wOBuw4I=
Date: Mon, 12 Aug 2024 16:35:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/hugetlb: fix potential race in
 __update_and_free_hugetlb_folio()
Message-ID: <2024081233-narrow-oaf-05da@gregkh>
References: <2024071559-unroasted-trapper-8b66@gregkh>
 <20240807035853.1489074-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807035853.1489074-1-linmiaohe@huawei.com>

On Wed, Aug 07, 2024 at 11:58:53AM +0800, Miaohe Lin wrote:
> There is a potential race between __update_and_free_hugetlb_folio() and
> try_memory_failure_hugetlb():
> 
>  CPU1					CPU2
>  __update_and_free_hugetlb_folio	try_memory_failure_hugetlb
> 					 folio_test_hugetlb
> 					  -- It's still hugetlb folio.
>   folio_clear_hugetlb_hwpoison
>   					  spin_lock_irq(&hugetlb_lock);
> 					   __get_huge_page_for_hwpoison
> 					    folio_set_hugetlb_hwpoison
> 					  spin_unlock_irq(&hugetlb_lock);
>   spin_lock_irq(&hugetlb_lock);
>   __folio_clear_hugetlb(folio);
>    -- Hugetlb flag is cleared but too late.
>   spin_unlock_irq(&hugetlb_lock);
> 
> When the above race occurs, raw error page info will be leaked.  Even
> worse, raw error pages won't have hwpoisoned flag set and hit
> pcplists/buddy.  Fix this issue by deferring
> folio_clear_hugetlb_hwpoison() until __folio_clear_hugetlb() is done.  So
> all raw error pages will have hwpoisoned flag set.
> 
> Link: https://lkml.kernel.org/r/20240708025127.107713-1-linmiaohe@huawei.com
> Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 5596d9e8b553dacb0ac34bcf873cbbfb16c3ba3e)
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Backports now queued up, thanks.

greg k-h

