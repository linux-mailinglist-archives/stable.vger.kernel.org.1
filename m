Return-Path: <stable+bounces-196538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C96AEC7B034
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D41A238328D
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209E3587AD;
	Fri, 21 Nov 2025 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="i7SXGPBF"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0BC358D12;
	Fri, 21 Nov 2025 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744604; cv=none; b=WRSzOnDYqYQACBF6Utz8JXGm25dWnmc6wuwYGFUltfrkmb8pi7biaWaN+WVfVco7rB4dFWjZSWVOvyU6DLNjTqLUtX74p3fUrflBkq2+4YUikurd39/XQN2Z7XPz+fza+8wZeXT/nm33ZMgIFWExTh7apkLIstSoAXtRaIA5CTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744604; c=relaxed/simple;
	bh=RDwZKWjSccvQwHbPZlTpGfJAy/aFm/NplWZhHj9Hpa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfXU6zvzDeFl1fAI4sPdxyMHe8R2skSNw3AAP1EOCwuC0AZ32mLIEmyFDu8hJsu/Cy9Xk1gRTWKz0+HSW5ALSEwfpXt+2khMiOH7tp0+IwHAwaU/8+5uoYSHGmWGlDf1XM+oIgDFFb789Z0HyNuKvsOluGm5vLc9ZZeXo/TFONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=i7SXGPBF; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 3397B60130F2;
	Fri, 21 Nov 2025 17:03:15 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with UTF8LMTP id 3wEjO05nWTg4; Fri, 21 Nov 2025 17:03:12 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 9856760130E6;
	Fri, 21 Nov 2025 17:03:12 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1763744592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTctwKLgG4xK9lAqbM3SQa9415e0zE6HqQk0IuWU/VQ=;
	b=i7SXGPBFMIEGdOAql4FxJa+HSEKv+WHtPY6hmw16R3ye0nybkgXpYHDszyCj7OAE91IH5c
	y32V9d77vwgQmolocTpT2Jiahue9VO0FXIUkoaUwlpGviWVIOCVF5M7dzhU2gFli8cfMPP
	b/Y708dtoBX8awx9aAR0iI9+OnTFM4yMc8JQlhzxn3KV1f9y6kNQc6sqaG478AbY7D/6ln
	WBOYuVrLwmYVLN9WXgRFmreMo9BtidkT3rAMtZIgNQ3v2inpTOGujb4E5S/JinVU4M/ZNo
	0nDg8JRNK5Tb1n6QYCjcZlsY1vphtR6n6rQdkamXOeLnx/ajm8yZ6xttoMsUfA==
Received: from [IPV6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde] (unknown [IPv6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id C43F3360106;
	Fri, 21 Nov 2025 17:03:11 +0000 (WET)
Message-ID: <7e2bc6d7-4fb2-4015-a0f8-38a34a7f8db0@tecnico.ulisboa.pt>
Date: Fri, 21 Nov 2025 17:03:11 +0000
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
 <8837bf19-dd98-40f9-b2ff-192a511c357c@tecnico.ulisboa.pt>
 <2025112100-backstage-wager-0d5a@gregkh>
 <44e00ee1-401d-41e8-b5c7-8070ce6d514e@tecnico.ulisboa.pt>
 <2025112111-impotency-unguarded-5e07@gregkh>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
In-Reply-To: <2025112111-impotency-unguarded-5e07@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/21/25 16:48, Greg Kroah-Hartman wrote:
> On Fri, Nov 21, 2025 at 04:39:58PM +0000, Diogo Ivo wrote:
>>
>>
>> On 11/21/25 15:03, Greg Kroah-Hartman wrote:
>>> On Fri, Nov 21, 2025 at 02:55:35PM +0000, Diogo Ivo wrote:
>>>>
>>>>
>>>> On 11/21/25 14:09, Greg Kroah-Hartman wrote:
>>>>> On Thu, Nov 13, 2025 at 02:59:06PM +0000, Diogo Ivo wrote:
>>>>>> When executing usb_add_phy() and usb_add_phy_dev() it is possible that
>>>>>> usb_add_extcon() fails (for example with -EPROBE_DEFER), in which case
>>>>>> the usb_phy does not get added to phy_list via
>>>>>> list_add_tail(&x->head, phy_list).
>>>>>>
>>>>>> Then, when the driver that tried to add the phy receives the error
>>>>>> propagated from usb_add_extcon() and calls into usb_remove_phy() to
>>>>>> undo the partial registration there will be an unconditional call to
>>>>>> list_del(&x->head) which is notinitialized and leads to a NULL pointer
>>>>>> dereference.
>>>>>>
>>>>>> Fix this by initializing x->head before usb_add_extcon() has a chance to
>>>>>> fail.
>>>>>>
>>>>>> Fixes: 7d21114dc6a2d53 ("usb: phy: Introduce one extcon device into usb phy")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
>>>>>> ---
>>>>>>     drivers/usb/phy/phy.c | 4 ++++
>>>>>>     1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
>>>>>> index e1435bc59662..5a9b9353f343 100644
>>>>>> --- a/drivers/usb/phy/phy.c
>>>>>> +++ b/drivers/usb/phy/phy.c
>>>>>> @@ -646,6 +646,8 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
>>>>>>     		return -EINVAL;
>>>>>>     	}
>>>>>> +	INIT_LIST_HEAD(&x->head);
>>>>>> +
>>>>>>     	usb_charger_init(x);
>>>>>>     	ret = usb_add_extcon(x);
>>>>>>     	if (ret)
>>>>>> @@ -696,6 +698,8 @@ int usb_add_phy_dev(struct usb_phy *x)
>>>>>>     		return -EINVAL;
>>>>>>     	}
>>>>>> +	INIT_LIST_HEAD(&x->head);
>>>>>> +
>>>>>>     	usb_charger_init(x);
>>>>>>     	ret = usb_add_extcon(x);
>>>>>>     	if (ret)
>>>>>>
>>>>>
>>>>> Shouldn't you be also removing an existing call to INIT_LIST_HEAD()
>>>>> somewhere?  This is not "moving" the code, it is adding it.
>>>>
>>>>   From my understanding that's exactly the problem, currently there is no
>>>> call to INIT_LIST_HEAD() anywhere on these code paths, meaning that if
>>>> we do not reach the point of calling list_add_tail() at the end of
>>>> usb_add_phy() and usb_phy_add_dev() then x->head will remain uninitialized
>>>> and fault when running usb_remove_phy().
>>>
>>> Then how does this work at all if the list is never initialized?
>>
>> In this case in drivers/usb/phy/phy.c a static LIST_HEAD(phy_list) is
>> declared and then for each new 'struct usb_phy *x' the x->head entry
>> will get added to this list by calling list_add_tail(&x->head, &phy_list).
> 
> Great, can you document this in the changelog text so that it makes more
> sense (and properly quote the fixes: sha1, I think you have too many
> digits there...) and resend a v2.

Yes, I'll fix it and send out a v2.

Thanks,
Diogo

> thanks,
> 
> greg k-h

