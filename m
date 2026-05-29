Return-Path: <stable+bounces-256515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPqfCO8qGWrCrggAu9opvQ
	(envelope-from <stable+bounces-256515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:58:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7385FDAB2
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5B4330234F7
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B85330B3F;
	Fri, 29 May 2026 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OF6pB+E+"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823121C5799;
	Fri, 29 May 2026 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034282; cv=none; b=rZn83HQi9gAuWaErNFdbw0YpFbGVhs9QPfLIoRpc3uGX4xMItPXc4a5Jdk48m9tbKKJhRFE629Wq7dIpHdI52V4tJL7slRcaVh+g9InwmA/XrhI26UidQixlE08KjxX89swdT9rIaauNBUPxPbPH/UBy/LNCqcO62BdYRGMngpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034282; c=relaxed/simple;
	bh=dIC/nhi2ln1n1f87hQSVwlY9L4pQ5CDNNmyhIT5Eawc=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=HxKprTndfxgXvKuG6sK7fG3s74/PMhScFvH9YkwZ2IMJqgCBmmXBjpoWS+tLhERvQ1oxMvTcOSRFcWEwzkfVSZkmvfsaEF3aCzruy3xAvSHpdRsM9sTjxZpzqG+XjlYtElU59o6boq22rsobrvQYz6ZYNgV2YrcixVMrTZL3D84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OF6pB+E+; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=4fvAyPV8w7MtdCPWvvD4q5TcKyr+caBDRRMdlMzEOWg=;
	b=OF6pB+E+OPnUWaJiqbNnbBxbpPGR+R3y69Xe4muuFENRxg3twnwV8YIDWvx3lq
	IhwwtRDNaegpVcjO7XyD6Z9iSR62JZ2b82FR5IyD6B2/685jzFdQCELAalI57Tqq
	yEGJWpHT1jcCgScii929YMIajSvmMI/LMw09LjlOniwfM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wC3r7i4KhlqjKH4AQ--.34316S2;
	Fri, 29 May 2026 13:57:13 +0800 (CST)
Message-ID: <6A192ABC.6010500@126.com>
Date: Fri, 29 May 2026 13:57:16 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?RG9taW5payBLYXJvbCBQacSFdGtvd3NraQ==?=
 <dominik.karol.piatkowski@protonmail.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: dpenkler@gmail.com, gregkh@linuxfoundation.org, kees@kernel.org, 
 dan.carpenter@linaro.org, lukeyang.dev@gmail.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] gpib: fmh_gpib: Fix resource leaks in fmh_gpib_attach_impl
