Return-Path: <stable+bounces-124108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A371A5D23E
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 23:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19590189D226
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA96264A8C;
	Tue, 11 Mar 2025 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LHTkuXbR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA2262819;
	Tue, 11 Mar 2025 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730747; cv=none; b=hbctGGz0RY8ppC1HkJhNW+qVMeoapxfjvPcflPVraiTM7TaWPRyvyHeUVIIDFjXQJbPq1WBJvslhyZDhOh/k2W3oxKp4wCJx0kXMlQusjJpU3HfuZ9IoV3A9eLI3UeOpctEkAPREWAIpaoWd6iDh4wDmSzyplb9FPMb6LTS0O/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730747; c=relaxed/simple;
	bh=8HRFAfVyOjptseF3KU9kXoh+jRX/3k4u9X74yN/vcMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKwm3WgN2tWnRxkG8DzxZEwifYOo4AJNQzZPG8TdPYAnr8UEDTDSkGI/DHyQBLQYSAq2GSHbRmRL4a84Vh+NmCDc7j1gkqr/24JfcdINSEBW/uBvak4c167maGn74knaZJ76TP01wGIdY3rdGTX7xG6PHCYrcLp5PvDTzYpSgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LHTkuXbR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f403edb4eso3298992f8f.3;
        Tue, 11 Mar 2025 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741730744; x=1742335544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEsjWCRQZcgQTwswO2KaPHe79iNOfo3YPhoH3sAGe+M=;
        b=LHTkuXbRGWmJhkbibovawK1ET/Sk1ZYxiI+XGTZlaphUDCQkosayBJYd3NgJOzunPp
         gn4tZ0hkoqKIVtoRBeLYMg7WglqOtR3N+ISPxkad3LQM8S76TeXcBMkMHlGi4NKHA1pm
         bORqBeo3Bxk+D804wArydBm0rsFvB6vLYpnBwOD/CXKI/dte8+BSv3v2p/LT5Oiba94j
         obu7Dsd/4fcHmCzTDQnOBVbx2UaBKfgtIlRENyTbbOGgeKdZmbx5eSsbPwR+BG7sAdnV
         7qJ8/tuyaWL9EjumTS7K5zmmx+212sb1fFdOsgMZZv/q77tTonY+UvVQ1F6GYF6pwZL5
         sGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730744; x=1742335544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEsjWCRQZcgQTwswO2KaPHe79iNOfo3YPhoH3sAGe+M=;
        b=o49t3RZdKFexATvWwhiSSzB3n549FQPpbuwCuJaTbqzZ9v3fEXSRwmVtNjQ43J1fgu
         jYEtTjFlrhgWNIBninr9prHUik9LYW/+1zoAu8YTRowoxOiBRtnbBdC8UQIcldf5p4p3
         XElLg8/hvFyhVGMYPV2ykLKH6+Gg1LQAPpS75JcrzTBo0w41tEuf0CBUl4ymmD7opD9B
         xQrkwt+k+HTZhpW092mvyJQmzyx5BuWiiCe5C0fsGeGqNpyps0fGEJPoxC+97wc29NSX
         Y1rHsT3HSS9F0gqyGQFWjVyCivACY9K7qXwAecjO4Lux5gdF6Hz0zC92hXxFj3ZipWkI
         WGDw==
X-Forwarded-Encrypted: i=1; AJvYcCUKiTrsc8HtUg7yYaufiajO0Z5pzgG4tyv+kWEqPClyJu6aDFXXi76PLW4X6WHT1scxvKCwBvsaWumK2nw=@vger.kernel.org, AJvYcCUqx7ccS6AIcFmHuw41wB72C+Oq5LHgzLHCMhXZbBDT9C7Xpb64J12Ynmuv3vMsnjz4J0QijSZ7@vger.kernel.org
X-Gm-Message-State: AOJu0YzTW8M5AX663aEaQcYhB5Fnw+aK2pzvczM0iSZhTc30YlzA/wrS
	oVzE7AwGYEQXxvKT17skb9HEm8IpJO8QSMXjSg2ccbCIdBoDekk=
X-Gm-Gg: ASbGnctJFeKLDjhoCgl4hgTXMiWe1+51N7AuKVW53KUcFGGrEKAq6YuMd3wdKBjnoAQ
	WHG9opw4AyVxouCyvJsde7SZ+0hVD/92EBHh4W8f22RTWWEKTXJIrcUmwhrmxOiVoDaywri/16k
	lJi63p5jqLhOnMVBGtT/JXK3ScGhNA/Bubv1gVv64r3vXpOV/PXeofWALghS2tfZeJ1pdxSdy8n
	5/MtUAJTTNn/FW99T5vdFbEspZNaX6R/VzMWPIPzamfya0CLXTlLGu5gKGJdpSlSby/r2yxx1ph
	+OPYgMn89tc3OKtiNZQ2e+3H1ueHQfVs7RePNlLNC+EauZKhFhVcZv15q5jwQWK8EgAUvchzVfa
	JCFgtypVbp9A2M8AEPw1VtA==
X-Google-Smtp-Source: AGHT+IF62lQu2QqFmxw901nU1txws2LkvZSv85laWHBvc6SVous+UK532kyR/iP5TGcaeJXnvHMF7w==
X-Received: by 2002:a5d:59a8:0:b0:390:f55b:ba94 with SMTP id ffacd0b85a97d-39132d31f55mr14974461f8f.13.1741730743571;
        Tue, 11 Mar 2025 15:05:43 -0700 (PDT)
Received: from [192.168.1.3] (p5b05767c.dip0.t-ipconnect.de. [91.5.118.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfad7sm19069003f8f.26.2025.03.11.15.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 15:05:42 -0700 (PDT)
Message-ID: <dceaaa73-df36-4db4-b373-6ddb26686c31@googlemail.com>
Date: Tue, 11 Mar 2025 23:05:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/109] 6.1.131-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170427.529761261@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.03.2025 um 18:05 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.131 release.
> There are 109 patches in this series, all will be posted as a response
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

