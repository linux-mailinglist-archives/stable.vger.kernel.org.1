Return-Path: <stable+bounces-132911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE3FA91521
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20263B5D0F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B721C19A;
	Thu, 17 Apr 2025 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWcsisTX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B921ADC4
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874930; cv=none; b=cUIiffXq83o1VsFS1P5KzvHUvpHsURGrzTGm0kO8sqbmBxx+4Xn8v4djDLwZOWsS3LiGYnzhxz+rUuCDBMFD6Gf5h0jQUqXC291HlqiWhjNDkzDa5B+NQFte/KIc4/jmGedsuiscs/xsuFpUgySzYfc54hJSZL27d0j3y1HSfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874930; c=relaxed/simple;
	bh=Vfs3mItdj9KPrNQdqQNYQknOyD2oMo8MEhXAQ5nfREs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjjwiF3g1h178CnFX3yiRnVOZMGHmFvb1NwWP05VOSDdD360KAWfx5E4Xz9YBur5vQqpHtcjDL6wPvuOmBAO4c046N5ErIpD9LmIDOSf7DywC+K9aDCHqptGbp76fNqKy8S0YE6wBVLSwiiWeIL2WfRWlJpflj0Ty/ngsvRf7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DWcsisTX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912387cf48so17842f8f.3
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 00:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744874927; x=1745479727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xVUuqaTr/85bEp2vmjyLVKnqValaRXl23CqZa0ZHR/g=;
        b=DWcsisTXwju7uFGnVICIrpKCw0w0sVF9FSo7DHFfei1qvS4WyVY6LIPEVh+IOTrHbN
         fC/vG0bh2w8GolpbylcBhmX5CbhYUs6Ebh1PQwYq4zEdEDsMTtAS7sbDc//JOgYG9KLP
         h5zjSl/zqxepciDVRySF/mo1lZXsd/VCLnBW1Edi+wCk/UJRMxUWFDexl54EKtCOBD3Y
         l2VSZZ8eTrpcA2693+uZTwSOTonMHJeuFTwdKUt0SC1VRRmJOogV/kfuGjqC38Kz15g4
         cieI2Tog9aeXPGW1oHJCSF115UT+Py/4Zx9tbZ28mkKVShriguVRmlxR9UoBSx3UXRAu
         eVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874927; x=1745479727;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVUuqaTr/85bEp2vmjyLVKnqValaRXl23CqZa0ZHR/g=;
        b=pw2dU7QLzz1GALfGjRKPhx0cXcz70mrkDRzy1Lof0bBthFO1yFkHkOSuc+4Gjox4yw
         8G48KQS3zBDWGUIdDndlO0qtbuuE9rxz33/3EK7bayuUUyTp+P5MOkdra4PGSUjP4DdL
         pTGgidlpno/GWoCdDG84emAWgMssZBCpbf1F+K10XBgf31h/fKV6JwehQPMVKWwCjSHE
         pFtoZvSOctOn3Ej0IRDu7BIiWKRP9VBP73vFaQUzzuHa84x5MpowcaxgFh+S/CmqFtsG
         qrXr99AdVgpsyBH/OdErnSjJ1GqzgSSv8OtVsebJjQUuMphd11X9HUMd3h6t4A/DuoVb
         S7gA==
X-Forwarded-Encrypted: i=1; AJvYcCWW+KUsFbw1Gqa8KjFAUDjCEAhGQ2lemFRsSkiiNjkdGceBFo6m6Wb2V9A3PAFyPSI5Ii2NQlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7UKMXjhoxPxwk8IAGyHk+5NUqhixT7vhD4NMMh5XfQ76ATP9
	nPZpsgumajGxmufoxpUJg+MBvpVrUj6988zP63DqovCQxxENoCoVlDs4U5A9iE0=
X-Gm-Gg: ASbGncu5BqWoggSD/KK4tvxvOUYYEHu/8TcXs6hoovEjgBf77/rmTldJzEAxRe/UI3V
	FAG5Iu6klKUAeJEeqh293TLBen3yISXG6gwblLDLE7+OfEKyzO5BaFqk4SogTbAwD5E5t4AB2rn
	L6jwd8Ncmk9CHcRZAiZqhdG+ZWWIUJWMJYdtSGvBZ+xSJCgU3Dh0vYxzzsNUeJnEXp6vx3uu1Mr
	NxxzRMv70s3kviYaZA25xuw5Qj+IuH0iI3/FFTn9EAY4BfjWk41EEQcTF2qspMDN6TF6EkmS8hb
	67+hRz+HE9/nXHe1vpbbF5k+ESX6g9ikIe5i6vJnz9hxCTlEZr554CTjP0iMc9S0PDjsz2CrlAB
	+ym76O78DzVxa2ASz