References: <20260528015028.12802-1-zenghongling@kylinos.cn> <LpJShJPaUZ8iZoWRA7Sy9TPz_7ZPHNvoU0lHOBrVEXvQGqlz493ShbF6ZKQ2zcRqPHVuxOkjzR0KCdS6OngnflPYa0gsqaRTpRWFbxuqQ4A=@protonmail.com>
In-Reply-To: <LpJShJPaUZ8iZoWRA7Sy9TPz_7ZPHNvoU0lHOBrVEXvQGqlz493ShbF6ZKQ2zcRqPHVuxOkjzR0KCdS6OngnflPYa0gsqaRTpRWFbxuqQ4A=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3r7i4KhlqjKH4AQ--.34316S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF4rtFWfAw4Uuw45Zr47Arb_yoWxGr4fpa
	1fWa15KryDtrs2qF43Xw1DWF4Fvw4xtFy5uw42k343A3WqyFyvyF48Gaya9ryvyr97Jw4Y
	krW0qr40kF4kZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4dgXUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoBmZamoZKrkzCgAA3T
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256515-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com,kylinos.cn];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,kernel.org,linaro.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[126.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhongling0719@126.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[126.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA7385FDAB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

   Hi Dominik Karol,

   Thanks for the analysis. You're right about the double-free issue.

   However, there's still a real leak : when dma_fifos resource
   lookup fails, the previously allocated gpib_iomem_res leaks because
   dma_port_res isn't assigned yet, so detach() won't clean it up.

   Minimal fix: cleanup only before field assignment:
```c
   if (!res) {
       dev_err(board->dev, "Unable to locate mmio resource for gpib dma 
port\n");
       release_mem_region(e_priv->gpib_iomem_res->start,
                         resource_size(e_priv->gpib_iomem_res));
       return -ENODEV;
   }

   This fixes the leak while avoiding double-free. Acceptable approach?

   Best regards,
   Hongling Zeng


在 2026年05月29日 00:46, Dominik Karol Piątkowski 写道:
> Hi Hongling Zeng,
>
> On Thursday, May 28th, 2026 at 03:50, Hongling Zeng <zenghongling@kylinos.cn> wrote:
>
>> The fmh_gpib_attach_impl() function has multiple resource leaks in its
>> error handling paths. When any initialization step fails, the function
>> returns early without properly releasing previously acquired resources.
>>
>> Fix by adding proper error handling labels and cleanup code that releases
>> resources in the reverse order they were acquired.
>>
>> Fixes: 8e4841a0888c7 ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB driver")
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> Cc: stable@vger.kernel.org
>> Suggested-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
>>
>> ---
>> Changes in v2:
>>   - Fixed unnecessary retval assignments in early error returns
>>   - Removed extra newline
>>   - Kept e_priv->irq assignment after request_irq() succeeds,as suggested by Dominik Karol
>> ---
>>   drivers/gpib/fmh_gpib/fmh_gpib.c | 37 +++++++++++++++++++++++++-------
>>   1 file changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpib/fmh_gpib/fmh_gpib.c b/drivers/gpib/fmh_gpib/fmh_gpib.c
>> index fcafdc02ea2e..404379cd1565 100644
>> --- a/drivers/gpib/fmh_gpib/fmh_gpib.c
>> +++ b/drivers/gpib/fmh_gpib/fmh_gpib.c
>> @@ -1418,7 +1418,8 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>>   				     resource_size(e_priv->gpib_iomem_res));
>>   	if (!nec_priv->mmiobase) {
>>   		dev_err(board->dev, "Could not map I/O memory\n");
>> -		return -ENOMEM;
>> +		retval = -ENOMEM;
>> +		goto err_release_gpib_region;
>>   	}
>>   	dev_dbg(board->dev, "iobase %pr remapped to %p\n",
>>   		e_priv->gpib_iomem_res, nec_priv->mmiobase);
>> @@ -1426,34 +1427,39 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma_fifos");
>>   	if (!res) {
>>   		dev_err(board->dev, "Unable to locate mmio resource for gpib dma port\n");
>> -		return -ENODEV;
>> +		retval = -ENODEV;
>> +		goto err_iounmap_gpib;
>>   	}
>>   	if (request_mem_region(res->start,
>>   			       resource_size(res),
>>   			       pdev->name) == NULL) {
>>   		dev_err(board->dev, "cannot claim registers\n");
>> -		return -ENXIO;
>> +		retval = -ENXIO;
>> +		goto err_iounmap_gpib;
>>   	}
>>   	e_priv->dma_port_res = res;
>>   	e_priv->fifo_base = ioremap(e_priv->dma_port_res->start,
>>   				    resource_size(e_priv->dma_port_res));
>>   	if (!e_priv->fifo_base) {
>>   		dev_err(board->dev, "Could not map I/O memory for fifos\n");
>> -		return -ENOMEM;
>> +		retval = -ENOMEM;
>> +		goto err_release_dma_region;
>>   	}
>>   	dev_dbg(board->dev, "dma fifos 0x%lx remapped to %p, length=%ld\n",
>>   		(unsigned long)e_priv->dma_port_res->start, e_priv->fifo_base,
>>   		(unsigned long)resource_size(e_priv->dma_port_res));
>>
>>   	irq = platform_get_irq(pdev, 0);
>> -	if (irq < 0)
>> -		return -EBUSY;
>> +	if (irq < 0) {
>> +		retval = -EBUSY;
>> +		goto err_iounmap_fifo;
>> +	}
>>   	retval = request_irq(irq, fmh_gpib_interrupt, IRQF_SHARED, pdev->name, board);
>>   	if (retval) {
>>   		dev_err(board->dev,
>>   			"cannot register interrupt handler err=%d\n",
>>   			retval);
>> -		return retval;
>> +		goto err_iounmap_fifo;
>>   	}
>>   	e_priv->irq = irq;
>>
>> @@ -1461,7 +1467,8 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>>   		e_priv->dma_channel = dma_request_slave_channel(board->dev, "rxtx");
>>   		if (!e_priv->dma_channel) {
>>   			dev_err(board->dev, "failed to acquire dma channel \"rxtx\".\n");
>> -			return -EIO;
>> +			retval = -EIO;
>> +			goto err_free_irq;
>>   		}
>>   	}
>>   	/*
>> @@ -1473,6 +1480,20 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>>   		fifo_max_burst_length_mask;
>>
>>   	return fmh_gpib_init(e_priv, board, handshake_mode);
>> +
>> +err_free_irq:
>> +	free_irq(e_priv->irq, board);
>> +err_iounmap_fifo:
>> +	iounmap(e_priv->fifo_base);
>> +err_release_dma_region:
>> +	release_mem_region(e_priv->dma_port_res->start,
>> +				resource_size(e_priv->dma_port_res));
>> +err_iounmap_gpib:
>> +	iounmap(nec_priv->mmiobase);
>> +err_release_gpib_region:
>> +	release_mem_region(e_priv->gpib_iomem_res->start,
>> +				resource_size(e_priv->gpib_iomem_res));
>> +	return retval;
> I see a problem with this patch.
>
> fmh_gpib_attach_impl is called from fmh_gpib_attach_holdoff_(all|end), and these
> are passed as attach through fmh_gpib_(unaccel_)interface. The only place where
> I see attach is called, is in common/iblib.c, in ibonline function. If attach
> fails (that is, returns with -errno), detach is called (fmh_gpib_detach for
> this case), where a proper cleanup is performed.
>
> If we release the resources in attach and not clear corresponding e_priv fields,
> we will fail badly in detach, as we do double free/unmap and use after free.
> Clearing e_priv fields will result in having two competing cleanup routines,
> and I don't like that idea - let's have one proper cleanup in one place. The
> only way to keep this approach would be to rewrite the core gpib logic for
> attach/detach, and I don't know if it's worth the effort - probably not.
>
> Thanks,
> Dominik Karol
>
>>   }
>>
>>   int fmh_gpib_attach_holdoff_all(struct gpib_board *board, const struct gpib_board_config *config)
>> --
>> 2.25.1
>>
>>


