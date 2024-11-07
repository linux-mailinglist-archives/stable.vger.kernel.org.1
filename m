Return-Path: <stable+bounces-91792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF4A9C043C
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256FD1F22746
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491D920C483;
	Thu,  7 Nov 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U63G19Xl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695820CCEA;
	Thu,  7 Nov 2024 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979371; cv=none; b=t0v24SCqRLvSNp4zGIU0j92oP85iRSJfYndeoKQyWCX1rFb+Ze756CW6JVxfZXajSWLR4VCsX9+UFMTvTk5seeayDrWD3xgqT6sJDyxQmiWP0iGQHIJT7rPICkw1dbb9fASJlWFDo69xBIttY8WPgBRZuzquoe9/hWbKV9yrcNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979371; c=relaxed/simple;
	bh=qxWjifonqFKnhZ8gv89dEn2nASW03TwilfxkBsp7j5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwDwqROKh1X1l3GbpSv0DdvKJqcrxDGGnmNZiQYhb8G48YJgvQeiRV1D8XN2dR/oO/0ec1VKpto86qP5eispxRHvg/0HUF7xUC8ZebDez0kZiwNFHv8MzQuslsT/k9PycNTZvXGeoQid7Dt7E+/wsXJZ5BpnL73EVcbn/gox5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=U63G19Xl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431616c23b5so5205335e9.0;
        Thu, 07 Nov 2024 03:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1730979368; x=1731584168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ty+qJBXg4bnlolQ5RZHsDuQ6RCsD7b6YT0DtPdQ5EVI=;
        b=U63G19XlgIvjA3qqsaHaFifCoznpbyoY67PvC2aWu/uVRozNNbTQ6/MFkMp4FmWvb0
         RrHyD6OYAdPChlYnc4ansIsV0/Yj7OHfJKcWAzWKMYdrCWYR/SNDlIACFsZ4x03XOcNf
         WCmDmoZHu+sJ0wK82GviyPbWrtIfpVixIwJuvrevt1+bN9unr09dMXl4yDMK/YaJGxr7
         zmz471TE0/K6akfrPyJrF9Fzp01yauydWzF12Hr1xpmAkhHaQUS9L8be2a0ZNuCZ7F0z
         nzkpaX9rOywhonK/nlRrh4v2jOx5Va5Tk6L66MaKUl10U2YPwkIpSjEUuZWeneEkFKsK
         aNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979368; x=1731584168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty+qJBXg4bnlolQ5RZHsDuQ6RCsD7b6YT0DtPdQ5EVI=;
        b=hROp5Kg8KsYCxWArWXN5PLoCx34WV53tNpWx/OJntq/0aGvsr4BTbkHsETpNTPOz0d
         GFKHYq0gtXJh1s3vfN+9RC9wq1fju+cWHTHabXXQpelarR5qkwI/5IqWmPLbvHC0X8mx
         QjMR2/FoGtASqvN55NW3/lMSX4+X4SQt5VFmCPjS1JFX1pui6otpB/nA67FCSOqBmkMA
         Wf4Eu/xV67V1h0AWT07aTZIFL7Ep/VLIR1jfXPj8b0k8d4nP9Eq5sxnoDbNwMhM7D41i
         8qovT73V5d9jM1t82ZkiS3WDTbGAeOCMcrjkIO2yl9SV+ov6LAcyDYSTrt81inA1uhM7
         hxKA==
X-Forwarded-Encrypted: i=1; AJvYcCVUgsMGNnM1dPHAWns0BOj8KWCPgJJD9ShH2z7YIBaryWX70If1rpg0UERJw/liHRINL4L2G3omZ1cs9vk=@vger.kernel.org, AJvYcCVgWyYOFBMH5SBoHF23tAx3uGH0+arvsPjisWg/mCeGVRC/h5DmQRBNL9WAaIGh/72/2KTJdcEu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5g2xNxDRPFUvzWdYZHMnGY5tP5GkwHtV6ZcvZ9cTI2QWDhfi/
	ofpZETHu9E7igaHIfczzFf3q1/sfw5VJX1o12UHgaqQOTHV54YuXFvvQvqI=
X-Google-Smtp-Source: AGHT+IGbrbjTVBvCyElsvoOE1ypSeiDOiFTAEQHkitYEQmG5JIs58kQwbh8kGECowUUtnuJYV+t9JA==
X-Received: by 2002:a05:600c:1c8a:b0:431:9340:77e0 with SMTP id 5b1f17b1804b1-432b382bdc8mr9191465e9.9.1730979367529;
        Thu, 07 Nov 2024 03:36:07 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac486.dip0.t-ipconnect.de. [91.42.196.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05319aesm20664355e9.8.2024.11.07.03.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 03:36:06 -0800 (PST)
Message-ID: <a14b2f06-fa71-40c3-a796-9193bbcc38ca@googlemail.com>
Date: Thu, 7 Nov 2024 12:36:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/126] 6.1.116-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org
References: <20241106120306.038154857@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.11.2024 um 13:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.116 release.
> There are 126 patches in this series, all will be posted as a response
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

