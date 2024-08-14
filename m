Return-Path: <stable+bounces-67714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C2E95242F
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 22:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18759B22C27
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91911C8FB1;
	Wed, 14 Aug 2024 20:43:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3601C6897;
	Wed, 14 Aug 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668235; cv=none; b=UMzE7avsWACrfUOw/UHr/XIrgDQNX4FiqCMmkkK1krcPi2f+9EwkHFF7u+oWQZ4StE97k1Ac3ZqESmT9tGtgJ0etM7z2nxUNtDPq9QrSA0XrbE19j1ihzWMrvGEUOshzQvFx/iV60AnFmPMHGghdhAvdLm/vORoCNkPtDaQBfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668235; c=relaxed/simple;
	bh=57f5+sRfNMzq7JhlwC2T9BHowhNWJEZti81iX5OKFJ4=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GJavHIDRfceu4Ne42RvjndvRmNXD7aolnV/lgPV//NS71GkY/95aGnTa0Gq9wwqFGaE+86PdJSncj+E/Zgyyhv8nP+hbGpvkNsjVCIHg/RRCClNnCwIbMt8cB+QzsGIFnhdamtsrhpDVkTl5y4hID56mY482umrMer+bMUC4iXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.78.237) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 14 Aug
 2024 23:43:44 +0300
Subject: Re: [PATCH] usb: dwc3: ep0: Don't reset resource alloc flag
 (including ep0)
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20240814-dwc3hwep0reset-v1-1-087b0d26f3d0@pengutronix.de>
 <c0e06e73-f6d1-1943-fc83-2cf742280398@omp.ru>
Organization: Open Mobile Platform
Message-ID: <e26d660b-ce53-6208-d56b-b33a1d1b22be@omp.ru>
Date: Wed, 14 Aug 2024 23:43:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c0e06e73-f6d1-1943-fc83-2cf742280398@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/14/2024 20:30:35
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 187071 [Aug 14 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 25 0.3.25
 b7c690e6d00d8b8ffd6ab65fbc992e4b6fdb4186
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.237
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/14/2024 20:35:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/14/2024 6:43:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 8/14/24 11:42 PM, Sergey Shtylyov wrote:
[...]

>> The DWC3_EP_RESOURCE_ALLOCATED flag ensures that the resource of an
>> endpoint is only assigned once. Unless the endpoint is reset, don't
>> clear this flag. Otherwise we may set endpoint resource again, which
>> prevents the driver from initiate transfer after handling a STALL or
>> endpoint halt to the control endpoint.
>>
>> Commit f2e0eee47038 (usb: dwc3: ep0: Don't reset resource alloc flag)
> 
>    You forgot the double quotes around the summary, the same as you
> do in the Fixes tag.
> 
>> was fixing the initial issue, but did this only for physical ep1. Since
>> the function dwc3_ep0_stall_and_restart is resetting the flags for both
>> physical endpoints, this also has to be done for ep0.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: b311048c174d ("usb: dwc3: gadget: Rewrite endpoint allocation flow")
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> ---
>>  drivers/usb/dwc3/ep0.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index d96ffbe520397..c9533a99e47c8 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -232,7 +232,8 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
>>  	/* stall is always issued on EP0 */
>>  	dep = dwc->eps[0];
>>  	__dwc3_gadget_ep_set_halt(dep, 1, false);
>> -	dep->flags = DWC3_EP_ENABLED;
>> +	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
> 
>    No ~ afer &=?

   Sorry, I wasn't attentive enough while reading the patch description... :-/

[...]

MBR, Sergey

