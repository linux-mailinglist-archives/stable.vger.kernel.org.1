Return-Path: <stable+bounces-113996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1894A29C40
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B5D3A501E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B3215176;
	Wed,  5 Feb 2025 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g1pNL/95"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85721215067;
	Wed,  5 Feb 2025 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792759; cv=none; b=TcEfvkQyOyfYHTmi3pw3rTPraKNLi5AYH43Gb175oZUL034XfVJTjgU8yyPbUz+t1njJviZ+fZUzk9yaeark61njfuEbj/6zzBilF7w8aowP79JQz2PC9MJIpNf8P52rUF1WGQJ5uPjRjygSlBDFTidvX75PJf7sXjZSsvGCPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792759; c=relaxed/simple;
	bh=+/HaVGqS9hPz+c0CBR2hXGAzuLCFsS66mg4KzaiJc84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpYF7ON/CwNx/I/VN1dCv2gaOHoQTvQflMo8Ja0c5ZI2SeWKKCRcWzl9wMmS2hCTfITxKIRbN/3yzdBBvq7AKTEfLtgE5uFvUocsQS30NdfKc8gMeNEkbX5vkda8jy76lOjk0uKTsZWp7Hquc7us8hRXhqLLTUTHBb4DFBuRi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=g1pNL/95; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361815b96cso1544975e9.1;
        Wed, 05 Feb 2025 13:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738792753; x=1739397553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bL029lQXje26EjRmbzipveomf3qqdFr3G9Ff/kItIb4=;
        b=g1pNL/95RjYTQVcowsIapJxWT/+eoHwjdXzZEyJVWYxakx7cgoOdTAf7/LePEAh/l6
         48phU3ShdtHmm5Ied3BW7HuhDF9zug4BO8lEd2JYWc323sZ6MRqKs/O80B9xvEb0sTdq
         fcyMZHrTkioEI4pSh/pUXfBgb730o2tAQFcMmyY7h0pmjWSIv6ZCcH3ZrXptZZvy5d3C
         Bkz3peWJq4mVWc/Vz9+3Z1Mm41wiFPZ+hFCmCmjatYiDqKkXneyPYYiWXtpWhcTMHl3y
         Q0B1C6jispmSUUY3Ny2bHlJ2W+SiiU6W6JYkQkwsTtS9q84/1t+61Fbevcs/Fn0Xm1Lf
         gjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738792753; x=1739397553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bL029lQXje26EjRmbzipveomf3qqdFr3G9Ff/kItIb4=;
        b=Y7o54zL+AR1VF/XOChKxwDgHtAPV+8wHhqmWM9+pFaXkjbW89A6dBiTLLaKleTowYS
         0RXcTkB2lFBf+9ha4ibKHS34pO/s0WylFQVGsgrGGD7ShDwJ8yH8KCyQMZnFGmcdiuJj
         HAU1zlwL1UNb2Gpn/pmAcgRSVmsCuCFZJ8qENV2HBkmL7aW9s1JX9bkQ6nnnnd8LFr5z
         HzmPxZ8tAtAMWLg+AZensH6a5hd1Kb/fqU2CKB3SlQJSnXZ+PmQi2AVSASZqeNgX82qe
         BZlWLVIcf3OlB5LyPi1ECvjUrebulm6lCWzPLLHoRGf8gJHIuBVDXEgXe8JHVvsCI/3I
         1Khg==
X-Forwarded-Encrypted: i=1; AJvYcCULQtW07fC9cBSwaGCoXS/TyMepI82I/Yxx9KmX4+gliZJm4C6W1bql24Ze4haMiHDVSFiIZfrQyHBdZ0c=@vger.kernel.org, AJvYcCW9cqU6g0CRcXC65UJnQJpv229sDJkEXfBNKJpg5A/PpcEy878ZUJQwepvZlfTY6+3fJJz5Hlyl@vger.kernel.org
X-Gm-Message-State: AOJu0YwTSuw/00RolDH6+6beRrTH/BFQ0Dsjgs5AJP03YVPo5KfQCMgg
	mT1kJdnl+rHfjofhFS1e+KbxW3Z1cqZLiDzrNtgzqEvPG79qlxY=
X-Gm-Gg: ASbGncuWkyyT1jxImF2nNLU8EfkmgTmmlgOGHtDAg2+SDQUrT31GjIZNDvNE8JkOhoX
	8eGzZxVEDichGXXnPH/tJqwguCU2LU22bI1azi9hN5+JEs5vromV23K4SJrhNcN5aHOrIDtm1rU
	5GlfKE0W8ZQk7Y4cf4qN0oYd8XPJVoBIwkAXtMrx7xePc3ZovD1znZO8+sUxcMuBIQVAVolJAzk
	+KgMeVKGLrkG7R4QdqKV1HESKO40rxxbzW50m4mTQwQxSuJuQfSU12ZyBhT1owNQFv+pXXjgZ+F
	8+TsZWlHrDGa0zkpiZtk8/BFfy3ft6m+wlruwNKJJGn0DrZtQ27+0AUGsPS3t7hFOuUO
X-Google-Smtp-Source: AGHT+IFoEmOafnmgI2ErEgGZN/fjvVWQLPszsj7LiHyQgikNEYkGssxptvECnW8C9xZE+kGYjoiJnA==
X-Received: by 2002:a05:600c:1897:b0:434:a315:19c with SMTP id 5b1f17b1804b1-4390ef68f6amr32778505e9.3.1738792752496;
        Wed, 05 Feb 2025 13:59:12 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4bac.dip0.t-ipconnect.de. [91.43.75.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38db14ece84sm4413898f8f.9.2025.02.05.13.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 13:59:11 -0800 (PST)
Message-ID: <2869bf74-b377-453c-8a22-43835c798bcf@googlemail.com>
Date: Wed, 5 Feb 2025 22:59:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/590] 6.12.13-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250205134455.220373560@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.02.2025 um 14:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.13 release.
> There are 590 patches in this series, all will be posted as a response
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

