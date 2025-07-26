Return-Path: <stable+bounces-164824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856B0B12936
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 08:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2AB1C20C2A
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 06:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7821F4CB2;
	Sat, 26 Jul 2025 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SpiEAAzZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BFE63CF;
	Sat, 26 Jul 2025 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753511472; cv=none; b=GhKFfAi95gHeZN4Q3huvoqNlwXV2hQlAGxRPxAKaW07G4I+JEUAMcuQ8hcJq3l7jaBfMUNXmqeXVjf0EjN0M4QLz5BMeXx/xzlQTqG/YtxoRz9c2m2nsEsEvMx6vgjOJLcWemFHMnvU/dlR0Eqwr0QSfR24B2acR0fd5UPw/e8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753511472; c=relaxed/simple;
	bh=7ehRp9BAapi50J1vElG63ICiiNGUnxcUkbk0ZJfv15I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVGfP8VEZVRM+8+i8o6FSoOxsKWwqPg11fT5r1h0AQa2vp1FI6jlvpBK9P7tFQwMExLQZ7GuU7UADbIIqFkfEhtExJ7Bk4LqAuPX8mQUuDFZTUGLtI8UctUwhk64zjb/9EZ02vhsNycNBLlnr6LjW17zPWeNaJF9W8T66Rgw2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SpiEAAzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD672C4CEED;
	Sat, 26 Jul 2025 06:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753511472;
	bh=7ehRp9BAapi50J1vElG63ICiiNGUnxcUkbk0ZJfv15I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpiEAAzZgJ3P6kIT0tldkNEnIbEGXEzkIaDS/FFd8sJBVk5ooKRBDhD2JJhAhu1uH
	 D4B+m12m8itKIM3EXNRek3BjT2XIOfNkbBjQfFRHzkIs8XN0KstD3h6BKul59b2jUU
	 4D8mkWKjxfDRh61NNRX+4fUTIM7TD45sPb2kOpBo=
Date: Sat, 26 Jul 2025 08:31:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: chalianis1@gmail.com
Cc: andy@kernel.org, linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: add support for a device tree of
 backlight.
Message-ID: <2025072640-consonant-flashcard-1805@gregkh>
References: <20250726000416.23960-1-chalianis1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726000416.23960-1-chalianis1@gmail.com>

On Fri, Jul 25, 2025 at 08:04:16PM -0400, chalianis1@gmail.com wrote:
> From: Chali Anis <chalianis1@gmail.com>
> 
> Support the of backlight from device tree and keep compatibility
> for the legacy gpio backlight.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chali Anis <chalianis1@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index da9c64152a60..5f0220dbe397 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -170,6 +170,18 @@ void fbtft_register_backlight(struct fbtft_par *par)
>  	struct backlight_device *bd;
>  	struct backlight_properties bl_props = { 0, };
>  
> +	bd = devm_of_find_backlight(par->info->device);
> +	if (IS_ERR(bd)) {
> +		dev_warn(par->info->device,
> +			"cannot find of backlight device (%ld), trying legacy\n",
> +			PTR_ERR(bd));

So now you are going to get a warning message for a system that
previously did not at all?  That's not very nice to those users :(


