Return-Path: <stable+bounces-184234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA585BD3390
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85B4D34813F
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F1F307AE6;
	Mon, 13 Oct 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ecMiudvK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB01547D2;
	Mon, 13 Oct 2025 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362534; cv=none; b=YhE3EBVoM3tNv046USjxxGtKE5lCxP4sKvz5cplM+aUAW1xmDvgUpreJnbwU2BkWIsJVf9cy8IfjMybqa5fjqRQq6ssvsSDSQNslSMIWaQGplsyarnkfWXKa6RjqRaTFeh5GzBxAbIfLPR0ZjMxn+KV9h8uxXIPk1R/x6BH1hzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362534; c=relaxed/simple;
	bh=PIlHtuyYZBVvRjK3PjQM2sTRLBoRkuM4y2i5R3QPrNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh+7+v+72u8NOxbZPdr35XBx6vNF5M5Pa2DB7TSFfTfUdnq+Fwes0NJ42UokoohZVF2UfpN4uW83C7ywXsw2h31dE+8+r4elwp74aTilAgcy42aDzMAffBaa8M9ukM82pjFlLKeDBiAq0hqV1BM2Wv8ugOV8Wa5IOVj7XIRx5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ecMiudvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38833C4CEE7;
	Mon, 13 Oct 2025 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760362532;
	bh=PIlHtuyYZBVvRjK3PjQM2sTRLBoRkuM4y2i5R3QPrNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecMiudvK7aLVEWLaI1Y17fvF/OVQcxW2fxMIn9jG/snqetLjU8kgjEFqFZWUZOxnj
	 tDkasEksiJ3XeiHwI2SkQfhimRBhFgNjm52CbpXWWW08kK0zybaS0PNQLfuXIvIeDx
	 xhPrdicxZ6PhHbmdjbwat2VINs8aOAndCemlJZvQ=
Date: Mon, 13 Oct 2025 15:35:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: sashal@kernel.org, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, muchun.song@linux.dev,
	osalvador@suse.de, david@redhat.com
Subject: Re: Patch "hugetlbfs: skip VMAs without shareable locks in
 hugetlb_vmdelete_list" has been added to the 6.17-stable tree
Message-ID: <2025101356-take-portside-5796@gregkh>
References: <20251013012500.16338-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013012500.16338-1-kartikey406@gmail.com>

On Mon, Oct 13, 2025 at 06:55:00AM +0530, Deepanshu Kartikey wrote:
> Hi Sasha,
> 
> Please do NOT backport commit dd83609b8898 alone to stable. This patch 
> causes a regression in fallocate(PUNCH_HOLE) operations where pages are 
> not freed immediately, as reported by Mark Brown.
> 
> The fix for this regression is already in linux-next as commit 
> 91a830422707 ("hugetlbfs: check for shareable lock before calling 
> huge_pmd_unshare()").
> 
> Please backport both commits together to avoid introducing the 
> regression in stable kernels:
> - dd83609b88986f4add37c0871c3434310652ebd5 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
> - 91a830422707a62629fc4fbf8cdc3c8acf56ca64  ("hugetlbfs: check for shareable lock before calling huge_pmd_unshare()")

As this is not in linux-next yet, I'll just drop this original patch for
now.  When it does land in Linus's tree, please let us know so we can
submit both of them to the stable queues.

thanks,

greg k-h

