Return-Path: <stable+bounces-152881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4349BADD00D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664101889DE8
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031B41F30A2;
	Tue, 17 Jun 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aVyKvt/E"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710991F4184
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170820; cv=none; b=CAGnx2sdbzsZyCzEgzC659NMYwzBvHZbksF9Fr3At6t0MQWSfEwbHp4Sy6jj+Jd7TDRTWo/D7m62JaJg/65Gwmgg/WH5oyaT6DzfErQugrT3UyYT2uxvsrZhxsdNie6dwUQdkWGejAihq6oihIM2PWfF/H6M8c+bqXsOCknqQUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170820; c=relaxed/simple;
	bh=X86HvNn1Etq4nfLYP7kZKqHceHvSsBHdbCb2iw1RucI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSH80T/33nZodzkzcbdm215TewrxI5tACs+KFuaRx0V3IfAJ/Jx5w6Z/ACilLx8nr3MtWyLeljg8lv59i/HmI5xCCviEQvBfr12Fxh4adJxxI1RPrlFtyTxSVH8SK63szA8OSZ0Gvfut5SUIwyl6P7HP1a6fC/kZjCcoUEEx7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aVyKvt/E; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-86efcef9194so193231239f.0
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750170817; x=1750775617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCezzKmxg1dgls52hhf0FjWDJWNalyuVnEBl6kLUIsM=;
        b=aVyKvt/ELE+/HQnZ+OOhR+RmL4uFjI104LoAu5i1nFnyxjiZBx6i+qkai2+PQnoajp
         jooLHOOGvbpQO72qVy4TnU/TrWIJiIOLcr5hu6uKkiUb2uPiBXxQxPNgb85FhIIe6BL+
         l9CUb8Fbd0K4ZTZ4FQpel31vZC+7+bosMcX9ed6omi3TUsaYgyaJgAEKeAMhXDHxrhc3
         bo1ekf4qo1E8htkESzTPj7p+nIOKetamHn765ixsVjVwPm1TGJmXjPM5s4uclKURkwiv
         6cAeoKKR3p4xf52aSuRrb4vGb0l3yaSypwlhAvGbZFiULKXextI3pxO5sir4zZUz4bij
         qecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750170817; x=1750775617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCezzKmxg1dgls52hhf0FjWDJWNalyuVnEBl6kLUIsM=;
        b=qZd+qn+xs6VCRRk1AsexHwwSPD3Uh59lDnL8jY44/23MGQ3vd2sdetGhmjtGl9UJ38
         qA1TFPvaWgEq7sRUrDilkjGC0WFPWblCTkxJUm24nU+3l2r8FPdyKs7v6WoVQvC+7HCc
         aWKyRIb5usXwbhPcQ8ZT9iawWqlkIVQHxpmqLFI1e4u9l+zw880mzATDT/Utl849B6+a
         A8fqKlcjKH6Bg0hJnMmR/EoZtFn7VToLCrCLnJsvuoCKZoyp641LxxtVrML8qK+A3NHP
         Ykn7O8M3LM8eDz4RE7eEO/PMZrtUNXVwHcudD6siXxNlVy8UUpoK/zKNt4O2OaP9PsKv
         lyXA==
X-Gm-Message-State: AOJu0Yzb5nLbcYzFbynx8yzSm0H42RLjdK1XC+JXXzmLEDVDYYCx+Cjy
	q5PUTp3cNxX0llqjpODYndi0z4zXqkHBeyNK5g7PWTv97pDWr6m5t7Au9QOXoja6sxGwLFP9iev
	Lts4U
X-Gm-Gg: ASbGncu8ADgh+g3hvgIfT9ngmjcQiuHFojoPlamd/JSXFP/9K/ybIfEeIKbDfkvRix2
	80l+b2ipPXFPvqQKBKVwkEC8axzTUk2oOc+HxCmSKEkNwoBaRzaNwqMlDjT0kHEsN1TB8V5XN5i
	fw2tJJ/yRL3no548e43byXbkPh8EHBv99iY/Yw1Q3FBOnIk5fDkmyF5US904pgBvMCA6+EhYN3B
	3FE2P+HPpB4stOtJItd4p71JrKKkLJchcTV7llFuDP2nJr4yqEL72RsP2Ipnw83AmJOMXnLuYGJ
	SZsHI1cfDifgCjUBAiFvym4cExTIef6aNm4pAqU40ux9Yan9c5HGoH3EnQ==
X-Google-Smtp-Source: AGHT+IElwZBiNQWjAWiOaLDmFDWjeem/vEkkaIJRBl2vN7cHOMMAs4NEHzDFTPVIStswodG8NWhemg==
X-Received: by 2002:a05:6602:608a:b0:873:f23:a39 with SMTP id ca18e2360f4ac-875dec1b0c0mr1567734539f.0.1750170817403;
        Tue, 17 Jun 2025 07:33:37 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87607473814sm16490539f.34.2025.06.17.07.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 07:33:36 -0700 (PDT)
Message-ID: <a9c5a443-b2de-498b-a8ea-d5a59d41a480@kernel.dk>
Date: Tue, 17 Jun 2025 08:33:36 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Revert of a commit in 6.6-stable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
References: <906ba919-32e6-4534-bbad-2cd18e1098ca@kernel.dk>
 <313f2335-626f-4eea-8502-d5c3773db35a@kernel.dk>
 <2025061702-print-cohesive-3a1b@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025061702-print-cohesive-3a1b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 7:43 AM, Greg Kroah-Hartman wrote:
> On Thu, Jun 12, 2025 at 11:49:46AM -0600, Jens Axboe wrote:
>> On 6/12/25 11:38 AM, Jens Axboe wrote:
>>> Hi Greg and crew,
>>>
>>> Can you revert:
>>>
>>> commit 746e7d285dcb96caa1845fbbb62b14bf4010cdfb
>>> Author: Jens Axboe <axboe@kernel.dk>
>>> Date:   Wed May 7 08:07:09 2025 -0600
>>>
>>>     io_uring: ensure deferred completions are posted for multishot
>>>
>>> in 6.6-stable? There's some missing dependencies that makes this not
>>> work right, I'll bring it back in a series instead.
>>
>> Oh, and revert it in 6.1-stable as well. Here's the 6.1-stable
>> commit:
>>
>> commit b82c386898f7b00cb49abe3fbd622017aaa61230
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Wed May 7 08:07:09 2025 -0600
>>
>>     io_uring: ensure deferred completions are posted for multishot
> 
> Both now reverted, thanks,

Thanks!

-- 
Jens Axboe


