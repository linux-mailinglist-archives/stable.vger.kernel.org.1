Return-Path: <stable+bounces-128508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD9BA7DACC
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 12:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F55E1889A42
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2769422FE07;
	Mon,  7 Apr 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J8JxFRDU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0E7218EB8;
	Mon,  7 Apr 2025 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744020702; cv=none; b=dixMttWhiYR3FonD83lgFzHX2+EmzikPltb0bE053EZF8wznT95XnyuFSIGpbk/UL7J6De9QPLUVIk6+w51yquZKugYaVp4oGtbkVCGdqeACK0YMZZJsLkoAXkn2Hxz/fumhOCuoa0Mi1+o57wu47DouZhM4k0j9COQdfdDwwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744020702; c=relaxed/simple;
	bh=8DRO14GMx6fMiKN8siwjcG5962IsUDzR4/99pLBUHJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6WRPdzTsOJYM2tafDuelSZuFU88NoL2sxka1RlrAFaQo5VwBXTSAZWViRUL9su63w550j3I368ZpTGOla6oyz3hz65/TdJCez1UwtCq4rSP+FYLn5tRLu8kDUp/8dFHIr48Vr5F3aUMMi86pt0/zftVNFw2L+MfKR3+IG9Zzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J8JxFRDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0459C4CEDD;
	Mon,  7 Apr 2025 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744020701;
	bh=8DRO14GMx6fMiKN8siwjcG5962IsUDzR4/99pLBUHJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8JxFRDU3b/nEMNMA0Kfv4wih0wm99QvixiL+PgpbLwcfCeDBBQkc30dtPwDq7Lj/
	 UkVErkk+RjS2rHiO2yeqUZcQjn4nzbUPqzfZ88jUFeVXh348SEJTiwFaC3r20MyeaW
	 /7A4lBuRZk5Lw5kgY1BAe9Fh0wYjdyaM/9+oTM8U=
Date: Mon, 7 Apr 2025 12:10:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] staging: rtl8723bs: Add error handling for sd_read()
Message-ID: <2025040718-twine-unmindful-a1ea@gregkh>
References: <20250407100318.2193-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407100318.2193-1-vulab@iscas.ac.cn>

On Mon, Apr 07, 2025 at 06:03:18PM +0800, Wentao Liang wrote:
> The sdio_read32() calls sd_read(), but does not handle the error if
> sd_read() fails. This could lead to subsequent operations processing
> invalid data. A proper implementation can be found in sdio_readN().
> 
> Add error handling for the sd_read() to free tmpbuf and return error
> code if sd_read() fails. This ensure that the memcpy() is only performed
> when the read operation is successful.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org # v4.12+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v6: Fix improper code to propagate error code
> v5: Fix error code
> v4: Add change log and fix error code
> v3: Add Cc flag
> v2: Change code to initialize val
> 
>  drivers/staging/rtl8723bs/hal/sdio_ops.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index 21e9f1858745..eb21c7e55949 100644
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
> +			return (u32)err;

You just casted a negative number to a positive type?

Step back and think exactly of what you should be doing here.  Walk the
callchain properly and think about how this all needed to be fixed up
properly, and then take some time to do that work and test it and submit
it properly.

Take your time, there's no rush here.

thanks,

greg k-h

