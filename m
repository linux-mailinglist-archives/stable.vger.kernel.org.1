Return-Path: <stable+bounces-6987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F285816BCE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 12:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5C7B2141A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEC618648;
	Mon, 18 Dec 2023 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GUjy7s4M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54846182D5
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 11:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3D7C433C9;
	Mon, 18 Dec 2023 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702897447;
	bh=L9HqcHbOU+gjJ2PFgZsi0tOW9CdJSdfJnovzLnl6H24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUjy7s4MulGkPrHra44+KhLvmpVSUOpoG1MmV494iBdMamE91Qla1YomY1NsISX+J
	 SeXaGr3A4VkLKK56WPgp+QvdB1ULdQsIl9Fsk9Hu8zjOdo0U7xInsplXFgQ0+nqJvM
	 +tE41oPHzZ/7PLz775t5Z+P93TrGjKTH621EKKaQ=
Date: Mon, 18 Dec 2023 12:04:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: stable@vger.kernel.org,
	Christopher Bednarz <christopher.n.bednarz@intel.com>
Subject: Re: [PATCH 5.15.x] RDMA/irdma: Prevent zero-length STAG registration
Message-ID: <2023121856-aviator-subwoofer-d471@gregkh>
References: <20231215192939.478-1-shiraz.saleem@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215192939.478-1-shiraz.saleem@intel.com>

On Fri, Dec 15, 2023 at 01:29:39PM -0600, Shiraz Saleem wrote:
> From: Christopher Bednarz <christopher.n.bednarz@intel.com>
> 
> [Upstream commit bb6d73d9add68ad270888db327514384dfa44958]
> 
> Currently irdma allows zero-length STAGs to be programmed in HW during
> the kernel mode fast register flow. Zero-length MR or STAG registration
> disable HW memory length checks.
> 
> Improve gaps in bounds checking in irdma by preventing zero-length STAG or
> MR registrations except if the IB_PD_UNSAFE_GLOBAL_RKEY is set.
> 
> This addresses the disclosure CVE-2023-25775.
> 
> The kernel version to apply this patch is 5.15.x.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Christopher Bednarz <christopher.n.bednarz@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c  |  6 ++++++
>  drivers/infiniband/hw/irdma/type.h  |  2 ++
>  drivers/infiniband/hw/irdma/verbs.c | 10 ++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)

Now queued up, thanks.

greg k-h

