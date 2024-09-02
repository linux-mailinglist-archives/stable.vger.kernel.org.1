Return-Path: <stable+bounces-72675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A8F96806C
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 09:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0723A2808EC
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D5178CDF;
	Mon,  2 Sep 2024 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="I5b3SIZu"
X-Original-To: stable@vger.kernel.org
Received: from smtpdh18-1.aruba.it (smtpdh18-1.aruba.it [62.149.155.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC4179954
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261544; cv=none; b=J74yTVz+1m3M2EyUJaUD3yzwpnF1mUPPZYesVqsZPM1DGmGtKUXMAbYNFQRdbI8+4cV/4aQpV/wwHwUA2OmJ7a/4eo0C8+VmYw0uZYvwYUXMtp2irR7N/3BBGq/QTHO43L3r+oUS4906a9McVTFF67ozRiyMLVkIxMaYcPkHaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261544; c=relaxed/simple;
	bh=6Wea60hTyUPz/NIKQ39u6mLhiFIPRjr6DJ9DttEJ+lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMq5VczVfboCFfr+YfrTKc8vZZwAfM+odlj7nyVftQmup7XeJVIS0SsjKNuszv3I7BfVB/xRPtgY9lIlI5m+abWxFQ23rk3G2d17PktQQAEJlm+zVkOHwqrDMn4WhFMfHtUNeecYXROrdMXEsuJiyXAI9WJd15VKRW93BsdQmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=I5b3SIZu; arc=none smtp.client-ip=62.149.155.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id l1Hxs0Ts4Y7T4l1HysUSkS; Mon, 02 Sep 2024 09:15:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1725261351; bh=6Wea60hTyUPz/NIKQ39u6mLhiFIPRjr6DJ9DttEJ+lc=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=I5b3SIZuSnvDYpTqxqaRpwKVXO2AuSOCPnsju0C4XioP+yVi4CmqGgU1aBVy76X5t
	 mT+YZSYv4m0vVWhBes+sfncp9dyak3Q9xnsaz3a9+H4oY72acCJRzv0a1Rmjb3p71c
	 gTLs1Lrf4rla2uibaSLhmXdzo2DdqeWScPoHEW2dX2UYwDCIdRywVXNKN6MZBZde4f
	 LpKSDGb2kHiHGwHdptC+Th3jd65YWuVl5XnNOY/y2yuce9qHZ9FE5thZBafSssY49b
	 bR4W/RJxwcbL6YU9fxravm/qXktnDlpN2WpVvtWm2emy/hQ83XiduWUmkqyp5aRazo
	 mvJgARNjbnN3w==
Message-ID: <78128328-7006-419e-9977-1487b3a2dab0@enneenne.com>
Date: Mon, 2 Sep 2024 09:15:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND] pps: add an error check in parport_attach
To: Ma Ke <make24@iscas.ac.cn>, christophe.jaillet@wanadoo.fr,
 linux@treblig.org, akpm@linux-foundation.org, sudipm.mukherjee@gmail.com,
 gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240828131814.3034338-1-make24@iscas.ac.cn>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <20240828131814.3034338-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGbE3zGolREKZsj53EaLe/Y2T8zfP8kV6IpeXs74fQi/xbKvJs4OlIpnw6lJSGfYxZ39/oHHX6e7RZRW3M9Ccx+amrX3F+9PV6qMMg6i9XW+TRUQ6lHe
 55NgwnkWf/z95fZ5Q4iHkh15p6dFl9AuWPNj9wMa0zaj4x++TIfc3GjnBlTiJxNTLvFZbCqM8vgpdal9u97WU/9gsnTeNozG7k3N2Vvvl40O6q88VGsz9Br+
 GSeDhGkGzQ4Y1RdXuCL6R4XMYnLg7DeroeC5ry7GPHWcqLOThfaE03wIQTm5yn8LPbCSSyfKqZQ7iHomW9a5vpuZyIhB2f04tFFsLoXd5YKnPT936cmsvUpu
 GWoq9j4jDtwiFgAkeWBIzKL5alJP7yqGN8P59OGUvBMzkbaeje7Ck6CSpx7CJXNVw1/tjNXxPFP2UnJ8ydqW/Jo8D/bW/ais4CbbWvMgm6uTn7toCek=

On 28/08/24 15:18, Ma Ke wrote:
> In parport_attach, the return value of ida_alloc is unchecked, witch leads
> to the use of an invalid index value.
> 
> To address this issue, index should be checked. When the index value is
> abnormal, the device should be freed.
> 
> Found by code review, compile tested only.
> 
> Cc: stable@vger.kernel.org
> Fixes: fb56d97df70e ("pps: client: use new parport device model")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
> Changes in v3:
> - modified Fixes tag as suggestions.
> Changes in v2:
> - removed error output as suggestions.
> ---
>   drivers/pps/clients/pps_parport.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
> index 63d03a0df5cc..abaffb4e1c1c 100644
> --- a/drivers/pps/clients/pps_parport.c
> +++ b/drivers/pps/clients/pps_parport.c
> @@ -149,6 +149,9 @@ static void parport_attach(struct parport *port)
>   	}
>   
>   	index = ida_alloc(&pps_client_index, GFP_KERNEL);
> +	if (index < 0)
> +		goto err_free_device;
> +
>   	memset(&pps_client_cb, 0, sizeof(pps_client_cb));
>   	pps_client_cb.private = device;
>   	pps_client_cb.irq_func = parport_irq;
> @@ -159,7 +162,7 @@ static void parport_attach(struct parport *port)
>   						    index);
>   	if (!device->pardev) {
>   		pr_err("couldn't register with %s\n", port->name);
> -		goto err_free;
> +		goto err_free_ida;
>   	}
>   
>   	if (parport_claim_or_block(device->pardev) < 0) {
> @@ -187,8 +190,9 @@ static void parport_attach(struct parport *port)
>   	parport_release(device->pardev);
>   err_unregister_dev:
>   	parport_unregister_device(device->pardev);
> -err_free:
> +err_free_ida:
>   	ida_free(&pps_client_index, index);
> +err_free_device:
>   	kfree(device);
>   }
>   

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


