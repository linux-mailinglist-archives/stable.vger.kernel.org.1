Return-Path: <stable+bounces-83078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1678C995548
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 19:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A8EB25063
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81F51E0E07;
	Tue,  8 Oct 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Iq/Ea76f"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EFA1E0DC3;
	Tue,  8 Oct 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407116; cv=none; b=UBzmYFu0ToQjJx8M//npdYoGced0UAcMKS8LSE3bANWFfpCV3czztevtw9XRB0AwCiTJYEDGJIACQXU/WQqXnwltnxiBjnhQz/Ay56ZmjzCUR0VAi4KklRccK1zdptHB6LWyH5zLj2QJ8OALWi08xDiszhVkneIY4Km5f3Q3x/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407116; c=relaxed/simple;
	bh=6yf8RgkWeLrXVP+1l3yxp5qwHoOq5jHnuctZRyfcLrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPea8tmGLjttiWq1mu2q3XzIukr+hsB2OnZEPuc4D4JmVwnY6FH7fjE/0ut/LmWO1InOOFT4N6z4SOxJomrAF1duvA8k5E7mk8id4TCi6O5TGwIG0gU8LhnOTmcT4gGNTzQK4jvYO1K9wZNuImuN9GG7HaWs86uqKLIiq2PuMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Iq/Ea76f; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ccfada422so3548137f8f.2;
        Tue, 08 Oct 2024 10:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728407113; x=1729011913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3YRV8BLw6t5/e/+7ajFhrM1Fg7IM/Mpe/N72BSndBc=;
        b=Iq/Ea76f3P8HPjS0ngu1ig3FYoXS35Fo0hkk7Ruw7h1YxU1KH0SGxw+U1+RtYGAcEe
         TnZE8oNFKIIwAS+kK1G8bCk+cmpa+FlZk17oW506775ojyXULLqsTXqj2wFO7Fg1ksmB
         6YmO4ItwCxz5tc/+ztWz/uLc07idu2tJZVJc8Mc6K3NGnDg4DWGmT0Xx9ogMVSizK90v
         H9qIOXaEEYv9bt9/0SE+MIuY0YQiQgPz2Et5Stl+SZtWzGckEqmW4mjCpXfmahFZFRTI
         gzoBOp6wacfu1dtQPnT29lR1WFCMMjmtNFOxCg1E5XTxRV0wABXhCliFwbEnFqQESvwQ
         fwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728407113; x=1729011913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3YRV8BLw6t5/e/+7ajFhrM1Fg7IM/Mpe/N72BSndBc=;
        b=G3ZuNJp/gHwotE3cfnCM4vxSLDeDGu74IHRHHvkuWG1JoKLgNnd9MnP4qAArMP2NqT
         Ra+b5xJ3xrOU1YWHLPkhqYpk3idDxpDr+FqJfvtLQ14LB01lihN0OxVQNj6BizLC2vQP
         ObH3Ye5lYvp1Nf+rFjEae5xgV1yDgUPahmPDvOxcAotMrWhjP4JWH0dw9mUuZtFAi0gs
         NZvg2coN9FrBr9ugjvnKOsR4DHavNWdQxb4zOx3qarqmx5XUfAR6IULObS47LXpA/8SR
         T7vP+FSLyw5+6MfVuqtuiaCfvYi/KSL5IkDwcDv72YiahZz41iuzBU12RHvJ/IXPO9l5
         1l/w==
X-Forwarded-Encrypted: i=1; AJvYcCWUpPgGf3arylAOmhDchHMxAaXNdIOZgxt6PZ6lkM8JWNwpff1USE+61kbmZ7WIe7GSh6uRDdZUZ05oaCk=@vger.kernel.org, AJvYcCWfaQctngsHjWrPE2MZwvRV7w54RBviZsncdaYNz0zTv4wF6VDJDBYtAQZDd2OPCnFbjtwThNWy@vger.kernel.org
X-Gm-Message-State: AOJu0YzZbMiNLybqgwBEVLfgGJuVg7/go0I5kpZAun0TqrSutvGxsQUW
	jnTqgGEbdjkSqFDPLhScmtROhT/cTY2U8kG41weOgzlgfHPodbA=
X-Google-Smtp-Source: AGHT+IHQfl0hND+4ioU/ew6zB6733O+fXHQ6AI/5lvB2hSbTyvQLjTIf02G16828G/wHCR8TOnBEsg==
X-Received: by 2002:a5d:648a:0:b0:375:1b02:1e3c with SMTP id ffacd0b85a97d-37d0e8de99dmr13576498f8f.45.1728407113096;
        Tue, 08 Oct 2024 10:05:13 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4723.dip0.t-ipconnect.de. [91.43.71.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f25asm8479886f8f.11.2024.10.08.10.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 10:05:12 -0700 (PDT)
Message-ID: <158d864c-7378-4929-b244-76af607574c2@googlemail.com>
Date: Tue, 8 Oct 2024 19:05:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/386] 6.6.55-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241008115629.309157387@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.10.2024 um 14:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.55 release.
> There are 386 patches in this series, all will be posted as a response
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

