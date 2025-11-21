Return-Path: <stable+bounces-196527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21731C7AE65
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D26FB4EDB89
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3312EA468;
	Fri, 21 Nov 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="EjEIz3Ay"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EED52E9EB1;
	Fri, 21 Nov 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743210; cv=none; b=GANmLipizhku+yIGbv2KN84LX0ZC3tv3IpxO+bbtO/4CW5rgFLJMsa71V4wh8wqcL6nKrTjp7LhSgRHzgqF87yLY1GCNLG6tVkELmWaKMlluy2YVBDJd5GtGRZ2VB7R99J+TUx7S1cpeBn8F1uJI+F5+1v1OaP0qCNZLvW1l7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743210; c=relaxed/simple;
	bh=cq+mOApO3YEzpzvvIt/G2fMP1l5T4nenEN3tFL5PCQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDYsp3Y+hbWNjujg8nV1uj0CA1QfZj6EvLle4AU3NFkm9Wdf1KR0tPadW4dYEOFqtQTx4YT31iR0GQOoYP28ygnEOMjrWoo3q0IK0lwWJn2LtZ1BkB+g9Cmcfh4t/rj8HN8SQZZpQ4/gDE9RfCNm76qGRSTRDbIyTulYAbHE9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=EjEIz3Ay; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id B48986002313;
	Fri, 21 Nov 2025 16:40:02 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id 6-D8MXEghn3S; Fri, 21 Nov 2025 16:40:00 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 39ACB6003C0B;
	Fri, 21 Nov 2025 16:40:00 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1763743200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LR5uTYZZlgFKDhJ2nx1opV/Ai9cjcaHfV2BTPzMcGQ=;
	b=EjEIz3Ay2+69yDek66agj6HHEEraA4zz2vE2UgvZ8pUfGZXa4ik8d4hORJEKU/HJSAA7fN
	91aoKwg+QX6Om0tm/eOyVvyGJ5e9Qvsf2ZjoOqJC9Nq89D+c/zs2Ch9VDDzZIdpJKjx7e3
	jXpEIplWvsX2Hh9FmtnMTGgbSFlBejkPdtUVN6ZYTqiAKrsfa69NcZqQ1212s5pQgqqpW3
	sP71hHxoMHEolObOyIpftqZnJCIe+J756AZHRJwtOVDLKgwpqALxhlwBBmgA2j/YQHEsBT
	YOrmNIvdvvoFWedJNo4yEKFZemOWkR7mF0TUgv7Jhe074hMTI8TSCYKt8ClNNQ==
Received: from [IPV6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde] (unknown [IPv6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 59AD1360108;
	Fri, 21 Nov 2025 16:39:58 +0000 (WET)
Message-ID: <44e00ee1-401d-41e8-b5c7-8070ce6d514e@tecnico.ulisboa.pt>
Date: Fri, 21 Nov 2025 16:39:58 +0000
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
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
In-Reply-To: <2025112100-backstage-wager-0d5a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/21/25 15:03, Greg Kroah-Hartman wrote:
> On Fri, Nov 21, 2025 at 02:55:35PM +0000, Diogo Ivo wrote:
>>
>>
>> On 11/21/25 14:09, Greg Kroah-Hartman wrote:
>>> On Thu, Nov 13, 2025 at 02:59:06PM +0000, Diogo Ivo wrote:
>>>> When executing usb_add_phy() and usb_add_phy_dev() it is possible that
>>>> usb_add_extcon() fails (for example with -EPROBE_DEFER), in which case
>>>> the usb_phy does not get added to phy_list via
>>>> list_add_tail(&x->head, phy_list).
>>>>
>>>> Then, when the driver that tried to add the phy receives the error
>>>> propagated from usb_add_extcon() and calls into usb_remove_phy() to
>>>> undo the partial registration there will be an unconditional call to
>>>> list_del(&x->head) which is notinitialized and leads to a NULL pointer
>>>> dereference.
>>>>
>>>> Fix this by initializing x->head before usb_add_extcon() has a chance to
>>>> fail.
>>>>
>>>> Fixes: 7d21114dc6a2d53 ("usb: phy: Introduce one extcon device into usb phy")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
>>>> ---
>>>>    drivers/usb/phy/phy.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
>>>> index e1435bc59662..5a9b9353f343 100644
>>>> --- a/drivers/usb/phy/phy.c
>>>> +++ b/drivers/usb/phy/phy.c
>>>> @@ -646,6 +646,8 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
>>>>    		return -EINVAL;
>>>>    	}
>>>> +	INIT_LIST_HEAD(&x->head);
>>>> +
>>>>    	usb_charger_init(x);
>>>>    	ret = usb_add_extcon(x);
>>>>    	if (ret)
>>>> @@ -696,6 +698,8 @@ int usb_add_phy_dev(struct usb_phy *x)
>>>>    		return -EINVAL;
>>>>    	}
>>>> +	INIT_LIST_HEAD(&x->head);
>>>> +
>>>>    	usb_charger_init(x);
>>>>    	ret = usb_add_extcon(x);
>>>>    	if (ret)
>>>>
>>>
>>> Shouldn't you be also removing an existing call to INIT_LIST_HEAD()
>>> somewhere?  This is not "moving" the code, it is adding it.
>>
>>  From my understanding that's exactly the problem, currently there is no
>> call to INIT_LIST_HEAD() anywhere on these code paths, meaning that if
>> we do not reach the point of calling list_add_tail() at the end of
>> usb_add_phy() and usb_phy_add_dev() then x->head will remain uninitialized
>> and fault when running usb_remove_phy().
> 
> Then how does this work at all if the list is never initialized?

In this case in drivers/usb/phy/phy.c a static LIST_HEAD(phy_list) is
declared and then for each new 'struct usb_phy *x' the x->head entry
will get added to this list by calling list_add_tail(&x->head, &phy_list).

Best regards,
Diogo

> thanks,
> 
> greg k-h

