Return-Path: <stable+bounces-169304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD5B23DE3
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 03:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6453A6805FE
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A951A9FB9;
	Wed, 13 Aug 2025 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="keHueJ3K"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC17019309E;
	Wed, 13 Aug 2025 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049670; cv=none; b=SxtKsUmUHLcEGonA4l/tQIM+D3e/8f/RsBtGEqhHFJ+/i1EI6BqJG8U4yN4mOjtxJ7qHIaP2jp2GWbBMS3QQJoC/8+KtxfX+5tGBSbLwCt81HSmN5VXijwXjJXlAt5B+T0J3EWE7RNbhw7gRQJ5wFOigE7PEtPFW74VGTbvZ7Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049670; c=relaxed/simple;
	bh=b/66eFoOJUGYGtvk3i6mg43Rz6p27tLfngWYdwITtCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0KpPE7w/hbNZrLiIJDkJwuJjVCtF7YeLL0T2iaWGv2nvwXQneFtbC3Nnrw3HCQ04KQ595eYnSQZ02mWLWzB8VcTW49OAIFjrU+LLDKGpPLfHkxA+MHN4zA7s60QVuYHeWQsxXOXbQ8H560lf1k54xk0M1Q67aOUZ3y2rH5frns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=keHueJ3K; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458bdde7dedso41961865e9.0;
        Tue, 12 Aug 2025 18:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755049667; x=1755654467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFH+WA4WMIkgA/NoGfISBdvyTY+rxVB25tf1bF3uJSw=;
        b=keHueJ3KQteeYIH6BTX9czG8XlVTT3ck72Or5myU6RA5LWSsG45RevJHxlIa7TdtdO
         SfniOHnbbF4cVGnpa49P6BnynywjJYBOxEzwwn9oqt+s4aZpp9KO+DnhD31Da2hUklzl
         vAMN58pvhlZ8kNcPFrudPz89S0NdNXBWv/UjzcN6juVgioY8yh5ek5C4saw+C8EKBmy4
         XN551sK3JVGWfeOUjyjnY7kIXo269zl5NaNFE/s3kqTLQ7/CO3rm5iEmedMo/h5gDN7o
         VlRMpJOgxOqS2I0QgMDNIhFBLt36RdMp+slLhWylNQXCWyIjT55Eev2F9OBeAVhcGCc/
         LSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755049667; x=1755654467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFH+WA4WMIkgA/NoGfISBdvyTY+rxVB25tf1bF3uJSw=;
        b=uPmeKpXMud/IhMAiBZTK5igdzhhfvt/UUXRnpC0Be2U01mSaNE3jQPFR7sDe/m/70j
         YIwLRMyd2KOqAJuigQKMmEb9PEGAh7snGaVd04blKpeHADQ8rpw78IJLuTsdbtDYwME6
         sszLoWveyxVJh233eeA0uLjg+sDdO4D3Nyi8jTGRpUYIldXUvP10An5seQLePOIWDk8V
         cCj3wiGWh492aNBwPF9SOqlUEG+sehpp7tYV6EgMAScb8gGuKu/krdrkhZUcUfkeJql+
         O4WrZlWOOHZGtQakbUZPcYIoRElAnpYm2m+mbY38wMBa6uvj8L5YmSR4hB53Q6Dkzo3E
         aHxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWLFB9biO1kDQxUygIdbK+HGwzqFKZycTEfDtkwaT+VbVPbKsePJRRI/qFqkKO3qJFXyzCaxo2@vger.kernel.org, AJvYcCXDSXRiNnoZ+w+MWhgvvALMSHyH+Ru3SghR7hhADROhHwRcoJMCBcaOKZlbaUYlmbIlNRDocxHkOu2Ye10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzixKd5vlP8wwA5bwhseTR7RdoOKLbqvBRHL8iKnKNAop/o9l5o
	Urq7euL+jjdVIIBqXDbdX2ttNAfjfhozksu9hfRIipkt5SvFpg5+Iwk=
X-Gm-Gg: ASbGncvjU/AzAq8MqNzstmYMGnXNzMihr4u83GdYYlrjnbZHBD7JahPBcMt3zNWhAPg
	wApBlMtZIrrSjWahj/OhRhnMwdOlW/VE1o3aZIqJlaf3deihT+U0a3BSBDN1b0TwsCLQweKQnj9
	NelKgXAdgKgUEmVnbLgffrbIknbhn0nEoH1AiID6u1kKP8HiEEtxnU0GmenDdy8fRRVCTAi3Or4
	R4QqJt5zQjjMIMvaAwXtpcrgWQerY+LbxhoIp0wVI9Wwfk/8LBGjBeO0pIPkmkBCRl6vQEsv9YA
	IQVBQMpkvuoGdVE1hMPKr+zgUkJ3pBCktbqZ85EQsBtmKaEesXNuh54m8FTA+gICnwjTdOeaBBe
	EJxqiwUy0F3dqFnvK7QGwniAxX3u7MMwcglFlN+t8IIKiAOidVt+BOMWeZlENL51uAHAKY5eKMA
	hL9i3ZAVhyVQ==
X-Google-Smtp-Source: AGHT+IHmPuk+3akgOK9C3VBI5YtMXx/eKKXYjDGkGxA4cJGwDRwr627rYjCbKUHzpizbCBCspkj97w==
X-Received: by 2002:a05:6000:2304:b0:3b8:d337:cc16 with SMTP id ffacd0b85a97d-3b917ea804amr640607f8f.41.1755049666911;
        Tue, 12 Aug 2025 18:47:46 -0700 (PDT)
Received: from [192.168.1.3] (p5b0570d7.dip0.t-ipconnect.de. [91.5.112.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16ddd23fsm8522385e9.11.2025.08.12.18.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 18:47:46 -0700 (PDT)
Message-ID: <b9e685f9-97d0-4b79-9058-3db13b46db5c@googlemail.com>
Date: Wed, 13 Aug 2025 03:47:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/262] 6.6.102-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250812172952.959106058@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.08.2025 um 19:26 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.102 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. Built with GCC 14.2 on Debian Trixie.
No dmesg oddities or regressions found. I did not see any of the Python warning messages here which I did see in the 
6.1.148-rc1 build.

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

