Return-Path: <stable+bounces-105279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BD99F7473
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 06:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBC516576C
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 05:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9ED86327;
	Thu, 19 Dec 2024 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2N6oPYt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6B2594;
	Thu, 19 Dec 2024 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587821; cv=none; b=U/zfj0rf2T9mISz8Zfye4npso33XBVe+rGFHy85zvIektH//P8doQqrKVPxPRdmPgDj0O/p7Nc0uLA+bQTZcQaKZkKcAncBvQyq+8QIPDHxR97dOVJMR9EcqDaWA3/fCgrLfsyCJOrPhQnnvdS+VY+lW0jamVLMmn4FyEn0ckDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587821; c=relaxed/simple;
	bh=+7TLl3NtbojDdQ3Ao558ON8VxgFcuQp8jiG0LJ4/niE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2gYIf6ckAX741zPZnQgJbXfjLST6QWuvUJ8COiVLS+PzF1HC4LO2yxaA7XGX4YrD6W/6mKsvhrmWe15m5ATT8uQ050yc8WkQB4EFBbbsYbc0LzJvmQnR6Tb5JBfKq+VSPZCnaDJK8KDvMiyG2bLQ3tw2p8ilb/V4YO7CzToCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2N6oPYt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so348190b3a.3;
        Wed, 18 Dec 2024 21:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734587819; x=1735192619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=og3GTYHjEa3/nY4Uaq9FXtli2n8aQSGFJSHAMYqe2MI=;
        b=G2N6oPYtDGaGRUc7puF0XpngtAdumJtxDVlF8dPQT25BlNiWKxjwYsU7izkp/DY7EO
         3iCsYCHWSR8L8jGlSWwhKJU8/2F5PNsFUyK6iKbrf5QqTtvqO2apcO6gRBBLRO9KVBDx
         0dJT4X3EbPgGqDUw6611pjKql+G2X/NTlj73G1a4WGZTNeNRSYxMzbLI8PL0SU6j2+Vr
         okawqj1ZqDOS5sybr8KXlr+/wj138LbVoZriCNYj9TDnBkm+iEQfK8xSwr5nEO0MFjrL
         6U6+lI2xqLM0mbZ/tK280mcK1XTAYCvcMkjO59OQ2J4h4b0TnHfNSgVo8s9z/PPwEbBg
         4hxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734587819; x=1735192619;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og3GTYHjEa3/nY4Uaq9FXtli2n8aQSGFJSHAMYqe2MI=;
        b=wwkMGaRWFmzDaXb5hajrF4merukDvaFU4TNBZRKwANwFSJ2Pkb+5p9O7HBeq7U5KkA
         fq4x9VZQN8tjkpjeNoJflOqvGWKlI1fus/53OIG3FWpPf4zKY1IN2IAuWtSM6+PcqxiK
         OqyRILAQm9XJVQc+vdtyiRRxaITJrtyvESUQSVSfgbVSuw+01Ny0zEDzfa8OnlKLWZTO
         c+7+NX3nrvNBbUQOwR082OeC3boF0eip77aOgHsreCKp+oDnkL4WGJhs5pvnurlxPT9y
         PAVQDTTzAI8esaEPqJdbUIqBHh+LzvGka8dDN3/FD1Iqh8vt0J9GFkSIZda/cxaRRjbn
         UKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLvZEyjnY2I+ON0jpReu6uTQgd/NO+L5fUelsIyJnrhLubWAMz36HE50y9i6ShAQ9aU7b/wX7w@vger.kernel.org, AJvYcCX94P3RRL80vU+GkRy856WP3bChw7DCoMqFVNCG7FCgTfVBF7IU318q5kjUk4gAPgOF2IPoTwaKdp0f2ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyteT25+cC4iRYvhNdDjbtd4I52eaUrwUZd8WtBDtIpHO+/ZAyt
	p3UUmx7eQ6LFfVsjYRcPiQuC/08u38jGZgzfXub+7yVyDLGjjUso
X-Gm-Gg: ASbGncsUv8hGSa1x4pekrdsAnpDSLfdToYmTv0H7r5kEciVkwfDPQGx8IQLCi2ghHa1
	EuvarewhDgNjT+w74IRRsRThlLKqxFCodc92Xw3Olu7FKCYAgAP1KsBRHMsf6ZAi74jMSEoU9dW
	moYa0gUdDI3SJWQ2X39mvhjDC953QO/LwaoYAEvQBkSh4XogtRtME+HwbVUHSOvp0rsaV53G4P1
	ZdHjZ6l5NPdrwY62Wo+cmjW1PhqMQ3OoVdvcTHVuHVaUEjnaWYi9D9wF6rDxhk+WutnsM6ZXgwS
	BAC/QOC4YWpuqKgGdaNl1vcF8Nfo+Q==
X-Google-Smtp-Source: AGHT+IEHVPF3G+cxcMl7m7/CSStSxwulpaTg9IQ8YQ1JtUXmFIPYITE2Wu5dMV86fPCk+uWMWBPfqA==
X-Received: by 2002:a05:6a21:9994:b0:1e1:beea:8898 with SMTP id adf61e73a8af0-1e5b4ab59f4mr8371013637.45.1734587818709;
        Wed, 18 Dec 2024 21:56:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830afasm461860b3a.49.2024.12.18.21.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 21:56:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <60f5d471-7c5c-4a1f-a1de-c52e272ca852@roeck-us.net>
Date: Wed, 18 Dec 2024 21:56:56 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/172] 6.12.6-rc1 review
To: Jiri Slaby <jirislaby@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, Juergen Gross <jgross@suse.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Anders Roxell <anders.roxell@linaro.org>
References: <20241217170546.209657098@linuxfoundation.org>
 <CA+G9fYu0_o6PXGo6ROFmGC1L=sAH9R+_ofw0Hhg8fZxrPRBKLg@mail.gmail.com>
 <746e105c-c6b2-48c7-ae89-4deeb97e1866@kernel.org>
 <869c01f2-e069-440b-a81b-fe71e969b72e@roeck-us.net>
 <20241218165444.GL2354@noisy.programming.kicks-ass.net>
 <4a1dfae2-d76c-4b78-a058-fce9d565dab6@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <4a1dfae2-d76c-4b78-a058-fce9d565dab6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/24 09:48, Jiri Slaby wrote:
> On 18. 12. 24, 17:54, Peter Zijlstra wrote:
>> On Wed, Dec 18, 2024 at 08:53:39AM -0800, Guenter Roeck wrote:
>>
>>> The fix is not yet in mainline, meaning the offending patch now results
>>> in the same build failure there.
> 
> Yes, as I wrote in the aforementioned message :).
> 
>> It's a test, to see if anybody except the build robots actually gives a
>> damn about i386 :-)
> 
> This is not much of a robot -- openSUSE still provides 386. As a port now. I failed to destroy that port in past several attempts :P -- there were still users.
> 

For my part, if I get a few more of the "nobody except the build robots
actually gives a damn" or "why are you testing this or "you should not
be testing this" responses, I _will_ stop testing this and any other
configuration where people make such statements. I am getting tired of it.
If anyone doesn't want something tested, it should be dropped from the
kernel or at least be marked broken or disabled for build tests.

Guenter


