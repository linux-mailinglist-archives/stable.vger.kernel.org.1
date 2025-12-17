Return-Path: <stable+bounces-202833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15334CC8983
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 826503011310
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEC3359706;
	Wed, 17 Dec 2025 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CukAPPK4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBC3596FC;
	Wed, 17 Dec 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977590; cv=none; b=PNXAldAup8xdV+7xdik86mXYGFrJNQ23RDLSD/YHjf/efTWrwWQkdN5J8gARGbyoa4/xGrNQt3hGbxFi6an6qrRCaz0AI9xJfADbvQpBahJf47e2CepojwyMlfKTwXU5898Wf1iEF78Wb26Q8ZJX564VoUHDdLd69g3yfF8hMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977590; c=relaxed/simple;
	bh=zT4O/jkTIePZrAxKcRDVE+8tK1lq7Hr0PfSYYVudTRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbEcrfDitFNWOl+P0GxDmn9zs8uz2fYU1glrFzH/e18eSN6Xu9GolMo0OqGt0C+45gSTzYFZcfSQl/wi95VJouqg/DEuEbezBCVrY2XS4mUbcqclxqetd82hqmddiPda4rB7pkB9CIsVCdSHw7AaJSrJmbqcF8Sk6LuRSzKeqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CukAPPK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082E6C4CEF5;
	Wed, 17 Dec 2025 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765977587;
	bh=zT4O/jkTIePZrAxKcRDVE+8tK1lq7Hr0PfSYYVudTRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CukAPPK4nr1Ux5b3F2pgVxKUswAGRcLDjxyIetcCwY8x+SXAXYZXFYFUIq86w3Hip
	 Lu26YRw8ZEH5FEIinuYq/1mC+6+XewEWhZb2iQ/qAIyeAtD0aRz+nRIMmQbd8ieKAg
	 xdZ/vmC5qSlk0+ZqYHkhjcPVKpDb5Yp31hFmYhWI=
Date: Wed, 17 Dec 2025 14:19:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, heikki.krogerus@linux.intel.com,
	mitltlatltl@gmail.com, linux-kernel@vger.kernel.org,
	sergei.shtylyov@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: typec: ucsi: fix probe failure in
 gaokun_ucsi_probe()
Message-ID: <2025121729-enduring-legend-6e4f@gregkh>
References: <cover.1764065838.git.duoming@zju.edu.cn>
 <4d077d6439d728be68646bb8c8678436a3a0885e.1764065838.git.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d077d6439d728be68646bb8c8678436a3a0885e.1764065838.git.duoming@zju.edu.cn>

On Tue, Nov 25, 2025 at 06:36:26PM +0800, Duoming Zhou wrote:
> The gaokun_ucsi_probe() uses ucsi_create() to allocate a UCSI instance.
> The ucsi_create() validates whether ops->poll_cci is defined, and if not,
> it directly returns -EINVAL. However, the gaokun_ucsi_ops structure does
> not define the poll_cci, causing ucsi_create() always fail with -EINVAL.
> This issue can be observed in the kernel log with the following error:
> 
> ucsi_huawei_gaokun.ucsi huawei_gaokun_ec.ucsi.0: probe with driver
> ucsi_huawei_gaokun.ucsi failed with error -22
> 
> Fix the issue by adding the missing poll_cci callback to gaokun_ucsi_ops.
> 
> Fixes: 00327d7f2c8c ("usb: typec: ucsi: add Huawei Matebook E Go ucsi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>   - Add cc: stable.
>   - Correct spelling mistake.
> 
>  drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> index 7b5222081bb..8401ab414bd 100644
> --- a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> +++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> @@ -196,6 +196,7 @@ static void gaokun_ucsi_connector_status(struct ucsi_connector *con)
>  const struct ucsi_operations gaokun_ucsi_ops = {
>  	.read_version = gaokun_ucsi_read_version,
>  	.read_cci = gaokun_ucsi_read_cci,
> +	.poll_cci = gaokun_ucsi_read_cci,
>  	.read_message_in = gaokun_ucsi_read_message_in,
>  	.sync_control = ucsi_sync_control_common,
>  	.async_control = gaokun_ucsi_async_control,
> -- 
> 2.34.1
> 

What ever happened to this?  if it is still needed, please rebase
against 6.19-rc1 and resend.

thanks,

greg k-h

