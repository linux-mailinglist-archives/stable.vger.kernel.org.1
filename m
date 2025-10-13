Return-Path: <stable+bounces-185549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F53BD6C74
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775D3420CF9
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65F02DE1E4;
	Mon, 13 Oct 2025 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="m4IjIrzQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8E2C08C4
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399363; cv=none; b=J3EoFTagrtjPEmBr5Fb/dBv5vQjhMP8Gb1PvGYo9Gl3Te2gDd4uXkEojAxPF7z2AcK/WM0Gwwbe6ngVye1mj1/eIYtoRyVJyCDAzy5BCl3a9Kqt7eCA3QXBe0KbWHpjktSnFpJqHRvdiVv9o1lY4Ib8IJAbAmAMQzwCMPzE9ikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399363; c=relaxed/simple;
	bh=DPqPKVJKoM3S17XqAq8bmlRdURRM8F4tonrV/c7MP2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOqpo/XnVQG9R5QjfPLhNJbccU+I8UE+ewDpJ/Ep+eZ0+E71/1MSUyBd9aKEVKC0q12KeI9ff/YODAhVt38z3Wlq0qWHXdU6HLy0jBXvYWd2Mt/QVm1bdJJXe70YYSZfUta8rcVXuVSgOj2CcsuyBDo/Hx332xwpf6MBSJHFqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=m4IjIrzQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4060b4b1200so3499986f8f.3
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760399359; x=1761004159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5IQjhjUeRhdsqvIEklKbDkjqGDRUGHZz22zuYo2k2I=;
        b=m4IjIrzQRHYo5PAAZmU3UKKfoj22IOCzcVvvzjxQe4KIT6/BxRZOEgIdT7dID+4tmi
         8ys94dQ9wpGhi1mFO2Lh+keM5wC28DYycXoWH6NNWw2uasrPOHpTwD+/FOMQD2BLaIHZ
         e4ymkzDm7/jT3JziT4BRYFFTyCv5C5TJt7PjyKxbYG0eitm8bZxwXZRKIQ7FniaTYvBg
         OAlY+phh5tqZGEuD5TpkzmFjtfMPfozKxpxkdBq0JV5Lrl5gGafBA0WHn+o7lOfwkbEm
         2tM9iztn4JrB0G25xO6DUkjqhI8e/2EiGTTDVG3l5WlaHRfE2kraW81CxpGhOMFQekod
         GTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399359; x=1761004159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5IQjhjUeRhdsqvIEklKbDkjqGDRUGHZz22zuYo2k2I=;
        b=UaOLXcfmgzYA+ZK3lQ9IpGTSBZ6XIXXKCqujavlhrF4wIqwgpc4R5utBIOPyq7X3N0
         PN/MWeYPJ7T2hMimJUzfzn5FITE+uTFVZgPIlCsHKxlA5zjfw75pUqwtM5b3SlFveAIR
         868H6Lcic4ZinWqK7JuIq+mJqqYX4peL51KP9yMThEChvFFxFzaNuCXVGVp/uzoJh/Db
         /bAAe/yTgBBMAVeCcHq2FZbrjorKg4DzJklME8D6v+XGO88LfPa6mnymz1UBNi7sni+S
         hi+n+yUJH42CDNJcLQUlIbh4OUyQ8sVpZEYM+E6YSkt3ptlSOwTjh/U/ekciGxUkgrq/
         qz3w==
X-Forwarded-Encrypted: i=1; AJvYcCWzjBxJAZMq6zsNVK0gODerqo0OJnTN3gVXFW6l80rzD60d3QPPrK3gNMYHYFJ/aBLvjBUpzMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jdRdCwqtHbWGmfwhTVELwJICh03fsBZjvQ5xHy/AfU27wTgY
	jR8Um13LndCVzmtFLwu/hVtW7C7RX3x/VsD7jST3XfjINiOzAMnNlIQ=
X-Gm-Gg: ASbGncveicjtXAplqfOdmySjF8TfWZGbgZJmAZWo75f3Aa5GFNl38bMhqTDo8YaXzHa
	x/4i7AoWMxdlJVHlQmVjx+zsg81n0gLBi7LdUUhC4IdvVQl2RT9a3ynYcZ1ES92WJBDLSE2JTwl
	9lHTIX1pa7aCxraHX2n1fNQ+g9m4v4c4PIPL+hF+UK7fxi1dd6zLo/YHS5RVi/w6pjsQZC1rmkU
	EhwhaRt/LExMU4rFijJPboY9KEg2XTmYYxXEkV38oJoFsuHDVgZ2aRwNubIBgR8G5KAdZgjIGYe
	deWU9NV6HlmttwwMDgrqan6K6W+alhQ5D+UaSVJWrehy/526aD/49SIpXea+r0tC/8vR+XF9doH
	Z0MmM6eIDoc4F4l6swmYWzdTKJT0ZzjpYsxt0TbBAEw6C6ibnPc00seYkVdsYDwjRoO+QbVirAf
	0UAgEdJvShXJr6kDSWEJQ=
X-Google-Smtp-Source: AGHT+IEcseHOVdvzwVXHr2ecTf0F6oIMAJeswTeWEHpm7pkR4PH0JeeBnX2ghP7A6wl1XDa7xCODQA==
X-Received: by 2002:a5d:5d08:0:b0:3f8:8aa7:464d with SMTP id ffacd0b85a97d-4267260e155mr15648973f8f.42.1760399359433;
        Mon, 13 Oct 2025 16:49:19 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca8d.dip0.t-ipconnect.de. [91.42.202.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm20457300f8f.45.2025.10.13.16.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 16:49:19 -0700 (PDT)
Message-ID: <831459fa-ab4c-4b64-b8c0-eb47a919d7f8@googlemail.com>
Date: Tue, 14 Oct 2025 01:49:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/196] 6.6.112-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144315.184275491@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.10.2025 um 16:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.112 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

