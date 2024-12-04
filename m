Return-Path: <stable+bounces-98284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7349E387B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 12:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01132835EE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 11:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D7A1CDA01;
	Wed,  4 Dec 2024 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I32eI+Xd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A621B415A
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310677; cv=none; b=p2AsflR3RebtMDK9Sir+aJrQVm1zZm5/lT1d5EoapPEOkDWjGT/Htf3YjA05iPH3BcF7hWZo3YEnCs8n5Q4gt0vy7/YTOJF2Szs7eTkEZYrTe+fCsJQ5ehGmbAD9eCMoD1P5Bn5n3v9BLYb1DiQERzJ/zIMlARFxgHA9U1K+BJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310677; c=relaxed/simple;
	bh=L5IyQ5nL3Vx0ii5rBZ5S9yZ06JCRh5nJS/h/hJf1L4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phiLMIxNDP9GjiklvsYjE59aVLIPv36/yd/odpn9VtOYMuuNr3TEd3D0un7/ib95bs+8n3d1r9rQdqZOwysP2nIBSzXRp5TLRyMzXciF5lco9GAD9zaDNobTPt7kCJdo3k+avDNYq3SqVoJNp2NygOElCvxDCqp3/DSf7TAgpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I32eI+Xd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e5b43350so162341f8f.2
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 03:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733310673; x=1733915473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VhaMZOPSYfWc16c/uIlUKV87o3EICb3QAE0FT4FA0n4=;
        b=I32eI+XdsOrjFXJoS/+/eoqCrpGs8eiYJByzzj+h0OYn8Dqgebaeu1R76Vi1A0YKOd
         r3o42plooKBrgh+PrNty3TaD0AbHyJ/Trpqkhv1jrOHtmy8YuoTZlUNKGAgGkLJzU4XN
         nMYMcb3pfaRrw3VkXg+XJoEt34g+EiPGPxP+VNpcdESjesdeqwonl8zQOc6ARZthmsAt
         9MDRInD2/SKmn+0LG00+iXlQYZ8bMSAIHvIf7sEoCX1p6oG3pV7xWm9wkjlSxnbpI0Z0
         yRkW2TwALsuHuwjBNJTromwzL9kW8f88Q/hSIajZ8CfZywMcXyru3kVqK4rbnz11n0RS
         lCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310673; x=1733915473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhaMZOPSYfWc16c/uIlUKV87o3EICb3QAE0FT4FA0n4=;
        b=j3NbJbq698uaGLxbXPeQ10CtR50YX5ashKuwBeiXqDl9loEeX2/gEqv9DkPSIpkWQn
         Vs051D/oYX7hbxKde4fq+JHH6vDDRX9kjFC6Kiu3gepbXtaZTR0iFUfc1HdJ55CuOWlP
         88ZV3A6yd3TPA417GwTseCF4jaJKXFP0/q20+k113bQ+uusX1QjvkFi36jh8B2NNS8mO
         VEB0RH3G+GxyJFdMIvXUjwO/aWgYnYS8AJtBg8E4/UJesFCUbz+TQZpHR9usTLLBdVF3
         CBMjV1cd5dYCubWjE4z4uJrre05m2I0gj6sFnZcBRPl6AHEhZc5Ti0joJsO52CqansPr
         VOmg==
X-Forwarded-Encrypted: i=1; AJvYcCVlvHXJ9E2kGVK1UsGfMd+tYqg3x2ZR0ZuTmeLJrLrMXuVzBP17gU8AHS4BSwGTdsaScqXU9Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1RPH752kzTdhtXpChWC5jEneiN+C0JoGT24M8gZMkBMRYQ8L
	H+6cxB/kPctPx3oMp+qTtNxIfdDbL5+FnlSOYlFK2qdURbqBeVJ9xB2Ibb9uNgQ=
X-Gm-Gg: ASbGncvEih84bQ4tgnic2hdQjhFbLh50o6e2YKBPQ2nExrrBcobwRAov+xaOZqhoBnd
	ihHl03XF0jFa3vQLJeBeIsZFPhNylDc+1FdBhyyvVG2/XBfjOStUknr7j2de5mCyxvrQo2Q5lhz
	ksyFMuxi8gRkH/fjAjdGEgKqnicKkyXjX5jY85/2UDz33EhQMnWaLhys/eH9xcQd0LbskSmW0Ob
	eGv60qgEhf/9BLgG90EVoqZCF7098Wg855Xa4v+QsF4MK4eG5a7Zw==
X-Google-Smtp-Source: AGHT+IHXyIRahTiY0jxdbWML3F/Qt7hDAusTvFHNbRMxDzDB3YlFm4EzkttRkB/g/4jkv3ZXZ8+ebA==
X-Received: by 2002:a05:6000:1a86:b0:385:f909:eb33 with SMTP id ffacd0b85a97d-385fd40ad98mr2091506f8f.10.1733310672843;
        Wed, 04 Dec 2024 03:11:12 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254181464csm12058921b3a.157.2024.12.04.03.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 03:11:12 -0800 (PST)
Message-ID: <87cfb429-175f-4d3a-a399-98264056536b@suse.com>
Date: Wed, 4 Dec 2024 19:11:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ocfs2: Revert "ocfs2: fix the la space leak when
 unmounting an ocfs2 volume"
