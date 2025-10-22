Return-Path: <stable+bounces-188984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A4FBFBD7A
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA8518C2F15
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A225343D6E;
	Wed, 22 Oct 2025 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AOsjwj61"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603A33F8BD
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136088; cv=none; b=t4BLekuu/xcN2w/wD3eZqho97T36Jo0E94hzuREWXHIv+uWgSrobh/N8a+fYKmMDMMtDL7EN6guhpsVybI7iMrNEANgs3FIgKTWsPLm1BQkZ3GgEEwdU1Ir7a4TXHi44jDNHWFGt65U0OQYQ6F3QGTyItt5/8DQbJtDV/Bsa9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136088; c=relaxed/simple;
	bh=Iejn0pWjNdBJA/skFH2+V/JvIaDlDJ3P1ZCkLVxJQvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExtWyG5YOM1eIatjXBNlIcZ3J7yd6CV/EciU7ek/f3dpuqCpKdJ7tiSiMEhwotmtAuf6PnoyLxOlPEulu5IgMnEU4ob7TIivrhkwRVp0dPKf3+TxTZEIlt8so1AEDyz3Ijuqp1QoDqCfHSDojJnzTTS2o5p4tR0Vx3O/otloR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AOsjwj61; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42701aa714aso4102601f8f.3
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761136083; x=1761740883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFbuSQX+6YT+HVJbPcsJSl2m1jB0KH5oX7eFGxAFFNQ=;
        b=AOsjwj61kMGZzbmE1tQnMGq5K/0JJ982cQIQI9j41XGJLYVjYXbL4SyedjwvK4pja5
         GCp3K2vN3S6bo3lkHsvcYgm4UzeHqpIc9+p7TX5WzAZw16ue37frIp8cwa+olGG24DWz
         ZGKoScaQi96uYIa786DqMlV2YoSqSPcz6Qt5/yFXaYO0QZ7O+upi82fJtLVveA+0PMAE
         Qhj9DdrDG2tHoBtVuxd3KjBfXCV1nedA+6hnCS8CpWNdYmlTwK1KjQBANCL5uiN8wudB
         CqyJOvA8JlqVUEkQwzoUgo0zceRFaZa90zvYAdqc7zdomid7VU9xsNkN3ifVU1LE8Q6X
         SHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761136083; x=1761740883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFbuSQX+6YT+HVJbPcsJSl2m1jB0KH5oX7eFGxAFFNQ=;
        b=T0GoK0I9Keue67UjjAWH+uQph1v3qR74yuIo/DPF/XYjbkXH2Cj+YTob6GMI/wfFpr
         dAXu5p5xUct+iYo9r6qUV2e6isdBgFamxf3joSuqiJqnlAFJ0oUB1FoLmrJaYbEwLSnB
         lu2IR8znmO65PT1FGP1X6km/2OFUeNWIvfWfqfPj0Hr2f7njp0NDYXLE45MvdqmdbvlE
         ELZjF7il/KFNS/mL3ySp6/hGaP95VxYxGYK5KzpBDDJdqMctna/7Nc+iE+hrg9dW51VC
         cmutNPn+iBI1o0ijz+z9/fqp110KMubQACbZNWMRvxvjHpDnWG+pw7kFHsI3tAj26nw6
         8iUA==
X-Forwarded-Encrypted: i=1; AJvYcCWSRuDiz4S9JU4/0n05q3nOBhC76Gs3EfXBSe4MSVAQ1vd6YEjiZB6ccJ55DNlztkLZhteMv4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61SsHrAjiKLUA44MJMKof2wZPH6S+lb11/a9spV5xGZFlwoNJ
	9+HlYXaHHtDAgbk+KtDiHfdkPfbJnJuOz0OycQS3cGMGsEkB/19EBwY=
X-Gm-Gg: ASbGncsWJtwCI5Nfu3ZG0lOQFsFPe/T86eCxL55gpacwyku20KpQwNY/c919DMxjQB+
	r1iVRAT2gHNdU0JzMOPhwlCz4hKuNGAJKTIRjYsdca6VFZc+clXTpS0Y6YUflN9ckzOAAGxNgGj
	UI71NBJdOL9q+lfHTAnyxJxyE8cROlY70ZFeuB9g2pWNF0STaWU4wh+Vtkg7QHGO3g6xaC288bu
	EZHr5GK6xFGvUZk64nROrqRokcbW3pEsP71/8R/fkcDMm6yBtVuvOTOfz6mjYAN6kpKyQZ5ixlo
	6zpMkmF/KPL1uWYflrpegLNZog8mnvAaNtF/BdyQqirRENw0SfQEpbzDh0HodF3qZ+B0uoH2v5+
	zJzR65Xh/8lSLEVVz2uqbrCeCAEycxn3zF5bEnn60czB8OU1I0slyVRpTZeXLUzCPEYYdLz43fR
	fymIB372wUGS8XotK9sXPsaEx8hytc2YfYEFeOaPzgqJoDAIDrGGI0FfoVoLzPnQ==
X-Google-Smtp-Source: AGHT+IFzalpz4I7N4GW5iAQvE1IHT4hcwYoMkH4rdlEMLAfJYgGKj+R8HqkyYQFmUVrdcF3vsI9GFg==
X-Received: by 2002:a05:6000:220c:b0:426:fd63:bbc0 with SMTP id ffacd0b85a97d-42704d786c2mr16326022f8f.27.1761136083310;
        Wed, 22 Oct 2025 05:28:03 -0700 (PDT)
Received: from [192.168.1.3] (p5b057850.dip0.t-ipconnect.de. [91.5.120.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce3aesm25354082f8f.48.2025.10.22.05.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:28:02 -0700 (PDT)
Message-ID: <7965a547-2267-4f09-af62-0b81a2d8dae7@googlemail.com>
Date: Wed, 22 Oct 2025 14:28:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251022053328.623411246@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.10.2025 um 07:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No more screen problems, no dmesg oddities or 
regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

