Return-Path: <stable+bounces-92912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0060C9C6F81
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 13:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2436B2390C
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9051DFD9F;
	Wed, 13 Nov 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="zXkAEAUJ"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3711DF27F
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501557; cv=none; b=JMfR8AL/H+tWonpvA15ru93J2fgsa17ZFLr4QZka3pXti7pRGL4b/PE8o9o/n8pJhNZfsBlb2txGITo+ginXF3leYCJ36QR50c8/pHZsGQlErL/xS01DTu6WncTYZVCf1M0Zfrdpn6e0svN1TkIDqNA8cHyKghX8r7jt7YehTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501557; c=relaxed/simple;
	bh=JdG7AJrRfvz0V26xDRU+dLwacdDFzlGP61mxVhm9UqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toCZQx7xeioXJtoF2GZ7EjboQaqpv2UExQ1UzU1iC/lvGYEPcrj8CDFN9hAFVVzwSMhlKOEEIZ9Po/D6sUFwMjIe/IIMuvbpZgmtrVtq+ukLLYisOhNw9C/z9jHnL6fxEhr2ZQW/CJINxemu3X9bUf4HjVAbLgrnuKhRIY7+bNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=zXkAEAUJ; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731501556;
	bh=ktqJk2cuJmF+bKTe8t4qNZZbKBCGpG3gZZtZiyrSnTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=zXkAEAUJoCmkw9Syhk+GO44hrNGCPDcgQif1DTi6GCdso+hV+d/N0wD6qhzUvww8A
	 qG0KLpM8ItgHt3gFrmNCOGTDjTwzD32PJKk5GguTqyocEDvY/kXf/4KS1xSkdWgtEP
	 GhaBsGYPOvowFmwqKrqUxhuiRU4SlkhlXr3OWSgBXLfyclvvTNqlDqysfWbkPg0qBw
	 Npj+POiiCXoXt6XBxnPoy5SLQ2Z+XRmDhCl0cvGB61KAFQM6YL1Bq8y+7u/LWZCTzg
	 UOe22h7KXTqxpWu+5OfbioVStT7Rlq+/Etq3VcfaKsPo6tzEIURCoidzCgo2by6T7l
	 gSUjuHAqeTzzw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 5E79BC80119;
	Wed, 13 Nov 2024 12:39:13 +0000 (UTC)
Message-ID: <7ecd5828-5e7a-4882-87ad-9c5fbf274524@icloud.com>
Date: Wed, 13 Nov 2024 20:39:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] driver core: class: Fix wild pointer dereference in
 API class_dev_iter_next()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
References: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
 <20241105-class_fix-v1-1-80866f9994a5@quicinc.com>
 <2024111205-countable-clamor-d0c7@gregkh>
 <2952f37a-7a11-42d9-9b90-4856ed200610@icloud.com>
 <2024111230-erratic-clay-7565@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024111230-erratic-clay-7565@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SYV05MqzjcMI26dwbWBJi8T5iJl7hZHM
X-Proofpoint-ORIG-GUID: SYV05MqzjcMI26dwbWBJi8T5iJl7hZHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411130108

On 2024/11/12 22:57, Greg Kroah-Hartman wrote:
> On Tue, Nov 12, 2024 at 10:46:27PM +0800, Zijun Hu wrote:
>> On 2024/11/12 19:43, Greg Kroah-Hartman wrote:
>>> On Tue, Nov 05, 2024 at 08:20:22AM +0800, Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> class_dev_iter_init(struct class_dev_iter *iter, struct class *class, ...)
>>>> has return type void, but it does not initialize its output parameter @iter
>>>> when suffers class_to_subsys(@class) error, so caller can not detect the
>>>> error and call API class_dev_iter_next(@iter) which will dereference wild
>>>> pointers of @iter's members as shown by below typical usage:
>>>>
>>>> // @iter's members are wild pointers
>>>> struct class_dev_iter iter;
>>>>
>>>> // No change in @iter when the error happens.
>>>> class_dev_iter_init(&iter, ...);
>>>>
>>>> // dereference these wild member pointers here.
>>>> while (dev = class_dev_iter_next(&iter)) { ... }.
>>>>
>>>> Actually, all callers of the API have such usage pattern in kernel tree.
>>>> Fix by memset() @iter in API *_init() and error checking @iter in *_next().
>>>>
>>>> Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
>>>> Cc: stable@vger.kernel.org
>>>
>>> There is no in-kernel broken users of this from what I can tell, right?
>>> Otherwise things would have blown up by now, so why is this needed in
>>> stable kernels?
>>>
>>
>> For all callers of the API in current kernel tree, the class should have
>> been registered successfully when the API is invoking.
> 
> Great, so the existing code is just fine :)
> 
>> so, could you remove both Fix and stable tag directly?
> 
> Nope, sorry.  Asking a maintainer that gets hundreds of patches to
> hand-edit them does not scale.
> 
> But really, as all in-kernel users are just fine, why add additional
> code if it's not needed?  THat's just going to increase our maintance
> burden for the next 40+ years for no good reason.
> 

Hi Greg.

This fix is very worthy and necessary since it fixes the APIs self issue
and the issue is irrelevant with how various API users (in-tree or
out-of-tree) use it as below inference shown:

API class_dev_iter_init() has checks for class_to_subsys(class) error
-> the error may happen
-> once the error happens
-> wild pointers dereference must happen within API class_dev_iter_next()
-> how terrible for such issue, and the error handling also have no
prompt messages.

API users must not like silent wild pointer dereference once the error
happen.

> thanks,
> 
> greg k-h


