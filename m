Return-Path: <stable+bounces-196496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 111AFC7A656
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1A6435462D
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424172C0F93;
	Fri, 21 Nov 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="VVgw1hB5"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13702BEFE0;
	Fri, 21 Nov 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736953; cv=none; b=DP+XuMcjRiKBhJ/6VFpQ+6jcB5WrBcukNpEk5mpCPBZBU685bC5u+NNpIvWOsR0keZODE80SOrA5Rb/Vqx2QV+Qqrv+TLWLzCf72wpVJ03ZJaJbNAUaTqvK1FPgqRYpo+wlNtLna/wkNomNTB5ZIVqCg8u6E7qh6GZcE/xb7gBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736953; c=relaxed/simple;
	bh=fJ0M1sLkQanyUpPHH+BQxk4e8Voa0eW8d6MqSI77FQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hefu1nnJzzJWk4iqrHhMYppijzn04Wnv6Q97DizwXud38CUPWLvCoDxKJxXTUbFkVzgLAWG7Tyx8VCjA4omOEAjB0KVxZY9xZeYIYfntopelawcSdhXr9m6d5f/vQLFRZK2i3f/FDZ4IAEuKCw2GPA8Qm2NhKQ0hazn9xersXJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=VVgw1hB5; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 8F3E06000222;
	Fri, 21 Nov 2025 14:55:39 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id PgXd2eaKOUDn; Fri, 21 Nov 2025 14:55:37 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 04A22600301C;
	Fri, 21 Nov 2025 14:55:37 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1763736937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zXjtXolyhsCsLWOHGRVWxpHyUifiSB46XqP9OtK47I=;
	b=VVgw1hB5TUn2jCTkFy/rUv5OhkzZQs/kyHsz2xd6BuU+ZUZFRvxJaGOL3F/J6j25NCebfh
	OadZbeGZoW2JTVIn9fZA1srhT4m9gSNQDhsK0HmWFF+291VG6rfA9BlcyiDXMy5PRZVOTD
	8bpbCfQzhdxKe/e9N9JAYR7t+1aRIsQWWVYMLIgEk4BhEG5PRyQAuKJMdeuH1hJsLswVEl
	0PEV/vsheFdHJzj14ZQdjV784RHyzTSdOgVO52bGejPMgzIdCGdAS02Y3k9Xyj65ALJLMU
	io9xZLU3IVIZF88WO4b+LKLpYIbjOLPa8Utp6Vi4iogXT4PSiI2M5CNXHbjwew==
Received: from [IPV6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde] (unknown [IPv6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 397A636009A;
	Fri, 21 Nov 2025 14:55:36 +0000 (WET)
Message-ID: <8837bf19-dd98-40f9-b2ff-192a511c357c@tecnico.ulisboa.pt>
Date: Fri, 21 Nov 2025 14:55:35 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: phy: Initialize struct usb_phy list_head
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251113-diogo-smaug_typec-v1-1-f1aa3b48620d@tecnico.ulisboa.pt>
 <2025112139-resale-upward-3366@gregkh>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
In-Reply-To: <2025112139-resale-upward-3366@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/21/25 14:09, Greg Kroah-Hartman wrote:
> On Thu, Nov 13, 2025 at 02:59:06PM +0000, Diogo Ivo wrote:
>> When executing usb_add_phy() and usb_add_phy_dev() it is possible that
>> usb_add_extcon() fails (for example with -EPROBE_DEFER), in which case
>> the usb_phy does not get added to phy_list via
>> list_add_tail(&x->head, phy_list).
>>
>> Then, when the driver that tried to add the phy receives the error
>> propagated from usb_add_extcon() and calls into usb_remove_phy() to
>> undo the partial registration there will be an unconditional call to
>> list_del(&x->head) which is notinitialized and leads to a NULL pointer
>> dereference.
>>
>> Fix this by initializing x->head before usb_add_extcon() has a chance to
>> fail.
>>
>> Fixes: 7d21114dc6a2d53 ("usb: phy: Introduce one extcon device into usb phy")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
>> ---
>>   drivers/usb/phy/phy.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
>> index e1435bc59662..5a9b9353f343 100644
>> --- a/drivers/usb/phy/phy.c
>> +++ b/drivers/usb/phy/phy.c
>> @@ -646,6 +646,8 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
>>   		return -EINVAL;
>>   	}
>>   
>> +	INIT_LIST_HEAD(&x->head);
>> +
>>   	usb_charger_init(x);
>>   	ret = usb_add_extcon(x);
>>   	if (ret)
>> @@ -696,6 +698,8 @@ int usb_add_phy_dev(struct usb_phy *x)
>>   		return -EINVAL;
>>   	}
>>   
>> +	INIT_LIST_HEAD(&x->head);
>> +
>>   	usb_charger_init(x);
>>   	ret = usb_add_extcon(x);
>>   	if (ret)
>>
> 
> Shouldn't you be also removing an existing call to INIT_LIST_HEAD()
> somewhere?  This is not "moving" the code, it is adding it.

 From my understanding that's exactly the problem, currently there is no
call to INIT_LIST_HEAD() anywhere on these code paths, meaning that if
we do not reach the point of calling list_add_tail() at the end of
usb_add_phy() and usb_phy_add_dev() then x->head will remain uninitialized
and fault when running usb_remove_phy().

Best regards,
Diogo

> thanks,
> 
> greg k-h

