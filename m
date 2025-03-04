Return-Path: <stable+bounces-120202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B18A4D2FD
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 06:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4547A8AE8
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 05:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD4158868;
	Tue,  4 Mar 2025 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LAqEY2Bm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F812905;
	Tue,  4 Mar 2025 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066273; cv=none; b=JV8pbHwo7zRKGoq5MBLCQ5Y3Cn7we5xsQsbEvqjsoqk92F7X++SI1nyM/LCYfuuZSdKiAJHp1wHAR1KSzuDAO8ZR2PFnfuucqm87nZa/CNBo8CnzL843l/MSEEEIR/UPw4T+4xRkHMG3QfJe8SAdxYJCEtIg97QZ60cnJfYpp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066273; c=relaxed/simple;
	bh=XOlyYoS+DYZzzpqMtqdefvheJDjjcKhfo/KUx+jL+mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFxBYMjQ9T+MOAdGThUr7ypw/TL1Pb51CEKtUu6LeMB/2iwwO/ju+42FmueS85dukfZ+HkvBdcCH0q40i6JaEI0/Xpsu5C/vO1ihr1eTamxyECyIkkI2H9ZG4CTZRYg06CIiiQ4bBuFyRckklRCwsb4OfUQS8+RMKTs32jmBIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LAqEY2Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082D6C4CEE5;
	Tue,  4 Mar 2025 05:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741066272;
	bh=XOlyYoS+DYZzzpqMtqdefvheJDjjcKhfo/KUx+jL+mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAqEY2BmguNwPwzhfQ48ubVXpbewXHohiWkbtc1CivNRjq0lKKTbdjZ2bycuuVsKi
	 NDGnJ6lYzINGjiiQ95PE+ZZXQ8Q8+NNZKXNqiwIBbo1k6cLp0Gp9xyBGHwzBy4DpzF
	 ZPEF3pPw0hOB2zNhjomd98mFvfybgkAx+3RqGAo0=
Date: Tue, 4 Mar 2025 06:30:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Liu Shixin <liushixin2@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	linux-kernel@vger.kernel.org, Shivank Garg <shivankg@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: fix shmem xarray update during migration
Message-ID: <2025030437-posting-barbecue-94af@gregkh>
References: <20250228174953.2222831-1-ziy@nvidia.com>
 <16838F71-3E96-4EFE-BDA1-600C33F75D36@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16838F71-3E96-4EFE-BDA1-600C33F75D36@nvidia.com>

On Mon, Mar 03, 2025 at 09:03:04PM -0500, Zi Yan wrote:
> On 28 Feb 2025, at 12:49, Zi Yan wrote:
> 
> > Pagecache uses multi-index entries for large folio, so does shmem. Only
> > swap cache still stores multiple entries for a single large folio.
> > Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
> > fixed swap cache but got shmem wrong by storing multiple entries for
> > a large shmem folio. Fix it by storing a single entry for a shmem
> > folio.
> >
> > Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
> > Reported-by: Liu Shixin <liushixin2@huawei.com>
> > Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com/
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > Reviewed-by: Shivank Garg <shivankg@amd.com>
> 
> +Cc:stable
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

