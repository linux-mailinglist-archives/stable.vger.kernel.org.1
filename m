Return-Path: <stable+bounces-125717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03257A6B21C
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 01:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC013AD4CB
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 00:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9E81C69D;
	Fri, 21 Mar 2025 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GcLupcOR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2444C81;
	Fri, 21 Mar 2025 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516221; cv=none; b=THqVR9FdXMJzHwMnCv7SEVxaMAuo5cEDkP64OJwHLnMhJuWRFOrRz+WswvPIO+w3hfCssPf4KTvv01LzkTO2xkAgV6aUM8H/dbRBa6cJ7WjXQlif4Jm/I6n9Qa13KsFR+7FRTBa+tQsVg/uYQJmZtR/4+uV9xzZahsyf5EL1Bs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516221; c=relaxed/simple;
	bh=y+qdshOX5j1BpmV0Hx0ab/wbb51DKY+JGD27gPvrACc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AT7Tera/hBSuBkP7l5RV4uEu0RzrVJOrS1eGvKcDgpUK1nX+aJeTzfpIP6liH2LKUUdcxcjtWm761VGJ5/NfAXV51LWJRhOED8qy518lnqEF3R8szEUsdB+XU4Tt09Yq++U2kFFcXC00Qg1imPVClEuL6jrC4KtgE9YqdYYYY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=GcLupcOR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso10416385e9.1;
        Thu, 20 Mar 2025 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742516217; x=1743121017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ea7fmlpLthKk3IRbgavzcICTl/i2DXUodnrEmgLAX10=;
        b=GcLupcORY2QtHDp4UHPXYq3U/m5H2QbnyGcG9PF/33tXcSL/B+hQMxpZ9Zjau+iLt3
         btaTVaSsvdpLzxn0Lkdn9CaJMIGnWbwVAwzjPoa2i1SmTqZ5sFllrBLMHEMOka0AfEaF
         pkMNYHpNa0wTuR5XcIERGlEiIV+HggOFJZ1+Lx5d9/PL4iLoW9ZJcuGmMPHlgraoEJRD
         7u6Bowk1A2JX3ZCxjIdAWKvA6RG7Wofuib467cIPsZdjYDzKaY4KHBWGpCoQijH0TT2F
         c5TmDO4UTNHm/DxjgJRYIY7jKCwKmLnaAc15dl6iaO3uYqTj9uu4A4VKq8Nk5ZiIgKHl
         sG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516217; x=1743121017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ea7fmlpLthKk3IRbgavzcICTl/i2DXUodnrEmgLAX10=;
        b=GAPyl/w3qGha2FoPhX5JmZW+HyzJU6VhgRwU+wy/hRjehcrzI1AlCorIVT/nLVPHUw
         d1jHj10ict6p46s/+jOds97J+maPOb7x3hq/1Dj3FaX3DIGurIyiIDq/s4d+AYmj8exJ
         PB9iNdMbnZ9isgfwYKeUUWkEJhHK4519jzh1mAPpQZ6NLDNiEWEnD5zyF6sUywcvZHJj
         392OAHLqhXvSodphEPPJai/OHlu7Ojxd06vQ+xvW28h1lbxcsjE6LLCs5EPdXTxBsqSb
         WSbZ+b4Tqh8rH67JQJcWr31lei0QDZFZ4RyVrxICHGNYNPIFWa6Y1/xnX5EaNBn96q+0
         jcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqjBuhN+0bPPp+9ddB6Rs4rwuGn6jbxUAfx965E49bgM55gHrnzboX1yZa+li/vEom/F4OfPXAy+lOzlM=@vger.kernel.org, AJvYcCWIxjLGMzsc5R+ghIhgqazkbmDtwR0RJjxA2hbezqy4xotUSWVQy2yLx4HP4PxQB/HPyxoYZiSy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7WJ8wWh1u9cUj0RGGjjvf5PhuYlgo6N9IkSEquEy8wT14ohH
	yNnvuC64kcCkO2ylKBoTw5cpJYxXKODKLYU8IukhoLV/uVVDHXw=
X-Gm-Gg: ASbGnctjAP2x4YJUvXis57StP3mPY9T24nF10+AvgmeMDUYO0zAzCrNP16VlaCtUxwH
	qrSZSKUqv2ted3JAAY2za1TGEG8B631LYLSjwqnXt23xAkrT+6lT+vQx5cNaqF56GEaDWADpeCA
	vPQOX50irDBH43DjxKS7UrogC+w9HaTv2pUMbQLuOtaBkIUM8AqnpLWYB5mBudaCOGQud/fU3p6
	xSvHYGFgwPxpvWmeFLYu84HEAe4IoqOj9KMc4FG1fxnAl1ndyoMor6hs5KjrJR+YJ/ett0kGOUc
	111eWrMNgIMXD3VppBQYXezTi42J+gDEeSK3pJCLWeBANFkluZI8d6zzAg/Qq6F6l6sXLnrrgkw
	SDQJqed8PdTZfkmOEYEk9OA==
X-Google-Smtp-Source: AGHT+IE6XqCI9XD8s8So7VfR6KjKaItLJSu4VvrcXVucSsSZaIhiQpsQfdzwyZ8DuTkowqhribL1TQ==
X-Received: by 2002:a7b:c049:0:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-43d5100a2camr6274405e9.22.1742516216338;
        Thu, 20 Mar 2025 17:16:56 -0700 (PDT)
Received: from [192.168.1.3] (p5b0579be.dip0.t-ipconnect.de. [91.5.121.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9e96bsm11575305e9.25.2025.03.20.17.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 17:16:55 -0700 (PDT)
Message-ID: <2d5e684f-13fc-42d5-a54c-063c59610624@googlemail.com>
Date: Fri, 21 Mar 2025 01:16:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250319143027.685727358@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.03.2025 um 15:27 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.8 release.
> There are 241 patches in this series, all will be posted as a response
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

