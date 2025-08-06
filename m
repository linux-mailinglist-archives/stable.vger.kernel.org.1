Return-Path: <stable+bounces-166676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB62B1BFA3
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 06:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009253AF801
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 04:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A229A1E573F;
	Wed,  6 Aug 2025 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vDrvf9iw"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182BD4431
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 04:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754455468; cv=none; b=oYinhwi8kxNSzguwNgkHTY1yEGtklwwDx1nCMXhkbwDSi/5be8oN+DQMzX6U+lhNF900okT9tLaCDSQFH/7kADkfVyWT9BafFVgXvr1FGRfssJ/OuHchpbnHv46/AX+jCOsFHA/CpWEZ+ctQTQvQsV/N/+HeOONdyGwW7QhuUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754455468; c=relaxed/simple;
	bh=clBZjVsM4riD1Jdr5EByIVbrzbJYrHxQ8DbI2snliuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=eqbgnPxk4xXa3+kqXCvYoZIwupjeXB2XDL55wppSDO57KtTI/fpIyT76a/gUROGuDEzuQ+KyuFbXsSYK6k54b+VnkoM7PUvknt//5fNG0S0xzGA1ZNuE/JhUOiH/qOOGOCMGyLoPgkZFK5Jd5eDzmHBFAR9wBEBNvXzOK5B2rB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vDrvf9iw; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250806044424epoutp01a2847186aa5cc27992f3030293e808b3~ZE-L5Jdnm3137031370epoutp01G
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 04:44:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250806044424epoutp01a2847186aa5cc27992f3030293e808b3~ZE-L5Jdnm3137031370epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754455464;
	bh=Ln69oVBXuHCu0TfnNFV5fRdjx0LD6IMCcRIsNkoyWhE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=vDrvf9iw5oWwNYOqyqsW1KZ7KxqcvG3LvgWJDTp1/clesHaSurbQJvhSDxGMPQWbH
	 95sUWWmjyCJl4bK2am5Y/xMH9va9LV1MyclG5iHuPa8t571WPslZm10WYHNKZTp/SN
	 M5+LrTihduwtf2XxaN0YfwCVTR+zCnaergMo3yQM=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250806044423epcas5p3a4d86812c586a7640dd24fef985a501f~ZE-LKdHPj1146811468epcas5p3V;
	Wed,  6 Aug 2025 04:44:23 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.86]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bxd463gy3z6B9m4; Wed,  6 Aug
	2025 04:44:22 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250806044421epcas5p37549884b5c64b50c525ea2f64b7ef047~ZE-JhiVKo0387103871epcas5p3u;
	Wed,  6 Aug 2025 04:44:21 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250806044419epsmtip228d167ce40210f0053f002a58f1e8853~ZE-HVupbJ0383403834epsmtip2s;
	Wed,  6 Aug 2025 04:44:19 +0000 (GMT)
Message-ID: <99fa41ed-dee0-499f-8827-67e1e1c70e60@samsung.com>
Date: Wed, 6 Aug 2025 10:14:18 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>, "balbi@ti.com"
	<balbi@ti.com>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "akash.m5@samsung.com" <akash.m5@samsung.com>,
	"hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
	"eomji.oh@samsung.com" <eomji.oh@samsung.com>, "shijie.cai@samsung.com"
	<shijie.cai@samsung.com>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, "muhammed.ali@samsung.com"
	<muhammed.ali@samsung.com>, "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20250805233832.5jgtryppvw2xbthq@synopsys.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250806044421epcas5p37549884b5c64b50c525ea2f64b7ef047
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250804142356epcas5p3aa0566fb78e44a37467ac088aa387f5e
References: <CGME20250804142356epcas5p3aa0566fb78e44a37467ac088aa387f5e@epcas5p3.samsung.com>
	<20250804142258.1577-1-selvarasu.g@samsung.com>
	<20250805233832.5jgtryppvw2xbthq@synopsys.com>