To: Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, stable@vger.kernel.org
References: <20241204033243.8273-1-heming.zhao@suse.com>
 <20241204033243.8273-2-heming.zhao@suse.com>
 <6c3e1f5a-916c-4959-a505-d3d3917e5c9c@linux.alibaba.com>
 <79b86b7b-8a65-49b8-aa33-bb73de47ad37@suse.com>
 <58618b80-f1ab-4b22-a3fc-9d29969615a0@linux.alibaba.com>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <58618b80-f1ab-4b22-a3fc-9d29969615a0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/4/24 17:28, Joseph Qi wrote:
> 
> 
> On 12/4/24 2:46 PM, Heming Zhao wrote:
>> On 12/4/24 11:47, Joseph Qi wrote:
>>>
>>>
>>> On 12/4/24 11:32 AM, Heming Zhao wrote:
>>>> This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
>>>> unmounting an ocfs2 volume").
>>>>
>>>> In commit dfe6c5692fb5, the commit log stating "This bug has existed
>>>> since the initial OCFS2 code." is incorrect. The correct introduction
>>>> commit is 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").
>>>>
>>>
>>> Could you please elaborate more how it happens?
>>> And it seems no difference with the new version. So we may submit a
>>> standalone revert patch to those backported stable kernels (< 6.10).
>>
>> commit log from patch [2/2] should be revised.
>> change: This bug has existed since the initial OCFS2 code.
>> to    : This bug was introduced by commit 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()")
>>
>> ----
>> See below for the details of patch [1/2].
>>
>> following is "the code before commit 30dd3478c3cd7" + "commit dfe6c5692fb525e".
>>
>>     static int ocfs2_sync_local_to_main()
>>     {
>>         ... ...
>>   1      while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start))
>>   2             != -1) {
>>   3          if ((bit_off < left) && (bit_off == start)) {
>>   4              count++;
>>   5              start++;
>>   6              continue;
>>   7          }
>>   8          if (count) {
>>   9              blkno = la_start_blk +
>> 10                   ocfs2_clusters_to_blocks(osb->sb,
>> 11                                start - count);
>> 12
>> 13               trace_ocfs2_sync_local_to_main_free();
>> 14
>> 15               status = ocfs2_release_clusters(handle,
>> 16                               main_bm_inode,
>> 17                               main_bm_bh, blkno,
>> 18                               count);
>> 19               if (status < 0) {
>> 20                   mlog_errno(status);
>> 21                   goto bail;
>> 22               }
>> 23           }
>> 24           if (bit_off >= left)
>> 25               break;
>> 26           count = 1;
>> 27           start = bit_off + 1;
>> 28       }
>> 29
>> 30     /* clear the contiguous bits until the end boundary */
>> 31     if (count) {
>> 32         blkno = la_start_blk +
>> 33             ocfs2_clusters_to_blocks(osb->sb,
>> 34                     start - count);
>> 35
>> 36         trace_ocfs2_sync_local_to_main_free();
>> 37
>> 38         status = ocfs2_release_clusters(handle,
>> 39                 main_bm_inode,
>> 40                 main_bm_bh, blkno,
>> 41                 count);
>> 42         if (status < 0)
>> 43             mlog_errno(status);
>> 44      }
>>         ... ...
>>     }
>>
>> bug flow:
>> 1. the left:10000, start:0, bit_off:9000, and there are zeros from 9000 to the end of bitmap.
>> 2. when 'start' is 9999, code runs to line 3, where bit_off is 10000 (the 'left' value), it doesn't trigger line 3.
>> 3. code runs to line 8 (where 'count' is 9999), this area releases 9999 bytes of space to main_bm.
>> 4. code runs to line 24, triggering "bit_off == left" and 'break' the loop. at this time, the 'count' still retains its old value 9999.
>> 5. code runs to line 31, this area code releases space to main_bm for the same gd again.
>>
>> kernel will report the following likely error:
>> OCFS2: ERROR (device dm-0): ocfs2_block_group_clear_bits: Group descriptor # 349184 has bit count 15872 but claims 19871 are freed. num_bits 7878
>>
> 
> Okay, IIUC, it seems we have to:
> 1. revert commit dfe6c5692fb5 (so does stable kernel).

OK.

> 2. fix 30dd3478c3cd in following way:

It looks good to me.

I will send v2 patch.

-Heming
> 
> diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
> index 5df34561c551..f0feadac2ef1 100644
> --- a/fs/ocfs2/localalloc.c
> +++ b/fs/ocfs2/localalloc.c
> @@ -971,9 +971,9 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>   	start = count = 0;
>   	left = le32_to_cpu(alloc->id1.bitmap1.i_total);
>   
> -	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start)) <
> +	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start)) <=
>   	       left) {
> -		if (bit_off == start) {
> +		if ((bit_off < left) && (bit_off == start)) {
>   			count++;
>   			start++;
>   			continue;
> @@ -997,7 +997,8 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>   				goto bail;
>   			}
>   		}
> -
> +		if (bit_off >= left)
> +			break;
>   		count = 1;
>   		start = bit_off + 1;
>   	}
> 
> Thanks,
> Joseph
> 
> 


