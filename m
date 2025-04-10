Return-Path: <stable+bounces-132018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABCFA8351C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 02:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0B88A4041
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 00:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC4D4D8D1;
	Thu, 10 Apr 2025 00:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HWYTXuRK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC4CA4B;
	Thu, 10 Apr 2025 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744245574; cv=none; b=nv/ue+f8wNy7ufVu2iKNp8ro5kUo+MhD4So6V4a5JxjkLpvSo5bmlJSVHZ6WH5J3QM+v85lk7F+UOptmhKh52WMzzL1kufO92CRk2PBkKFOxgGWZzT3j9G2SxXdNKEQF35PSUabViG9BM/Ma9IBBnnj5PrJ4LzDgkWBD/KUreGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744245574; c=relaxed/simple;
	bh=v1xTqYyQGjrdHdfqnJMCy/GEsGpvzq0zxz4dc1BbO+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEtblcp4Y8UqpWlPmwucrM9VG219j1ApL2f0Nzp6zFLHM7rdrrvIQTnZfRRHEplbpSfGlJaV6gVH6IZxn1GhiOCl7NQy/ZTRb34mZSE7ptubYiOuYA4HnhKrkoNq9gwP4DjZBHSIbxEVd4hD/ivn+bBbT0rlBBzyRAhF+Rv2fos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HWYTXuRK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so2185505e9.2;
        Wed, 09 Apr 2025 17:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744245571; x=1744850371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WR6EtZhgqa4qIvzL5KBbZ/Tlso86MFa8EDmz2drhxVw=;
        b=HWYTXuRKit/kI01kJmQa/y4ykVEfcshVG3MWmO+TQYYxq8OxCAfEWZIy85FoXq9S90
         klV4vB4zIFqaLx0NbQHfU9vI44Uf+WLa9tXgK2cQtRaIuC6dQANa80XEwsc889xwWp3N
         DLQnifU0yIsxPwe1S8m1/HZ5qak3ZvuVHI9ljEKojjxMtwrwn+hpK3MT1OOh2rUtKV+7
         /TrwuyCFfI5bvaOr3TdC4xffd6k79180NkUNEZvELH/uyRRhD5e9U0L8gyXDjFXmxOm8
         xSLJfi3CZtis/31zo2mU93NoX0wrOd+1igUSRNtCGQCqcPWO4Rs1R0H3mCJc8FZoRhFz
         XuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744245571; x=1744850371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WR6EtZhgqa4qIvzL5KBbZ/Tlso86MFa8EDmz2drhxVw=;
        b=iWvTDcOLKl0/yxN090TWR8gn+GG7sPShUwBbk561UzRsXw1stBH8GW4ntkgvAsTzpM
         guquWU/OpPPZbyvSweHanyXkvrJ3BjKLJK4dxa1d8txSHAKIVjTGsPdJ2omd+8jVTH2L
         vJ8QF5wt39RX8z54ElNrNpmE8s3gsspzZvC/1W+bkclyppqCkHSfMrOGA3XIbo1DAu9n
         HfMRzGcUniR4j/Hhl9lAm6Z35VwpR9r9L75tnBUOexowYTQpuMwkKb0fAKYHerIR6MX1
         xORw+orXjyds9/vqT3QGWgrnN74n/9oF+zQ5CUkElkUtCmZ/YDkOqY/DSk0ZJd13IDJV
         dUOA==
X-Forwarded-Encrypted: i=1; AJvYcCVkC2eaABj4gq93/6Hgcl2OuHUmbnvjoz/2+Wm7Yb8FQgDUGtzmEZwJW2RaiohOoKOZAVv3A4r/VUd7Sqc=@vger.kernel.org, AJvYcCXo+EzslSrTkJwh+bvWVEagRWJyek21XpxQvar+XnBMdISCBpMlKvMf9kfRxjkdusBFr03fc2J0@vger.kernel.org
X-Gm-Message-State: AOJu0YzdGQSZ+IgIyAsSLvah8UqGMKjVrKJBnXJnzjxgWm+1HtiXpwjh
	d0Hy0ak79FT5v8h2MB3PiCP5rIIFabecnunUujs2SKFuxzS2tN4=
X-Gm-Gg: ASbGnctEuOaASCTnX4EL+QYgwlq23PSAgyxrbHNsPrZgw4Ijvnnn5iNwOIUDnHatA7o
	8iQzlp5tEmVGN/MG23s0od56Vz8ZJWJdB2eN7uxaaUhqdokMTFX3vmfUy0RLTp135Qk91pynDtG
	4GAgoTzZsW5LJa9hPl31t4Lh68hAitHD8aApHM2+WR/1Jt8RILadEq+AyZwggI7bK58+orIK2KR
	W7uGYjZp09L08ABwwyaaa7PqNRkhk/lHo51C93eHS30bdAYoxd/pmZ2d1iMz2gAiHYfTTMOWJCz
	SVdY79jjxIa8YhGtNczc+THTM2h019eYFojHYXns9kcwUz4BNOUa15CCmI3aSdmkNzzNtYWMod3
	+4QLi7/TYWs8oyov6dLMTo3uncH0=
X-Google-Smtp-Source: AGHT+IEGLlOEVjD0cfNCMZEAvQK/rkLT6cKka5phhDaoU/N8I3k1WGhfmz01KwcDGykFj9fymvC63A==
X-Received: by 2002:a05:600c:3b19:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-43f2fedc137mr2644815e9.9.1744245571303;
        Wed, 09 Apr 2025 17:39:31 -0700 (PDT)
Received: from [192.168.1.3] (p5b057855.dip0.t-ipconnect.de. [91.5.120.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc6dsm36304595e9.28.2025.04.09.17.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 17:39:30 -0700 (PDT)
Message-ID: <3747935d-8e6c-4971-b7b1-b53ea9dbb6d2@googlemail.com>
Date: Thu, 10 Apr 2025 02:39:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/502] 6.13.11-rc3 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250409115907.324928010@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250409115907.324928010@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.04.2025 um 14:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.11 release.
> There are 502 patches in this series, all will be posted as a response
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

