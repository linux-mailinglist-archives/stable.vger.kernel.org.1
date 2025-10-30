Return-Path: <stable+bounces-191722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0834CC1FE1A
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 12:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE2F407CB3
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 11:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6787032C305;
	Thu, 30 Oct 2025 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="USaJzqdI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C112641FB;
	Thu, 30 Oct 2025 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825050; cv=none; b=ubfHv3ElElmvmDuP3D90tWx7T4CVXKLXy5zOIwaf1nzFiNy3X9wyO7mbAnaI2inEyZ5rqsEQn7RhY13eE03nAlMUonlYlxqKtqpBVK0H6AJzQGZzj+ElT1hEQLrkK0342HxVY+9PElw3aHjeQ+DzojK7uwe8ix7XgmM6gRD8j7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825050; c=relaxed/simple;
	bh=RFHsMIRxHKiFsDl2RebWGt38rj7OqrSZnwR6uVRjep8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyXMqZ1WutFeHfia932dZk+De72dgv6pP8AVA7ygpXRq7XrTDs5WMzsPZvMx25OuXWN00ZljfV3mGrEJXgfwgTyBYHQZDoPzeKu1p1kcZW7c9l1iXPcJ+pBG7g4tAFFTgcIWdZMpCHEnIobJrIRtKyvQIK9R3NFjgY+e+VKeA0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=USaJzqdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB4BC4CEF1;
	Thu, 30 Oct 2025 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761825049;
	bh=RFHsMIRxHKiFsDl2RebWGt38rj7OqrSZnwR6uVRjep8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USaJzqdIiSawnzcIJi30+phzmOMAFWuKMo8lq93UxisrHFzKLq+J0yERg2VXXPktX
	 VbhiG2tO1lOGyemtFJI6DClWNl9lk+GiBUE/80Qv09k58+ikLP+mxQT027EPGR0JO9
	 BlCawNXKYsplD09Mp7u1DA6ejIUe2avUYGiHFNPA=
Date: Thu, 30 Oct 2025 12:50:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: stable@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: Re: [PATCH 5.4.y] iommu/amd: Fix 2G+ memory-size overflow in
 unmap_sg()
Message-ID: <2025103008-prideful-trunks-8562@gregkh>
References: <20251030111956.308-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030111956.308-1-guojinhui.liam@bytedance.com>

On Thu, Oct 30, 2025 at 07:19:56PM +0800, Jinhui Guo wrote:
> Since npages is declared as int, shifting npages << PAGE_SHIFT
> for a 2 GB+ scatter-gather list overflows before reaching
> __unmap_single(), leading to incorrect unmapping.
> 
> A 2 GB region equals 524,288 pages. The expression
> npages << PAGE_SHIFT yields 0x80000000, which exceeds
> INT32_MAX (0x7FFFFFFF). Casting to size_t therefore produces
> 0xFFFFFFFF80000000, an overflow value that breaks the unmap
> size calculation.
> 
> Fix the overflow by casting npages to size_t before the
> PAGE_SHIFT left-shift.
> 
> Fixes: 89736a0ee81d ("Revert "iommu/amd: Remove the leftover of bypass support"")
> Cc: stable@vger.kernel.org # 5.4
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
> 
> Hi,
> 
> We hit an IO_PAGE_FAULT on AMD with 5.4-stable when mapping a
> 2 GB scatter-gather list.
> 
> The fault is caused by an overflow in unmap_sg(): on stable-5.4
> the SG-mmap path was never moved to the IOMMU framework, so the
> bug exists only in this branch.

What upstream commit fixed this?  And why not just backport that?

And as this kernel is only going to be "alive" for one more month (i.e.
probably one more release), why care about it now at all?  Shouldn't you
already have moved your whole infrastructure off of it by now?

Especially because, as of right now, release 5.4.301 contains 1527
unfixed CVEs?  Surely that should mean something? :)

thanks,

greg k-h

