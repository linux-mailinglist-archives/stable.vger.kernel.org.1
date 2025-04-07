Return-Path: <stable+bounces-128447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A639A7D4CE
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FA4162D93
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 07:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC85B227BA9;
	Mon,  7 Apr 2025 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RxSxXE56"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A2225A34;
	Mon,  7 Apr 2025 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009145; cv=none; b=FL3m/gppMdWmVv3kjRnn8thlIAWRcu3LyT0qU0vvHb38vGSOVkVy2/9WMmaiRZdM3spiHRFl7HNyCuuqPePiXtK5RizWXgZMpb3yx5UzgP/ted2gfT9DpFxiWJwt3tq3fFIts4T90x4NgLLLnllbNnchQjnXTAwkLGHFDpbxogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009145; c=relaxed/simple;
	bh=Uk8IEJjSk6lDLTgiBkYUJt4GuvbJc5JKYcglOwe3qY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUgW0GhFjmkomLkFwxBCePvSx0y1X4yLRime2hUIfdlDKFbymdtnWyu6Hnf03FphfFXhy/GObmkulm/+2FMtwssYAp0Z2ECJpeEbLUPg48ECC/sgT0v20blP+C3Z17Z95gCstecLlCpNHFHzuKO41AuBotKShjxG1r9ezr3gd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RxSxXE56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE64C4CEDD;
	Mon,  7 Apr 2025 06:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744009144;
	bh=Uk8IEJjSk6lDLTgiBkYUJt4GuvbJc5JKYcglOwe3qY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxSxXE56MDJE8vtcJ0H7OR9N0MjXRsra/eRHC8S1WxM2K4Pct6HI/HRHnLK6zUNY7
	 8KIkFavKw9ZE1HxlmGNCFi/e4Q3WVdHN/AQAK9bhpCjTCE7eVVbc7fQw0iDuMod5db
	 xcpGN0pT1VXE3HZ++qgo1CrS39ghMCsFGF0GdxYc=
Date: Mon, 7 Apr 2025 08:57:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] staging: rtl8723bs: Add error handling for sd_read()
Message-ID: <2025040745-penny-graffiti-9ae7@gregkh>
References: <20250406023513.2727-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406023513.2727-1-vulab@iscas.ac.cn>

On Sun, Apr 06, 2025 at 10:35:13AM +0800, Wentao Liang wrote:
> The sdio_read32() calls sd_read(), but does not handle the error if
> sd_read() fails. This could lead to subsequent operations processing
> invalid data. A proper implementation can be found in sdio_readN().

Great, why not use that instead?

> Add error handling for the sd_read() to free tmpbuf and return error
> code if sd_read() fails. This ensure that the memcpy() is only performed
> when the read operation is successful.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org # v4.12+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v5: Fix error code
> v4: Add change log and fix error code
> v3: Add Cc flag
> v2: Change code to initialize val
> 
>  drivers/staging/rtl8723bs/hal/sdio_ops.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index 21e9f1858745..d79d41727042 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> @@ -185,7 +185,12 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
>  			return SDIO_ERR_VAL32;
>  
>  		ftaddr &= ~(u16)0x3;
> -		sd_read(intfhdl, ftaddr, 8, tmpbuf);
> +		err = sd_read(intfhdl, ftaddr, 8, tmpbuf);
> +		if (err) {
> +			kfree(tmpbuf);
> +			return SDIO_ERR_VAL32;

Why isn't the error that you get from the lower levels being returned
here instead?  Throwing that away feels wrong, don't you think?

thanks,

greg k-h

