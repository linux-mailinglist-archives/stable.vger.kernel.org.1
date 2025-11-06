Return-Path: <stable+bounces-192599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E79C3A91C
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 12:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B6434E28A0
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 11:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC12D73AD;
	Thu,  6 Nov 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QIGEoVth"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E130C36D
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428452; cv=none; b=i9DMnx653nUJhIB0hwIeR3Wk6IQ/LodR/Hwg+V1rIeV+JDTZW6Q3vT4WccYq0A7QlVQ1AZGOonvz53WKQxaP9YdwoyVn5gO6Xg6ii6guF+j00okYjZ9aJMJG5S261W01gVmk+azw9UCtNylXfgzyYfzcG4mAX46mEP69IEhEkTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428452; c=relaxed/simple;
	bh=gqFoFf46u93fEIR3f7KGfVgWFxz4ZCAlCSAL+KsGpGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSl8KRr+Kvcb5FUqIYsjaimkd7TBVNyVdEfbpEFVjwPBks1UrfAEGJrMFTcOIICxLGFCzQlWBYszdx1Euto9617oq0UUi+rBocZ/5OfwUYboH8Fix/BRViBz0/HZoRE/ax9sxJFEFRIYWf0fzk25NwBlsUxygE/rIsmvijChUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QIGEoVth; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <04492fd4-4808-421a-b082-a05503b1d714@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762428445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCaZfTw8LVN8e158p7WTbXJgn+JFFz3khksAUsAIdCo=;
	b=QIGEoVthivvh8bJnndu0eNjX8TXhCLP7OofGY/I2uwqtDKCkqND52Waf+0JFo1AhKuHk44
	gNGKZhTnc/XrD07sw+UUOIFsaGMiBgIkep+LE/zEbLH9ZVkxLXliFNES+4bwKVd/LuffAE
	xTOK8Ho9mYp3twiVE7QJcjRH1QKzGKI=
Date: Thu, 6 Nov 2025 11:27:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: txgbe: remove wx_ptp_init() in device reset flow
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 'Andrew Lunn' <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>,
 'Eric Dumazet' <edumazet@google.com>, 'Jakub Kicinski' <kuba@kernel.org>,
 'Paolo Abeni' <pabeni@redhat.com>,
 'Richard Cochran' <richardcochran@gmail.com>,
 'Simon Horman' <horms@kernel.org>, 'Jacob Keller' <jacob.e.keller@intel.com>
Cc: 'Mengyuan Lou' <mengyuanlou@net-swift.com>, stable@vger.kernel.org
References: <17A4943B0AAA971B+20251105020752.57931-1-jiawenwu@trustnetic.com>
 <de2f5da5-05db-4bd7-90c3-c51558e50545@linux.dev>
 <09a701dc4ec1$d0cc3210$72649630$@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <09a701dc4ec1$d0cc3210$72649630$@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/11/2025 02:05, Jiawen Wu wrote:
> On Thu, Nov 6, 2025 4:03 AM, Vadim Fedorenko wrote:
>> On 05/11/2025 02:07, Jiawen Wu wrote:
>>> The functions txgbe_up() and txgbe_down() are called in pairs to reset
>>> hardware configurations. PTP stop function is not called in
>>> txgbe_down(), so there is no need to call PTP init function in
>>> txgbe_up().
>>>
>>
>> txgbe_reset() is called during txgbe_down(), and it calls
>> wx_ptp_reset(), which I believe is the reason for wx_ptp_init() call
> 
> wx_ptp_reset() just reset the hardware bits, but does not destroy the PTP clock.
> wx_ptp_init() should be called after wx_ptp_stop() has been called.

wx_ptp_init()/wx_ptp_reset() recalculate shift/mul configuration based
on link speed. link down/link up sequence may bring new link speed,
where these values have to reconfigured, right? I kinda agree
that full procedure of wx_ptp_init() might not be needed, but we have to
be sure not to reuse old ptp configuration.

> 
>>
>>> Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
>>> ---
>>>    drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
>>> index daa761e48f9d..114d6f46139b 100644
>>> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
>>> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
>>> @@ -297,7 +297,6 @@ void txgbe_down(struct wx *wx)
>>>    void txgbe_up(struct wx *wx)
>>>    {
>>>    	wx_configure(wx);
>>> -	wx_ptp_init(wx);
>>>    	txgbe_up_complete(wx);
>>>    }
>>>
>   
> 


