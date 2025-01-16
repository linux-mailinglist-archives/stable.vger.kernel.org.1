Return-Path: <stable+bounces-109287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B5DA13DBD
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 16:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB20C164B38
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED8122B8B9;
	Thu, 16 Jan 2025 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BTW4YFJ6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62024A7F6;
	Thu, 16 Jan 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041685; cv=none; b=rz6syiReV9gzbIPcpX9mj0pUt8fNhvhXdmjtclH6YXn8QcaoE/nJ81a66aTy3QsjyhWjL2xHrU69AwvDKuZ2dIXxOGYkJ7sVHrZCVXqBTvZiA88t2PMgFKBjtBDbPCfSFZEMLCGpIdiZS7C48c5wRWtk/HljiH7NgtfGZxd435E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041685; c=relaxed/simple;
	bh=y4crMJVNNSHNOuMvHECSfD9Gl9BCNbLj0WOCOJV2KG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMaEbqwOtRy8/LyynCIQqbC3TQ4kHVUmq8gVIgvg6ruEKD7gDXIg04yaNu4dDHIsQ4Esk5hq+z9tifS0oAjykKuNUt9Wqp5fI8HHIw5Ixp9HZr5QoFHRed795+0Zvduk7oY64qnPl93QuIjtwvv1f5eblHvE1HyNxIxwbkw6eyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BTW4YFJ6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43624b2d453so10953805e9.2;
        Thu, 16 Jan 2025 07:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1737041682; x=1737646482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIMiu7qfvV+XA/dz3F5+XwUyd0m6b8Z8Cw1RmbU0RNs=;
        b=BTW4YFJ6df4Olsh5SJc4H3HAFqUzpEAmu6ASnITyJbR1sViS4qK5l0ZCmjSriCW73P
         9F66RnBrijbdfB1g60v2ZYurwyO8MKByNXfF1+7jgVm9LMgmbFWabMFZ4P0B/NPbxEPr
         2eajzMDDGCV6jAtU5ULmTtlqWardbi4T6vVUwGJwAhSynFLCy2DIGjukCQfli0W0INC6
         7GZCDU53yy29id5UyIB2JM8TRFoqgfSghDppvvkzonSYFF3VO4P18cQBVbxqFK5KzCxm
         GiQl/F9Fk8qhVI2f1Wuzz4udRuhJff7EuyRhHCLx3rUhn1tCPSkwweBSCQ6oltWi2npw
         NZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737041682; x=1737646482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIMiu7qfvV+XA/dz3F5+XwUyd0m6b8Z8Cw1RmbU0RNs=;
        b=wITRY5HmsSRvWxm78NnWekR5MRpJZPchz8W/GfT8e7YNRGGOdd0m5pMrOJ2ETMPqg+
         g1/KLdfrn+kimPB/1qHqZYkyuIzSoU/cH4CA9ByYOo+iyfNKP9E22patg58hVguCFSmG
         jG/qiSRmwQe5Fkg+fb/3xvmdXo4Zplc8JQF+H9pcvdNUm0JbUQ02bRsgTKFMCJaZwRa5
         hYxFXp9Jzn6MOZrlMV/SZE2Dop9EGVRs9rp7/O0ttFp4pJvg1zgHZ+Yz549UNWXKaqI5
         eQ1uI7WYTEeB8O4PLprKX7wemZ19O5nH3SRW5fze0LuoUwlenrenwK0oIQAyvICnBKKU
         cDmA==
X-Forwarded-Encrypted: i=1; AJvYcCWFtquSavlUtRxQCdlEW7RMTUXoVlMchOOgVBAaa+7AzH0AdL9L9E7c6NRuQjczP1Hpq75Sr7pQTAbaKI8=@vger.kernel.org, AJvYcCWPxfrlEZObG0aQYx4nuJL+p6MrQID/ZSh1s295H7+hEdiyleLQKZeddrcOFXrEoOOPlOC5cnrz@vger.kernel.org
X-Gm-Message-State: AOJu0YyExLU7NMgammLVcXTRPAHZ0sS38yQHME37ieoDiDvQ2NWQ5SFj
	+4fVzKLNG625WRxLaLsM/ITxuiqWbhMkgNJk/fjOsFG0MGNRJkg=
X-Gm-Gg: ASbGnctSlXwSAFK0pP35DwHJQOe7MSxEba05+mgyuIF7EriiKx0EZQ3lQOrMuknJagY
	utJhTz7sSriBlhasObxK62YkZlLnHR6bjlQPhZWoc7Dp7FwmHtZk6XvagyESFL6be6WBjDoHBiC
	pBUFx1ic5VWk66qejwKwXOdvxr4vjX0T3PL4cGU0dn/lX4OSoe7oQu/4e0hcZLxtdpa/27buIUA
	e/tF8gfXiEXEYX5QXL0bMSRi4i6u7lLKpzJhWIcjFJMpqgTdJHS6cUcg0wO1Uwj5ugkSVFJfmYR
	Omus4SMJAJJCvjaA9zrt4jevL2g3QjOW
X-Google-Smtp-Source: AGHT+IHFgTwOy4bMk8ut+aUp4MgqoTA81b/86r0Q0oUdh9GfbgBkjvEf1gAqWFQn7R/bNHGuDu+Xjw==
X-Received: by 2002:a05:600c:4fc6:b0:436:1baa:de1c with SMTP id 5b1f17b1804b1-436e269793cmr317709405e9.13.1737041681915;
        Thu, 16 Jan 2025 07:34:41 -0800 (PST)
Received: from [192.168.1.3] (p5b2acf03.dip0.t-ipconnect.de. [91.42.207.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389046250csm2525965e9.25.2025.01.16.07.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 07:34:41 -0800 (PST)
Message-ID: <7b7c1a70-db81-41f5-abc3-8395aa600a6e@googlemail.com>
Date: Thu, 16 Jan 2025 16:34:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/129] 6.6.72-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250115103554.357917208@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.01.2025 um 11:36 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.72 release.
> There are 129 patches in this series, all will be posted as a response
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

