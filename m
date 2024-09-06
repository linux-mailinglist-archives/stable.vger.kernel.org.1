Return-Path: <stable+bounces-73789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A486B96F5AD
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D3F28365B
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A71CE6F1;
	Fri,  6 Sep 2024 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SBBleonV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F51CE707;
	Fri,  6 Sep 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630322; cv=none; b=issGW0LeEkwavIqpzcUcR9JDTHhMLhHUXUaV4mb/hzGH/q+DArWQwAg5bO4jVUz7pD3iUnbVTZyMv4Dc97qvM5bT8hdKEKfQkqlm+iOX3NuT3w7ZG+WU6OtQ/zG19PvJAYdtIH0lffMEbuRVECz438aG3iOMJnnWCqd1wK8Bpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630322; c=relaxed/simple;
	bh=LzRu9zx/RUvzGJLN1xZh1Ep1FK6fI45Qs5Gss1BDzLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6oDhnEdlj6yMujGW4a4CZS0MKMLXntSvJT32HBaKFWT+q++9m2Xw41n1W1y3RBkCEEXQn0x2ehnQXZ/kz2nMaSN60FZoIbmrOEKZiNmJhn6GjfFbx2Or6xvEJ7jZORsM8NvrMhQ7Q7G5mRzgPBHfkZuKftlezlzJX8/84n66DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SBBleonV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86e9db75b9so255789666b.1;
        Fri, 06 Sep 2024 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1725630319; x=1726235119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7QnaMeuAhRWgF7/G1QpvRene3BE387G8iUVU/cYI6I=;
        b=SBBleonVUtaT7+605LDExoaYQ+t1BUYKr8RMt5EugGPPXjG4MSiUho8lJ5SWY0vuse
         wK+V3zJFJskT9kYHAdNF2XGkY4UeUrdC3BpJW2vE8MkE2gqk9f3jnenXnImRtmWS8hnf
         3b7hnqcIOWxbPba/yOS4Hm9DEtLWnqRBckQInas69dJin4kZ9VbKkvKKXjIYXl4ru53+
         rt922OPkBEagkNcXfJKsV0y4K4+vdQ+nRd/P165V/hoCIjcwS6CP9FqPulNXErZbIFX8
         ZUtGnEbLI6IezmECCSpExVzgvj0r56ZKowIqCwjY+pEs6GJrF7NzLWjCK5Ir5Y5E3V8U
         WbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725630319; x=1726235119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7QnaMeuAhRWgF7/G1QpvRene3BE387G8iUVU/cYI6I=;
        b=RQ3vAbgZUrLBpheXjKldlTwYwtFy2gDDEKjkEc7tl5w3JtsVFeeLBwH4NG5/ESodPR
         Oh/rGx6ZYE+7mPd/rHc//6M5H0f8J9wlPGJh5qDj8TC4h29zjQcn+fO/5ycS3Gjyc7zN
         fwJIDjIb/a2nt6zNqogiOIR+ARLWXw4Z6T1Rq8h4hofGVyyhj5dhgbXpl0dQDp8DhJVR
         lens4/3s73jDCJV+aZpasN46AZNQNbxqSU/bvbHLEKo8Qlk4fIa1XRaWoGAXhkt5kfZq
         g6zdAVnEMYoGnqe4DsWC0a3S6MW5iqS/xmSraaxNT8FV5aOQZUIvGjzgVjP8KkCCDbzx
         r94w==
X-Forwarded-Encrypted: i=1; AJvYcCUFr47xmh9Wis6KCocC3imZ0vYYRYLoU5LigxuUM6azWmjZlRwhKG6eHVFqvlbV1hgXEZWNnMtXvpaOSoY=@vger.kernel.org, AJvYcCVWmnL874bBgOFL3G9LKOnPKGiYoo065T50NZ5TiEwidMr+7jg+vVXUJd5A58b7Zf1PUghhZSnJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwJte8NN58/5DsUit2hpUmXCL4/r8NrKj6mCKlALAg2FxDuKCMH
	UvudE4d5ftBB7Q7ea8KY6wAMW+IGgXRrWvdKj2UvDgkUuh+EMYY=
X-Google-Smtp-Source: AGHT+IEv8YGmNOmoxLrIE4zsDNN/4eYRy5OvNPIBzaSoVTJV/vA5tWTyX1TUK/eEESiUddviQvTMwQ==
X-Received: by 2002:a17:906:4796:b0:a8a:7898:1420 with SMTP id a640c23a62f3a-a8a88667910mr200813066b.31.1725630319134;
        Fri, 06 Sep 2024 06:45:19 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b40f2.dip0.t-ipconnect.de. [91.43.64.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a77140b3dsm206649166b.213.2024.09.06.06.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 06:45:18 -0700 (PDT)
Message-ID: <63922fdb-6aa0-483c-ad57-1c310df160b0@googlemail.com>
Date: Fri, 6 Sep 2024 15:45:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 000/183] 6.10.9-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240905163542.314666063@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240905163542.314666063@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.09.2024 um 18:36 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.9 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

