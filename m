Return-Path: <stable+bounces-108616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E58A10BF0
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 17:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE893A3521
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250821C1AAA;
	Tue, 14 Jan 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBjRFNy4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6B1AA1DC
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871180; cv=none; b=mCmyGZGCqTNhd8XSs6G7XhSiRzgzEm76uy121fVL9FE6EkCmmKI+V7is4IrdFrZfftD+cZSsZT+pXyAjiGKeQrlajncjhl33dg+QwTBTpNI5y+gQOclzMRKPQz7SNCj3EfX3lejFMgPV51GZeGfFmoW+fdEcTsvLdwb7edfNu+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871180; c=relaxed/simple;
	bh=DPxSBXYj5+Cie9FQhV3urqAbzP460lDWuePHUdfwhY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtGNBDFYKvoy5OqXUrKoS/F3d5lAYiJZmxP4cWUjlRjNGMrA7WWFZxhV7An2Aw7fnkevWCEiB5Gl43fru0ztVO7HJ2NXkmMVKujFXiFV20OEOpzO7V4oHtb7AxVVKTZmnf6eqSIsO+7iKcbtYfsi789xm/0Lde991mPPJB9dxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBjRFNy4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so474565885a.0
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736871178; x=1737475978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1ez0Y9/qkSWPKaIZfJ3AgE1cJ4EV6MroSfCc0eODCI=;
        b=WBjRFNy4gZBzGOhImxq0c9ekN29DRNDBtaeSS04dpBZIQE7oN/6JuxOlS63F5SrTnd
         r5KPObzu8r7GQUtCdb6AFmkyK9f5+w1XjJW6qNapkyx61jF3BsUuEFyZ6wCbRjoqJk7r
         ps6nOnla/jRKsbvky7zjETR9P6iWtykr9peYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736871178; x=1737475978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1ez0Y9/qkSWPKaIZfJ3AgE1cJ4EV6MroSfCc0eODCI=;
        b=tIGPA9KPBPiRTsj0wdGlAVf36yfdeejSiSnGmRsETiBMabV8/L+rdwco65BEJBhw0Y
         ZnK1TZJkiIc4p8eC0juHHKguLm4Th82UWMRAe0S70HWP5K+ZeYzPMEtqQhxzKwZ4C3xi
         nG3EGhnmq3GE7Si+bgzw6e+Gsx+9gDjfnXB7NTgbmho8Z1jY24HuY8Se3IuVHgx65tcL
         Qa+BL4qceRHy4eDmsF2PDU8LG3fSHFjWpvRgxQSUXFSF0Lliynq0rrXW2AStDH5kOmeq
         7dQgsd/8ewwL0ToJGFhQrRF/ELx71KduHeS/pfty+dvs0paMpcGS9dGjCFknL8iNWWFQ
         riTg==
X-Forwarded-Encrypted: i=1; AJvYcCU8P7YQt0sIfjVYx53aoYWJ9eeBm7kwSz6y0tMwg8jGIPuxDR0t0XtyMvW9dhTk2NyG23cLCG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQKM9M0IacJvYfy1bket54KSl/DYJxSF55KyL3b4Hhgy/bCBww
	QLjzexIY2QGeifke3zBAdyuZO54vMQtjQkmvkBO64OC406UqLP3W7jokzmKP6krUn53IFxLsLJv
	Q
X-Gm-Gg: ASbGncuh23b8ksa7eBtCi276E++C52UHg7jr75u4VCbi2sR+aM2nAV+UHJAwwXfvOdq
	Iu3eBMxfhcqnHQroeYZzXo17dVO2LYsh6IOZNqjJHYoqSZgHswCE0TFCsTwHps0/k+oa+xShn7o
	hXijwwzT+4GTGVeWb9op5BYQZ484TllXmY2wvquDiWfmQYRhamPFPcl335PBAv0X/+f6re+T+Ci
	V+VGpXPoGUnLJgifx//scoVkyIIYRbgBHAQjbCGcqKrhjv6k1Pjja8V05uFcwfa8Q8=
X-Google-Smtp-Source: AGHT+IHrpXsovA0TmTlCENO3wBEAm5DshEtDzJ+tfCxG67zi2dsgrXWeJ08LvJG3WrXCFjZLz5iriQ==
X-Received: by 2002:a05:6e02:114f:b0:3ce:7cca:7c0d with SMTP id e9e14a558f8ab-3ce7cca7c40mr17669525ab.12.1736871167110;
        Tue, 14 Jan 2025 08:12:47 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce7d9d720esm3366995ab.70.2025.01.14.08.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 08:12:46 -0800 (PST)
Message-ID: <af9577f7-71fb-4760-9bd6-c3fc43aa0f30@linuxfoundation.org>
Date: Tue, 14 Jan 2025 09:12:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Fix rseq for cases without glibc support
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Raghavendra Rao Ananta <rananta@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241210224435.15206-1-rananta@google.com>
 <15339541-8912-4a1f-b5ca-26dd825dfb88@linuxfoundation.org>
 <291b5c9a-af51-4b7a-91de-8408a33f8390@efficios.com>
 <fbfe56d9-863b-4bf4-868c-bc64e0d3e93a@efficios.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <fbfe56d9-863b-4bf4-868c-bc64e0d3e93a@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 07:27, Mathieu Desnoyers wrote:
> On 2025-01-14 09:07, Mathieu Desnoyers wrote:
>> On 2025-01-13 18:06, Shuah Khan wrote:
>>> On 12/10/24 15:44, Raghavendra Rao Ananta wrote:
>>>> Currently the rseq constructor, rseq_init(), assumes that glibc always
>>>> has the support for rseq symbols (__rseq_size for instance). However,
>>>> glibc supports rseq from version 2.35 onwards. As a result, for the
>>>> systems that run glibc less than 2.35, the global rseq_size remains
>>>> initialized to -1U. When a thread then tries to register for rseq,
>>>> get_rseq_min_alloc_size() would end up returning -1U, which is
>>>> incorrect. Hence, initialize rseq_size for the cases where glibc doesn't
>>>> have the support for rseq symbols.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")
>>>> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
>>>> ---
>>>
>>> Applied to linux_kselftest next for Linux 6.14-rc1 after fixing the
>>> commit if for Fixes tag
>>
>> Hi Shuah,
>>
>> I did not review nor ack this patch. I need to review it carefully
>> to make sure it does not break anything else moving forward.
>>
>> Please wait before merging.
> 
> I am preparing an alternative fix which keeps the selftests
> code in sync with librseq.
> 

Sorry for the mixup. I will go drop this now.

thanks,
-- Shuah