On 8/6/2025 5:08 AM, Thinh Nguyen wrote:
> On Mon, Aug 04, 2025, Selvarasu Ganesan wrote:
>> From: Akash M <akash.m5@samsung.com>
>>
>> This commit addresses a rarely observed endpoint command timeout
>> which causes kernel panic due to warn when 'panic_on_warn' is enabled
>> and unnecessary call trace prints when 'panic_on_warn' is disabled.
>> It is seen during fast software-controlled connect/disconnect testcases.
>> The following is one such endpoint command timeout that we observed:
>>
>> 1. Connect
>>     =======
>> ->dwc3_thread_interrupt
>>   ->dwc3_ep0_interrupt
>>    ->configfs_composite_setup
>>     ->composite_setup
>>      ->usb_ep_queue
>>       ->dwc3_gadget_ep0_queue
>>        ->__dwc3_gadget_ep0_queue
>>         ->__dwc3_ep0_do_control_data
>>          ->dwc3_send_gadget_ep_cmd
>>
>> 2. Disconnect
>>     ==========
>> ->dwc3_thread_interrupt
>>   ->dwc3_gadget_disconnect_interrupt
>>    ->dwc3_ep0_reset_state
>>     ->dwc3_ep0_end_control_data
>>      ->dwc3_send_gadget_ep_cmd
>>
>> In the issue scenario, in Exynos platforms, we observed that control
>> transfers for the previous connect have not yet been completed and end
>> transfer command sent as a part of the disconnect sequence and
>> processing of USB_ENDPOINT_HALT feature request from the host timeout.
>> This maybe an expected scenario since the controller is processing EP
>> commands sent as a part of the previous connect. It maybe better to
>> remove WARN_ON in all places where device endpoint commands are sent to
>> avoid unnecessary kernel panic due to warn.
>>
>> Fixes: e192cc7b5239 ("usb: dwc3: gadget: move cmd_endtransfer to extra function")
>> Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
>> Fixes: c7fcdeb2627c ("usb: dwc3: ep0: simplify EP0 state machine")
>> Fixes: f0f2b2a2db85 ("usb: dwc3: ep0: push ep0state into xfernotready processing")
>> Fixes: 2e3db064855a ("usb: dwc3: ep0: drop XferNotReady(DATA) support")
>> Cc: stable@vger.kernel.org
> I don't think this is a fix patch. You're just replacing WARN* with
> dev_warn* without doing any recovery. Let's remove the Fixes and table
> tag. Also, can we replace dev_warn* with dev_err* because these are
> critical errors that may put the controller in a bad state.
>
> Thanks,
> Thinh


Hi Thinh,

Thanks for your review comments.
Yeah we agree. This is not a fix patch. Sure we will update new patchset 
with replace dev_warn* with dev_err*.

As for dropping the stable tag,  It would be better these changes to be 
applied across all stable kernels, so shall we keep stable tag in place?

Thanks,
Selva
>
>> Signed-off-by: Akash M <akash.m5@samsung.com>
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 666ac432f52d..7b313836f62b 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -288,7 +288,9 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>>   	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
>>   			DWC3_TRBCTL_CONTROL_SETUP, false);
>>   	ret = dwc3_ep0_start_trans(dep);
>> -	WARN_ON(ret < 0);
>> +	if (ret < 0)
>> +		dev_warn(dwc->dev, "ep0 out start transfer failed: %d\n", ret);
>> +
>>   	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
>>   		struct dwc3_ep *dwc3_ep;
>>   
>> @@ -1061,7 +1063,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
>>   		ret = dwc3_ep0_start_trans(dep);
>>   	}
>>   
>> -	WARN_ON(ret < 0);
>> +	if (ret < 0)
>> +		dev_warn(dwc->dev, "ep0 data phase start transfer failed: %d\n",
>> +				ret);
>>   }
>>   
>>   static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
>> @@ -1078,7 +1082,12 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
>>   
>>   static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
>>   {
>> -	WARN_ON(dwc3_ep0_start_control_status(dep));
>> +	int	ret;
>> +
>> +	ret = dwc3_ep0_start_control_status(dep);
>> +	if (ret)
>> +		dev_warn(dwc->dev,
>> +			"ep0 status phase start transfer failed: %d\n", ret);
>>   }
>>   
>>   static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
>> @@ -1121,7 +1130,10 @@ void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
>>   	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
>>   	memset(&params, 0, sizeof(params));
>>   	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
>> -	WARN_ON_ONCE(ret);
>> +	if (ret)
>> +		dev_warn_ratelimited(dwc->dev,
>> +			"ep0 data phase end transfer failed: %d\n", ret);
>> +
>>   	dep->resource_index = 0;
>>   }
>>   
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 321361288935..50e4f667b2f2 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1774,7 +1774,11 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>>   		dep->flags |= DWC3_EP_DELAY_STOP;
>>   		return 0;
>>   	}
>> -	WARN_ON_ONCE(ret);
>> +
>> +	if (ret)
>> +		dev_warn_ratelimited(dep->dwc->dev,
>> +				"end transfer failed: ret = %d\n", ret);
>> +
>>   	dep->resource_index = 0;
>>   
>>   	if (!interrupt)
>> @@ -4041,7 +4045,9 @@ static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
>>   		dep->flags &= ~DWC3_EP_STALL;
>>   
>>   		ret = dwc3_send_clear_stall_ep_cmd(dep);
>> -		WARN_ON_ONCE(ret);
>> +		if (ret)
>> +			dev_warn_ratelimited(dwc->dev,
>> +				"failed to clear STALL on %s\n", dep->name);
>>   	}
>>   }
>>   
>> -- 
>> 2.17.1

