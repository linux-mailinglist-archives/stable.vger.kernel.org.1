Return-Path: <stable+bounces-144199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1A0AB5A9C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9133189BFB4
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CB28F501;
	Tue, 13 May 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="N4EtAS0l"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846201AF0CE;
	Tue, 13 May 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155572; cv=none; b=mfSje5VqCFtMPKMZXRLTs+GC8G3EK1vmIRyUpR0dmc7cUC4+bncLd+WYiwawQ+96w8ci7g8d3sio9MvV+yh9zHAGYZtGxY3gmfVkrEm6WcqBcawaiJR0Kal5Kt73mCZOIg8T5IFmzH1cSyfN3MgyjO0Ax4+n7Gde9vohKox8MjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155572; c=relaxed/simple;
	bh=JKn5JUNSPQnoUID7X6py4mf39Q8/q4+b7LFzorRC/YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJ9lQsNnzkOd1pdrOzTw7esW/05jwGMoBPx1Mw57Bmi8RmpGPrD2YX4WREzM/vRmuw0zZHoO0m6Vd2ecDCy8gaoewk3lSkd3wLCW2R6TOpqY+aXSVunssa0iy0+DebEd23Y7k0q96iwswWrPLMREc5gfXRVjHteQwrcZRYjgImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=N4EtAS0l; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so2979978f8f.1;
        Tue, 13 May 2025 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747155569; x=1747760369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZjOMb5om57dmJRgoIxDIvEHKMEbYGpwwXOt5lNMlrw=;
        b=N4EtAS0lDs3r9LBYW3Yb1X2FMmu8NuIELFE64R4oPJRzhPVTpMrIVESAU/PeX4t3jg
         wtRCwgO8wnhp0S2ZEkYYnAq1C4UozBimZAvCW+vQ1czYc+n7OhXbx8qoa+akvfaSYQ9T
         1AYOCAmndTRIBK+BA3l8Dg1/wZm5QY2nIP+1rpsL/lS7zG8bTPdFRcE5K6sUVABOsUze
         PMandbixPlZZybm6QkzjkJ/WgvBmzZbJplOoXD2tY7ybeJBBefNBwQ8vqMlONwXfdLaE
         tsdreuQxAOyrYMH50XQ5ckQRpqomEGWQfZ4saykQMASWXiss3vQfs51VTxg6hutIYO7R
         VLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747155569; x=1747760369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZjOMb5om57dmJRgoIxDIvEHKMEbYGpwwXOt5lNMlrw=;
        b=JjbyKnpAlG0zOLtVO5AqUUkf7OV2k6Gmm+amQhtACqEHhNJZEwfZFPEoXEs5LnWYTi
         d3/KVpp1o/ap/J/9NEMUbOnMlNPIZTVx059fQ9+sJspbOaBE8m47YCv6OIlLZb0RsGvK
         brwDysIs8ZODibC2FcSfDbozZwoJO5xegbNWpE6gGA4YzUYQ1pkJM5Ay/LUyU0tuQh1j
         POeCF3+Rtb4Kvo5k5uQj9v5aP2NxRQL9wu+Zsze0z9BkdNJSTxs0DFHnrCjSO2bvn0NP
         JgBj9jMlKxIszbO9FXLh7TI7T+hjm5Q97S6w22levqngD2kSuvHnSpMFHYA3geKHbGck
         wSCA==
X-Forwarded-Encrypted: i=1; AJvYcCVa5wSwiFeSfjRrHBvldMzKCgMn2oFoimJF66XrmJ506FQD+NCzfjDTfw5WVOOl9o7vsC2MgVADFYQtN1M=@vger.kernel.org, AJvYcCWUrPYIrLNkVPtY13UGDPvcJ0E27lhCXMNOXL1PiqTeERaIaIEBoumVJm07aa9xujK48LJA7Y/p@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxPVm7pGSZ3gJy1fQLMcWoL62SHPEF57r9s07eDkiWjYKExhP
	hpoxcaUWzKPwYQEZk/T5c1acZE0WvEoKPOfnmtBJCAVuWgUZ3Gk=
X-Gm-Gg: ASbGncuk9yGLSEtVnrAfH1qtWD2TBjNLvA19e0zDEMCOAzeOurr4o1ZyCTvMhX5i9EB
	GV7q9mCjmndbYbO4wM4uYvQs3qIYT9q74FtK1EjaxfbR2cZfXhAVXz7Wi5nuRxo22lCekFKq9qW
	sO+IAQRkTyzyeX3T98+QzFLEEgOqSkE4HkqzV/Zf++Iz5FOyX0+WosACSh3VE+rVyxzTzwaj5uH
	FuuQnhnU84SP/AaiGasV469DcKktuD7wOeUzcFqGJfCw0t0JdQ/n6XwNCxtT1+4+101O36/dR4W
	M9tum0OftetG4hJkG8zKajdxR3ZV2X+6Bo5l/bkA/BBzKXKjvs0RiPkQijTaKXSHJ7WDLQ700/4
	IqlCvyX6thUcMYI0YwEdIs/oycxI=
X-Google-Smtp-Source: AGHT+IFhwISbP27MyrHpLdvwM3SbZp+KgRuLNu2E6DunVvbQvlOIlBVqXXd3IdXUeECrOpl7XSpB9w==
X-Received: by 2002:a05:6000:1445:b0:3a2:ffbe:89d5 with SMTP id ffacd0b85a97d-3a34991e01bmr14060f8f.43.1747155568548;
        Tue, 13 May 2025 09:59:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac006.dip0.t-ipconnect.de. [91.42.192.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2cf1bsm17013992f8f.72.2025.05.13.09.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 09:59:27 -0700 (PDT)
Message-ID: <17062792-a294-4eaf-b827-22785940957b@googlemail.com>
Date: Tue, 13 May 2025 18:59:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/184] 6.12.29-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172041.624042835@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.05.2025 um 19:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.29 release.
> There are 184 patches in this series, all will be posted as a response
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

