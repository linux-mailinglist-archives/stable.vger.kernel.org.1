Return-Path: <stable+bounces-116938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A62EA3AD23
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 01:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1881174FEB
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 00:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8561D286297;
	Wed, 19 Feb 2025 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ch+Pw4CE"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124E224D6
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925250; cv=none; b=mDlVaxXTY6q42KEpIb/6hv+UG92rp2b/GqoOtZbdduLX0mw10ktCrH+9nLJMdrGQ6pUsPwcDiVvlC1us3z9TUKeUuqtpM39fpTCyBCwr0aUmE1jHYx4cpAdbE2OR7ChsPPaJQYFhdz9zXfzyjuHHZdCf09FDrnU8ltz1NFmrlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925250; c=relaxed/simple;
	bh=QGiWs8CbBv3H0f/Uh9KQny7ksqxc16ijTALsxn9XL9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnsR8lDOtwEvZvV8Nsqya27+0jOGK8RHFQJZKWChsyzOutd+kDqcaWV2fSBrJ+zLl6gXNLD5gImIbrV9s8uAXUh5UQETewsL2U9RUTkP+Aybf6p37qdMglrBx6pIVG1HVZ4Ca/Qo/rwQIxFQmqMfBvAdso8yh4s0TenuLFZYhfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ch+Pw4CE; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739924936; bh=h1GCWz8aZMtRMVMCvM66rlwRcQ0d+VXG/E3Uw7/VVXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ch+Pw4CEPkuLjS/bnOGI+dR5K10b6MbKCibW4qRUxENOYZHLroE4CtR7/c2xEpoUi
	 UN2xwFUquHbQ72wEKrvH3EVvSmDkP2e0veVvzAFj9EClZZptv4p7TANj5WXN3DjWMV
	 ZzRE5Owy1k6iH7TnD2Ov9wjdSxnJGupW+Iiqn5qA=
Received: from [192.168.3.47] ([120.244.194.234])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 736AA226; Wed, 19 Feb 2025 08:28:54 +0800
X-QQ-mid: xmsmtpt1739924934twouyxgg7
Message-ID: <tencent_72D614383030790D87B4B735BE1F1B92D208@qq.com>
X-QQ-XMAILINFO: M7k988jRTRnEZzP4/OMjP7qT7EGgslYTmgywpTfciXNnIYyMzDXtIT0LdLA273
	 UkDoE37udtqXgU3hx9zXHZhcSr64CUvzvpL/F+PvpaefwSAnKnshQh4TvYQViw9l7/wPeqxWOa0j
	 DqFvRxH8i/IC1AQj07IwqG3uJRrc//tvoUp7j0Iutpz+uGdGyIHv/6hH4fW0crUuZcg+Saz42VxG
	 AweZwuiYNaasNQCrrQTlNx9EQsA385+xswgYjRXxqMCPYD1urcFqDFtNO/ojAu3gK14eq2uN8Hba
	 j7MrxWXGffo9zW8XpXof3gkmZYmqtZJi/O3DbGgBvzGGdBwR2ZJCm11PafP6hAHTORHxFvQ+N+yH
	 MOSFX7eeEQfEeeG4/pYTzNNDnkXa1jP/oj419ToESqQxPCOp+dJS9TWZxexKDQnZKPMFtqILhDW5
	 V5RbmPkzFK/C7m+V3ZYlanNl2h6Ep4QhKM+pAiapaTaauR15YpTW6lRLrMNqVfqi/Rh2HJb4u3Ip
	 wgCdQ5aB4JhoGI0Q8Vuf3MeU1BOEqd6uQIpvQLyUYdeTId97lYTQ2q2wLcuoQZIzBiKdvsyK1gJS
	 taqvQgq8KOaw+e6GVjEjfSlZILvDCh82SScUZnZHCr9QHHMF1hBDh5sruhVhWZKYFEuVjruAZbAq
	 7Yv2XcPNuFvrDcX9o2yxkNOoZQbM5cSw0XcFjdXUYxl6Xt6qhU4XvVZrqug5DiQ8KC8jD8YDfIN1
	 FOFUQCLpOA4FZ1RcW+mt3sQ0rVz9dpFRNpY7149K1jFI0b1nuthoYXdTIflQ9vnfOaAwDKgjPu9T
	 qqcTXhzdoaFfPgpnWdV3vIy8YHJUzhl6jO/I8XOs3ouJO2kz5Q0SDihJlEXiT9K4CgXOcWSbznQj
	 au9GswHqQhy07EJZD2j+hYka5duTUcErXjOBDp6d6X7V9GpihhacWKfjKbB+wYnNUxDG83jGbx8j
	 kiQzFckgnYQw3JNP0zeugz89pAsjnO
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-OQ-MSGID: <df9b3328-9697-4c1a-b183-4d27af7f61fc@qq.com>
Date: Wed, 19 Feb 2025 08:28:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] nfsd: release svc_expkey/svc_export with rcu_work
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Yang Erkun <yangerkun@huawei.com>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
References: <tencent_4D4DC3879124B5B5140E1D0C64031B6D5706@qq.com>
 <2025021848-mouth-destruct-c700@gregkh>
Content-Language: en-US
From: Bin Lan <lanbincn@qq.com>
In-Reply-To: <2025021848-mouth-destruct-c700@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/18/2025 10:47 PM, Greg KH wrote:
> On Thu, Feb 13, 2025 at 07:46:56PM +0800, lanbincn@qq.com wrote:
>> From: Yang Erkun <yangerkun@huawei.com>
>>
>> commit f8c989a0c89a75d30f899a7cabdc14d72522bb8d upstream.
> Why do you want a commit that was reverted because it was wrong to be
> backported to a stable kernel tree?
>
> Please fix your workflow to properly test and figure this thing out
> ahead of time so that it doesn't waste our reviews.
>
> thanks,
>
> greg k-h

I apologize for my mistake, will take more attention for this and do 
more properly test. thanks.



