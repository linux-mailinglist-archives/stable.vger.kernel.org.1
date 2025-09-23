Return-Path: <stable+bounces-181506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6660AB96108
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE6E19C2538
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070091386B4;
	Tue, 23 Sep 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="imOyS2kf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336FD184540
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635251; cv=none; b=nJASOAhVTUWJIfUUBb6Azntu8vOBTprzqVLj3HzVpoFRy24SDyQANMTHSgOCvEt0efzuzyDZYGEx/V0ErtezHp9V+/zDL/LwE8LLWVoZI4OoEw99oO/EQCNj++FL9e1esXgQq220GGZUo2vrmsMUJsgb155wP3m4G5wqvdVg1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635251; c=relaxed/simple;
	bh=fEMX99a4LLdufdD4JU/OLopt+VDI9F3h9V5l+JeNSDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/Bmrx6Bq+nmoeOx+Wo9Vz+v6dgI0pdPKnPNQZasXM7zI9/NNArZFkQRnk7xU10esG48aGXeMZNu+nVfXzJqM6ubjKTcoMq9Ibf3x7oI8n+ohCRoj9eYUt1c3vC0S+ZFxgeq2GOAPqxms6c3hhwgplxzKYAdfoZ5jvnnR0Di64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=imOyS2kf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45e03730f83so24616675e9.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758635248; x=1759240048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28l1fEqACwCBZqKhFY3KyPqEpdAA3HLg8xJ4dHMoe/Q=;
        b=imOyS2kfayuhpDue+BHU1FYIl9kfeBysJFX7QhZmrnlI06e6VhcKxSYCssqBh0Ur/g
         6htqDugTpG0Zs2NwkvgqGOYLqqdD9Wi4pE0t6CvTDbw/0yhrHmpWaGldwxA7g5ZW0fDF
         h8YciSfx2OQI2O1P1lrpKwyk5UnVJqRb3LX+CIvE624sDJKB0OwFwYUzXd6WA6nzzPt8
         W922NfeAg0yAUy7o5SoQ4TtSq3jTLMHFYB1u3WJOWGmAGxgne33cg0thcLY9u2ilSrUB
         SoneZMgCGPKgON9zj1WL5lkNI8yCqtjiljIAhctVUnT7MrmSOYUb2oMcHiqkvITnUgUr
         x+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635248; x=1759240048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28l1fEqACwCBZqKhFY3KyPqEpdAA3HLg8xJ4dHMoe/Q=;
        b=VSIFAWM/ueOTlVKIO/BBXPUCAQk0Urk+9j0FmqrJTHLXUeGXy+fEfjHz0r5dfAogqL
         CTiFntoNrs/bzk7A8OlrJRKX5uuXOLjcIFhgoWo9SZFURjnan3wRH7Y5bW16zZ3IsUvJ
         M3dqdxu6vAf/oAaqTJkyK4s/KIT6nBkodJcfHGBelBsYu5cw2NGr5YFwDOdn5EHTZgu2
         rjjzUJ+DDsHmZB0hVmumJvQMhKp7zARH0XQzEQlD3qRp+OSMUFE8axQ3xjgQxQrBIV7t
         ydaDG1RmUzbbEdlF6jSnkbS4L3cVyqB8XSLSXvXYr5XJGrBPPIYMCTI2zOEass/YMdBk
         fh/g==
X-Forwarded-Encrypted: i=1; AJvYcCW7Dc4y30vTedq7i9T+FPkbVOc0Jri8GDqitSywvzSk7aP8co0Th3oa6y86L6LY/RhXXkkTWzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytr28/0BtRBQQCM4dh9TvifkCDURDBnRzxUaJWnMi397VMlpXk
	57jukprMWpTaI7DByW/pCBw7FJJbf1nqByiB9IftV4Qjvd4fLMjX9yY=
X-Gm-Gg: ASbGncuyKHQb50xv6CQppIFLVZ4LTRTL4uvYsLGKEA7pZOwwoEz+YFyFsXbfe9pdz4p
	zC4mcsdcSvDGha3qsY+qVBHWd1n093BqMmv5QCS2TglqQb5Mg7uLZl8y8XXbL/VohWXUgk9hKak
	ttR1rqsDFQRSj2OvjBUIoJi4DcRmXhGfkJg2EGmiQpIluG0aSE/6zpex0T6Eb1w3WbP8HdGZ3ib
	q/7LgWO9UcXwui5VHcbRz00sbLVGJR1gYKrqu5on2GrICOnSUZegNn4W+BM6W6E0vD/fXcEJPGt
	HnmCD8LHa1NYb5VKt6H8QbG8Fvt2wgmGIBOZ0bRz2vKA6oDSAXAGn+uyTECDgKYBZlIKvD7puKO
	8iOwdcf6/SMDiSuvpnYMvx+Yt8TZSzWx98Or9IonYWZAAkDAJwBvFv2c/h8j/mPBTE/cHHg+ZCH
	vD
X-Google-Smtp-Source: AGHT+IEz0/K9oDXr/zLCHQ4dVkUmW53CD8fdbE0aFuXBqjyL0D4mn9goYVNMKiHIDqyrqbQhLjRZcg==
X-Received: by 2002:a05:600c:4692:b0:45d:d609:1199 with SMTP id 5b1f17b1804b1-46e1dac9639mr27593965e9.30.1758635248308;
        Tue, 23 Sep 2025 06:47:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac1a7.dip0.t-ipconnect.de. [91.42.193.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d73sm23740097f8f.8.2025.09.23.06.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 06:47:27 -0700 (PDT)
Message-ID: <4d2d7e50-9853-4c8b-8a62-52c37004f4e4@googlemail.com>
Date: Tue, 23 Sep 2025 15:47:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250922192408.913556629@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.09.2025 um 21:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.49 release.
> There are 105 patches in this series, all will be posted as a response
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

