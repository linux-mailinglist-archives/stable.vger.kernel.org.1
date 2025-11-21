Return-Path: <stable+bounces-196488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 672CBC7A30F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 429FF35B843
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D7534D4DC;
	Fri, 21 Nov 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WkolxRgs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54D31A553;
	Fri, 21 Nov 2025 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735164; cv=none; b=emdAacD4lpOVe68YQNTS0YcbinLGgFBaMjWgNGCadjrfH5vmlPTd/6qECyuSvKQMTarnA7NdGc7MVpEoj85ATJjz/0GLDp6JrFiaLHcuflofBETPEqjXalW1GWgesRt4/bqcE18C8A2IqELkTSJ7x5F8JZLEwr9v8X0mvZf2tPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735164; c=relaxed/simple;
	bh=EfNgh1eMYbot4wypvinALGz/1QAaFx7WiLHvTYXxY5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFKMLg+jaIXJSIvZ5K/O6sfjv23IJIzKe5MMRdmLVMZnxohK5vip15nBLiwW1cPfBV0zgqd60dtIJZwCyyCLPru/YXOnCYdtV+dlczPt00YbBKyqAbdJ03pMgBWQYTjhvWPSE14NSOoCR8y8lkKAElDO/AVczFSERchbatu4SfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WkolxRgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36427C4CEF1;
	Fri, 21 Nov 2025 14:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763735163;
	bh=EfNgh1eMYbot4wypvinALGz/1QAaFx7WiLHvTYXxY5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkolxRgs9Gg80SOhs+pRUK7okzYko3cZv95bTb5hmHv3FMqcYsMk4ze9sbgm23oIR
	 aPa9MXgeCE/s5nl3ojy8PHVbfXa7Xt+lEZC1LmVOYmrDDVe/NuzLlyc8Elgo9V6vr/
	 CG/wOsiR3b3D+RwKFyqaU+dlXCCEtOfllM5fF/yo=
Date: Fri, 21 Nov 2025 15:18:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: stern@rowland.harvard.edu, vz@mleia.com, piotr.wojtaszczyk@timesys.com,
	arnd@arndb.de, stigge@antcom.de, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] USB: ohci-nxp: Fix error handling in ohci-hcd-nxp
 driver
Message-ID: <2025112116-shimmer-overtime-718f@gregkh>
References: <20251117013428.21840-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117013428.21840-1-make24@iscas.ac.cn>

On Mon, Nov 17, 2025 at 09:34:28AM +0800, Ma Ke wrote:
> When obtaining the ISP1301 I2C client through the device tree, the
> driver does not release the device reference in the probe failure path
> or in the remove function. This could cause a reference count leak,
> which may prevent the device from being properly unbound or freed,
> leading to resource leakage.
> 
> Fix this by storing whether the client was obtained via device tree
> and only releasing the reference in that case.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - only released the device reference when the ISP1301 client was obtained through device tree, not in the non-DT case where the global variable is used;
> - removed unnecessary NULL checks as suggested by reviewer.
> ---
>  drivers/usb/host/ohci-nxp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
> index 24d5a1dc5056..081b8c7f21a0 100644
> --- a/drivers/usb/host/ohci-nxp.c
> +++ b/drivers/usb/host/ohci-nxp.c
> @@ -50,6 +50,7 @@ static const char hcd_name[] = "ohci-nxp";
>  static struct hc_driver __read_mostly ohci_nxp_hc_driver;
>  
>  static struct i2c_client *isp1301_i2c_client;
> +static bool isp1301_using_dt;

This will not work for multiple devices in the system :(

Please add this to the device-specific structure instead.

thanks,

greg k-h

