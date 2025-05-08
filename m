Return-Path: <stable+bounces-142879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A74AAFF8B
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78BB3B1818
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E22797AE;
	Thu,  8 May 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SwK7ndla"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4822C321;
	Thu,  8 May 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719371; cv=none; b=dRO17otsVGbQiaZv2SYqQzKuuGE3uRwidoeKPv/l2/XVojuZad8drucU3DHBX1N/S3jcQzKnT4AHAd7+Dqw1212xOfyyC4a4BdaTAw4FZQ25uFsQs6Z6r1vil8D7PGNs6C+S2LBoVUAHgEa2YeP+RfQxl0xzOTxT/rtamm3VQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719371; c=relaxed/simple;
	bh=Y9vWFCVlw2g4DpNXUL4fhrgJKM0WgJemKT0SgUg2hNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsyXZqkZRT5eMrk84iTHqqVK+vsbHHhkomezTGHNaotOyXipWd6CB20PeWKbV50wsmIuX7OABCnGcWWABTch1TJdO2Pl6yWIvVxOjnejAkGgtg8H2dkJefAr6XNINz927EpoXAgYXzmoMYTTfmf7/qVp5xk//O6S357mrggO8uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SwK7ndla; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so13018655e9.3;
        Thu, 08 May 2025 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1746719368; x=1747324168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eOY1fBOilgG1yZWy9IkYeCeO3dhjP7Lg4rWy8ix1o0M=;
        b=SwK7ndla8jspccm0CEEOxAlBp4tkK7crrY7ks6GZ/tTCSpgyRVck6UDrSUcUUDcSkE
         kNuAZORjgkRK03Bh8QDMwdr3KyGP7c73Xnb8M1o0H2aaVR4WaPqK4AzOi44eayq9PDSQ
         oBWHGycy9vF1vNxlmBf9n2ABWUIXX4p93g8xgIy8NjbD3nrdVC6dGK7fNWO227UzD+d6
         w9bUBQmz1j9AFDEpAQp6IBWXb6QF4R8P5sR1l6tvhCcsQBsh0jLcwcUhWLsk2bEKQnET
         mh0I4Fm12iMjvN+UpfEMS7Fr7A/YUb8SmbG046Ui4kiGpWB4mhVBsmUsMw8BYMLV0Gur
         h7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746719368; x=1747324168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOY1fBOilgG1yZWy9IkYeCeO3dhjP7Lg4rWy8ix1o0M=;
        b=qHktj8IRQ9YqXV/vRTVL10izEykBIaltI3Wl11h631rq0gCcylUGv0l2qGspED6zIf
         i7FqOdyUzd/mf65o5FdvYDjJ+fNJrTTH4IOaza5VjUZ+Xue2FcYwaJEUR9D2BUmBAPKz
         Ozxt9nN/HPb/L0X3f/3yeCJPLy//+dhp1mtjZJHxb9ePbaA7TtGU7HcDscnaqb8kl8S/
         qPB2kCVy/GQKXxGh+Gzy0ZfBUbHvxpHOD1jDz1Vyvq9F5S7k6jW5ngqnJ4sk6pRZSHTW
         uebP1dOXILtXBArbK4f8qCvnoJhHqx3YAUoOvLgVnhgc2XoZmJEXos/X3aoPlpHRV/Q0
         u+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUHUPNO1kK80gYT3Vbls94w1caBfT4djfdPLRvECPZVpZEMOTc4mjuuOkhliZWsZ8YPwSor0H2@vger.kernel.org, AJvYcCVXS+kvhc0+ScEjxXlUxADv8bTY0hcmIGbXyaiYk6Khlk81O4H322TJ8R+HA3oeh8c2CIOZ6rWyceN8wVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHZweb3Fzp/2J3JQDuSnP35jbITKMt1OLsvZLjywNU027KdYa
	bZOgXGpj1fjcc2ed8ujA11N3hLxbOz/+BrxRqOFoHV731ZYMUQg=
X-Gm-Gg: ASbGnctTng1v631LiK1Sa93rSJaap4+aGla5kD8C08B4zteNgl8N/2ZsaQkG9r+yrXJ
	E42m7V/kGyJuKRF88OZN3ROqiNxhcJpIk0K9i2vxjtKph9IVuhiG38oD8ilriBLb5tarBKtKmyo
	nIkzkW+brKuwf9ioT6HnX4Sl95TOkYDh+ssq5dwm5jcpj8s7FjF/FWdK2Iy4J4+M4NfbWeYLP0O
	yWw3ep8Ong/i0RLa/i91tnqDNQun4bwNTIUhPQc2JWoZ092uaGwzXT9xzK0OcSnJJiTeRJfQXsv
	FzBPlfK0U0KVa4Hak4WVQ2jArc8R+pQ1drYsK+/d4VJt8434vmJwtyohF9jnyOOYA+sjRbjvAr8
	BqB+i0KW9b5A2cQjtWw==
X-Google-Smtp-Source: AGHT+IHO1DhAK3LRIJ8mCQPQrQm2PUR4aTQxh06gBQlCA4oEfIzCTN7RksSJNtOQ/XUQJQDZ1GqkOQ==
X-Received: by 2002:a05:600c:1d08:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-441d44c7d8cmr75789755e9.15.1746719367357;
        Thu, 08 May 2025 08:49:27 -0700 (PDT)
Received: from [192.168.1.3] (p5b05727d.dip0.t-ipconnect.de. [91.5.114.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd328f0fsm42637535e9.7.2025.05.08.08.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:49:26 -0700 (PDT)
Message-ID: <bd2a17cf-a8ff-4e6e-9872-0bd28c2ef507@googlemail.com>
Date: Thu, 8 May 2025 17:49:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 000/183] 6.14.6-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250507183824.682671926@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.05.2025 um 20:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.6 release.
> There are 183 patches in this series, all will be posted as a response
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

