Return-Path: <stable+bounces-181510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C5B965BE
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1111891D05
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D1425E469;
	Tue, 23 Sep 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LTxgTabt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA1226D1D
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638377; cv=none; b=X+Ixz7iCtN3ihS6JgZ67DJAjqXDN+O2JAQJCI9Rc5/fZntelC5wrYVm/G2sQ/yNWQyn7iV0xOuXKfzQH30KfIMWNRljZImQ6c/5AT3BtcfNrLaU2wDMWUtfIQ8AwTUTlg0+z9lntUJ42IDb8wZskz+1GcALl2INfL0FX11QatfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638377; c=relaxed/simple;
	bh=2W1p1PVxEkh/5Jzxzj8mbMEaZhGYn3Pso3aH49N+ygo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bL7qaC+QsqIb/GT+Fy0XqqAGjtOOrRU3GPtagjB/rz+aABwa3mbDL8EWTv0yUebEn6zvccFMP4hlM5PPSnZaWPR7iR71douEEAEoabyKQmDEt4T2SzBTwhjUZoPUKu6O6et9fmkIUrP/73fErUHRtvrAIimF/zGmLns+6IGNvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LTxgTabt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so2316657f8f.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758638374; x=1759243174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G03TPrIwIbXqqIw62bjb6NY2zbYfnOY1m550GCrJAlU=;
        b=LTxgTabtLX9stgUg0gZFEPh5AYuQHFgSrhkKbDILlPaG+5CETU1t76X504yvPOy2+I
         rd1omQgcNtTsMDfO6wczUMqo3AGb/HBxPepW+fBFZYZmOpkYbhqMeHmiC6gGAN+zMPUD
         RXm+tbZo0VUb2yMHksiPdzA098+TZHrSLPjTxLyrfq7cZuG6daB3PYTmyRqZE+SB7Pa2
         rjMxo/vdsKf1mGkDVbYGuwtNkri4dZl9TpcqxEqLAjKitiJAwuXNYH58MTzG6NrSwPHb
         /Ljii+DGBKYUCC9WGN8GtRRtufHqJ7M40OxJOslUSNfcoGwDUsKjjh+X26UZQ/9TZssJ
         yDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638374; x=1759243174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G03TPrIwIbXqqIw62bjb6NY2zbYfnOY1m550GCrJAlU=;
        b=ewwOsP19Vzzf1xdTxE98tPvLj9+sFKXwRCypw+7D0CDsh1Y9sE5ZGyBUbZVmIbzGpT
         0nXBYKiRmwccrB3HcCz8RKSTeoWSIfWkx0deQNqELyxSQ/1wvlchOhjdFBauVATHJ9eV
         agD99u9Yd0YCZAUhwsnGzyHgyVtHmufdmW/0uGlTmzrQ5MzjnLOvHifBf5cPC3flDTT6
         Hc+ANsZHEPg+a/WWtvWlOEYwtTLuAO7eEj9lR0mr3KTRgxSpLeL+X1ZqlBCn6ssN9JAw
         UHt4d7F+zXmLd13IdQXMpu0epH3n3Zvw0kKkzpWS3AjLvHogcS6oPMuttLSLcWCc7zU/
         EI+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+EYtOMATsumSeV7f4Ukqu7XeRGLRCsauoYWFISV6MNI8nnVrGyLB54YKMPllt+ageuC5wERo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvjcfAI/D3h2yErOJFvjz+zwAlIeeHzBSvJ6iOhqAe+lU1eCVR
	ZrYD0VAzk9Q84NSaS4bIQBGIReGlpgGSf1wlUKjwD9KUzaUAW0+vGM8=
X-Gm-Gg: ASbGnct4DfomYzaSEXAVTxAdXPz+CVVSi5JyrSTvTD3Q97F0XaE5KfBF0GrFGmWGmBW
	2Q9Vc8QkXATrQROATkst9vYGv+I+MsbFvM2XZEIYDcTBTbKZ3LXDM/9xHGnXuYOT7jEbsvxfWL5
	zNATiHSSN9dyJd0goAykNNokS6xzQPaH1hLMz/XkVyh8UPZOMhckmA8/G0beV/yHGgxc7iH7X11
	VPyKAe/GuswIOgqG2sKsZOccMHuE2+CPTNMUsulLUVJ7i6Z0WrS6g7HFaiE0RiUn05uU+romWYj
	a0MqTt9TJcvys3vt3Zum157/YUVJ7Etnd/mNEgGR2lmBvnKB+0SlcALaM8QhBlBhE6D1PIRVCp+
	DOrY3wLOSfg4Sc1v7ycds71MTYKl5HZMGXJNXRIozSepG45ybnqMwTSXjUogZtH0eRR/ChiiUME
	yL
X-Google-Smtp-Source: AGHT+IESPIKuTD5INgzVqUCgOWgsSMbYvBp254k7b3uOL7WxECIr1xPMPZTeONsx6mtFF/O0lx3uqA==
X-Received: by 2002:a05:6000:2287:b0:3e7:4265:66de with SMTP id ffacd0b85a97d-405c47b97ebmr2400311f8f.8.1758638373611;
        Tue, 23 Sep 2025 07:39:33 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac1a7.dip0.t-ipconnect.de. [91.42.193.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1d98093dsm16253415e9.3.2025.09.23.07.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 07:39:32 -0700 (PDT)
Message-ID: <6bb6c4ea-3ece-4799-848d-a961b96bc8d6@googlemail.com>
Date: Tue, 23 Sep 2025 16:39:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250922192412.885919229@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.09.2025 um 21:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
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

