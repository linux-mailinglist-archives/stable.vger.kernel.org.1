Return-Path: <stable+bounces-16060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823CA83E8F6
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 02:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4018B286469
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1558C18;
	Sat, 27 Jan 2024 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F4MbMzYx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC079CD
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318900; cv=none; b=LXgubQAbTekjtchX5/k3e3NNah8geaSACbxhzdw5BIQwNnedTZyTeBZlf4UKyhuFV4dbeU8Sg1RkGU8UnyD/uUG2oYSrMVi/I/83GqGYxDpz9FmJgjJifrlsvMTZC5lYgWCee99sKysadVN0zBMdSYnKGOMvJ0T6B62aCI0sYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318900; c=relaxed/simple;
	bh=nrCk/HrqSOJI9bP1rLw3zSfmAsfAr4mqxZPHS2ER4XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksmwlpj+UO9bTduDmY3Pl0sfcdYhNVptZc2HRuoqGn7W/42eRNmYWdQgndAjvLgsmeWTNOUQUVguw9Pa7eFKpTOO92/81MO+WZ9wocQ30BPRXn1GfGmfeWkCJ+kz4CAWxTaSoaYJsBOguv+wqrblHLjkVS1AINcXbZtkOuyOA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F4MbMzYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8246AC433F1;
	Sat, 27 Jan 2024 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706318899;
	bh=nrCk/HrqSOJI9bP1rLw3zSfmAsfAr4mqxZPHS2ER4XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4MbMzYxnbGhgOem55aZNYvPiUT16BH5AvOIvzSKwZmEcm46tNWHElHDKBZb3bbqp
	 Mn+Mr/67HIctzpLLhVuqKslsYxCY9ljjQwuBkFEjhHs9dhzqux4LxKD9TqiMkMUYoO
	 u+9av3LEG1JbigGSABVJZuArnDn1jhoFn9LuK10A=
Date: Fri, 26 Jan 2024 17:28:18 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: stable@vger.kernel.org, Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 5.15.x] RDMA/irdma: Ensure iWarp QP queue memory is OS
 paged aligned
Message-ID: <2024012630-animating-patriarch-6f6d@gregkh>
References: <20240126202144.323-1-shiraz.saleem@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126202144.323-1-shiraz.saleem@intel.com>

On Fri, Jan 26, 2024 at 02:21:43PM -0600, Shiraz Saleem wrote:
> From: Mike Marciniszyn <mike.marciniszyn@intel.com>
> 
> [ Upstream commit 0a5ec366de7e94192669ba08de6ed336607fd282 ]
> 
> The SQ is shared for between kernel and used by storing the kernel page
> pointer and passing that to a kmap_atomic().
> 
> This then requires that the alignment is PAGE_SIZE aligned.
> 
> Fix by adding an iWarp specific alignment check.
> 
> The patch needed to be reworked because the separate routines
> present upstream are not there in older irdma drivers.
> 
> Fixes: e965ef0e7b2c ("RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp")
> Link: https://lore.kernel.org/r/20231129202143.1434-3-shiraz.saleem@intel.com
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 745712e1d7de..e02f541430ad 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2783,6 +2783,11 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  
>  	switch (req.reg_type) {
>  	case IRDMA_MEMREG_TYPE_QP:
> +		/* iWarp: Catch page not starting on OS page boundary */
> +		if (!rdma_protocol_roce(&iwdev->ibdev, 1) &&
> +		    ib_umem_offset(iwmr->region))
> +			return -EINVAL;
> +
>  		total = req.sq_pages + req.rq_pages + shadow_pgcnt;
>  		if (total > iwmr->page_cnt) {
>  			err = -EINVAL;
> -- 
> 1.8.3.1
> 
> 

You obviously did not test this change, as it fails to build, so why ask
for it to be backported?  I've dropped all of these now from both 6.1.y
and 5.15.y, please be more careful in the future.

thanks,

greg k-h

