Return-Path: <stable+bounces-132239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473B0A85E54
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8ED03BAF04
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A874964E;
	Fri, 11 Apr 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iNTyHFJD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDED29CE1;
	Fri, 11 Apr 2025 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376890; cv=none; b=FUNFyOAHTnyxcJF3dflNFtxkaWRqMPIxkimVt9SrV8P6dQao2/6xa1ED2pGAU9H3OsfrytmDIdd/gaK/xRRKaj//fSWqMqeoZxSpiAym6UlWktaw0yEXZbVR2P6IVb0gwzR9O9TMCpvZ4LxFe/MVKGLe0BwMTLWElEkNbi78JWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376890; c=relaxed/simple;
	bh=fvmjwaRGD+rwit+sowsme3k8raa55Qub8202b/xCVA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXd87BfX1KEUiRTmBimuncfGeh/9CLQfM4v0GErDlAgLUaTlBt9cZ8aZw06DcEyPOxVtt0BQh2uT3fNZlBtavSHHGOlHQGWCUHhLctIvJsfHWurKOyQtL035fEAqNhKOaNkeUVi3WWqN5Px5MZcpXVThEP4WDtqABV1dNr135T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iNTyHFJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41508C4CEE2;
	Fri, 11 Apr 2025 13:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744376889;
	bh=fvmjwaRGD+rwit+sowsme3k8raa55Qub8202b/xCVA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNTyHFJDSLvZD64CiKCgC2RJDKgqk6u/RJC/gUakURrU3I8rWWtRcdSI3gstbAqgn
	 2K8iIPQlBQRY0dgJRgL7PoNQO/BV+usfFat+OXIZNKQ54IezmIWJ6r31iM6n2+Umr5
	 SHtHYkaDqqrfRtKQ3/fFOtc2gw3jK/89RE8+/1Ns=
Date: Fri, 11 Apr 2025 15:08:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Frode Isaksen <fisaksen@baylibre.com>
Cc: linux-usb@vger.kernel.org, Thinh.Nguyen@synopsys.com,
	Frode Isaksen <frode@meta.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_fs: Invalidate io_data when USB
 request is dequeued or interrupted
Message-ID: <2025041139-sedan-liquid-de35@gregkh>
References: <20250331085540.32543-1-fisaksen@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331085540.32543-1-fisaksen@baylibre.com>

On Mon, Mar 31, 2025 at 10:53:50AM +0200, Frode Isaksen wrote:
> From: Frode Isaksen <frode@meta.com>
> 
> Invalidate io_data by setting context to NULL when USB request is
> dequeued or interrupted, and check for NULL io_data in epfile_io_complete().
> The invalidation of io_data in req->context is done when exiting
> epfile_io(), since then io_data will become invalid as it is allocated
> on the stack.
> The epfile_io_complete() may be called after ffs_epfile_io() returns
> in case the wait_for_completion_interruptible() is interrupted.
> This fixes a use-after-free error with the following call stack:
> 
> Unable to handle kernel paging request at virtual address ffffffc02f7bbcc0
> pc : ffs_epfile_io_complete+0x30/0x48
> lr : usb_gadget_giveback_request+0x30/0xf8
> Call trace:
> ffs_epfile_io_complete+0x30/0x48
> usb_gadget_giveback_request+0x30/0xf8
> dwc3_remove_requests+0x264/0x2e8
> dwc3_gadget_pullup+0x1d0/0x250
> kretprobe_trampoline+0x0/0xc4
> usb_gadget_remove_driver+0x40/0xf4
> usb_gadget_unregister_driver+0xdc/0x178
> unregister_gadget_item+0x40/0x6c
> ffs_closed+0xd4/0x10c
> ffs_data_clear+0x2c/0xf0
> ffs_data_closed+0x178/0x1ec
> ffs_ep0_release+0x24/0x38
> __fput+0xe8/0x27c
> 
> Signed-off-by: Frode Isaksen <frode@meta.com>
> Cc: stable@vger.kernel.org
> ---
> v1 -> v2:
> Removed WARN_ON() in ffs_epfile_io_complete().
> Clarified commit message.
> Added stable Cc tag.
> 
>  drivers/usb/gadget/function/f_fs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 2dea9e42a0f8..e35d32e7be58 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -738,6 +738,9 @@ static void ffs_epfile_io_complete(struct usb_ep *_ep, struct usb_request *req)
>  {
>  	struct ffs_io_data *io_data = req->context;
>  
> +	if (io_data == NULL)
> +		return;

What prevents req->context to be set to NULL right after you check this?

thanks,

greg k-h

