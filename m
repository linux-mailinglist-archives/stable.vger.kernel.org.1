Return-Path: <stable+bounces-133192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CD8A91F34
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A4D7ACE5C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53924EF82;
	Thu, 17 Apr 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q/YMLiyt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1582628D
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899150; cv=none; b=bVvuN541cnSDvXZKjanhp2onPYsZoVsqMnPukfYwgqAtQmmD+hwsXOkAaDkE0P8LKML4xAJ6fpob6uIhZpPER+tV5ZHYCPvkpUH4O/aF7to+zSrx3xigOu0OuVP1OKVvVLKgBdMAfHZ7iQ+eaTLpwWvQu1V7YkvSHM3nP/n1JZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899150; c=relaxed/simple;
	bh=uK1SQy4R4rqc5WSDshmNwowC0n4tD4Sh+TRwb3Ng/ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3n20T3XUh87+6JXHor8h/G8XndCcWvex1prltCC9EUB6D6OObEMY92mRrakV6Oa6FZ4xIuE+Tg8kZHAXkcpnm1UVqzzjfZY/IuEiuAQC93HcYSnt6DfDeaS4La9GjnyjREWexDueLtQgI0wZdQnGhbKs6FtBRA2yBsmlhq33NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q/YMLiyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310A3C4CEE4;
	Thu, 17 Apr 2025 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744899150;
	bh=uK1SQy4R4rqc5WSDshmNwowC0n4tD4Sh+TRwb3Ng/ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/YMLiyttmBmbWbeHpn4xdrzn5yIcHwo+EoBxNABYqCoh+reU0oJoiUJ0t5lh7EZd
	 tlZbFtdRA/XDHe7q7O3Q6kHDa7BmPxmOvxBELp3F10qEUIL8sb91GemsgIIwK5SnRP
	 9NB83sDeSrlgpSom5eXK9VYw00BjoW/0CQTB+zks=
Date: Thu, 17 Apr 2025 16:12:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yi Liu <yi.l.liu@intel.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] iommufd: Fail replace if device has not
 been attached" failed to apply to 6.14-stable tree
Message-ID: <2025041711-handwash-sleep-09d0@gregkh>
References: <2025041759-knee-unearned-530e@gregkh>
 <9160a4eb-fc69-4a0b-8bd9-5b9d5f4f5bc7@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9160a4eb-fc69-4a0b-8bd9-5b9d5f4f5bc7@intel.com>

On Thu, Apr 17, 2025 at 08:52:16PM +0800, Yi Liu wrote:
> On 2025/4/17 19:42, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.14-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 55c85fa7579dc2e3f5399ef5bad67a44257c1a48
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041759-knee-unearned-530e@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
> > 
> > Possible dependencies:
> 
> I think the possible dependency is the below commit. This patch adds a
> helper before iommufd_hwpt_attach_device() which is added by below commit.
> 
> commit fb21b1568adaa76af7a8c853f37c60fba8b28661
> Author: Nicolin Chen <nicolinc@nvidia.com>
> Date:   Mon Feb 3 21:00:54 2025 -0800
> 
>     iommufd: Make attach_handle generic than fault specific
> 
>     "attach_handle" was added exclusively for the iommufd_fault_iopf_handler()
>     used by IOPF/PRI use cases. Now, both the MSI and PASID series require to
>     reuse the attach_handle for non-fault cases.
> 
>     Add a set of new attach/detach/replace helpers that does the attach_handle
>     allocation/releasing/replacement in the common path and also handles those
>     fault specific routines such as iopf enabling/disabling and auto response.
> 
>     This covers both non-fault and fault cases in a clean way, replacing those
>     inline helpers in the header. The following patch will clean up those old
>     helpers in the fault.c file.
> 
>     Link: https://patch.msgid.link/r/32687df01c02291d89986a9fca897bbbe2b10987.1738645017.git.nicolinc@nvidia.com
>     Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>     Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index dfd0898fb6c1..0786290b4056 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -352,6 +352,111 @@ iommufd_device_attach_reserved_iova(struct
> iommufd_device *idev,
>         return 0;
>  }
> 
> +/* The device attach/detach/replace helpers for attach_handle */
> +
> +static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
> +                                     struct iommufd_device *idev)
> +{
> +       struct iommufd_attach_handle *handle;
> +       int rc;
> +
> +       lockdep_assert_held(&idev->igroup->lock);
> 
> 
> @Greg, anything I need to do here?

That should be it, thanks!

greg k-h

