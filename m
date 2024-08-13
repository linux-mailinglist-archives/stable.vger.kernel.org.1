Return-Path: <stable+bounces-67474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8CF9503BE
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 13:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8041C21E80
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C25199381;
	Tue, 13 Aug 2024 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XMoOm/Ty"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA188199249;
	Tue, 13 Aug 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548745; cv=none; b=o2658Ao5OOcNGOoduA4gJuW1lrUwyRCUOGHU3nn6trCiCs/rbAfB/yHBAeqy8QDT8nutB9EhHZo174/AscQr8Z8T1TY6wVpjjPPzMUY1+TSXV1ZB49CsFYLlLwTZbRDKBj4NPKIVwynodw7dercWy9joU4TuRgFe0vOi3MzTL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548745; c=relaxed/simple;
	bh=KvjJGzz1xQNHWNACafMPW1Wkpkmc0RPCTQ8VSp9K8kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZlmusTL9LU4bSnptC5LQB1QUjgs7bp8zp/t9hotaKNW8MQ66eVTESIUxOwrRv7LlSUkE7djD72hNrR6hvMLQt89FQ0IuDZ/ln6WXZ6rOASryAeA59/Za7bMbSzSi376nPqG9zQzrpOQFVmGzJUtcFXu1XhSqqT+Aj+rQVZGQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XMoOm/Ty; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280bca3960so42034465e9.3;
        Tue, 13 Aug 2024 04:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723548742; x=1724153542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQABmyNW1RlBrkRbzNCFM1S6Y1XBMV0+uzxHW7+CsqE=;
        b=XMoOm/TyknUqy2H7bWa9ZxDUyLzJzpfmPC45YJKZHFrSaR+KigMPCorzGkKgnbV1SC
         vNoZwobgzqD+mG6Ef2c0oFGc5lyvkF9tNFxCw7DurQEy+/6lgXjuWgqfA/WGBh+PcXat
         BcBn1V3kWawQIEGw3OqJBtaUDdrrm+CjydemmA28Y5PXcMplRbPFdtjV/dDKnq5PziKm
         CqPsyDccW+8kZHFv6Zi+RpVF/ORTqy3er5TDEP+Xnk3XH4q25PgPM+In4L3+9M2VpSEm
         hntJcNIL6kNZCzCTUh7vSy3Bf+W45UmtHwiYGo9vkKGL5sACZbgYqKqNI4NueXgoEmp5
         zzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723548742; x=1724153542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQABmyNW1RlBrkRbzNCFM1S6Y1XBMV0+uzxHW7+CsqE=;
        b=DmScgFMB1h2vwXI+8/gXztnuqkWdAuO0XnntjKVqTfPmOVR4zRg8ForLjFEYJyJBbm
         SugwvT3M7H5tGnaDaOdw18kE0QyZ7jo643NjYx2HeeGAsOWlj2y4i4yfvtG8ZYcFxOCN
         ic9WbrZ5xQb8yKt/UGHCbUgXA2CdOqCx+HCusYPFemlslA7ic8CgkhC/oUSR00CfrSeg
         BT2aqdg9+EM4NS9rrwfx4JjpgXsAnyTUncYeYy6BH94k97mEH7QYaYDVCjHdiFMUkcQI
         i3zI/RDYztG/Kjx39Jp3yDLnW6ggp9ufIzvhTgVDT+cmjjPqud2KsKcXOW7o7TN0SJT+
         peYw==
X-Forwarded-Encrypted: i=1; AJvYcCVu+9u+sASjQX5Nezm/4twyxkmAwSLCbLIYUos2UqUkjIa/FiD2p2yiqQOpx9K/FzvSpeDUYwhh@vger.kernel.org, AJvYcCXgUMWITlHE+O5qTN08Z1TZZpr3Yncg2DENn5d9OoVe3cXre59t8XgeovMn+g/m/GWzXMy95L1xM6cdE3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzev0nht8EMpVdhqGjEfhzdQDhURvg26xADwExCjCMVUrkWj6be
	QH/qc22hw11AfKKlBPPsJAmMWf/39Uyha/ZEbDL+WCsbMrRw8IifhtXnJqA=
X-Google-Smtp-Source: AGHT+IESryEa0asHTPnoFS7YMhj5meOeCzPgPfOAkdjqUQzXXWQtykthSh3Dr83QzmofWloKvGjzeQ==
X-Received: by 2002:a05:600c:4713:b0:426:61e8:fb3b with SMTP id 5b1f17b1804b1-429d48738c0mr25837595e9.27.1723548741894;
        Tue, 13 Aug 2024 04:32:21 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac34a.dip0.t-ipconnect.de. [91.42.195.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c739083sm215211905e9.18.2024.08.13.04.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 04:32:21 -0700 (PDT)
Message-ID: <0fa4405b-deda-4761-bfae-973676302282@googlemail.com>
Date: Tue, 13 Aug 2024 13:32:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 000/263] 6.10.5-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240812160146.517184156@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.08.2024 um 18:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

