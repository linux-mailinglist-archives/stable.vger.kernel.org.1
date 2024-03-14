Return-Path: <stable+bounces-28182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E0787C1D1
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 18:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B300D28403D
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90D9745E7;
	Thu, 14 Mar 2024 17:06:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 561E874297
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435993; cv=none; b=tBuEYT/xn9P37nnBEN0gJVNmifK4XM/OuZSbTTFF7elpBLTLveJgbQ2DVtJ75tVTKBIdKtV4N8pLs0ZoHf9yxErkfTDaxf7GGwNPhs5F3ZqVZ14IV1RoYfv95o3e6W/hrM+uVpQneYha8cEQeU6Qc0Lkl4GX16e1884r94DFcQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435993; c=relaxed/simple;
	bh=CGkln+OmSkzR1fL8B64pytuSGwIBUDXizmxgaTNMi1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB9Dl7+XGQR/DVrYAwCh3bMAFH6gSUX62/R9JUEL1MnO2HtYx/u9ERfP/pvBUOsFo6RrZNuNNYxt2UO6k3FfdbUUPbyZ4K1IV9wgVnhBUcODAhhOUZ8r4nV75AG3ckmJyLAozHzhbxxiyk5xHsFI+rSe9A/Kg+2HzMsS4Z+6wqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 457369 invoked by uid 1000); 14 Mar 2024 13:06:29 -0400
Date: Thu, 14 Mar 2024 13:06:29 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
  linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
  Karina Yankevich <k.yankevich@omp.ru>, lvc-project@linuxtesting.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] usb: storage: isd200: fix error checks in
 isd200_{read,write}_config()
Message-ID: <8819c3a3-fbf1-4df5-9e40-3509ef383b4a@rowland.harvard.edu>
References: <20240314093136.16386-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314093136.16386-1-r.smirnov@omp.ru>

On Thu, Mar 14, 2024 at 12:31:36PM +0300, Roman Smirnov wrote:
> The expression result >= 0 will be true even if usb_stor_ctrl_transfer()
> returns an error code. It is necessary to compare result with
> USB_STOR_XFER_GOOD.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> Cc: stable@vger.kernel.org
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/isd200.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/isd200.c b/drivers/usb/storage/isd200.c
> index 300aeef160e7..2a1531793820 100644
> --- a/drivers/usb/storage/isd200.c
> +++ b/drivers/usb/storage/isd200.c
> @@ -774,7 +774,7 @@ static int isd200_write_config( struct us_data *us )
>  		(void *) &info->ConfigData, 
>  		sizeof(info->ConfigData));
>  
> -	if (result >= 0) {
> +	if (result == USB_STOR_XFER_GOOD) {
>  		usb_stor_dbg(us, "   ISD200 Config Data was written successfully\n");
>  	} else {
>  		usb_stor_dbg(us, "   Request to write ISD200 Config Data failed!\n");
> @@ -816,7 +816,7 @@ static int isd200_read_config( struct us_data *us )
>  		sizeof(info->ConfigData));
>  
>  
> -	if (result >= 0) {
> +	if (result == USB_STOR_XFER_GOOD) {
>  		usb_stor_dbg(us, "   Retrieved the following ISD200 Config Data:\n");
>  #ifdef CONFIG_USB_STORAGE_DEBUG
>  		isd200_log_config(us, info);
> -- 
> 2.34.1
> 
> 

