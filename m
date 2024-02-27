Return-Path: <stable+bounces-23859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D858A868B8C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDB31F2188E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822A5135A6A;
	Tue, 27 Feb 2024 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ILfIJKkG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C8754BCF
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024587; cv=none; b=iqA/+Yh/QKDSPAI/WlWwL2lWJV55TuozO8rhX5lI6zYXnQhcglGa4Y1bvNp0BG9KGYKVEiuqdgp6bz7j1uoonO7f2PP7r7EG46F8R271yGMICYjntQMVgKs+D3a1Mg2q/nlQ3iZFn4xdC7DP5g96bjmea0PI2n/8mv8wga5EC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024587; c=relaxed/simple;
	bh=SFvU5xMHlud00Hpw84Ov5ild9BQy8adDbKg/x/NcSQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3sz6u4ggRZR/T3eIMNSzK3mRaYgAFB6WiRDhuYFUUwY787TpGw1lUeH+IINhj9yruaASN1W2oFdSfTz8yDFmHTx4QwNHUZUXrJqhFlA/8Twp83729EQ91iVq0zo4IKzCrfWxZfoAqdFFZWgIGYIQNwmTXt6+VbDoDjQGicqmbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ILfIJKkG; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-299e0271294so2483079a91.3
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 01:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709024584; x=1709629384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLWKW0rddddhS0GoDZzCVkkEKFBdhhwku0d8WbS6hqw=;
        b=ILfIJKkGE0i6QvGKqPTdCCnrO4PZ38SrJkx0Or/jNGU0jvV2qbOrlxJH/D2opH1XAt
         tGpGuxlDLJOzrh4agc32BOhioZUEMo+iaxGAzJcKWxBFtMKt071d9LC903ZMFvPKYonY
         gE8ervov5oaCrt64FtLl5MS83Yjd26ByXfhD1Y22rHQMC32KhmWeK7jfSR4nFQUH/H8B
         YXw7BU272PyPNWdBRNDgMRkveTHJSAHzwZQa5lzBRGUQREpxSzxROVeRg/LsSooybZJ4
         ggXG0gYRMTXFWIiBOZhUl6SpfCYIK4StQTyBi7xmgxSiRTnGgQh2QsLIIguU6SQvbQw/
         wVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024584; x=1709629384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLWKW0rddddhS0GoDZzCVkkEKFBdhhwku0d8WbS6hqw=;
        b=WGdssZ8Np9S+JuYg2GgbjsqjZD3UqozeAXVeON1+u5lBZNDQt/KOmpc1TCtkLqQjJn
         7JK05lEx65gBxLGBevcXpcu9PEGDeSgExqE/V4GJ8CleTT4XE0YAMmfPUq4nuLmGMkEq
         YvzTQS3JBqRRS3E2wJdPOV1KwcG7HMsFDN6lHQLcp1ZR2wH4jyQzEY19Ajbjd2ZDj/Yn
         Le9k+75ukY3wHaQL1sgTmGXQyLLs+lL3s/f9A3j66szp9X/84732ACbjZ6kx3IT5b9fC
         TTEQgdKIpW0NdoCrgLvMx6eubap7UFpwMGmfC3/6Ds28v7m+VBJQQt+vbDoarC9Ft0PG
         ZsAQ==
X-Gm-Message-State: AOJu0YxcgKvq2OxJBOvJTIQjm3RcwGnxBGWAXy3mYK57WDYSmWg2X9U9
	2ImUVntOwtalaNJF7XC0wVvsAVfEQm2pXT/JdrVt3idwT3+lxk1Ux3S5VUKKIKo=
X-Google-Smtp-Source: AGHT+IGT8GKJLrvz66s6R+NcknDLb/Wvs0VSXHeVppJGuaxT385CRMHoicOivGU3ulipqOw675qReg==
X-Received: by 2002:a17:90a:9918:b0:299:5c12:5ab with SMTP id b24-20020a17090a991800b002995c1205abmr6797699pjp.5.1709024584545;
        Tue, 27 Feb 2024 01:03:04 -0800 (PST)
Received: from [10.254.201.60] ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id nc12-20020a17090b37cc00b0029a61f99121sm7935957pjb.25.2024.02.27.01.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 01:03:04 -0800 (PST)
Message-ID: <a0af11d1-c8ff-4b41-aa28-8d813a1e72c5@bytedance.com>
Date: Tue, 27 Feb 2024 17:02:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/zswap: invalidate duplicate entry when !zswap_enabled
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, chengming.zhou@linux.dev
Cc: stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <2024022622-resent-ripeness-43f1@gregkh>
 <20240227022540.3441860-1-chengming.zhou@linux.dev>
 <2024022728-phoenix-varsity-45e9@gregkh>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <2024022728-phoenix-varsity-45e9@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/27 16:54, Greg KH wrote:
> On Tue, Feb 27, 2024 at 02:25:40AM +0000, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> We have to invalidate any duplicate entry even when !zswap_enabled since
>> zswap can be disabled anytime.  If the folio store success before, then
>> got dirtied again but zswap disabled, we won't invalidate the old
>> duplicate entry in the zswap_store().  So later lru writeback may
>> overwrite the new data in swapfile.
>>
>> Link: https://lkml.kernel.org/r/20240208023254.3873823-1-chengming.zhou@linux.dev
>> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Nhat Pham <nphamcs@gmail.com>
>> Cc: Yosry Ahmed <yosryahmed@google.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> (cherry picked from commit 678e54d4bb9a4822f8ae99690ac131c5d490cdb1)
> 
> What tree is this for?

Ah, for linux-6.6.y. I forgot to use your command line to send patch...

Thanks.