X-Google-Smtp-Source: AGHT+IE3Zzfxa2xFyAPrwj1JpkKzEGocwO0Z4hobPysDcfIP1i7yTyBis7baQC7iPuUdTJ/9/E9XkQ==
X-Received: by 2002:a5d:47ac:0:b0:39c:30f1:beaa with SMTP id ffacd0b85a97d-39ee8fada0cmr628338f8f.7.1744874926948;
        Thu, 17 Apr 2025 00:28:46 -0700 (PDT)
Received: from [192.168.0.101] (46.150.74.144.lvv.nat.volia.net. [46.150.74.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4f3bb0sm43455915e9.22.2025.04.17.00.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 00:28:45 -0700 (PDT)
Message-ID: <f957e366-51e1-4447-982c-93374d0fde2e@linaro.org>
Date: Thu, 17 Apr 2025 09:28:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: fix compile-test defaults
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, "Rob Herring (Arm)"
 <robh@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250417065535.21358-1-johan+linaro@kernel.org>
 <a0739b6b-b043-47f1-8044-f6ed68d39f2c@linaro.org>
 <aACsQUADxYHTQDi1@hovoldconsulting.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <aACsQUADxYHTQDi1@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2025 09:22, Johan Hovold wrote:
> On Thu, Apr 17, 2025 at 09:10:09AM +0200, Krzysztof Kozlowski wrote:
>> On 17/04/2025 08:55, Johan Hovold wrote:
>>> Commit 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
>>> enabled compile testing of most Arm CPUFreq drivers but left the
>>> existing default values unchanged so that many drivers are enabled by
>>> default whenever COMPILE_TEST is selected.
>>>
>>> This specifically results in the S3C64XX CPUFreq driver being enabled
>>> and initialised during boot of non-S3C64XX platforms with the following
>>> error logged:
>>>
>>> 	cpufreq: Unable to obtain ARMCLK: -2
>>
>> But isn't this fixed by my commit (d4f610a9bafd)? How is it possible to
>> reproduce above error when you are NOT test compiling?
> 
> Correct, but this was how I found the issue and motivation for
> backporting the fixes including yours which was not marked for stable.

OK, just does not feel up to date anymore.

>  
>>> Commit d4f610a9bafd ("cpufreq: Do not enable by default during compile
>>> testing") recently fixed most of the default values, but two entries
>>> were missed
>>
>> That's not really a bug to be fixed. No things got worse by missing two
>> entries, so how this part could be called something needing fixing?
> 
> I'm not saying it's buggy, I'm explaining that the identified issue was
> recently fixed partially.
>  
>>>  and two could use a more specific default condition.
>>
>> Two entries for more specific default - before they were ALWAYS default,
>> so again I narrowed it from wide default. Nothing to fix here. You can
>> narrow it further but claiming that my commit made something worse looks
>> like a stretch - and that's a meaning of fixing someone's commit.
> 
> Relax. I'm not blaming you for doing anything wrong here.
> 
> I sent a fix for the same issues you addressed and Viresh let me know
> that he had already merged a fix for most of the issues:
> 
> 	https://lore.kernel.org/lkml/20250416134331.7604-1-johan+linaro@kernel.org/
>  
>>> Fix the default values for drivers that can be compile tested and that
>>> should be enabled by default when not compile testing.
>>>
>>> Fixes: 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
>>
>>
>>> Fixes: d4f610a9bafd ("cpufreq: Do not enable by default during compile testing")
>>
>> That's not correct tag - it introduced no new issues, did not make
>> things worse, so nothing to fix there, if I understand correctly.
> 
> Fair enough, I could have used dependency notation for this one.
> 
> Let me do that in v3.

OK. I have doubts that this should be marked as a fix in the first place
- even skipping my commit. Some (several?) people were always
considering COMPILE_TEST as enable everything, thus for them this was
the intention, even if it causes such S3C64xx cpufreq warnings:

https://lore.kernel.org/all/8b6ede05-281a-4fb1-bcdc-457e6f2610ff@roeck-us.net/

I had also talks about this in the past that one should never boot
compile test kernel.

Best regards,
Krzysztof

