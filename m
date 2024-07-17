Return-Path: <stable+bounces-60413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDF933A56
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 11:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DFF283D54
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3427317E8E3;
	Wed, 17 Jul 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Z1jB1Ceq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653AE17DA39;
	Wed, 17 Jul 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209847; cv=none; b=Cwbh2Ae+Kbq/f0m8zf6xFZKLJBnLCxoI3bLa4IHWwfIZRuag13KZdh7LorXlEg9T9GXWFkTyf79M2vgZAdmHEPvxUQOXzotx8Q4dSnWo3RQwrmaDLDfepZ5wSapfDSEkYEY2zogemWmTlT15o0UlLviDeBeDYX/zKrcylaH029c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209847; c=relaxed/simple;
	bh=widKc8K6pYV76Mu2nvcrhjA5QONVBH9tGu2f247sgBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHek2HbtPUYEduUyo0DX91ZxFDPTWH5p80ns1MMR4WxLQjUySRzaFYU1XUj6itbz2mVvtElIdxcrwtwwfadIlg/QF2eWM4NZRiv8kTTS3CFu+WbOG7/1cRcS8MTAhECilizy52nJBUmgglzfVXx3gtIrELIIxasn2yAQ0Oh54Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Z1jB1Ceq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77e392f59fso764449266b.1;
        Wed, 17 Jul 2024 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1721209844; x=1721814644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFYzt4+oRDf35DO6ym9OnuWNHVGbXwPsjErtYOtvDgY=;
        b=Z1jB1CeqGYzSodFWs3aFmrA41h0JrMQPTX24vQrwVWUMBLvsD4iUTFEX2cp1N99Qwx
         0TiU2d9G4b31a4AIHC3VIx9RPdCl2cd2ViZFh3tWT3PoimWAv/pC8/pagjYqKrB5cTsw
         LhQ8oHPcjL9RTFOH6ah1XtpVf2Hx7SNDWiNLjQ6NAqqdUYyGNaGnffU68IIFfS42vYEH
         XKtdJphYlqCQhAuWuhUj3A/dHWRvT1QTDBN0/aE7E0PZ7/BbesUacneggTMcVa7zjs/X
         C0iDddmT5R/7yNJ3pIVevwMhM4qlCiZ9/7LqctW95R7MGF/sNClhIwAkx9qjn7zFo6Bn
         u6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721209844; x=1721814644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFYzt4+oRDf35DO6ym9OnuWNHVGbXwPsjErtYOtvDgY=;
        b=p3JporGbAj8te8gRLcp069La3wwxXf1WkEnm2jkOJQgndBo9FnCO0c4SAD/UBU7GH3
         rIMMk5jsvwXBHE8+qcPRHvA1NhRYt+OSnrJNeqSrPoybGDaIME3aJ6h1Tfrp46c1BWXJ
         jggFNZA2gPau6INM8SM78ZaZjVlJhONOAu7ujOhldtrUg39Nc3mGdOppDXXpo/v9bwrb
         LYMv+vFo8GYgWRgpD1TIq77joHxHH9eRNj9lvz0meEce39Pef4bYaLJf06crWTZV0LxW
         Md/1VKpsTJPhpeJgW0O/j9U0XCkkUe616B1OPlE8/cHSIo4AUzCTnnWuuQkQ1as0JYh2
         b68Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+mZ7uFKBMDflkJMk/FkafID5jFOireICuy7dS7Eqg53OEvJ8XQccGoRY0DkmW/9X4MLEytmjXeCMLeLSpKGAf5H+kyyEQh6XQ8yekXXVpSL7MEEhbFc3v2r2BiBeFs5ua1H5v
X-Gm-Message-State: AOJu0YyF2SgfXNKN+fMXEkSu+DW6W3pmW7qoV+BxdLYStpunTej0IbFE
	+6vy+/iqNnm7zQYKgWzSDoO2b+dtpOxrTUCVf5KUVvEIbsG7F1w=
X-Google-Smtp-Source: AGHT+IEr2sHIgKgs6+p3oVsZSoFqhiljMqhuzHMlM+ZfQkRyh6AyJ7nsZ0R/NgzjCdmjRCHQJo3S3Q==
X-Received: by 2002:a17:906:f291:b0:a77:cf9d:f496 with SMTP id a640c23a62f3a-a7a011af228mr77259366b.39.1721209843495;
        Wed, 17 Jul 2024 02:50:43 -0700 (PDT)
Received: from [192.168.1.3] (p5b0576fa.dip0.t-ipconnect.de. [91.5.118.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7e9esm427481966b.62.2024.07.17.02.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 02:50:42 -0700 (PDT)
Message-ID: <655921dc-bc68-4408-b07a-efcbf8fdd712@googlemail.com>
Date: Wed, 17 Jul 2024 11:50:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/95] 6.1.100-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063758.086668888@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240717063758.086668888@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.07.2024 um 08:39 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.100 release.
> There are 95 patches in this series, all will be posted as a response
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

