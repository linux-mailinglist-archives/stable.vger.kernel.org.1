Return-Path: <stable+bounces-194513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1559C4F363
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 18:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61639189D432
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759FD377EB1;
	Tue, 11 Nov 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="L3lvQu2N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702534F256
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881171; cv=none; b=sySEb0nAuAFhoxLVW8LNSrY362pwNHtcJcg/7TmfOGiIF3AOq5Bfw8t6aQQSnrFm3lQ9ZUa9LefTBlRhgisUhXT7qN8h7su364QYw8gmLBATuQWlw6f+PX6XZJaYjjyCnaKS6pjPS+y5+BLtwY7ljXLLhgJnvoEff+mpsCp3J7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881171; c=relaxed/simple;
	bh=NhtdUKojR8AS0bdaC+QuH+e6fwl3THaYmzRDwTgiWLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1V63XdDCtCTqlW/sv10NxVSY9IdIWEzh7f/R34XfmIen5j+7SdKOj70HmyRSx/04RpQ8MQ8Xpkz03/fFVhezLJYkr9ljLHYLLD3oywUhjDpflucl3EJYgZw9jqvSOkKG+QyanpDbygI1vaPxOlGdSR4p89mOPZUv1NjsGnwnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=L3lvQu2N; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so24511435e9.3
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762881168; x=1763485968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqZC9RRTjweuAlm02YPfwCHcdnGqj2UDL6R/JHOFHK0=;
        b=L3lvQu2NHnEGBOQ21ulbxeu+gq4pqK86XDQu+lO5eVWv/Wf6G1i7elDlEEVeRygCQZ
         iOAL+uU2ep+lDGzhENaFoxCWcAb+O3CMoYllKiUPNVqmA8mhFBGtrELF7eVHXzKvnHJP
         QnQWk+mQigl9RgJepFIZQMxJK90SNrjCfVXBssQFnqDXF3eWjCKNirzgzJPI2ZrNz1bi
         2JTQFBYYh+L9iDGygW3Sb9meag5ZYC1vXalLoWg3z0BW8CV+VBqw0jggoakyxUa4aDeV
         De7dE9DYTNMJijydmHCOG5CfgQeMVa7eFtekBEvEpYYshq0UYU1A74VTtSwgdX6Cm1Ju
         EuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881168; x=1763485968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqZC9RRTjweuAlm02YPfwCHcdnGqj2UDL6R/JHOFHK0=;
        b=Q07Gst+qCYLl1XzxhqwJsn9M+RmNPvRrLMoExCvm+IOVp5a3bVh9ivCMyq8jzIRKYN
         0bllbmQMpqlEKRs6guNjFYRhR5E4OQ9U3vAbaqHGyyksXR1zGYzQ3smQmriz4CucBJBP
         Kv9jXHBsDLaS8Gt+fap9razGnln62MqJb9ONFf3G6sJaE4S5RfwLPPzRwTjfOGEXK9T3
         IEymYeBKqcc3oLKkhKd09q8YzFtukhVhN39DNp0qOSMu0Kd5AW8uIGYPgOvOQizNi70U
         qDqWnx9d7OozrhPktDlOzNDzLlHKCULjSnAlz9m5MU2e8XEdgM5xmm7l7oCbUtAYBOZg
         9r4g==
X-Forwarded-Encrypted: i=1; AJvYcCVgf6j8xDkN4bHqyUwUSVHhRnBBN52nX6+frjHggVKwUt55Fney4QWdDUfOetwp+3sPktT5Bow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYoVhDxmtlzjlYXCvcXSrxBm8cYxvwKfRkLvUn4U70fw5Wznd
	0NlHfChk+FBONHBR5Fz6xmYWUyUSZcoEI132DxubmsEbIrJrTOb3eOU=
X-Gm-Gg: ASbGncuJPgifVBniaNtGaRn6pZWqlMRSmF3O6Cqo4m2zwrWSvLNxZQ9CqPHM6EbekNw
	u4+T/FYld8g2oxV5q7X0ruIiDlgcMPogdWYXPdKZXZqU+hUX4+i1lToADHN38xTTIoozuezoXRa
	+HPRn7m32iDSvVQoyHBrJIaHL+/N0BNRAim96aflIWAI8zNZC7tGYTagMsiRDzEuAP+OIRH3pee
	AbRof8K8PTOG9TU+kXkJel6skhALDG6Q5bkHZkwezt3KHmh55HfIGxcBNYtKWgiV51KpisYkXZ+
	g2YRWGfqrWKPnbxc2Be1uX7jmgB9HQx+uXfs0kUGGnWxJncRDXWEUXXrRuyUui9U6XukwuMIYFR
	gdmGCV8HlMO4h9SFe292h9v8sKoYnwATAB8N8syrMungRbRXf2gBI9IJ/0a9hmPhAPkybf5G3Jf
	v3mdXeeaD72M5GiR4JzXk+K8rgqWtNQSvVSk+KaSQoOWa0/rZ8hjo8dXr4pTE/1dw=
X-Google-Smtp-Source: AGHT+IGJMVlZIgx3+f1AZy+dlKlifd63oezYeoPNJGyyFGVGoS5RoptzE35LCIuQes2+JmdBcEqtGw==
X-Received: by 2002:a05:600c:4594:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-477870623f5mr1540535e9.6.1762881167658;
        Tue, 11 Nov 2025 09:12:47 -0800 (PST)
Received: from [192.168.1.3] (p5b2b46e7.dip0.t-ipconnect.de. [91.43.70.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477815eeb55sm25584185e9.0.2025.11.11.09.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 09:12:47 -0800 (PST)
Message-ID: <9db2ecf0-ee3e-4c10-bb4b-1cf02c9ab8e2@googlemail.com>
Date: Tue, 11 Nov 2025 18:12:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251111004536.460310036@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.11.2025 um 01:32 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
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

