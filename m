Return-Path: <stable+bounces-58750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EEB92BB6C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 15:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A45D1F27A6D
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E5A15DBB9;
	Tue,  9 Jul 2024 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PtsalJxW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E715445E;
	Tue,  9 Jul 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531973; cv=none; b=Ns6iQnZ0bRFJ2umMWCobVro7y1PQYYgA30Ms7aGVnHVhuXjddf5pjKDM7kXwZXWTS5gRwL+FtSOptnC3sbpA2TYRRY4zodTiUlu7Rg+hq3PIlGc4/vxHSix56suuQzC9BajMferToBqGFrTVUX0d3+lPi2lqkQk3DbZeyIbASgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531973; c=relaxed/simple;
	bh=mOE+ryN8qxxEVONxkiQngqNrCkNEB9WBTPuTNVncMOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shs+FC9SgHM+JBLrw0ixdHiGr9LZVOCBxdM9nG/ZQjTTQ0ieehw115AzxY/YLWBg8UnGRmFzTO8/yMfKjWCeRlkhbzjs3rbg/QyPT6VpVv+CF/5XgjDe/vYptH0wzToSXy4dmnOBOxH/A25AwAxja5l46LMcOCK9TfsNsfbsXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PtsalJxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7155FC32786;
	Tue,  9 Jul 2024 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720531972;
	bh=mOE+ryN8qxxEVONxkiQngqNrCkNEB9WBTPuTNVncMOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtsalJxWGaXFB9T7jLMLh7Ih886MrFqgDPdz3jcM2NG0VRU6tQC3lLBTvDWW5x/NY
	 BxtT4eqc40FFMIAsSBC2zbYanf4pJuIwqNj/lDGe9vHNPUIxRkXqqr+45S+8DlVZ8a
	 DNjoLE4uvKgLBaDhpz6dtKbrYdChnBdNf8T6Nlac=
Date: Tue, 9 Jul 2024 15:32:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
	manoj@linux.vnet.ibm.com, mpe@ellerman.id.au,
	clombard@linux.vnet.ibm.com, imunsie@au1.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix possible null pointer dereference in
 read_handle()
Message-ID: <2024070940-customize-sturdily-fc81@gregkh>
References: <20240709131754.855144-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709131754.855144-1-make24@iscas.ac.cn>

On Tue, Jul 09, 2024 at 09:17:54PM +0800, Ma Ke wrote:
> In read_handle() of_get_address() may return NULL which is later
> dereferenced. Fix this bug by adding NULL check.
> 
> Cc: stable@vger.kernel.org
> Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/misc/cxl/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
> index bcc005dff1c0..d8dbb3723951 100644
> --- a/drivers/misc/cxl/of.c
> +++ b/drivers/misc/cxl/of.c
> @@ -58,7 +58,7 @@ static int read_handle(struct device_node *np, u64 *handle)
>  
>  	/* Get address and size of the node */
>  	prop = of_get_address(np, 0, &size, NULL);
> -	if (size)
> +	if (!prop || size)
>  		return -EINVAL;

How was this issue found?

thanks,

greg k-h

