Return-Path: <stable+bounces-28174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69487C0E5
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 17:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50095B224BF
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF0173500;
	Thu, 14 Mar 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cCMj+ER0"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD04DDD9
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432167; cv=none; b=Ip0d1VGmLaw8D4rjMe7b9v0jrStb1Yb+tIrp3p3USGkvnB5eOLIILxICN2kjo/GeF8qHIe9qlwLXEJ4dAdvSFJTgbKYY5foVqxLs/CETUwOGvenoJK720X36Czoje+YYiJD9nidl6YtIn6r9ovqhKzdF7gJP0IFhpIy4+tJyoZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432167; c=relaxed/simple;
	bh=yPIgt4zoNub9ymm4btsAb/8Wg/W9ZfsIoFT2aUWIRVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a25P54jmTdNo8paNeMkFu17uyeY6+XT6MApI6ePh+Aun+hdwXH2lkw+xyZTi2BSvOhdOXdjp86Fmp33a9BrZPBLXsyCqAwmE+qKMfb0l2kOFQDolQcfUUZ3ebSQkoFUnV2e3seFLi9BGT8e9jHA3m3PNrBvAqMxh85OFPbrgDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cCMj+ER0; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-366478a02baso1965925ab.0
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710432165; x=1711036965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aMYe/+wuIMRrzJVkoVVY+zCmShtZ6kBSGstMUDAkBRg=;
        b=cCMj+ER0/3GYlBKCLNANcR9SWcGJuSt/yBEMlHUnkybmV/ozXajBE7jgaMsKup7N4/
         C41nAHQKjGLng/ERxX0bAa2ZYmJiT4W6V7Ln0m8UjkOOWmiqSXysjKZePWZqvz0L4U8c
         9h38GF589mPwENWJNRDWpeSE4bt1/xi1X2mQYq5j9AGLhrggor9tynqzvx51FBz+oJhW
         a/aDFNOFCUQA7QKmFCw5Irjxy4Y2XvofFOBaMQFlcOm7LO5dJcJfV7DajaVb1Arcj2oC
         ciOJYYvzq0xbgseUqc/5kOqC7FiOltQsYtkDM+7EaYZ4mklz27C17uuAauIy6wJQJqcf
         yHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710432165; x=1711036965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMYe/+wuIMRrzJVkoVVY+zCmShtZ6kBSGstMUDAkBRg=;
        b=TV1A++si1TKhPMkUTLsI9xt9MTc6AmGoEhjv2fBbYAnzB2gAw26Z2kd+B564Xp/yrK
         O7kJJceySSyMew/s7RcfVPR+5dVbExiUzMo2CWQixri1A+2GG9nq6YbuhRmDXNIKuqDP
         zTUlOnv1lfjuIWD5BwcWyKs43u0VnXlHuTBRfMAq29pC8zCdDxrUtm+RXxBu3hoPGD5R
         aQqm/UBgl9YfINTiJ3ICbPceaKo5wvn0GzOmBm1Q4ROpJHJtsVb3F/JqPGA99E0iThdJ
         a4z9bBwkelkzhPDiWqPPmiPuICfvzgzsHNZ/yy2DWICT0l9wjVbvxk/6Hpa5TSkhaMSe
         Zg/Q==
X-Forwarded-Encrypted: i=1; AJvYcCULVyMv297m9WKQT5aN18WcNg3mPZYniGbdOb6qbGNXNzpP/f9Bre86RtF0n9+BNjXDi2xeWDUqUiTLN4GV3tMFIEV32ijz
X-Gm-Message-State: AOJu0Yxsgp1laDhp9WBRDZEcPweLUmqgB1h7ML6OUxqPcZ92CXgeEbJn
	KzXxC0yj00tzw2tfcbNYdJgfud0TGTzs4DFosDnmTD2B/VllFEsk4XVvNzmHEg8=
X-Google-Smtp-Source: AGHT+IE04Rlqombq5HbsU6MQJnA1CY+nLOcuKvmSdWD0vbchEpHxzVEbpGlZkHj+eyglBvArxb1PDA==
X-Received: by 2002:a5e:c90e:0:b0:7c8:afe9:b1eb with SMTP id z14-20020a5ec90e000000b007c8afe9b1ebmr2505802iol.1.1710432164535;
        Thu, 14 Mar 2024 09:02:44 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id hh13-20020a0566021d0d00b007c8b1ace770sm416463iob.39.2024.03.14.09.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 09:02:44 -0700 (PDT)
Message-ID: <7ac9f1f3-9551-473e-b3ab-329e276aa41f@kernel.dk>
Date: Thu, 14 Mar 2024 10:02:43 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10/5.15] io_uring: fix registered files leak
Content-Language: en-US
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Roman Belyaev <belyaevrd@yandex.ru>
References: <20240312142313.3436-1-pchelkin@ispras.ru>
 <8a9993c7-fd4d-44ff-8971-af59c7f3052c@kernel.dk>
 <466e842f-66c6-4530-8c16-2b008fc3fbc6-pchelkin@ispras.ru>
 <fb57be64-4da6-418b-9369-eae0db42a570@kernel.dk>
 <085beb85-d1a4-4cb0-969b-e0f895a95738@kernel.dk>
 <a8c81d35-e6ac-420c-9ffa-24dd9e009e29-pchelkin@ispras.ru>
 <3f17f1d9-9029-4d03-9b0a-9c500cce54e9@kernel.dk>
 <e7cbf950-c732-4eb3-a91f-8f09249e4f72-pchelkin@ispras.ru>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e7cbf950-c732-4eb3-a91f-8f09249e4f72-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/24 9:55 AM, Fedor Pchelkin wrote:
> On 24/03/13 06:40PM, Jens Axboe wrote:
>> Hi,
>>
>> OK, here they are. Two patches attached for every stable kernel, that
>> gets rid of the remnants of the SCM related code:
>>
>> 5.4
>> 5.10 and 5.15 (same patches)
>> 6.1
>> 6.6
>> 6.7
>>
>> Would appreciate if Fedor and Pavel could give them a once over, but I
>> think they are all fine. It's just deleting the code...
> 
> Thank you, Jens!
> 
> FWIW, I think it's all good and it eliminates the reported problem
> obviously. Compiled and tested the repro with my kernel config.

Great, thanks for checking!

> Just a minor notice - stable rules declare two common ways for upstream
> patch mentioning in backports [1]. And the first one starts from
> lowercase. No big deal here definitely but maybe somebody has some
> handling of these two variants - by regexps or similar, I actually don't
> know. But I see in the git history that Greg also applies the variant
> you've used.

Honestly that doesn't matter, as long as the upstream commit is
referenced. I always do it this way, not my first stable rodeo.

-- 
Jens Axboe


