Return-Path: <stable+bounces-165513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1382EB16021
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 14:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96ABA7A8735
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 12:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA0D29C343;
	Wed, 30 Jul 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="daBuS8N9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66620298D
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753877837; cv=none; b=liot+M499y99dUrGg9BSlcpGOGhjSRdJ6CgWHxOKD8GFcHvOM0vWseE18E+xnma5S5BnOqlcgPW5j4/kBNRohSgRCY7L6lJl2mc7NSNbKWwnKKN0AQMYVBNP75tdmswfHQNtWIQWNkeICRJu1dvM1tL7cW/aiM1vTcOpYpDCJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753877837; c=relaxed/simple;
	bh=d3QjiVRRfmAZ6Ii0CTIFdp4YtRPXug0kqPESo38KdOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kb6DFL1hGnDFPgWpYUQmsQGc+9xiQ2HYVDkpXA4ASP0/BYJuF93G/bqt5RZe5sydA/FmA8jjE7ACWmkxS+1iDLBjTUAKA8Mw02WUBDFUyzgUucETvCJAf34x0t6i6lIl2KJjJLIXHe1oJL3IY3aLeOjSif6jkt1tmK30PWjm8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=daBuS8N9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76ba6200813so46615b3a.0
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753877835; x=1754482635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fso/N3jhxzl9tgZefuRFK00XLLOrTOKmeJ45KLHNkF0=;
        b=daBuS8N9j9iph8IsL6mARnuNv+0hZETiyB62Lzaub6wqeyeKI0leDt7UW1MH9ju7iL
         ued6MxRW3fl9fl1YrhVxgvE7sVw7je1XsXiByux8+FLqlXMtsUlteoRYk66O13qBZcR/
         a7JmUHFbyu0Eum5gOlYREXtVL1f2KQg00sIpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753877835; x=1754482635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fso/N3jhxzl9tgZefuRFK00XLLOrTOKmeJ45KLHNkF0=;
        b=Nfq83vtOFaQAU7wMfIm4jCWcX2Elkj21ma+39Ov+8ZiLsIiboA9ZGA95g6pyh0q02D
         vHAoUQojTlWYqnpQpu2+TT79C/kbFAOWeEWYRZKV4RpBncoV/NoCadQiEdEUsRoRggq6
         wNFq9QwQs2/Jes74J0bHX0jAsckuyWYoX9w4qwiS++2MiisXiC/oZQXE3e3GoAGesYRf
         quSyVJ5Ekp3wo1qqhm384wT9IDa5VV1tZE0mEOtK/xthTLSyW2E+OOZAAort6WxnUt8W
         qs2O01evG5xDKIeDYO18xP1gD+Duv6BKuG5baWfXr5d87wuiPzexssa9mdvAWLK5cATv
         sFqw==
X-Forwarded-Encrypted: i=1; AJvYcCVMOPMcNu5MU6W4TY53DPdXacTUnaqyvdAmYFXevwOukIxsvRXMxqdDyx4563cOyFXTCDpfF8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8jmwqshRs+6/9dgL1S/AVS0iKJu4y9Bgd5R/VFzAdRpLULv5
	z6T4cIuftEjtXCTKPv6/JlKNEXSf44QZS2DvHvUUnMgZaNVTM6xMcx4+b7HFZCMq9SXanOpXzDy
	1Dk5F+sM=
X-Gm-Gg: ASbGnct8TuNQuDapN1R+7p6i4QC6diGyk0rVBvvBg3WPGHqixe7MTjAsoYCj1QyNDug
	rXScJMwVk53aF23UvUX6ejTI4M0XOedjpKiMF6iLYzYvvsEbGZrxHV3142sFwrHn4qR3s9Ly88Q
	hHUAg2DFHnbcD+G+1jvtIIZkiYj5o+g2NmNzzAnWdxbJF1qMqlhSYqKIzAKuYc/pXLCM6zr9346
	jyScgYc47ih3UdrorP/qtsX465fbWww9QirnvlBojIKuPjmTMmLFXQrbygZqYRh1enUBMAawLWW
	yrBdchebisTzZhIhmQ5oDeWhNu7xfNpvBN14R9zN1ORVlHLhBoUiIS99tjIv946VAWoP+ab5BT4
	VuYMWy5JFtxOvcsqaeKRQg6K8Mw==
X-Google-Smtp-Source: AGHT+IFZH400EkMw50BLNlpuJqmrhaPtkfCKRsDQSo+uUE4Lv5IdCV+v3w+I7tZggNSviZKx3VteRg==
X-Received: by 2002:a05:6a21:4c85:b0:21f:5ef3:b1ea with SMTP id adf61e73a8af0-23dc0d57446mr2487798637.1.1753877835235;
        Wed, 30 Jul 2025 05:17:15 -0700 (PDT)
Received: from [192.168.0.80] ([202.179.69.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76a284b4047sm3602858b3a.101.2025.07.30.05.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:17:14 -0700 (PDT)
Message-ID: <f6fc2cf9-18dd-411a-b291-8ee0005cd292@mvista.com>
Date: Wed, 30 Jul 2025 17:47:11 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y 8/8] act_mirred: use the backlog for nested calls to
 mirred ingress
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, stable@vger.kernel.org
References: <1753464140-e7196da4@stable.kernel.org>
 <20250728052618.171895-1-skulkarni@mvista.com>
 <2025073030-thrash-negative-6089@gregkh>
Content-Language: en-US
From: Shubham Kulkarni <skulkarni@mvista.com>
In-Reply-To: <2025073030-thrash-negative-6089@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

Thank you so much for the information! I will send the missing "fixes" 
patch first to v5.10 & then send a v2 for v5.4 including the missing 
"fixes" patch.

Thanks,
Shubham

On 30/07/25 2:41 pm, Greg KH wrote:
> On Mon, Jul 28, 2025 at 10:56:18AM +0530, skulkarni@mvista.com wrote:
>> My apologies for sending the HTML content in the previous email/reply which was rejected by the stable mailing list.
>> Here is a resend without HTML part:
>> ---
>>
>> Hello Sasha/Greg,
>>
>> For the "found follow-up fixes in mainline warning" for this patch:
>> "Found fixes commits:
>>   5e8670610b93 selftests: forwarding: tc_actions: Use ncat instead of nc"
>>
>> While analysing the patches, I actually had noticed that the commit 5e867061 is a follow up i.e. "fixes" commit. But this commit  5e867061 is not part of the next stable kernel v5.10.y and as per my understanding, we are not allowed to backport a commit which is not in the next stable kernel version. Thus I haven't included that commit/patch here.
>>
>> I am new to the process & learning the rules. Can you please let me know if any action is required from my side for this patchset here?
> 
> You need to submit all of the needed fixes for anything you have
> backported as well.  As you are introducing a "problem", that would not
> be good.
> 
> But, as you say, this is not in the 5.10.y tree yet, so please submit a
> version for that as well, then there should not be any problem.
> 
> thanks,
> 
> greg k-h

