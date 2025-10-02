Return-Path: <stable+bounces-183007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB68DBB2848
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 07:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641BD19C3A13
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 05:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A1B3E47B;
	Thu,  2 Oct 2025 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E9lBigks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2DB442C
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382199; cv=none; b=NPH4EPQP3I1QpWdQ7h3lSGEw/Lf6XKd26AUrmCCvTyzrlRzeWEXJP/dv27/kOZkMqSz4efM7eVD0yNyBGicRt64/ICEHs80ub90Dz8M8h8p9mcE7+T3l7t0/6+MDuBd9Gz148jb4roVsZf/7688wtCePmIwq4gEgtg99XOGBdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382199; c=relaxed/simple;
	bh=VMz3Qsa5pMXqp5Xj6opyVh+9jZU586esN8Rth9j6vDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmYabvNKWvyszly5FK0nU4UbqegG89sY+HY8zI4njF63JQ/eGmdCK6za2iucbUMVwcrW2MfA+BsHDKk0eoY8pPnj3Oi/iTQKe4NyNt7TfhuUp9daT7bnmvBym/I1TqJzK9PSHFgM4KWuA9fBGZSWuJRsAyWjiffAzs0H3BQaw4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E9lBigks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0340BC4CEFC;
	Thu,  2 Oct 2025 05:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759382198;
	bh=VMz3Qsa5pMXqp5Xj6opyVh+9jZU586esN8Rth9j6vDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9lBigksOs2/FVFxJ6pmZhWDP6w4afYya+iNgcFK49eTLZBv5XlNIlz+b6GWlrUG+
	 c523b6YAtQwO4K8blV6c9LOfyMotYYq+89qg8DX7sqW0i/8BHiz8E9fF3eTIPVrpoo
	 K7vNQOv6lYGPGuT+O/48xtNAsOD2VFU+gQ/e94fI=
Date: Thu, 2 Oct 2025 07:16:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhichuang Sun <zhichuang@google.com>
Cc: stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux-foundation.org
Subject: Re: [PATCH] commit 6b080c4e815ceba3c08ffa980c858595c07e786a upstream
Message-ID: <2025100207-writing-judgingly-6b2a@gregkh>
References: <20251001211909.721369-1-zhichuang@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001211909.721369-1-zhichuang@google.com>

On Wed, Oct 01, 2025 at 09:19:09PM +0000, Zhichuang Sun wrote:
> iommu/amd: fix amd iotlb flush range in unmap

Shouldn't this be the subject line?

> This was fixed in mainline in 6b080c4e815ceba3c08ffa980c858595c07e786a,
> but do not backport the full refactor.

Why not?

> Targeting branch lts linux-5.15.y.

Why just this one?  Why not also 5.10.y and 5.4.y?

> AMD IOMMU driver supports power of 2 KB page size, it can be 4K, 8K,
> 16K, etc. So when VFIO driver ask AMD IOMMU driver to unmap a
> IOVA with a page_size 4K, it actually can unmap a page_size of
> 8K, depending on the page used during mapping. However, the iotlb
> gather function use the page_size as the range of unmap range,
> instead of the real unmapped page size r.
> 
> This miscalculation of iotlb flush range will make the unflushed
> IOTLB entry stale. It triggered hard-to-debug silent data corruption
> issue as DMA engine who used the stale IOTLB entry will DMA into
> unmapped memory region.
> 
> The upstream commit aims at changing API from map/unmap_page() to
> map/unmap_pages() and changed the gather range calculation along
> with it. It accidentally fixed this bug in the mainline since 6.1.
> For this backport, we don't backport the API change, only port the
> gather range calculation to fix the bug.
> 
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Fixes: fc65d0acaf23179b94de399c204328fa259acb90

Please use the proper format as documented:

Fixes: fc65d0acaf23 ("iommu/amd: Selective flush on unmap")

thanks,

greg k-h

