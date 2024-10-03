Return-Path: <stable+bounces-80669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D5998F498
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 18:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736371C2158D
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 16:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB25C4437A;
	Thu,  3 Oct 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFjBmUPs"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A41779A5
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974402; cv=none; b=dJTM2KlpPo9OWwuUj9fhYUN525yrfWf/oBcpIge/le8yqMFbj+2R/hkLsXZV9JvuKOX0REj9hnrZxEZ+1vsLxIQsP5qFzn191k4qDFd+Jq5QR0rtkyTNIVCIciwbBMyJ6yONfAfcE+oO6z48akQiScfc0eFX5ZsyWYceTQIivKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974402; c=relaxed/simple;
	bh=GxOLANAUYVCbqAXK2UflvIdQy85WG4HEQDkrX2neNsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpLANAsGW+U2wFKQK6KktxB9TpW9LVmDzkJb1nEuOh4lEPq88VBMfTklBZW6cR5B9A5yutFDL25OByt40kzOu5nd6vzKdodo0fnDRs5PwmkC8Kjund4kxMEsBHXtJhoLzGqyH8pR2f1gcFCVfzV+2JUE6MiNWn3FW7OvPs2rKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFjBmUPs; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82cd872755dso56373939f.1
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727974400; x=1728579200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jn27iD9GUcN/48rlbUcXNX7wgKXu88OCUbYnL6GqvYM=;
        b=GFjBmUPsFx5yhQi0mnXJMQAzqC87NzgDhl65AaHT6aAYVN9TCWIlGtrq/Vi+xg0Cy1
         SjUloJxw0KtTxNw+frplQJT4ubNeDQtIiHiXFvSidNbyHg2R6BKhARb4rCW6bQAmqwYW
         Z/ENdpZIJd5/oF5XJk9BjFtTeVdk2+/yrTAzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974400; x=1728579200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn27iD9GUcN/48rlbUcXNX7wgKXu88OCUbYnL6GqvYM=;
        b=DyFqRPWCR9t0nbVS/Ft7TNrHOY0n//IjJUCTFiv8s9QR3B1O97yKypjVHUGCOcOt93
         YwjvayFB0GyyLDZp0B6Cn9go+6br+tHKNktw4t2gVj0nmX58wtHMK33HB1y0g3LCFa22
         qEhlnnhkJfRN1OpoW5N0OUIt15GbL4aeerqoAkhfJ2G+n6dtnAMMEXsvInVaCKY6Ixtp
         8ItYJek4zRBbVAqukkLDIFrxFNSiHKMIjBc4pTLO4l+bRDE/MbQTtAJsw7rPpdKL+RIa
         rAti3LM33L5GbNgUV+zOx63OzLHRPHTtgzMp37cdndMmjKYqiMkc7zdxuDqX0qd5e6bq
         IrzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKCgFlCBKkSJC1l0/yfGLMTuy5Zq70rMt86sBMiPh/lAcwyCKLfeJyRyZrodUeppZWbKsBLRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZDLtDx7D913Gzh3KDaCh2Y0zXk5aAnpSjrABSwCIpQ+7zkwA
	CyNP7rq90OD7D6OcMCNvLLEz7OGuRzpne80S9Qz7UTlrXkg4y7DlMlrgxWgXD6o=
X-Google-Smtp-Source: AGHT+IHb4J2d6oYBmTVDhzlj8GxV+3IkqVVVHY5lzga9roKvp7Ars1HFAD9W/MmR9al0u5gEC39S5w==
X-Received: by 2002:a05:6602:2c0f:b0:82c:ed57:ebea with SMTP id ca18e2360f4ac-834d84a7261mr899319139f.13.1727974400091;
        Thu, 03 Oct 2024 09:53:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834efe38883sm32125439f.52.2024.10.03.09.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:53:19 -0700 (PDT)
Message-ID: <fa9e15b3-4478-4ba7-a00a-6632c98271a3@linuxfoundation.org>
Date: Thu, 3 Oct 2024 10:53:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Greg KH <greg@kroah.com>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
 <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
 <ZvwLAib3296hIwI_@zx2c4.com>
 <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>
 <ZvwPTngjm_OEPZjt@zx2c4.com>
 <2db8ba9e-853c-4733-be39-4b4207da2367@linuxfoundation.org>
 <ZvzIeenvKYaG_B1y@zx2c4.com> <2024100227-zesty-procreate-1d48@gregkh>
 <Zv18ICE_3-ASLGp_@zx2c4.com>
 <7657fb39-da01-4db9-b4b2-5801c38733e4@linuxfoundation.org>
 <Zv20olVBlnxL9UnS@zx2c4.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Zv20olVBlnxL9UnS@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 15:01, Jason A. Donenfeld wrote:
> On Wed, Oct 02, 2024 at 01:45:57PM -0600, Shuah Khan wrote:
>> This is not different from other kernel APIs and enhancements and
>> correspo0nding updates to the existing selftests.
>>
>> The
>> vdso_test_getrandom test a user-space program exists in 6.11.
>>
>> Use should be able to run vdso_test_getrandom compiled on 6.12
>> repo on a 6.11 kernel.
>> vdso_test_getrandom test a user-space program exists in 6.11.
>> Users should be able to run vdso_test_getrandom compiled on 6.12
>> repo on a 6.11 kernel. This is what several CIs do.
> 
> The x86 test from 6.12 works just fine on 6.11.

Yes x86 test is a good example to look at that handles 32-bit
and 640-bit issues you brought up in your email.

That is reason why I asked you to refer to x86 Makefile to
solve the architecture differences related to this test you
mentioned in your email.

> 
> I really don't follow you at all or what you're getting at. I think if
> you actually look at the code, you'll be mostly okay with it. And if
> there's something that looks awry to you, send a patch or describe to me
> clearly what looks wrong and I'll send a patch.
To be very clear about the selftest guidelines (covered in
kselftest.rst document)

1. Ideally selftests should compile on all architectures.
    Exception to this are few architecture specific
    features which can be selectively compiled either
    with ifdef statements in the code or Makefile arch
    checks.
    
    The goal is to keep these to a minimum so we can a wide
    range of tests in CIs and other test systems.

2. Selftest from mainline should run on stable releases
    handling missing features and missing config options
    with skip so we don't have to deal false failures.

    The goal is to minimize false negatives and false positives.

3. Reported results are clear to the users and testers.

Thank you for the patches. I will review your patches and give you
feedback.

thanks,
-- Shuah


